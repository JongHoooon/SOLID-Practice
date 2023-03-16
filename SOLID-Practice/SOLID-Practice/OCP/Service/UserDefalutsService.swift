//
//  UserDefalutsService.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/16.
//

import Foundation

fileprivate enum Key: String {
    case redCount = "redCount"
    case greenCount = "greenCount"
}

protocol UserDefaultsService {
    func saveRedCount(_ count: Int)
    func saveGreenCount(_ count: Int)
    
    func getRedCount() -> Int?
    func getGreenCount() -> Int?
    
    func removeRedCount()
    func removeGreenCount()
}

class UserDefaultServiceImpl: UserDefaultsService {
    private let userDefaultRepository: UserDefaultsRepository
    
    init(userDefaultRepository: UserDefaultsRepository) {
        self.userDefaultRepository = userDefaultRepository
    }
    
    // MARK: - Save
    
    func saveRedCount(_ count: Int) {
        userDefaultRepository.save(Key.redCount.rawValue, count)
    }
    
    func saveGreenCount(_ count: Int) {
        userDefaultRepository.save(Key.redCount.rawValue, count)
    }
    
    // MARK: - Get
    
    func getRedCount() -> Int? {
        userDefaultRepository.get(Key.redCount.rawValue)
    }
    
    func getGreenCount() -> Int? {
        userDefaultRepository.get(Key.greenCount.rawValue)
    }
    
    // MARK: - Remove
    
    func removeRedCount() {
        userDefaultRepository.remove(Key.redCount.rawValue)
    }
    
    func removeGreenCount() {
        userDefaultRepository.remove(Key.greenCount.rawValue)
    }
}
