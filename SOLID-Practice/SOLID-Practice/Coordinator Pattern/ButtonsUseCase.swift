//
//  ButtonsUseCase.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/18.
//

import Foundation

protocol ButtonUseCase {
    var yellowButtonCount: Int { get set }
    var greenButtonCount: Int { get set }
}

final class ButtonUseCaseImpl: ButtonUseCase {
    var yellowButtonCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "yellowButton")
        } set {
            UserDefaults.standard.set(newValue, forKey: "yellowButton")
        }
    }
    
    var greenButtonCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: "greenButton")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "greenButton")
        }
    }
}
