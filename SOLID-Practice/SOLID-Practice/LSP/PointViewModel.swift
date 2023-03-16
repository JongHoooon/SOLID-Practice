//
//  PointViewModel.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/16.
//

import RxSwift
import RxCocoa

protocol PointViewModelInput {
    func didTapPointButton()
}

protocol PointViewModelOutput {
    var pointInfo: PublishRelay<String> { get }
}

protocol PointViewModel: PointViewModelInput, PointViewModelOutput {}

final class PointViewModelImpl: PointViewModel {
    
    let cardUseCase: CardUseCase
    
    init(cardUseCase: CardUseCase) {
        self.cardUseCase = cardUseCase
    }
    
    // MARK: - Output
    
    var pointInfo: RxRelay.PublishRelay<String> = PublishRelay()
    
    // MARK: - Input
    
    func didTapPointButton() {
        let card: String = {
            if cardUseCase is WRUseCase {
               return "WR"
            } else {
                return "HD"
            }
        }()
        let input: Int = Int.random(in: 1...100) * 100
        let point: Double = cardUseCase.calculatePoint(input)
        pointInfo.accept("\(card)카드로 결제하겠습니다.\n\(input)₩ 결제하겠습니다.\n\(point)포인트 적립 예정입니다.")
    }
}
