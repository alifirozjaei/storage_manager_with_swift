import Foundation

enum StorageError: Error {
  case emptyItemError 
  case notStringError
  case storageIsFullError
  case invalidItemType
}

class StorageFacility {
  // Create fix size array
  private var repository: [String?] = [] {
    willSet {
      print("-> Repo Updated: \(newValue)")
    }
  }

  init(storage_size: Int) {
    repository = Array(repeating: nil, count: storage_size)
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
  /// MARK: - todo: use composition. make it single responsible
  /// `checkItemExist(_:)` & `numberOfItem(_:)` are different functionalities relative to facility and can be included inside one
  func checkItemExist(_ item: String) -> Bool {
    /// alternative: `contains(_:)`
    if let _ = repository.firstIndex(where: { $0 == item}) {
      return true
    } 
    return false
  }

  func numberOfItem(_ item: String) -> Int {
    /// exercise: utilize `filter(_:)` method
    var counter: Int = 0 
    for storedItem in repository {
      if storedItem == item {
        counter += 1
      }
    }
    return counter
  }
}

class QualityAssuranceDept {
    init() {
      print("Quality Assurance Dept Instance Created.")
      print("----------------------------------------")
    }

    func evaluate(_ item: Any?, memo: (Bool) -> Void ) throws -> Void {
      // check input item is empty
      guard let item = item else {
        throw StorageError.emptyItemError
      }

      if item is String {
        memo(true)
      } else {
        memo(false)
      }
    }
}

class StorageManager {
    private let qa: QualityAssuranceDept = QualityAssuranceDept()
    private var facility: StorageFacility

    init(storage_size: Int) {
      facility = StorageFacility(storage_size: storage_size)
      print("Storage Manager Instance Created.")
      print("----------------------------------------")
    }

    func store(_ item: Any?) throws {
      do {
        // check item is empty
        var itemIsString: Bool = true
        try qa.evaluate(item) {
          itemIsString = $0
        }
        /// better practice: `if let _ = item as? String { ... } 
        if itemIsString {
          // store new item in facility
          try facility.store(item as! String)
        } else {
          throw StorageError.invalidItemType
        }
      } catch {
          throw error
      }
    }
    // MARK: - todo: update the code below based on changes
    func checkItemExist(_ item: Any?) throws -> Bool {
      if item is String {
        return facility.checkItemExist(item as! String)
      } else {
        throw StorageError.invalidItemType
      }
    }
    // MARK: - todo: update the code below based on changes
    func getItemCount(_ item: Any?) throws -> Int {
      if item is String {
        return facility.numberOfItem(item as! String)
      } else {
        throw StorageError.invalidItemType
      }
    }
}


let sm = StorageManager(storage_size: 5)

let items = ["Apple", "Orange", "Banana", "Apple"]
for item in items {
  try? sm.store(item)
}

do {
  let isExist = try sm.checkItemExist("Apple")
  let counts = try sm.getItemCount("Apple")
  print("Check Apple Exist: ", isExist)
  print("Get Apple Count: ", counts)
  
  try sm.getItemCount(10)
} catch {
  print("Error: \(error)")
}

// do {
//   try sm.store("item 1")
//   try sm.store("item 2")
//   try sm.store("item 3")
//   try sm.store(10)
// } catch {
//   print("----------------------------------------")
//   print("Error: \(error)")
// }
