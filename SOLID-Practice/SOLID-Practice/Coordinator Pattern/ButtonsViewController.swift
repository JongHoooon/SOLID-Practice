//
//  ButtonsViewController.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/18.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ButtonsViewController: UIViewController {
    
    static func create(with viewModel: ButtonsViewModel) -> ButtonsViewController {
        let viewController = ButtonsViewController(viewModel: viewModel)
        
        return viewController
    }
    
    private let disposeBag = DisposeBag()
    private var viewModel: ButtonsViewModel!
    
    
    let buttonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16.0
        
        return view
    }()
    
    let yellowButton: UIButton = {
        let button = UIButton()
        button.setTitle("🟡 버튼", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.systemYellow.cgColor
        
        return button
    }()
    
    let greenButton: UIButton = {
        let button = UIButton()
        button.setTitle("🟢 버튼", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.systemGreen.cgColor
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        bindInput()
    }
    
    init(viewModel: ButtonsViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ButtonsViewController {
    func bindInput() {
        yellowButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.didTapYellowButton()
            })
            .disposed(by: disposeBag)
        
        greenButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.didTapGreenButton()
            })
            .disposed(by: disposeBag)
    }
}

private extension ButtonsViewController {
    
    func configureLayout() {
        
        view.backgroundColor = .systemBackground
        
        [
            yellowButton,
            greenButton
        ].forEach { buttonStackView.addArrangedSubview($0) }
        
        [
            buttonStackView
        ].forEach { view.addSubview($0) }
        
        buttonStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
