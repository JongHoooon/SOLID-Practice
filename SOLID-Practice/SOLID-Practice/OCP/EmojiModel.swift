//
//  EmojiModel.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/16.
//

import Foundation

struct EmojiModel {
    enum EmojiType: String {
        case redApple
        case greenApple
    }
    let emoji: EmojiType
    var currentRedColor: Int = 0
    var currentGreenColor: Int = 0
}
