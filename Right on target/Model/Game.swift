//
//  Game.swift
//  Right on target
//
//  Created by Alexander on 29.09.2021.
//

protocol GameProtocol {
    associatedtype SecretType
    var score: Int { get }
    var secretValue: SecretType { get }
    var isGameEnded: Bool { get }
    func restartGame()
    func startNewRound()
    // сравнение значения пользователя с загаданным и подсчет очков
    func calculateScore(secretValue: SecretType, userValue: SecretType)
}

class Game<T: SecretValueProtocol>: GameProtocol {
    typealias SecretType = T
    var score = 0
    var secretValue: T
    private var compareClosure: (T, T) -> Int
    private var roundsCount: Int!
    private var currentRoundNumber = 0
    var isGameEnded: Bool {
        if currentRoundNumber == roundsCount {
            return true
        } else {
            return false
        }
    }

    init(secretValue: T, rounds: Int, compareClosure: @escaping (T, T) -> Int) {
        self.secretValue = secretValue
        roundsCount = rounds
        self.compareClosure = compareClosure
        startNewRound()
    }

    func restartGame() {
        score = 0
        currentRoundNumber = 0
        startNewRound()
    }

    func startNewRound() {
        currentRoundNumber += 1
        self.secretValue.setRandomValue()
    }

    func calculateScore(secretValue: T, userValue: T) {
        score = score + compareClosure(secretValue, userValue)
    }
}
