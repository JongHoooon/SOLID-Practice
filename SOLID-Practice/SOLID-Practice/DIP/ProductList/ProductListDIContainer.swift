//
//  ProductListDIContainer.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/17.
//

import Foundation

final class ProductListDIContainer {
    
    lazy var productListViewController: ProductListViewController = {
        return ProductListViewController.create(with: productListViewModel)
    }()
    
    private lazy var productListUseCaseImpl: ProductListUseCase = {
        return ProductListUseCaseImpl()
    }()

    private lazy var productListViewModel: ProductListViewModel = {
    return ProductListViewModelImpl(productListUseCase: productListUseCaseImpl)
    }()
}
