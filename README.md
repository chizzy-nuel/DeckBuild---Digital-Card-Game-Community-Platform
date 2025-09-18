# DeckBuild - Digital Card Game Community Platform

A blockchain-based platform for deck recipes, match logs, and player community rewards built on the Stacks blockchain using Clarity smart contracts.

[![Built with Stacks](https://img.shields.io/badge/Built_with-Stacks-purple.svg)](https://www.stacks.co/)
[![Smart Contract](https://img.shields.io/badge/Smart_Contract-Clarity-orange.svg)](https://clarity-lang.org/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Overview

DeckBuild creates a decentralized community where trading card game players can share deck recipes, track match results, review strategies, and earn DST (DeckBuild Strategy Token) rewards for their participation. The platform supports multiple game formats and emphasizes strategic depth through comprehensive deck analysis and match tracking.

## Key Features

### Comprehensive Deck Management
- **Deck Recipe Sharing**: Create and share complete deck lists with strategic analysis
- **Format Support**: Standard, Modern, Legacy, Commander, and Limited format tracking
- **Archetype Classification**: Aggro, control, midrange, combo, and ramp strategy categories
- **Mana Curve Analysis**: Detailed cost curve tracking for deck optimization
- **Color Identity Tracking**: Multi-color combination support and analysis

### Advanced Match Tracking
- **Detailed Match Logs**: Record opponent matchups, game length, and strategic notes
- **Win Rate Analytics**: Automatic win percentage calculation for deck performance
- **Play Pattern Analysis**: Track play/draw statistics and sideboard usage
- **Ranked vs Casual**: Separate tracking for competitive and casual play
- **ELO-Style Ratings**: Dynamic player rating system based on match results

### Community Review System
- **Deck Reviews**: Rate and review community deck recipes with detailed feedback
- **Competitiveness Assessment**: Classify decks by competitive viability
- **Spicy Vote System**: Community appreciation for innovative and creative strategies
- **Strategy Discussion**: In-depth analysis and improvement suggestions

### Player Progression
- **Match Statistics**: Comprehensive tracking of games played and win rates
- **Deck Building Recognition**: Rewards for sharing innovative strategies
- **Format Specialization**: Track preferred formats and expertise areas
- **Achievement Milestones**: Recognition for consistent play and deck creation

## Token Economy (DST - DeckBuild Strategy Token)

### Token Details
- **Name**: DeckBuild Strategy Token
- **Symbol**: DST
- **Decimals**: 6
- **Total Supply**: 54,000 DST
- **Blockchain**: Stacks

### Reward Structure
![DeckBuild Reward Structure](images/deckbuild-reward-structure.png)

## Smart Contract Architecture

### Core Data Structures

#### Player Profile
![Player Profile Structure](images/player-profile-structure.png)

#### Deck Recipe
![Deck Recipe Structure](images/deck-recipe-structure.png)

#### Match Log
![Match Log Structure](images/match-log-structure.png)

#### Deck Review System
![Deck Review Structure](images/deck-review-structure.png)

### Game Format Support

The platform supports all major trading card game formats:

- **Standard**: Current set rotation with regular meta updates
- **Modern**: Extended card pool with consistent strategic diversity  
- **Legacy**: Vintage card access enabling powerful combo strategies
- **Commander**: Multiplayer singleton format with unique deck building
- **Limited**: Draft and sealed formats with skill-based gameplay

### Archetype Classification

Strategic categories for deck analysis:

| Archetype | Strategy Focus | Typical Game Plan |
|-----------|---------------|-------------------|
| Aggro | Speed and pressure | Early game dominance |
| Control | Card advantage | Late game inevitability |
| Midrange | Balanced approach | Adaptive strategy |
| Combo | Synergistic interactions | Explosive turns |
| Ramp | Resource acceleration | Big threats early |

## Getting Started

### Prerequisites
- [Clarinet](https://github.com/hirosystems/clarinet) - Stacks smart contract development tool
- [Stacks Wallet](https://www.hiro.so/wallet) - For blockchain interactions
- Understanding of trading card game mechanics
- Knowledge of Clarity smart contracts

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/deckbuild-platform.git
cd deckbuild-platform
```

2. **Install Clarinet**
```bash
curl -L https://github.com/hirosystems/clarinet/releases/download/v1.8.0/clarinet-linux-x64.tar.gz | tar xz
mv clarinet /usr/local/bin/
```

3. **Initialize project**
```bash
clarinet new deckbuild-project
cd deckbuild-project
# Copy contract to contracts/deckbuild.clar
```

### Deployment

1. **Test the contract**
```bash
clarinet test
```

2. **Deploy to devnet**
```bash
clarinet integrate
```

3. **Deploy to testnet/mainnet**
```bash
clarinet deployment apply -p testnet
```

## Usage Examples

### Add Deck Recipe
![Add Deck Recipe Function](images/add-deck-recipe-function.png)

### Log Match Result
![Log Match Function](images/log-match-function.png)

### Write Deck Review
![Write Review Function](images/write-deck-review-function.png)

### Vote Review Spicy
![Vote Spicy Function](images/vote-spicy-function.png)

### Update Game Format
![Update Format Function](images/update-format-function.png)

### Claim Achievement Milestone
![Claim Milestone Function](images/claim-milestone-function.png)

## Core Functions

### Deck Management
- `add-deck-recipe(...)` - Share deck lists with strategic analysis
- `get-deck-recipe(deck-id)` - Retrieve deck details and performance stats
- `write-review(...)` - Submit feedback and ratings for community decks
- `vote-spicy(...)` - Appreciate innovative and creative strategies

### Match Tracking
- `log-match(...)` - Record game results with detailed match data
- `get-match-log(match-id)` - View individual match details and notes
- `update-game-format(format)` - Update preferred format specialization

### Community Features
- `claim-milestone(milestone)` - Unlock achievement rewards
- `update-username(username)` - Update player profile information
- `get-player-profile(player)` - View player statistics and ratings

### Token Operations
- `get-balance(user)` - Check DST token balance
- `get-name()`, `get-symbol()`, `get-decimals()` - Token metadata

## Strategic Analysis Features

### Deck Performance Metrics
- **Win Rate Tracking**: Automatic calculation of deck success rates
- **Match Count Statistics**: Volume-based performance validation
- **Archetype Matchup Data**: Opponent strategy analysis
- **Format-Specific Performance**: Win rates across different game formats

### Meta Analysis Tools
- **Color Combination Tracking**: Multi-color strategy popularity
- **Mana Curve Optimization**: Cost distribution analysis for consistency
- **Sideboard Usage Statistics**: Post-game adjustment effectiveness
- **Game Length Analysis**: Turn count tracking for strategy timing

### Community Intelligence
- **Deck Rating System**: 1-10 scale community evaluation
- **Competitiveness Classification**: Casual to competitive viability assessment
- **Innovation Recognition**: Spicy votes for creative strategies
- **Format Meta Tracking**: Popular archetypes and emerging strategies

## Player Progression System

### Rating System
- **Starting Rating**: 1200 ELO-style points for new players
- **Win/Loss Adjustment**: +15 for wins, -10 for losses with ranking impact
- **Competitive Balance**: Separate tracking for ranked and casual play
- **Format Specialization**: Rating development within preferred formats

### Achievement Milestones
![Achievement Milestones](images/achievement-milestones-deckbuild.png)

### Community Recognition
- **Deck Innovation**: Rewards for sharing creative strategies
- **Match Dedication**: Recognition for consistent play and improvement
- **Review Quality**: Spicy votes for helpful strategy analysis
- **Format Expertise**: Specialization recognition within specific formats

## Access Controls & Requirements

### Deck Recipe Sharing
- Minimum 40-card deck size for competitive validity
- Format specification required for proper categorization
- Mana curve calculation for strategic analysis

### Match Logging
- Valid result options: win, loss, or draw only
- Positive game length requirement for realistic match data
- Optional but encouraged strategic notes for community learning

### Review System
- Cannot review own deck creations to ensure objectivity
- One review per deck per player to prevent spam
- Rating scale validation (1-10) for consistent feedback

## Security Features

### Input Validation
- String length limits appropriate for card game terminology
- Numeric range validation for ratings, card counts, and game statistics
- Match result validation against acceptable outcomes
- Mana curve reasonableness checks for deck analysis

### Access Control
- Self-review prevention for objective deck feedback
- Match logging restricted to player's own games
- Profile updates limited to account owners
- Spicy voting restrictions to prevent self-voting

### Anti-Gaming Measures
- Win rate calculations based on actual match results
- Rating adjustments tied to legitimate game outcomes
- Milestone verification against recorded statistics
- Community validation through review and voting systems

### Error Handling
![DeckBuild Error Codes](images/deckbuild-error-codes.png)

## Competitive Gaming Features

### Tournament Support
- **Match Format Tracking**: Support for various competitive formats
- **Sideboard Documentation**: Post-game adjustment tracking
- **Ranked Play Recognition**: Separate statistics for competitive matches
- **Meta Analysis**: Community-driven format analysis and trends

### Strategy Sharing
- **Deck Tech Documentation**: Detailed strategy explanations in reviews
- **Matchup Analysis**: Opponent archetype performance tracking
- **Innovation Rewards**: Community recognition for creative deck building
- **Format Expertise**: Specialized knowledge sharing within game formats

### Community Learning
- **Strategy Discussion**: Review system enabling in-depth analysis
- **Performance Feedback**: Win rate and match data for deck improvement
- **Meta Adaptation**: Community tracking of format changes and trends
- **Skill Development**: Rating system encouraging consistent improvement

## Development Roadmap

### Phase 1: Core Gaming Platform
- Smart contract deployment with comprehensive deck and match tracking
- Community review system with spicy voting for strategy appreciation
- Player rating system with ELO-style competitive tracking
- Token reward distribution for gaming community participation

### Phase 2: Advanced Analytics
- Detailed meta analysis tools and format trend tracking
- Tournament integration with bracket management systems
- Advanced deck building tools with card database integration
- Mobile application for real-time match logging and community engagement

### Phase 3: Competitive Integration
- Professional tournament partnership and prize support
- Streaming integration for match broadcasting and analysis
- Advanced statistics and performance analytics
- Global leaderboards and competitive ranking systems

### Phase 4: Ecosystem Expansion
- Multi-game support for various trading card games
- NFT integration for unique card ownership and trading
- AI-powered deck building assistance and strategy recommendations
- Virtual tournament hosting and remote competitive play

## Community Standards

### Healthy Gaming Culture
- Emphasis on strategic improvement and learning rather than purely win-focused metrics
- Recognition for innovative deck building and creative strategies
- Supportive community feedback through constructive reviews
- Balanced approach to competitive play and casual enjoyment

### Strategic Integrity
- Honest match reporting and accurate deck recipe sharing
- Constructive feedback focused on strategy improvement
- Recognition of diverse play styles and format preferences
- Community support for players developing their strategic skills

## Testing

```bash
# Run comprehensive tests
clarinet test

# Test specific gaming modules
clarinet test tests/deck_management_test.ts
clarinet test tests/match_tracking_test.ts
clarinet test tests/community_features_test.ts
clarinet test tests/rating_system_test.ts

# Validate contract
clarinet check
```

## API Reference

### Read-Only Functions
- `get-player-profile(player)` - Player statistics and competitive ratings
- `get-deck-recipe(deck-id)` - Deck details and performance analytics
- `get-match-log(match-id)` - Individual match data and strategic notes
- `get-deck-review(deck-id, reviewer)` - Review content and community feedback
- `get-milestone(player, milestone)` - Achievement status and completion dates

### Write Functions
- Deck creation and strategy sharing functions
- Match result logging and performance tracking functions
- Community review and feedback functions
- Profile and preference management functions
- Achievement milestone claiming functions

## Contributing

We welcome contributions from card game players, strategy analysts, tournament organizers, and developers!

### Development Guidelines
1. Fork the repository and create feature branches
2. Write comprehensive tests for gaming scenarios
3. Follow trading card game terminology and conventions
4. Update documentation with strategic context and examples
5. Submit pull requests with detailed gaming use case descriptions

### Contribution Areas
- Gaming-specific smart contract enhancements
- Mobile deck building and match tracking applications
- Tournament integration and bracket management features
- Strategy analysis tools and meta tracking systems
- Community feedback and review system improvements

## Community Standards

### Strategic Gaming Environment
- Respectful interaction between players of all skill levels
- Constructive feedback focused on strategy improvement rather than criticism
- Recognition and appreciation for innovative deck building and creative strategies
- Support for diverse play styles and format preferences

### Competitive Integrity
- Honest match reporting and accurate performance tracking
- Fair play principles in community reviews and ratings
- Recognition of both competitive achievement and casual enjoyment
- Community support for developing players and strategic learning

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support & Community

- **Documentation**: [docs.deckbuild.io](https://docs.deckbuild.io)
- **Discord**: [Join our gaming community](https://discord.gg/deckbuild)
- **Twitter**: [@DeckBuildPlatform](https://twitter.com/deckbuildplatform)
- **Email**: support@deckbuild.io

## Acknowledgments

- Built on Stacks blockchain infrastructure
- Powered by Clarity smart contract language
- Inspired by the global trading card game community
- Dedicated to strategic gaming and community learning
- Community-driven development with player feedback

---

**Building strategies, tracking progress, sharing knowledge**
