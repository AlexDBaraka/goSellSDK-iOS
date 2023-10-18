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
    
    /// Creates Apple token with Tap Payments.
    ///
    /// - Parameters:
    ///   - request: Create token request.
    ///   - completion: Completion that will be called when request finishes.
    @objc(createApplePayTokenWithAppleTokenData:completion:)
    public func createApplePayToken(
        with appleTokenData: Data,
        completion: @escaping (Token?, TapSDKError?) -> Void
    ) {
        guard let appleToken = try? JSONDecoder().decode(AppleTokenModel.self, from: appleTokenData) else {
            completion(nil, TapSDKError(type: .serialization))
            return
        }
        
        let applePayToken = CreateTokenApplePay(appleToken: appleToken)
        let request = CreateTokenWithApplePayRequest(applePayToken: applePayToken)
        
        APIClient.shared.createToken(with: request) { (response, error) in
            
            completion(response, error)
        }
    }
	
	// MARK: - Private -
	// MARK: Methods
	
	private override init() { super.init() }
}
