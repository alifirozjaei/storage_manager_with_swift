//
//  QualityAssuranceDept.swift
//
//
//  Created by Vahid on 12/10/23.
//

import Foundation

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
		/// `item is String` is a `Bool`, right? lines below can be simplified
		if item is String {
			memo(true)
		} else {
			memo(false)
		}
	}
}
