//
//  ProductListUseCaseTests.swift
//  SOLID-PracticeTests
//
//  Created by JongHoon on 2023/03/18.
//

import XCTest
@testable import SOLID_Practice

// use case를 테스트 - use case는 그대로 두고 다른 요인을 바꿔도 기대하는 값이 나온느지 체크

class ProductListUseCaseTests: XCTestCase {
    var sampleDataSource = [
        Product(title: "맥크리스피 크리미 어니언", price: 6900, isSale: true),
        Product(title: "더블 쿼터파운더 치즈", price: 7400, isSale: false),
        Product(title: "맥크리스피 디럭스 버거", price: 6800, isSale: false),
        Product(title: "맥크리스피 클래식 버거", price: 5900, isSale: true),
        Product(title: "빅맥", price: 5200, isSale: true),
        Product(title: "1955버거", price: 6400, isSale: true)
    ]
    
    func testProductListUseCase_whenAllIsNotSaleProduct_thenCalculateAccuracy() {
        // given
        let useCase = ProductListUseCaseImpl()
        
        // when
        let data = sampleDataSource
            .map {
                Product(
                    title: $0.title,
                    price: $0.price,
                    isSale: false
                )}
        
        // then
        let result = useCase.calculate(data)
        let expectValue = data
            .map { $0.price }
            .reduce(0, +)
        
        XCTAssertTrue(expectValue == result)
    }
    
    func testProductListUseCase_whenAllIsAllSaleProduct_thenCalculateAccuracy() {
        // given
        let useCase = ProductListUseCaseImpl()
        
        // when
        let data = sampleDataSource
            .map {
                Product(
                    title: $0.title,
                    price: $0.price,
                    isSale: true
                )}
        
        // then
        let result = useCase.calculate(data)
        let expectValue = data
            .map { $0.price * 0.8 }
            .reduce(0, +)
        
        XCTAssertTrue(expectValue == result)
    }
}
