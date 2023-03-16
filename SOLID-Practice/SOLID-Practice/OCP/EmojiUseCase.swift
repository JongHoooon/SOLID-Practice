//
//  EmojiUseCase.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/16.
//

import Foundation
import RxSwift

protocol EmojiUseCase {
    func updateEmoji(with: EmojiModel) -> Observable<EmojiModel>
    func getCurrentEmojiCount() -> Observable<EmojiModel>
    func removeEmojuCount() -> Observable<(Int, Int)>
}

final class EmojiUseCaseImpl: EmojiUseCase {
    private let userDefaultsService: UserDefaultsService
    
    init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
    }
    
    func updateEmoji(with emojiModel: EmojiModel) -> Observable<EmojiModel> {
        var currentRedCount: Int = userDefaultsService.getRedCount() ?? 0
        var currentGreenCount: Int = userDefaultsService.getGreenCount() ?? 0
        
        // Business Logic: 두 배 이상 차이나면 적은 수를 * 2 후 추가한다
        switch emojiModel.emoji {
        case .redApple:
            if currentRedCount * 2 < currentGreenCount {
                currentRedCount = currentRedCount * 2 + 1
            } else {
                currentRedCount += 1
            }
        case .greenApple:
            if currentGreenCount * 2 < currentRedCount {
                currentGreenCount = currentGreenCount * 2 + 1
            } else {
                currentGreenCount += 1
            }
        }
        
        updateEmoji(currentRedCount, currentGreenCount)
        
        let emojiModel = EmojiModel(
            emoji: emojiModel.emoji,
            currentRedColor: currentRedCount,
            currentGreenColor: currentGreenCount
        )
        
        return Observable.just(emojiModel)
    }
    
    func getCurrentEmojiCount() -> Observable<EmojiModel> {
        let currentRedCount: Int = userDefaultsService.getRedCount() ?? 0
        let currentGreenCount: Int = userDefaultsService.getGreenCount() ?? 0
        let emojiModel = EmojiModel(
            emoji: .redApple,
            currentRedColor: currentRedCount,
            currentGreenColor: currentGreenCount
        )
        
        return Observable.just(emojiModel)
    }
    
    func removeEmojuCount() -> Observable<(Int, Int)> {
        userDefaultsService.removeRedCount()
        userDefaultsService.removeGreenCount()
        
        let currentRedCount: Int = userDefaultsService.getRedCount() ?? 0
        let currentGreenCount: Int = userDefaultsService.getGreenCount() ?? 0
        return Observable.just((currentRedCount, currentGreenCount))
    }
}

// MARK: - Private Method

private extension EmojiUseCaseImpl {
    func updateEmoji(_ redCount: Int, _ greenCount: Int) {
        userDefaultsService.saveRedCount(redCount)
        userDefaultsService.saveGreenCount(greenCount)
    }
}
