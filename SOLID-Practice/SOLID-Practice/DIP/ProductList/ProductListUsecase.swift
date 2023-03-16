//
//  ProductListUsecase.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/17.
//

import Foundation

protocol ProductListUseCase {
    func calculate(_ productList: [Product]) -> Double
}

final class ProductListUseCaseImpl: ProductListUseCase {
    func calculate(_ productList: [Product]) -> Double {
        var totalFee: Double = 0.0
        productList.forEach { product in
            totalFee += product.isSale ? product.price * 0.8 : product.price
        }
        return totalFee
    }
}
