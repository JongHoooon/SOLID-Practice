//
//  EmojiViewController.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/16.
//

import UIKit
import SnapKit
import RxSwift

final class EmojiViewController: UIViewController {
    
    private let disposBag = DisposeBag()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16.0
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let redAppleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0

        
        return label
    }()
    
    private let greenAppleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0

        
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16.0
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let redButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("🍎 버튼", for: .normal)

        return button
    }()

    private let greenButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("🍏 버튼", for: .normal)

        return button
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.text = "info"

        return label
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - Bind

private extension EmojiViewController {
    
    private func bindInput() {
        
    }
    
    private func bindOutput() {
        
    }
}

// MARK: - Private Method

private extension EmojiViewController {
    func configLayout() {
        [
            labelStackView,
            buttonStackView,
            infoLabel
        ].forEach { view.addSubview($0) }
        
        [
            redAppleLabel,
            greenAppleLabel
        ].forEach { labelStackView.addArrangedSubview($0) }
        
        [
            redButton,
            greenButton
        ].forEach { buttonStackView.addArrangedSubview($0) }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(100.0)
        }
        
        infoLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-32.0)
            $0.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalTo(infoLabel.snp.top).offset(-16.0)
            $0.centerX.equalToSuperview()
        }
    }
}
