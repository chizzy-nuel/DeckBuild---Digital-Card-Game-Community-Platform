;; DeckBuild - Digital Card Game Community Platform
;; A blockchain-based platform for deck recipes, match logs,
;; and player community rewards

;; Contract constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-found (err u101))
(define-constant err-already-exists (err u102))
(define-constant err-unauthorized (err u103))
(define-constant err-invalid-input (err u104))

;; Token constants
(define-constant token-name "DeckBuild Strategy Token")
(define-constant token-symbol "DST")
(define-constant token-decimals u6)
(define-constant token-max-supply u54000000000) ;; 54k tokens with 6 decimals

;; Reward amounts (in micro-tokens)
(define-constant reward-match u2200000) ;; 2.2 DST
(define-constant reward-deck u3400000) ;; 3.4 DST
(define-constant reward-milestone u9000000) ;; 9.0 DST

;; Data variables
(define-data-var total-supply uint u0)
(define-data-var next-deck-id uint u1)
(define-data-var next-match-id uint u1)

;; Token balances
(define-map token-balances principal uint)

;; Player profiles
(define-map player-profiles
  principal
  {
    username: (string-ascii 24),
    game-format: (string-ascii 12), ;; "standard", "modern", "legacy", "commander", "limited"
    matches-played: uint,
    decks-shared: uint,
    win-count: uint,
    player-rating: uint, ;; ELO-style rating
    join-date: uint
  }
)

;; Deck recipes
(define-map deck-recipes
  uint
  {
    deck-name: (string-ascii 18),
    format: (string-ascii 12),
    archetype: (string-ascii 14), ;; "aggro", "control", "midrange", "combo", "ramp"
    main-colors: (string-ascii 8), ;; "WU", "BR", "RGB", etc
    card-count: uint,
    mana-curve: uint, ;; average mana cost * 10
    builder: principal,
    match-count: uint,
    win-rate: uint ;; percentage * 10
  }
)

;; Match logs
(define-map match-logs
  uint
  {
    deck-id: uint,
    player: principal,
    opponent-archetype: (string-ascii 14),
    match-result: (string-ascii 4), ;; "win", "loss", "draw"
    game-length: uint, ;; turns
    play-first: bool,
    sideboard-used: bool,
    match-notes: (string-ascii 60),
    match-date: uint,
    ranked: bool
  }
)

;; Deck reviews
(define-map deck-reviews
  { deck-id: uint, reviewer: principal }
  {
    rating: uint, ;; 1-10
    review-text: (string-ascii 60),
    competitiveness: (string-ascii 8), ;; "casual", "semi", "competitive"
    review-date: uint,
    spicy-votes: uint
  }
)

;; Player milestones
(define-map player-milestones
  { player: principal, milestone: (string-ascii 12) }
  {
    achievement-date: uint,
    match-count: uint
  }
)

;; Helper function to get or create profile
(define-private (get-or-create-profile (player principal))
  (match (map-get? player-profiles player)
    profile profile
    {
      username: "",
      game-format: "standard",
      matches-played: u0,
      decks-shared: u0,
      win-count: u0,
      player-rating: u1200,
      join-date: stacks-block-height
    }
  )
)

;; Token functions
(define-read-only (get-name)
  (ok token-name)
)

(define-read-only (get-symbol)
  (ok token-symbol)
)

(define-read-only (get-decimals)
  (ok token-decimals)
)

(define-read-only (get-balance (user principal))
  (ok (default-to u0 (map-get? token-balances user)))
)

(define-private (mint-tokens (recipient principal) (amount uint))
  (let (
    (current-balance (default-to u0 (map-get? token-balances recipient)))
    (new-balance (+ current-balance amount))
    (new-total-supply (+ (var-get total-supply) amount))
  )
    (asserts! (<= new-total-supply token-max-supply) err-invalid-input)
    (map-set token-balances recipient new-balance)
    (var-set total-supply new-total-supply)
    (ok amount)
  )
)

;; Add deck recipe
(define-public (add-deck-recipe (deck-name (string-ascii 18)) (format (string-ascii 12)) (archetype (string-ascii 14)) (main-colors (string-ascii 8)) (card-count uint) (mana-curve uint))
  (let (
    (deck-id (var-get next-deck-id))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len deck-name) u0) err-invalid-input)
    (asserts! (>= card-count u40) err-invalid-input)
    (asserts! (> mana-curve u0) err-invalid-input)
    
    (map-set deck-recipes deck-id {
      deck-name: deck-name,
      format: format,
      archetype: archetype,
      main-colors: main-colors,
      card-count: card-count,
      mana-curve: mana-curve,
      builder: tx-sender,
      match-count: u0,
      win-rate: u0
    })
    
    ;; Update profile
    (map-set player-profiles tx-sender
      (merge profile {decks-shared: (+ (get decks-shared profile) u1)})
    )
    
    ;; Award deck creation tokens
    (try! (mint-tokens tx-sender reward-deck))
    
    (var-set next-deck-id (+ deck-id u1))
    (print {action: "deck-recipe-added", deck-id: deck-id, builder: tx-sender})
    (ok deck-id)
  )
)

