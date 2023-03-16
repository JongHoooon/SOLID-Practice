//
//  ServiceConcrete_ApplyFactory.swift
//  SOLID-Practice
//
//  Created by JongHoon on 2023/03/17.
//

import Foundation

class ServiceConcrete_ApplyFactory: ServiceFactory {
    func makeService() -> Service {
        return ServiceConcreteImpl()
    }
}
