//
//  EmojiViewModel.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/16.
//

import Foundation
import RxSwift
import RxCocoa

protocol EmojiViewModelInput {
    func viewWillAppear()
    func didTapRedAppleButton()
    func didTapGreenAppleButton()
    func didTapClearButton()
}

protocol EmojiViewModelOutput {
    var countInfo: PublishRelay<(redCount: Int, greenCount: Int)> { get }
}

protocol EmojiViewModel: EmojiViewModelInput, EmojiViewModelOutput {}

final class EmojiViewModelImpl: EmojiViewModel {
    
    private var disposeBag = DisposeBag()
    private var emojiUseCase: EmojiUseCase?
    
    init(emojiUserCase: EmojiUseCase) {
        self.emojiUseCase = emojiUserCase
    }
    
    // MARK: - Output
    
    var countInfo: PublishRelay<(redCount: Int, greenCount: Int)> = PublishRelay()
    
    // MARK: - Input
    
    func viewWillAppear() {
        loadEmojiInfo()
    }
    
    func didTapRedAppleButton() {
        emojiUseCase?.updateEmoji(with: EmojiModel(emoji: .redApple))
            .map { emojiModel in
                return (emojiModel.currentRedColor, emojiModel.currentGreenColor)
            }
            .subscribe(onNext: { [weak self] in
                self?.countInfo.accept($0)
            })
            .disposed(by: disposeBag)
    }
    
    func didTapGreenAppleButton() {
        emojiUseCase?.updateEmoji(with: EmojiModel(emoji: .greenApple))
            .map { emojiModel in
                return (emojiModel.currentRedColor, emojiModel.currentGreenColor)
            }
            .subscribe(onNext: { [weak self] in
                self?.countInfo.accept($0)
            })
            .disposed(by: disposeBag)
    }
    
    func didTapClearButton() {
        emojiUseCase?.removeEmojuCount()
            .subscribe(onNext: { [weak self] in
                self?.countInfo.accept($0)
            })
            .disposed(by: disposeBag)
    }
}

private extension EmojiViewModelImpl {
    func loadEmojiInfo() {
        emojiUseCase?.getCurrentEmojiCount()
            .map { emojiModel in
                return (emojiModel.currentRedColor, emojiModel.currentGreenColor)
            }
            .subscribe(onNext: { [weak self] in
                self?.countInfo.accept($0)
            })
            .disposed(by: disposeBag)
    }
}
