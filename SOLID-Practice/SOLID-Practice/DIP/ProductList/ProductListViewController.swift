//
//  ProductListViewController.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/17.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: UITableViewController {
    
    static func create(with viewModel: ProductListViewModel) -> ProductListViewController {
        let viewController = ProductListViewController(viewModel: viewModel)
        
        return viewController
    }
    
    private let disposeBag = DisposeBag()
    private var viewModel: ProductListViewModel!
    
    lazy var calButton: UIButton = {
        let button = UIButton()
        button.setTitle("계산", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)

        return button
    }()

    lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("구매", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)

        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        bindInput()
        bindOutput()
    }

    
    // MARK: - Init
    
    init(viewModel: ProductListViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sampleDataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductTableViewCell
        cell.model = viewModel.sampleDataSource[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapCellForRow(at: indexPath.row)
    }
    
    override func tableView(_: UITableView, didDeselectRowAt: IndexPath) {
        viewModel.didTapCellForRow(at: didDeselectRowAt.row)
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
}

private extension ProductListViewController {
    
    func setupViews() {
        tableView.allowsMultipleSelection = true
        view.backgroundColor = .white
        title = "메뉴 리스트"
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: calButton), UIBarButtonItem(customView: buyButton)]
    }
    
    @objc
    private func didTapCalButton() {
        viewModel.didTapCalButton()
    }
    
    @objc
    func didTapBuyButton() {
        viewModel.didTapBuyButton()
    }
    
    func bindInput() {
        calButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.didTapCalButton()
        })
        .disposed(by: disposeBag)
        
        buyButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.didTapBuyButton()
        })
        .disposed(by: disposeBag)
    }
    
    func bindOutput() {
        viewModel.totalFee
            .subscribe(onNext: { [weak self] in
                self?.title = $0
                
            })
            .disposed(by: disposeBag)
    }
}
