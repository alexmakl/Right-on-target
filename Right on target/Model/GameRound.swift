//
//  GameRound.swift
//  Right on target
//
//  Created by Alexander on 29.09.2021.
//

protocol GameRoundProtocol {
    var score: Int { get set }
    var currentSecretValue: Int { get set }
    var round: Int { get set }
    func calculateScore(with value: Int)
}

class GameRound: GameRoundProtocol {
    var score: Int = 0
    var currentSecretValue: Int
    var round: Int
    var lastRound: Int

    init?(secretValue: Int, round: Int, lastRound: Int) {
        currentSecretValue = secretValue
        self.round = round
        self.lastRound = lastRound
    }

    func calculateScore(with value: Int) {
        if value > currentSecretValue {
            score += 50 - value + currentSecretValue
        } else if value < currentSecretValue {
            score += 50 - currentSecretValue + value
        } else {
            score += 50
        }
    }
}
