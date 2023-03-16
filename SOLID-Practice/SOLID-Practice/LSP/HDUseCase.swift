//
//  HDUseCase.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/16.
//

import Foundation

final class HDUseCase: CardUseCase {
    func calculatePoint(_ input: Int) -> Double {
        return Double(input) * 0.005
    }
}
