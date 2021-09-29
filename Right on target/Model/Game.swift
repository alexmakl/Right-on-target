//
//  Game.swift
//  Right on target
//
//  Created by Alexander on 29.09.2021.
//

protocol GameProtocol {
    var secretValueGenerator: GeneratorProtocol! { get set }
    var currentRound: GameRoundProtocol! { get set }
    var isGameEnded: Bool { get }
    func restartGame()
    func startNewRound()
}

class Game: GameProtocol {
    var secretValueGenerator: GeneratorProtocol!
    var currentRound: GameRoundProtocol!
    private var lastRound: Int
    var isGameEnded: Bool {
        if currentRound.round >= lastRound {
            return true
        } else {
            return false
        }
    }

    init?(startValue: Int, endValue: Int, rounds: Int) {
        secretValueGenerator = Generator(startValue: startValue, endValue: endValue)
        currentRound = GameRound(
            secretValue: secretValueGenerator.getRandomValue(),
            round: 1,
            lastRound: rounds
        )
        lastRound = rounds
    }

    func restartGame() {
        currentRound.round = 0
        currentRound.score = 0
        startNewRound()
    }

    func startNewRound() {
        currentRound.currentSecretValue = secretValueGenerator.getRandomValue()
        currentRound.round += 1
    }
}
