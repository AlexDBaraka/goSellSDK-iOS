//
//  ErrorDetail.swift
//  goSellSDK
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

/// Error detail model.
@objcMembers public final class ErrorDetail: NSObject {
    
    // MARK: - Public -
    // MARK: Properties
    
    /// Error name.
    public private(set) var code: ErrorCode = .unknown
    
    /// Error description.
    public private(set) var descriptionText: String = .empty
    
    /// Generated error title.
    public var title: String {
        
        return "Error \(self.code)"
    }
    
    /// Error description.
    public override var description: String {
        
        return "\(self.title): \(self.descriptionText)"
    }
    
    // MARK: - Internal -
    // MARK: Methods
    
    internal convenience init(code: ErrorCode) {
        
        self.init(code: code, description: .empty)
    }
    
    internal init(code: ErrorCode, description: String) {
        
        super.init()
        
        self.code = code
        self.descriptionText = description
    }
    
    // MARK: - Private -
    
    private enum CodingKeys: String, CodingKey {
        
        case code               = "code"
        case descriptionText    = "description"
    }
}

// MARK: - Decodable
extension ErrorDetail: Decodable {
    
    public convenience init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let code = try container.decodeInt(forKey: .code)
        let errorCode = ErrorCode(rawValue: code) ?? .unknown
        
        let descriptionText = try container.decode(String.self, forKey: .descriptionText)
        
        self.init(code: errorCode, description: descriptionText)
    }
}
