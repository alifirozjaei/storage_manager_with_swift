import Foundation

enum StorageError: Error {
  case emptyItemError 
  case notStringError
  case storageIsFullError
  case invalidItemType
}

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
        throw error
    }
  }
}


let sm = StorageManager(storage_size: 5)

let items = ["Apple", "Orange", "Banana", "Apple"]
for item in items {
  try? sm.store(item)
}

let isExist = sm.reporter.itemExist("Apple")
let counts =  sm.reporter.numberOfItem("Apple")
print("Check Apple Exist: ", isExist)
print("Get Apple Counts: ", counts)
  
