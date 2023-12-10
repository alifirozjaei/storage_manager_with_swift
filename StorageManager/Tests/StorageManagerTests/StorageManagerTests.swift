import XCTest
@testable import StorageManager

final class StorageManagerTests: XCTestCase {
	
	private weak var reporter: Reporter? /// `weak` references ensure that `ARC` will cleanup references when possible
	
	override func tearDown() {
		super.tearDown()
		XCTAssertNil(reporter) /// Memory leak detection
	}
	/// create a system under test
	/// validate that there will be no memory leaks within the system through `tearDown()` method.
	/// - Success: No memory leaks, horay!
	/// - Failure: There is a memory leak and should be investigated.
	func test_memoryIntegrity() throws {
		
		let sut = StorageManager(storage_size: 5)
		
		let items = ["Apple", "Orange", "Banana", "Apple"]
		for item in items {
			try sut.store(item)
		}
		
		let exists = sut.reporter.itemExist("Apple")
		let numberOfItems =  sut.reporter.numberOfItem("Apple")
		
		XCTAssert(exists)
		XCTAssertEqual(numberOfItems, 2)
		
		self.reporter = sut.reporter /// Pass and persist reference
	}
	
	func test_shouldFailOnCapacityFull() throws {
		let sut = StorageManager(storage_size: 4)
		
		let firstOrder: [String] = ["Apple", "Orange", "Pear", ""]
		for item in firstOrder {
			try sut.store(item)
		}
		
		let secondOrder = "Banana"
		XCTAssertThrowsError(try sut.store(secondOrder)) { error in
			let failure = error as? StorageError
			XCTAssertNotNil(failure)
			XCTAssertTrue(failure == StorageError.storageIsFullError)
		}
	}

}
