//
//  ClosureTypes.swift
//  
//  Created by Joachim Deelen on 29.10.20.
//  Copyright © 2020 micabo-software UG. All rights reserved.
//

import UIKit.UITextInput

/// The closure of this type handles the `...ShouldBeginEditing(_:)` delegate method
public struct ShouldBeginEditing<TextInputType: UITextInput> {
	private let closure: (TextInputType) -> Bool
	public init(_ closure: @escaping (TextInputType) -> Bool) {
		self.closure = closure
	}
}
extension ShouldBeginEditing: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.shouldBeginEditing = closure as? (T) -> Bool
	}
}


/// The closure of this type handles the `...DidBeginEditing(_:)` delegate method
public struct DidBeginEditing<TextInputType: UITextInput> {
	private let closure: ((TextInputType) -> Void)
	public init(_ closure: @escaping (TextInputType) -> Void) {
		self.closure = closure
	}
}
extension DidBeginEditing: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.didBeginEditing = closure as? (T) -> Void
	}
}

/// The closure of this type handles the `...ShouldEndEditing(_:)` delegate method
public struct ShouldEndEditing<TextInputType: UITextInput> {
	private let closure: (TextInputType) -> Bool
	public init(_ closure: @escaping (TextInputType) -> Bool) {
		self.closure = closure
	}
}
extension ShouldEndEditing: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.shouldEndEditing = closure as? (T) -> Bool
	}
}

/// The closure of this type handles the `...DidEndEditing(_:)` delegate method
public struct DidEndEditing<TextInputType: UITextInput> {
	private let closure: ((TextInputType) -> Void)
	public init(_ closure: @escaping (TextInputType) -> Void) {
		self.closure = closure
	}
}
extension DidEndEditing: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.didEndEditing = closure as? (T) -> Void
	}
}

/// The closure of this type handles the `...DidEndEditing(_:reason:)` delegate method
public struct DidEndEditingWithReason<TextInputType: UITextInput> {
	private let closure: ((TextInputType, UITextField.DidEndEditingReason) -> Void)
	public init(_ closure: @escaping (TextInputType, UITextField.DidEndEditingReason) -> Void) {
		self.closure = closure
	}
}
extension DidEndEditingWithReason: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.didEndEditingWithReason = closure as? (T, UITextField.DidEndEditingReason) -> Void
	}
}

/// The closure of this type handles the `...(_:shouldChangeCharactersIn:replacementString:)` delegate method
public struct ShouldChange<TextInputType: UITextInput> {
	let closure: ((TextInputType, NSRange, String) -> Bool)
	public init(_ closure: @escaping (TextInputType, NSRange, String) -> Bool) {
		self.closure = closure
	}
}
extension ShouldChange: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.shouldChange = closure as? (T, NSRange, String) -> Bool
	}
}

/// The closure of this type handles the `...DidChange(_:)` delegate method
public struct DidChange<TextInputType: UITextInput> {
	private let closure: ((TextInputType) -> Void)
	public init(_ closure: @escaping (TextInputType) -> Void) {
		self.closure = closure
	}
}
extension DidChange: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.didChange = closure as? (T) -> Void
	}
}

/// The closure of this type handles the `...DidChangeSelection(_:)` delegate method
public struct DidChangeSelection<TextInputType: UITextInput> {
	private let closure: ((TextInputType) -> Void)
	public init(_ closure: @escaping (TextInputType) -> Void) {
		self.closure = closure
	}
}
extension DidChangeSelection: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.didChangeSelection = closure as? (T) -> Void
	}
}

/// The closure of this type handles the `...ShouldClear(_:)` delegate method
public struct ShouldClear<TextInputType: UITextInput> {
	private let closure: (TextInputType) -> Bool
	public init(_ closure: @escaping (TextInputType) -> Bool) {
		self.closure = closure
	}
}
extension ShouldClear: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.shouldClear = closure as? (T) -> Bool
	}
}

/// The closure of this type handles the `...ShouldReturn(_:)` delegate method
public struct ShouldReturn<TextInputType: UITextInput> {
	private let closure: (TextInputType) -> Bool
	public init(_ closure: @escaping (TextInputType) -> Bool) {
		self.closure = closure
	}
}
extension ShouldReturn: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.shouldReturn = closure as? (T) -> Bool
	}
}

/// The closure of this type handles the `...(_:shouldInteractWith:in:interaction:)` delegate method
public struct ShouldInteractWithAttachment<TextInputType: UITextInput> {
	private let closure: (TextInputType, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool
	public init(_ closure: @escaping (TextInputType, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool) {
		self.closure = closure
	}
}
extension ShouldInteractWithAttachment: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.shouldInteractWithAttachment = closure as? (T, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool
	}
}

/// The closure of this type handles the `...(_:shouldInteractWith:in:interaction:)` delegate method
public struct ShouldInteractWithURL<TextInputType: UITextInput> {
	private let closure: (TextInputType, URL, NSRange, UITextItemInteraction) -> Bool
	public init(_ closure: @escaping (TextInputType, URL, NSRange, UITextItemInteraction) -> Bool) {
		self.closure = closure
	}
}
extension ShouldInteractWithURL: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: inout TextInputDelegateClosureStore<T>) {
		store.shouldInteractWithURL = closure as? (T, URL, NSRange, UITextItemInteraction) -> Bool
	}
}
