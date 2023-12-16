//
//  StorageError.swift
//
//
//  Created by Vahid on 12/10/23.
//

import Foundation

enum StorageError: Error {
	case emptyItemError
	case notStringError
	case storageIsFullError
	case invalidItemType
}
