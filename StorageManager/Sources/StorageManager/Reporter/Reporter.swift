//
//  Reporter.swift
//
//
//  Created by Vahid on 12/10/23.
//

import Foundation

protocol Reportable {
    func itemExist<T: Equatable>(_ item: T, in items: [T?]) -> Bool
    func numberOfItem<T: Equatable>(_ item: T, in items: [T?]) -> Int
}

class Reporter: Reportable {
    func itemExist<T: Equatable>(_ item: T, in items: [T?]) -> Bool {
        return items.contains(item)
    }
    
    func numberOfItem<T: Equatable>(_ item: T, in items: [T?]) -> Int {
        return items.filter{$0 == item}.count
    }
}
				