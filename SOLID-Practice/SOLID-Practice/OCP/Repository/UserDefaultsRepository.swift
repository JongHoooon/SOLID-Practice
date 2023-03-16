//
//  UserDefaultsRepository.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/16.
//

import Foundation

protocol UserDefaultsRepository {
    func save(_ key: String, _ value: Int)
    func get(_ key: String) -> Int?
    func remove(_ key: String)
}

class UserDefaultsRepositoryImpl: UserDefaultsRepository {
    static let shared = UserDefaultsRepositoryImpl()
    private init() {}
    
    let standard = UserDefaults.standard
    
    func save(_ key: String, _ value: Int) {
        return standard.set(value, forKey: key)
    }
    
    func get(_ key: String) -> Int? {
        return standard.object(forKey: key) as? Int
    }
    
    func remove(_ key: String) {
        return standard.removeObject(forKey: key)
    }
}
