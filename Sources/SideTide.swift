//
//  SideTide.swift
//  SideTide
//
//  Created by Joachim Deelen on 28.10.20.
//  Copyright © 2020 micabo-software UG. All rights reserved.
//

import UIKit

// MARK: - Delegate Builder

/// Gathers the different Closure-Types puts them into the `TextInputDelegateClosureStore` and creates
/// the designated `TextFieldDelegate` or `TextViewDelegate`
@_functionBuilder
public struct TextInputDelegateBuilder<TextInputType: UITextInput> {

	public static func buildBlock(_ closures: TextInputDelegateBuilding...) -> TextInputDelegateClosureStore<TextInputType> {
		var store = TextInputDelegateClosureStore<TextInputType>()
		closures.forEach { $0.insertClosure(into: &store) }
		return store
	}
	// This creates the TextFieldDelegate as the final result by initializing it with the closure store
	public static func buildFinalResult(_ store: TextInputDelegateClosureStore<TextInputType>) -> TextFieldDelegate where TextInputType == UITextField {
		return TextFieldDelegate(store: store)
	}

	// This creates the TextViewDelegate as the final result by initializing it with the closure store
	public static func buildFinalResult(_ store: TextInputDelegateClosureStore<TextInputType>) -> TextViewDelegate where TextInputType == UITextView {
		return TextViewDelegate(store: store)
	}
}

/// Types conforming to this protocol can be used by the `TextInputDelegateBuilder` as building blocks.
/// Conforming types know how to store themselves into the `TextInputDelegateClosureStore`
public protocol TextInputDelegateBuilding {
	func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>)
}


// MARK: - TextFieldDelegate Expression Builder

// Evaluates all Closure-Type expressions associated with TextFieldDelegates
public extension TextInputDelegateBuilder where TextInputType == UITextField {
	static func buildExpression<T: UITextField>(_ shouldBeginEditing: ShouldBeginEditing<T>) -> TextInputDelegateBuilding {
		return shouldBeginEditing
	}
	static func buildExpression<T: UITextField>(_ didBeginEditing: DidBeginEditing<T>) -> TextInputDelegateBuilding {
		return didBeginEditing
	}
	static func buildExpression<T: UITextField>(_ shouldEndEditing: ShouldEndEditing<T>) -> TextInputDelegateBuilding {
		return shouldEndEditing
	}
	static func buildExpression<T: UITextField>(_ didEndEditing: DidEndEditing<T>) -> TextInputDelegateBuilding {
		return didEndEditing
	}
	static func buildExpression<T: UITextField>(_ didEndEditingWithReason: DidEndEditingWithReason<T>) -> TextInputDelegateBuilding {
		return didEndEditingWithReason
	}
	static func buildExpression<T: UITextField>(_ shouldChange: ShouldChange<T>) -> TextInputDelegateBuilding {
		return shouldChange
	}
	static func buildExpression<T: UITextField>(_ shouldClear: ShouldClear<T>) -> TextInputDelegateBuilding {
		return shouldClear
	}
	static func buildExpression<T: UITextField>(_ shouldReturn: ShouldReturn<T>) -> TextInputDelegateBuilding {
		return shouldReturn
	}
	static func buildExpression<T: UITextField>(_ didChangeSelection: DidChangeSelection<T>) -> TextInputDelegateBuilding {
		return didChangeSelection
	}
}


// MARK: - TextViewDelegate Expression Builder

// Evaluates all Closure-Type expressions associated with TextViewDelegates
public extension TextInputDelegateBuilder where TextInputType == UITextView {
	static func buildExpression<T: UITextView>(_ shouldBeginEditing: ShouldBeginEditing<T>) -> TextInputDelegateBuilding where TextInputType == UITextView {
		return shouldBeginEditing
	}
	static func buildExpression<T: UITextView>(_ didBeginEditing: DidBeginEditing<T>) -> TextInputDelegateBuilding {
		return didBeginEditing
	}
	static func buildExpression<T: UITextField>(_ shouldEndEditing: ShouldEndEditing<T>) -> TextInputDelegateBuilding {
		return shouldEndEditing
	}
	static func buildExpression<T: UITextField>(_ didEndEditing: DidEndEditing<T>) -> TextInputDelegateBuilding {
		return didEndEditing
	}
	static func buildExpression<T: UITextView>(_ shouldChange: ShouldChange<T>) -> TextInputDelegateBuilding {
		return shouldChange
	}
	static func buildExpression<T: UITextField>(_ didChange: DidChange<T>) -> TextInputDelegateBuilding {
		return didChange
	}
	static func buildExpression<T: UITextField>(_ didChangeSelection: DidChangeSelection<T>) -> TextInputDelegateBuilding {
		return didChangeSelection
	}
	static func buildExpression<T: UITextView>(_ shouldInteractWithAttachment: ShouldInteractWithAttachment<T>) -> TextInputDelegateBuilding {
		return shouldInteractWithAttachment
	}
	static func buildExpression<T: UITextView>(_ shouldInteractWithURL: ShouldInteractWithURL<T>) -> TextInputDelegateBuilding {
		return shouldInteractWithURL
	}
}


// MARK: - Closure Store

/// Used by the `TextInputDelegateBuilder` to store the different closures
public struct TextInputDelegateClosureStore<TextInputType: UITextInput> {
	internal var shouldBeginEditing: ((TextInputType) -> Bool)?
	internal var didBeginEditing: ((TextInputType) -> Void)?
	internal var shouldEndEditing: ((TextInputType) -> Bool)?
	internal var didEndEditing: ((TextInputType) -> Void)?
	internal var didEndEditingWithReason: ((TextInputType, UITextField.DidEndEditingReason) -> Void)?
	internal var shouldChange: ((TextInputType, NSRange, String) -> Bool)?
	internal var didChange: ((TextInputType) -> Void)?
	internal var didChangeSelection: ((TextInputType) -> Void)?
	internal var shouldClear: ((TextInputType) -> Bool)?
	internal var shouldReturn: ((TextInputType) -> Bool)?
	internal var shouldInteractWithAttachment: ((TextInputType, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?
	internal var shouldInteractWithURL: ((TextInputType, URL, NSRange, UITextItemInteraction) -> Bool)?
}
