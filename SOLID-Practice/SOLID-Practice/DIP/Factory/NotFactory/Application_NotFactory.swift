//
//  Application_NotFactory.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/17.
//

import Foundation

class Application_NotFactory {
    var service: ServiceConcrete_NotFactory?
    
    init() {
        service = makeService()
    }
    
    /// 구현체에 의존하는 상태
    func makeService() -> ServiceConcrete_NotFactory {
        return ServiceConcrete_NotFactory()
    }
}
