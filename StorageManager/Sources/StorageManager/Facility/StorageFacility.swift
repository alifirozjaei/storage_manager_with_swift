//
//  StorageFacility.swift
//  
//
//  Created by Vahid on 12/10/23.
//

import Foundation

class StorageFacility {
	// Create fix size array
	private var repository: [String?] = [] {
		willSet {
			print("Repo Updated: \(newValue)")
		}
	}
	
	private var reporter: Reporter
	
	init(storage_size: Int, reporter: Reporter) {
		repository = Array(repeating: nil, count: storage_size)
		self.reporter = reporter
		self.reporter.set_storage(self)
		print("StorageFacility Instance Created.")
		print("----------------------------------------")
	}
	
	func store(_ item: String) throws -> Void {
		// check repo is full
		guard let index = repository.firstIndex(where: { $0 == nil}) else {
			throw StorageError.storageIsFullError
		}
		
		// add new item to repo
		repository[index] = item
	}
	
	func getRepository() -> [String?] {
		return self.repository
	}
}
