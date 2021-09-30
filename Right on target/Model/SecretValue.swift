//
//  SecretValue.swift
//  Right on target
//
//  Created by Alexander on 30.09.2021.
//

typealias SecretNumericValue = SecretValue<Int>
typealias SecretColorValue = SecretValue<Color>

protocol SecretValueProtocol {
    // ассоциированный тип, который будет определять тип данных значения
    associatedtype ValueType
    // Загаданное значение
    var value: ValueType { get }
    mutating func setRandomValue()
}

struct SecretValue<T: Equatable>: SecretValueProtocol {
    typealias ValueType = T
    var value: T
    // замыкание для выбора случайного значения
    private let randomValueClosure: (T) -> T

    init(initialValue: T, randomValueClosure: @escaping (T) -> T) {
        value = initialValue
        self.randomValueClosure = randomValueClosure
    }

    mutating func setRandomValue() {
        self.value = randomValueClosure(self.value)
    }
}