;; Log match result
(define-public (log-match (deck-id uint) (opponent-archetype (string-ascii 14)) (match-result (string-ascii 4)) (game-length uint) (play-first bool) (sideboard-used bool) (match-notes (string-ascii 60)) (ranked bool))
  (let (
    (match-id (var-get next-match-id))
    (deck (unwrap! (map-get? deck-recipes deck-id) err-not-found))
    (profile (get-or-create-profile tx-sender))
    (is-win (is-eq match-result "win"))
  )
    (asserts! (> game-length u0) err-invalid-input)
    (asserts! (or (is-eq match-result "win") (or (is-eq match-result "loss") (is-eq match-result "draw"))) err-invalid-input)
    
    (map-set match-logs match-id {
      deck-id: deck-id,
      player: tx-sender,
      opponent-archetype: opponent-archetype,
      match-result: match-result,
      game-length: game-length,
      play-first: play-first,
      sideboard-used: sideboard-used,
      match-notes: match-notes,
      match-date: stacks-block-height,
      ranked: ranked
    })
    
    ;; Update deck stats
    (let (
      (new-match-count (+ (get match-count deck) u1))
      (new-wins (if is-win (+ (* (get win-rate deck) (get match-count deck)) u1000) (* (get win-rate deck) (get match-count deck))))
      (new-win-rate (/ new-wins new-match-count))
    )
      (map-set deck-recipes deck-id
        (merge deck {
          match-count: new-match-count,
          win-rate: new-win-rate
        })
      )
    )
    
    ;; Update profile
    (map-set player-profiles tx-sender
      (merge profile {
        matches-played: (+ (get matches-played profile) u1),
        win-count: (if is-win (+ (get win-count profile) u1) (get win-count profile)),
        player-rating: (if is-win (+ (get player-rating profile) u15) (- (get player-rating profile) u10))
      })
    )
    
    ;; Award match tokens with win bonus
    (let (
      (base-reward reward-match)
      (win-bonus (if is-win u700000 u0))
    )
      (try! (mint-tokens tx-sender (+ base-reward win-bonus)))
    )
    
    (var-set next-match-id (+ match-id u1))
    (print {action: "match-logged", match-id: match-id, deck-id: deck-id})
    (ok match-id)
  )
)

;; Write deck review
(define-public (write-review (deck-id uint) (rating uint) (review-text (string-ascii 60)) (competitiveness (string-ascii 8)))
  (let (
    (deck (unwrap! (map-get? deck-recipes deck-id) err-not-found))
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (and (>= rating u1) (<= rating u10)) err-invalid-input)
    (asserts! (> (len review-text) u0) err-invalid-input)
    (asserts! (is-none (map-get? deck-reviews {deck-id: deck-id, reviewer: tx-sender})) err-already-exists)
    
    (map-set deck-reviews {deck-id: deck-id, reviewer: tx-sender} {
      rating: rating,
      review-text: review-text,
      competitiveness: competitiveness,
      review-date: stacks-block-height,
      spicy-votes: u0
    })
    
    (print {action: "review-written", deck-id: deck-id, reviewer: tx-sender})
    (ok true)
  )
)

;; Vote review spicy
(define-public (vote-spicy (deck-id uint) (reviewer principal))
  (let (
    (review (unwrap! (map-get? deck-reviews {deck-id: deck-id, reviewer: reviewer}) err-not-found))
  )
    (asserts! (not (is-eq tx-sender reviewer)) err-unauthorized)
    
    (map-set deck-reviews {deck-id: deck-id, reviewer: reviewer}
      (merge review {spicy-votes: (+ (get spicy-votes review) u1)})
    )
    
    (print {action: "review-voted-spicy", deck-id: deck-id, reviewer: reviewer})
    (ok true)
  )
)

;; Update game format
(define-public (update-game-format (new-game-format (string-ascii 12)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len new-game-format) u0) err-invalid-input)
    
    (map-set player-profiles tx-sender (merge profile {game-format: new-game-format}))
    
    (print {action: "game-format-updated", player: tx-sender, format: new-game-format})
    (ok true)
  )
)

;; Claim milestone
(define-public (claim-milestone (milestone (string-ascii 12)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (is-none (map-get? player-milestones {player: tx-sender, milestone: milestone})) err-already-exists)
    
    ;; Check milestone requirements
    (let (
      (milestone-met
        (if (is-eq milestone "grinder-85") (>= (get matches-played profile) u85)
        (if (is-eq milestone "brewer-16") (>= (get decks-shared profile) u16)
        false)))
    )
      (asserts! milestone-met err-unauthorized)
      
      ;; Record milestone
      (map-set player-milestones {player: tx-sender, milestone: milestone} {
        achievement-date: stacks-block-height,
        match-count: (get matches-played profile)
      })
      
      ;; Award milestone tokens
      (try! (mint-tokens tx-sender reward-milestone))
      
      (print {action: "milestone-claimed", player: tx-sender, milestone: milestone})
      (ok true)
    )
  )
)

;; Update username
(define-public (update-username (new-username (string-ascii 24)))
  (let (
    (profile (get-or-create-profile tx-sender))
  )
    (asserts! (> (len new-username) u0) err-invalid-input)
    (map-set player-profiles tx-sender (merge profile {username: new-username}))
    (print {action: "username-updated", player: tx-sender})
    (ok true)
  )
)

;; Read-only functions
(define-read-only (get-player-profile (player principal))
  (map-get? player-profiles player)
)

(define-read-only (get-deck-recipe (deck-id uint))
  (map-get? deck-recipes deck-id)
)

(define-read-only (get-match-log (match-id uint))
  (map-get? match-logs match-id)
)

(define-read-only (get-deck-review (deck-id uint) (reviewer principal))
  (map-get? deck-reviews {deck-id: deck-id, reviewer: reviewer})
)

(define-read-only (get-milestone (player principal) (milestone (string-ascii 12)))
  (map-get? player-milestones {player: player, milestone: milestone})
)