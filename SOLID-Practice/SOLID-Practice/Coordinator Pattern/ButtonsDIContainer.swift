//
//  ButtonsDIContainer.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/18.
//

import Foundation
import UIKit

class ButtonsDIContainer {
    func makeButtonCoordinator(navigationController: UINavigationController) -> ButtonsCoordinator {
        return ButtonsCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension ButtonsDIContainer: ButtonsCoordinatorDependencies {
    func makeButtonViewController(actions: ButtonsViewModelActions) -> ButtonsViewController {
        return ButtonsViewController.create(with: makeButtonsViewModel(actions: actions))
    }
    
    func makeYellowViewController(tapCount: Int) -> UIViewController {
        return YellowViewController.create(tapCount: tapCount)
    }
    
    func makeGreenViewController(tapCount: Int) -> UIViewController {
        return GreenViewController.create(tapCount: tapCount)
    }
}

private extension ButtonsDIContainer {
    func makeButtonsUseCaseImpl() -> ButtonsUseCase {
        return ButtonsUseCaseImpl()
    }
    
    func makeButtonsViewModel(actions: ButtonsViewModelActions) -> ButtonsViewModel {
        return ButtonsViewModelImpl(
            actions: actions,
            buttonsUseCase: makeButtonsUseCaseImpl()
        )
    }
}
