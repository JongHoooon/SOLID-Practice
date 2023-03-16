//
//  PointViewController.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/16.
//

import UIKit
import RxSwift
import SnapKit

final class PointViewController: UIViewController {
    
    let viewModel: PointViewModel
    let disposeBag = DisposeBag()
    
    let pointButton: UIButton = {
        let button = UIButton()
        button.setTitle("point 계산하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemGray3
        
        return button
    }()
    
    let pointLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "결제 대기 중..."
        
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        bind()
    }
    
    // MARK: - Init
    init(viewModel: PointViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Bind

private extension PointViewController {
    
    func bind() {
        bindInput()
        bindOutput()
    }
    
    func bindInput() {
        pointButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.didTapPointButton()
            })
            .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        viewModel.pointInfo
            .asDriver(onErrorJustReturn: "에러발생!")
            .drive(pointLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
}


// MARK: - Private Method
private extension PointViewController {
    
    func configureLayout() {
        view.backgroundColor = .systemBackground
        
        [
            pointButton,
            pointLabel
        ].forEach { view.addSubview($0) }
        
        pointLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(48.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(80.0)
        }
        
        pointButton.snp.makeConstraints {
            $0.top.equalTo(pointLabel.snp.bottom).offset(16.0)
            $0.centerX.equalToSuperview()
        }
    }
}
