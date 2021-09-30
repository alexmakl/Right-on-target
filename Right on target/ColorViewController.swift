//
//  SecondViewController.swift
//  Right on target
//
//  Created by Alexander on 29.09.2021.
//

import UIKit

class ColorViewController: UIViewController {

    var game: Game<SecretColorValue>!
    // номер "правильной" кнопки
    var correctButtonTag = 0

    @IBOutlet weak var hexLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!

    var buttonsCollection: [UIButton]!
    
    // MARK: - Жизненный цикл
    override func viewDidLoad() {
        super.viewDidLoad()
        // Создаем экземпляр сущности "Игра"
        game = (GameFactory.getColorGame() as! Game<SecretColorValue>)
        buttonsCollection = [button1, button2, button3, button4]
        updateScene()
    }

    private func updateScene() {
        let secretColorString = game.secretValue.value.getByHEXString()
        updateSecretColorLabel(withText: secretColorString)
        updateButtons(withRightSecretValue: game.secretValue)
    }

    @IBAction func compareValue(sender: UIButton) {
        var userValue = game.secretValue
        userValue.value = Color(from: sender.backgroundColor!)
        game.calculateScore(secretValue: game.secretValue, userValue: userValue)
        // Проверяем, окончена ли игра
        if game.isGameEnded {
            // Показываем окно с итогами
            showAlertWith(score: game.score)
            // Рестартуем игру
            game.restartGame()
        } else {
            // Начинаем новый раунд игры
            game.startNewRound()
        }
        updateScene()
    }

    @IBAction func closeCurrentScene() {
        dismiss(animated: true, completion: nil)
    }

    private func updateSecretColorLabel(withText newHEXColorText: String) {
        hexLabel.text = "#\(newHEXColorText)"
    }

    private func updateButtons(withRightSecretValue secretValue: SecretColorValue) {
        correctButtonTag = Array(1...4).randomElement()!
        buttonsCollection.forEach { button in
            if button.tag == correctButtonTag {
                button.backgroundColor = secretValue.value.getByUIColor()
            } else {
                var copySecretValueForButton = secretValue
                copySecretValueForButton.setRandomValue()
                button.backgroundColor = copySecretValueForButton.value.getByUIColor()
            }
        }
    }
    
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(score) очков", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
