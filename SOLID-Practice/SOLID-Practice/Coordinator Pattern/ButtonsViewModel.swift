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

final class ButtonsViewModelImpl: ButtonsViewModel {
    
    private let actions: ButtonsViewModelActions
    private var buttonsUseCase: ButtonsUseCase
    
    init(actions: ButtonsViewModelActions, buttonsUseCase: ButtonsUseCase) {
        self.actions = actions
        self.buttonsUseCase = buttonsUseCase
    }
    
    // MARK: - Input
    
    func didTapYellowButton() {
        buttonsUseCase.yellowButtonCount += 1
        actions.showYellowButton(buttonsUseCase.yellowButtonCount)
    }
    
    func didTapGreenButton() {
        buttonsUseCase.greenButtonCount += 1
        actions.showGreenButton(buttonsUseCase.greenButtonCount)
    }
}
