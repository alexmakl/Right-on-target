//
//  ViewController.swift
//  Right on target
//
//  Created by Alexander on 19.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // загаданное число
    var number = 0
    // раунд
    var round = 0
    // сумма очков за раунд
    var points = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func checkNumber() {
        if round == 0 {
            number = Int.random(in: 1...50)
            label.text = String(number)
            round = 1
        } else {
            let numSlider = Int(slider.value.rounded())
            if numSlider > number {
                points += 50 - numSlider + number
            } else if numSlider < number {
                points += 50 - number + numSlider
            } else {
                points += 50
            }
            if round == 5 {
                let alert = UIAlertController(title: "Игра окончена", message: "Вы заработали \(points) очков", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                round = 1
                points = 0
            } else {
                round += 1
            }
            number = Int.random(in: 1...50)
            label.text = String(number)
        }
    }

}

