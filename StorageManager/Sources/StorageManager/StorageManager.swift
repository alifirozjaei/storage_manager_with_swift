// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

struct AnyEqualable: Equatable { }

class StorageManager: Storable {
    typealias T = AnyEqualable
    
    private var facilities: [String: Any] = [:]
    private let storageSize: Int
    private let reporter = Reporter()
    
    init(storageSize: Int) {
        self.storageSize = storageSize
    }
    
    func store<T: Equatable>(_ item: T) throws {
        let typeName = String(describing: type(of: item))
        
        if let facility = facilities[typeName] as? StorageFacility<T> {
            try facility.store(item)
        } else {
            let newFacility = StorageFacility<T>(storageSize: self.storageSize)
            try newFacility.store(item)
            facilities[typeName] = newFacility
        }
    }
    
    func itemExist<T: Equatable>(_ item: T) -> Bool {
        let typeName = String(describing: type(of: item))
        
        if let facility = facilities[typeName] as? StorageFacility<T> {
            return reporter.itemExist(item, in: facility.getRepository())
        }
        
        return false
    }
    
    func numberOfItem<T: Equatable>(_ item: T) -> Int {
        let typeName = String(describing: type(of: item))
        
        if let facility = facilities[typeName] as? StorageFacility<T> {
            return reporter.numberOfItem(item, in: facility.getRepository())
        }
        
        return 0
    }
}