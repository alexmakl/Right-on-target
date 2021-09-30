//
//  ViewController.swift
//  Right on target
//
//  Created by Alexander on 19.09.2021.
//

import UIKit

class NumberViewController: UIViewController {

    var game: Game<SecretNumericValue>!

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!

    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        // Создаем экземпляр сущности "Игра"
        game = (GameFactory.getNumericGame() as! Game<SecretNumericValue>)
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }

    // MARK: - Взаимодействие View - Model

    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
        var userSecretValue = game.secretValue
        userSecretValue.value = Int(slider.value)
        game.calculateScore(secretValue: game.secretValue, userValue: userSecretValue)
        if game.isGameEnded {
            showAlertWith(score: game.score)
            game.restartGame()
        } else {
            game.startNewRound()
        }
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.secretValue.value))
    }

    @IBAction func closeCurrentScene() {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Обновление View

    private func updateLabelWithSecretNumber(newText: String) {
        label.text = newText
    }

    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(score) очков", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

