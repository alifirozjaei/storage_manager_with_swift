//
//  Reporter.swift
//
//
//  Created by Vahid on 12/10/23.
//

import Foundation

class Reporter {
	private var storage: StorageFacility?
	
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
	
	func numberOfItem(_ item: Any) -> Int {
		guard let repository = self.storage?.getRepository() else {
			return 0
		}
		
		if let itemString = item as? String {
			let filteredItems = repository.filter { $0 == itemString }
			return filteredItems.count
		} else {
			return 0
		}
	}
}
