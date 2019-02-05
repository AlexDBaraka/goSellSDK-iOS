//
//  SessionAppearance.swift
//  goSellSDK
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import struct	CoreGraphics.CGBase.CGFloat
import class	UIKit.UIColor.UIColor
import class	UIKit.UIControl.UIControl
import class	UIKit.UIFont.UIFont
import struct	UIKit.UIGeometry.UIEdgeInsets

@objc public protocol SessionAppearance: class, NSObjectProtocol {
	
	// MARK: - Common
	
	/// SDK appearance mode. If not implemented it will be treated as `default`.
	///
	/// - Parameter session: Target session.
	/// - Returns: SDKAppearanceMode
	@objc optional func appearanceMode(for session: SessionProtocol) -> SDKAppearanceMode
	
	/// Defines if success/failure popup appears after the transaction finishes.
	/// Default is `true`.
	///
	/// - Parameter session: Target session.
	/// - Returns: Bool
	@objc optional func sessionShouldShowStatusPopup(_ session: SessionProtocol) -> Bool
	
	// MARK: - Header
	
	/// Font for the header text.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIFont
	@objc optional func headerFont(for session: SessionProtocol) -> UIFont
	
	/// Color for the header text.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func headerTextColor(for session: SessionProtocol) -> UIColor
	
	/// Background color for the header.
	///
	/// In windowed mode this color will be applied immediately, but in fullscreen mode only when there is content *under* the header.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func headerBackgroundColor(for session: SessionProtocol) -> UIColor
	
	/// Header cancel button font.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIFont
	@objc optional func headerCancelButtonFont(for session: SessionProtocol) -> UIFont
	
	/// Header cancel button text color.
	///
	/// - Parameters:
	///   - state: Control state. Either `normal` or `highlighted`.
	///   - session: Target session.
	/// - Returns: UIColor
	@objc optional func headerCancelButtonTextColor(for state: UIControl.State, for session: SessionProtocol) -> UIColor
	
	// MARK: - Card Input Fields
	
	/// Card input fields font.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIFont
	@objc optional func cardInputFieldsFont(for session: SessionProtocol) -> UIFont
	
	/// Card input fields text color.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func cardInputFieldsTextColor(for session: SessionProtocol) -> UIColor
	
	/// Card input fields placeholder color.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func cardInputFieldsPlaceholderColor(for session: SessionProtocol) -> UIColor
	
	/// Card input fields invalid text color.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func cardInputFieldsInvalidTextColor(for session: SessionProtocol) -> UIColor
	
	// MARK: Card Input Description
	
	/// Card input fields description font.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIFont
	@objc optional func cardInputDescriptionFont(for session: SessionProtocol) -> UIFont
	
	/// Card input fields description text color.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func cardInputDescriptionTextColor(for session: SessionProtocol) -> UIColor
	
	/// Card input save card switch off tint color.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func cardInputSaveCardSwitchOffTintColor(for session: SessionProtocol) -> UIColor
	
	/// Card input save card switch on tint color.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func cardInputSaveCardSwitchOnTintColor(for session: SessionProtocol) -> UIColor
	
	/// Card input save card switch thumb tint color.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func cardInputSaveCardSwitchThumbTintColor(for session: SessionProtocol) -> UIColor
	
	/// Card input scan icon frame tint color.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func cardInputScanIconFrameTintColor(for session: SessionProtocol) -> UIColor
	
	/// Card input scan icon tint color.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIColor
	@objc optional func cardInputScanIconTintColor(for session: SessionProtocol) -> UIColor
	
	// MARK: Pay/Save Button
	
	/// Pay/Save button background color for the given `state`.
	///
	/// - Parameters:
	///   - state: Control state.
	///   - session: Target session.
	/// - Returns: UIColor
	@objc optional func tapButtonBackgroundColor(for state: UIControl.State, for session: SessionProtocol) -> UIColor?
	
	/// Pay/Save button font.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIFont
	@objc optional func tapButtonFont(for session: SessionProtocol) -> UIFont
	
	/// Pay/Save button text color for the given `state`.
	///
	/// - Parameters:
	///   - state: Control state.
	///   - session: Target session.
	/// - Returns: UIColor
	@objc optional func tapButtonTextColor(for state: UIControl.State, for session: SessionProtocol) -> UIColor?
	
	/// Pay/Save button corner radius.
	///
	/// - Parameter session: Target session.
	/// - Returns: CGFloat
	@objc optional func tapButtonCornerRadius(for session: SessionProtocol) -> CGFloat
	
	/// Defines if loader is visible on Pay/Save button.
	///
	/// - Parameter session: Target session.
	/// - Returns: Bool
	@objc optional func isLoaderVisibleOnTapButtton(for session: SessionProtocol) -> Bool
	
	/// Defines if security icon is visible on Pay/Save button.
	///
	/// - Parameter session: Target session.
	/// - Returns: Bool
	@objc optional func isSecurityIconVisibleOnTapButton(for session: SessionProtocol) -> Bool
	
	/// Pay/Save button insets on payment/card saving screen from the edges (left, right and bottom) of the screen and content.
	///
	/// - Parameter session: Target session.
	/// - Returns: UIEdgeInsets
	@objc optional func tapButtonInsets(for session: SessionProtocol) -> UIEdgeInsets
	
	/// Pay/Save button height on payment/card saving screen.
	///
	/// - Parameter session: Target session.
	/// - Returns: CGFloat
	@objc optional func tapButtonHeight(for session: SessionProtocol) -> CGFloat
}
