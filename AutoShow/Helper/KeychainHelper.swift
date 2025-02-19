//
//  KeychainHelper.swift
//  AutoShow
//
//  Created by Timofey Sinitsyn on 19.02.2025.
//

import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()
    private init() {}
    
    func save(_ data: String, service: String, account: String) {
        let data = Data(data.utf8)
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ] as [String: Any]
        
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
}
