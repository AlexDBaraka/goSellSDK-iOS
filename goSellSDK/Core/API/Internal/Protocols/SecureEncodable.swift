//
//  SecureEncodable.swift
//  goSellSDK
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import Foundation

/// Secure Encodable protocol.
internal protocol SecureEncodable: Encodable { }

internal extension SecureEncodable {
    
    // MARK: - Internal -
    // MARK: Methods
    
    /// Secure encodes the model.
    ///
    /// - Parameter encoder: Encoder to use.
    /// - Returns: Secure encoded model.
    /// - Throws: Either encoding error or serialization error.
	func secureEncoded(encryptionKey: String?, using encoder: JSONEncoder = JSONEncoder()) throws -> String {
        
        let jsonData = try encoder.encode(self)
		
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            
            throw TapSerializationError.wrongData
        }
		
		guard let encryptionKey = encryptionKey else {
			
			throw TapSerializationError.wrongData
		}
		
		print("APIClient SecureEncodable encryptionKey", encryptionKey)
		print("APIClient SecureEncodable encrypted", Crypter.encrypt(jsonString, using: encryptionKey))
        guard let encrypted = Crypter.encrypt(jsonString, using: encryptionKey) else {
            
            throw TapSerializationError.wrongData
        }
        
        return encrypted
    }
}
