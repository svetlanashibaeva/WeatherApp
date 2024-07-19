//
//  DIManager.swift
//  WeatherApp
//
//  Created by Светлана Шибаева on 18.07.2024.
//

import Foundation

final class DIManager {
    
    static let shared = DIManager()
    
    private var services = [String: () -> Any]()
    
    private init() {}
    
    // записываем как ди менеджер должен сохранить реализацию, как его доставать и получать
    func register<T>(type: T.Type, closure: @escaping () -> Any) {
        let key = String(describing: type.self)
        services[key] = closure
    }
    
    // получаем сервис из ди менеджера
    func resolve<T>(type: T.Type) -> T {
        guard let resolver = services[String(describing: type.self)] else {
            fatalError("Сервис не зарегестрирован")
        }
        
        guard let service = resolver() as? T else {
            fatalError("Неверный тип")
        }
        
       return service
    }
}
