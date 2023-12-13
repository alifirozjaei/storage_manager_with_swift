//
//  Reporter.swift
//
//
//  Created by Vahid on 12/10/23.
//

import Foundation
				
class Reporter {
	/// `coupling` causes memory leaks. Look into different reference types.
	weak private var storage: StorageFacility?
	
	init() {
		print("Reporter Instance Created.")
		print("----------------------------------------")
	}
	
	func set_storage(_ storage: StorageFacility){
		self.storage = storage
	}
	
	func itemExist(_ item: Any) -> Bool {
		if let repository = self.storage?.getRepository(),
		   let itemString = item as? String {
			return repository.contains(itemString)
		}
		return false
	}
	/// If a repository is non-existant, it is a better practice to inform clients of a `StorageError`
	func numberOfItem(_ item: Any) -> Int {
		guard let repository = self.storage?.getRepository() else {
			return 0
		}
		/// Alternative: `compactMap(_:)`
		/// https://developer.apple.com/documentation/swift/sequence/compactmap(_:)
		/// enclose type cast within mapping function
		if let itemString = item as? String {
			let filteredItems = repository.filter { $0 == itemString }
			return filteredItems.count
		} else {
			return 0
		}
	}
}
