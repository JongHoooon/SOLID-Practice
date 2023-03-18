//
//  ProductListViewModel.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/17.
//

import RxSwift
import RxCocoa

protocol ProductListViewModelInput {
    func didTapCalButton()
    func didTapBuyButton()
    func didTapCellForRow(at index: Int)
}

protocol ProductListViewModelOutput {
    var totalFee: BehaviorRelay<String> { get }
    var sampleDataSource: [Product] { get }
}

protocol ProductListViewModel: ProductListViewModelInput, ProductListViewModelOutput {}

final class ProductListViewModelImpl: ProductListViewModel {
    
    let productListUseCase: ProductListUseCase
    init(productListUseCase: ProductListUseCase) {
        self.productListUseCase = productListUseCase
    }
    
    // Output
    
    var totalFee: BehaviorRelay<String> = .init(value: "총 금액 = \(0)")
    var sampleDataSource = [
        Product(title: "맥크리스피 크리미 어니언", price: 6900, isSale: true),
        Product(title: "더블 쿼터파운더 치즈", price: 7400, isSale: false),
        Product(title: "맥크리스피 디럭스 버거", price: 6800, isSale: false),
        Product(title: "맥크리스피 클래식 버거", price: 5900, isSale: true),
        Product(title: "빅맥", price: 5200, isSale: true),
        Product(title: "1955버거", price: 6400, isSale: true)
    ]
    
    // Input
    
    func didTapCalButton() {
        let resultFee = productListUseCase.calculate(sampleDataSource.filter { $0.isSelected })
        totalFee.accept("총 금액 = \(resultFee)")
    }
    
    func didTapBuyButton() {
        totalFee.accept("구매 완료")
    }
    
    func didTapCellForRow(at index: Int) {
        sampleDataSource[index].isSelected.toggle()
        print("\(index): \(sampleDataSource[index].isSelected)")
    }
}
