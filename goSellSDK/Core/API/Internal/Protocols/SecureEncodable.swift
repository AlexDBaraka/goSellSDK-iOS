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
    func secureEncoded(using encoder: JSONEncoder = JSONEncoder()) throws -> String {
        
        let jsonData = try encoder.encode(self)
		print("APIClient SecureEncodable jsonData", String(data: jsonData, encoding: .utf8))
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            
            throw TapSerializationError.wrongData
        }
        /*guard let encryptionKey = SettingsDataManager.shared.settings?.encryptionKey else {
            
            throw TapSerializationError.wrongData
        }*/
		let encryptionKey = "-----BEGIN PUBLIC KEY-----\nMIIBIDANBgkqhkiG9w0BAQEFAAOCAQ0AMIIBCAKCAQEA1TG4EN/LaWq4txZjTxlA\nSk9B8b5MDH9FIWX3iTzkoCoifg5EHXInMj9aluCvPDe6e4QiKMZ+PTEFno2b4Oh7\nyl2L1y1RGt9UaSu6ZIW3dlLKL4AM7X22fkTVhfd5hgAhcmKh4uhlyfA1fQ3FPEK9\na6WoB/KSLqBOfMVVoGa7WghY9q0r+zkcr1VL3zcj9v9sTmNLf87wsa+1DASx0rWe\nR5AtC8AtXSlOCOgbAXeFOkIOYLKObG8MagNj/r7vg2gJ3a1Df3apWlR+eJD0Qw3i\ny3ZBMqZCvTWgTckLqh2IBNj5XfakIOEZdRkhLXahtwJAKjO/JODKzukr3KrioXEC\nBwIBEQ==\n-----END PUBLIC KEY-----\n"
		print("APIClient SecureEncodable encryptionKey", encryptionKey)
		print("APIClient SecureEncodable encrypted", Crypter.encrypt(jsonString, using: encryptionKey))
        guard let encrypted = Crypter.encrypt(jsonString, using: encryptionKey) else {
            
            throw TapSerializationError.wrongData
        }
        
        return encrypted
    }
}
