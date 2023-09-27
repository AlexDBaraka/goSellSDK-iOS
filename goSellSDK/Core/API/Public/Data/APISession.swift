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
    @objc(createTokenWithRequest:completion:)
    public func createToken(with request: CreateTokenWithCardDataRequest, completion: @escaping (Token?, TapSDKError?) -> Void) {
        
        APIClient.shared.createToken(with: request) { (response, error) in
            
            completion(response, error)
        }
    }
	
	// MARK: - Private -
	// MARK: Methods
	
	private override init() { super.init() }
}
