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
    let viewModel: EmojiViewModel!
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16.0
        stackView.axis = .horizontal
        
        return stackView
    }()
    
    private let redAppleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .systemGray6
        
        return label
    }()
    
    private let greenAppleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .systemGray6
        
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
    
    private let clearButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("모두 지우기", for: .normal)

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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.viewWillAppear()
    }
    
    // MARK: - Init
    
    init(viewModel: EmojiViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Bind

private extension EmojiViewController {
    private func bind() {
        bindInput()
        bindOutput()
    }
    
    
    private func bindInput() {
        redButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.didTapRedAppleButton()
            })
            .disposed(by: disposBag)
        
        greenButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.didTapGreenAppleButton()
            })
            .disposed(by: disposBag)
        
        clearButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.didTapClearButton()
            })
            .disposed(by: disposBag)
    }
    
    private func bindOutput() {
        
        viewModel.countInfo
            .asDriver(onErrorJustReturn: (0, 0))
            .drive(onNext: { [weak self] in
                let redCount = $0.redCount
                let greenCount = $0.greenCount
                
                self?.infoLabel.text = "🍎 누적합: \(redCount)\n🍏 누적합: \(greenCount)"
                self?.redAppleLabel.text = String(repeating: "🍎", count: redCount)
                self?.greenAppleLabel.text = String(repeating: "🍏", count: greenCount)
            })
            .disposed(by: disposBag)
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
            greenButton,
            clearButton
        ].forEach { buttonStackView.addArrangedSubview($0) }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(300.0)
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
