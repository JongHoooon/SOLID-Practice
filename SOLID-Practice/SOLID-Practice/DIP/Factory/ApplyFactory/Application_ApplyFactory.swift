//
//  Application_ApplyFactory.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/17.
//

import Foundation

class Application_ApplyFactory {
    let serviceFactory: ServiceFactory
    var service: Service?
    
    init(serviceFactory: ServiceFactory) {
        self.serviceFactory = serviceFactory
        service = makeService()
    }
    
    func makeService() -> Service {
        return serviceFactory.makeService()
    }
}
