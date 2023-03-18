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
    
    //    static func
    
    private let disposeBag = DisposeBag()
    //    private var viewModel:
    
    
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
