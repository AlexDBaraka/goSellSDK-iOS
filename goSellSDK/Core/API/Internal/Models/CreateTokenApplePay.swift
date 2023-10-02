//
//  CreateTokenApplePay.swift
//  goSellSDK
//
//  Created by Osama Rabie on 11/01/2020.
//  Copyright © 2020 Tap Payments. All rights reserved.
//

public struct CreateTokenApplePay: Encodable,Decodable {
    
    // MARK: - Internal -
    // MARK: Properties
    
    /// Card identifier.
    internal let appleToken: AppleTokenModel
    internal let paymentType: String
    // MARK: Methods
    
    /// Initializes the model with decoded apple pay token
    ///
    /// - Parameters:
    ///   - appleToken: The base64 apple pay token
    public init(appleToken: AppleTokenModel) {
        
        self.appleToken = appleToken
        self.paymentType = "applepay"
    }
    
    // MARK: - Private -
    
    private enum CodingKeys: String, CodingKey {
        
        case appleToken     = "token_data"
        case paymentType     = "type"
    }
}

