//
//  ButtonsCoordinator.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/18.
//

import UIKit

protocol ButtonsCoordinatorDependencies {
    func makeButtonViewController(actions: ButtonsViewModelActions) -> ButtonsViewController
    
    func makeYellowViewController(tapCount: Int) -> UIViewController
    func makeGreenViewController(tapCount: Int) -> UIViewController
}

final class ButtonsCoordinator {
    private weak var navigationController: UINavigationController?
    private let dependencies: ButtonsCoordinatorDependencies
    
    init(
        navigationController: UINavigationController,
        dependencies: ButtonsCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let actions = ButtonsViewModelActions(
            showYellowButton: showYellow(tapCount:),
            showGreenButton: showGreen(tapCount:)
        )
        let vc = dependencies.makeButtonViewController(actions: actions)
        navigationController?.pushViewController(vc, animated: true)
    }
}

private extension ButtonsCoordinator {
    
    func showYellow(tapCount: Int) {
        let vc = dependencies.makeYellowViewController(tapCount: tapCount)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func showGreen(tapCount: Int) {
        let vc = dependencies.makeGreenViewController(tapCount: tapCount)
        navigationController?.pushViewController(vc, animated: true)
    }
}
