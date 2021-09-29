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
    var round = 1
    // сумма очков за раунд
    var points = 0
    lazy var secondViewController = getSecondViewController()
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!

    override func loadView() {
        super.loadView()
        print("loadView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        // генерируем случайное число
        number = Int.random(in: 1...50)
        // устанавливаем загаданное число в метку
        label.text = String(number)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    private func getSecondViewController() -> SecondViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SecondViewController")
        return viewController as! SecondViewController
    }

    @IBAction func checkNumber() {
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

