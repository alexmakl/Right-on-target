//
//  ViewController.swift
//  Right on target
//
//  Created by Alexander on 19.09.2021.
//

import UIKit

class ViewController: UIViewController {

    var game: Game!

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!

    // MARK: - Жизненный цикл

    override func viewDidLoad() {
        super.viewDidLoad()
        // Создаем экземпляр сущности "Игра"
        game = Game(startValue: 0, endValue: 50, rounds: 5)
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }

    // MARK: - Взаимодействие View - Model

    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        game.currentRound.calculateScore(with: Int(slider.value.rounded()))
        if game.isGameEnded {
            showAlertWith(score: game.currentRound.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentRound.currentSecretValue))
    }

    // MARK: - Обновление View

    private func updateLabelWithSecretNumber(newText: String) {
        label.text = String(newText)
    }

    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(score) очков", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

