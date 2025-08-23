//
//  DIContainer.swift
//  UnSplashExample
//
//  Created by 이동기 on 8/3/25.
//

import Foundation

public class DIContainer {
    
    init() { }
    
    // 싱글턴을 유지하기 위한 메서드
    final func shared<T>(__function: String = #function, _ factory: () -> T) -> T {
        sharedInstanceLock.lock()
        defer {
            sharedInstanceLock.unlock()
        }
        if let instance = (sharedInstances[__function] as? T?) ?? nil {
            return instance
        }
        let instance = factory()
        sharedInstances[__function] = instance
        
        return instance
    }
    
    private let sharedInstanceLock = NSRecursiveLock()
    private var sharedInstances = [String: Any]()
    
    deinit {
        #if DEBUG
        print("\(type(of: self)) deinit")
        #endif
    }
    
}
