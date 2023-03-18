//
//  ButtonsViewModel.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/18.
//

import Foundation

struct ButtonsViewModelActions {
    let showYellowButton: (Int) -> Void
    let showGreenButton: (Int) -> Void
}

protocol ButtonsViewModelInput {
    func didTapYellowButton()
    func didTapGreenButton()
}

protocol ButtonsViewModelOutput {}

protocol ButtonsViewModel: ButtonsViewModelInput, ButtonsViewModelOutput {}

final class Button
