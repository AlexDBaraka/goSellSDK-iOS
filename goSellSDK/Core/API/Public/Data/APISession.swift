//
//  APISession.swift
//  goSellSDK
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

/// API session class, for API calls.
@objcMembers public final class APISession: NSObject, Singleton {
	
	// MARK: - Public -
	// MARK: Properties
	
	/// Shared instance.
	@objc(sharedInstance)
	public static let shared = APISession()
	
	// MARK: Methods
	
	/// Retrieves all saved cards for the given customer.
	///
	/// - Parameters:
	///   - customer: Customer identifier.
	///   - completion: Closure that will be called once request finishes.
	@objc(retrieveAllCardsOfCustomer:completion:)
	public func retrieveAllCards(of customer: String, completion: @escaping ([SavedCard]?, TapSDKError?) -> Void) {
		
		APIClient.shared.listAllCards(for: customer) { (response, error) in
			
			completion(response?.cards, error)
		}
	}
	
	/// Deletes the card.
	///
	/// - Parameters:
	///   - card: Card identifier.
	///   - customer: Customer identifier.
	///   - completion: Closure that will be called once request finishes.
	@objc(deleteCard:ofCustomer:completion:)
	public func deleteCard(_ card: String, of customer: String, completion: @escaping (Bool, TapSDKError?) -> Void) {
	
		APIClient.shared.deleteCard(with: card, from: customer) { (response, error) in
			
			completion(response?.isDeleted ?? false, error)
		}
	}
    
    /// Creates token with a given token request, calling completion when request finishes.
    ///
    /// - Parameters:
    ///   - request: Create token request.
    ///   - completion: Completion that will be called when request finishes.
    @objc(createTokenWithCardNumber:expirationMonth:expirationYear:cvc:cardHolderName:encryptionKey:completion:)
    public func createToken(
        with cardNumber: String,
        expirationMonth: String,
        expirationYear: String,
        cvc: String,
        cardHolderName: String,
        encryptionKey: String?,
        completion: @escaping (Token?, TapSDKError?) -> Void
    ) {
        let request = CreateTokenWithCardDataRequest(
            card: .init(
                number: cardNumber,
                expirationMonth: expirationMonth,
                expirationYear: expirationYear,
                cvc: cvc,
                cardholderName: cardHolderName,
                address: nil,
                encryptionKey: encryptionKey
            )
        )
        
        APIClient.shared.createToken(with: request) { (response, error) in
            
            completion(response, error)
        }
    }
    
    /// Creates Apple Pay Token based on Apple token
    ///
    /// - Parameters:
    ///   - appleTokenData: Apple Pay Token data retrieved.
    @objc(createApplePayTokenizationApiRequestWithAppleTokenData:)
    func createApplePayTokenizationApiRequest(with appleTokenData: Data) -> CreateTokenWithApplePayRequest? {
        var token = String(data: appleTokenData, encoding: .utf8) ?? ""
        if token == ""
        {
            token = """
{"version":"EC_v1","data":"D/LdKnlcYlgS/fzLRr6SdP1GlVAo2Dn8l+GJPyjyDhobBUzfIqVVXJws26NPG8F5Nor1d11pN40I9Dj2VW3PB9V3d2RiRI7EoMRJDiX+bZEccvkB2J8HV+2A/wgTP94qitwIn10AZ4Z2utO+q6UpW8ZBbncxDniE/4zqwgA/YYM8YnxhXQ/IzupRxD1JaAcj6mVue1XxWpw12zhqQgnCo59QSEPysCxVQoIbDnSUFd6eIj649oNLxkOztauZG0KZiK6UZjUnlRfN5Rq1ooCSPgi1gSLXyWiCAoEaQUuE/9VI1nNVhA5LBsDA96PGoQTxoXsklOFIhO+ZliwU8IMu8NMv+Q4APahmRZUHCcKYVhKcFnsyMgi6HYnNuQjWX7iLXCbbPI92HsXcF5p5XfSCcY2DG2qN190qDpUKBJwHjg==","signature":"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","header":{"ephemeralPublicKey":"MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE2kfjdvQLxcfRS7rXFBI0vPKjL/qBOUNUgkN/JXcvpq0ACHbPWlgogvm5YZh/GBecVCu1AU1i+TSCaZ0VTnBWeg==","publicKeyHash":"LjAAyv6vb6jOEkjfG7L1a5OR2uCTHIkB61DaYdEWD+w=","transactionId":"1c072b6b9bdac6fb0757a8da8851eb1308a23a224b64b23bfb52f87e7ba6a81a"}}
"""
        }
        print("Apple Pay Token \(token)")
        if let jsonData = token.data(using: .utf8)
        {
            do {
                let dict = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
                let finalDict =  ["type": "applepay","token_data": dict] as [String : Any]
                let applePayToken:CreateTokenApplePay = try CreateTokenApplePay(dictionary: finalDict)
                let request = CreateTokenWithApplePayRequest(applePayToken: applePayToken)
                return request
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }else
        {
            return nil
        }
    }
	
	// MARK: - Private -
	// MARK: Methods
	
	private override init() { super.init() }
}
