//
//  StorageFacility.swift
//  
//
//  Created by Vahid on 12/10/23.
//

import Foundation

protocol Storable {
    associatedtype T
    func store(_ item: T) throws
}


class StorageFacility<T: Equatable>: Storable {
    private(set) var repository: [T?] = [] {
        willSet {
            print(newValue)
        }
    }
    
    init(storageSize: Int) {
        repository = Array(repeating: nil, count: storageSize)
    }
    
    func store(_ item: T) throws -> Void {
        guard let index = repository.firstIndex(where:{$0 == nil}) else {
            throw StorageError.StorageIsFull
        }
        repository[index] = item
    }
    
    func getRepository() -> [T?] {
        return repository
    }
}
