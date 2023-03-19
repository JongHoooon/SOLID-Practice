//
//  ProductListVIewModelTests.swift
//  SOLID-PracticeTests
//
//  Created by JongHoon on 2023/03/18.
//

@testable import SOLID_Practice
import XCTest

// viewModel 테스트 - viewModel은 그대로 두고, 안에서 사용하는 UseCase를 mock으로 바꾸어 가며 테스

final class ProductListVIewModelTests: XCTestCase {

    var sampleDataSource = [
        Product(title: "맥크리스피 크리미 어니언", price: 6900, isSale: true),
        Product(title: "더블 쿼터파운더 치즈", price: 7400, isSale: false),
        Product(title: "맥크리스피 디럭스 버거", price: 6800, isSale: false),
        Product(title: "맥크리스피 클래식 버거", price: 5900, isSale: true),
        Product(title: "빅맥", price: 5200, isSale: true),
        Product(title: "1955버거", price: 6400, isSale: true)
    ]
    
    class ProductListUseCaseMock: ProductListUseCase {
        func calculate(_ productList: [Product]) -> Double {
            var totalFee: Double = 0.0
            productList.forEach {
                totalFee += $0.isSale ? $0.price * 0.5 : $0.price
            }
            return totalFee
        } 
    }
    
    func test_whenUseCaseChanged_thenSuccessAccuracy() {
        // given
        let useCase = ProductListUseCaseMock()
        let viewModel = ProductListViewModelImpl(productListUseCase: useCase)
        
        // when (= input)
        viewModel.didTapCellForRow(at: 0)
        viewModel.didTapCellForRow(at: 1)
        viewModel.didTapCalButton()
        
        // then (= output)
        XCTAssertEqual(viewModel.totalFee.value, "총 금액 = \(6900 * 0.5 + 7400)")
    }
}
