//
//  string.swift
//  
//
//  Created by Fang Ling on 2023/5/4.
//

import Foundation

/* Conversion between base64 encoded string and plain text.
 * See: https://stackoverflow.com
 *      /questions/29365145/how-can-i-encode-a-string-to-base64-in-swift
 */
extension String {
    func from_base64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func to_base64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

/// Returns true if the string can be convert to Int
extension String {
    func is_int() -> Bool {
        if Int(self) != nil {
            return true
        } else {
            return false
        }
    }
}
