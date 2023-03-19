//
//  YellowViewController.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/18.
//

import UIKit
import SnapKit

class YellowViewController: UIViewController {

    static func create(tapCount: Int) -> YellowViewController {
        return YellowViewController(tapCount: tapCount)
    }

    let tapCount: Int

    init(tapCount: Int) {
        self.tapCount = tapCount
        super.init(nibName: nil, bundle: nil)
        
        view.backgroundColor = .systemYellow
    }

    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented")
    }

    lazy var cntLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addSubviews()
        makeConstraints()
    }

    private func setupViews() {
        cntLabel.text = String(tapCount)
    }

    private func addSubviews() {
        view.addSubview(cntLabel)
    }

    private func makeConstraints() {
        cntLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

}
