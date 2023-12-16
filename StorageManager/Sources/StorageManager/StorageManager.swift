// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

class StorageManager {
	private let qa: QualityAssuranceDept = QualityAssuranceDept()
	private var facility: StorageFacility
	let reporter: Reporter = Reporter()
	
	init(storage_size: Int) {
		facility = StorageFacility(storage_size: storage_size, reporter: reporter)
		print("Storage Manager Instance Created.")
		print("----------------------------------------")
	}
	
	func store(_ item: Any?) throws {
		do {
			// Check if item is a string
			guard let itemString = item as? String else {
				throw StorageError.invalidItemType
			}
			
			// Store the item in the facility
			try facility.store(itemString)
		} catch {
			/// `store(_:)` method is a throwing function. No need to `catch (let error)` if no further operations are running.
			throw error
		}
	}
}
