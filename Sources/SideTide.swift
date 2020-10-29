//
//  SideTide.swift
//  SideTide
//
//  Created by Joachim Deelen on 28.10.20.
//  Copyright © 2020 micabo-software UG. All rights reserved.
//

import UIKit
import ObjectiveC

public class TextInputDelegateClosureStore<TextInputType: UITextInput> {
	fileprivate var shouldBeginEditing: ((TextInputType) -> Bool)?
	fileprivate var didBeginEditing: ((TextInputType) -> Void)?
	fileprivate var shouldEndEditing: ((TextInputType) -> Bool)?
	fileprivate var didEndEditing: ((TextInputType) -> Void)?
	fileprivate var didEndEditingWithReason: ((TextInputType, UITextField.DidEndEditingReason) -> Void)?
	fileprivate var shouldChange: ((TextInputType, NSRange, String) -> Bool)?
	fileprivate var didChange: ((TextInputType) -> Void)?
	fileprivate var didChangeSelection: ((TextInputType) -> Void)?
	fileprivate var shouldClear: ((TextInputType) -> Bool)?
	fileprivate var shouldReturn: ((TextInputType) -> Bool)?
	fileprivate var shouldInteractWithAttachment: ((TextInputType, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)?
	fileprivate var shouldInteractWithURL: ((TextInputType, URL, NSRange, UITextItemInteraction) -> Bool)?
}

@_functionBuilder
public struct TextInputDelegateBuilder<TextInputType: UITextInput> {

	public static func buildBlock(_ closures: TextInputDelegateBuilding...) -> TextInputDelegateClosureStore<TextInputType> {
		let store = TextInputDelegateClosureStore<TextInputType>()
		closures.forEach { $0.insertClosure(into: store) }
		return store
	}
	public static func buildFinalResult(_ store: TextInputDelegateClosureStore<TextInputType>) -> TextInputBaseDelegate<TextInputType> {
		return TextInputBaseDelegate<TextInputType>(store: store)
	}
}

public extension TextInputDelegateBuilder where TextInputType == UITextField {
	static func buildExpression<T: UITextField>(_ shouldBeginEditing: ShouldBeginEditing<T>) -> TextInputDelegateBuilding {
		return shouldBeginEditing
	}
	static func buildExpression<T: UITextField>(_ didBeginEditing: DidBeginEditing<T>) -> TextInputDelegateBuilding {
		return didBeginEditing
	}
	static func buildExpression<T: UITextField>(_ shouldChange: ShouldChange<T>) -> TextInputDelegateBuilding {
		return shouldChange
	}
}

public extension TextInputDelegateBuilder where TextInputType == UITextView {
	static func buildExpression<T: UITextView>(_ shouldBeginEditing: ShouldBeginEditing<T>) -> TextInputDelegateBuilding where TextInputType == UITextView {
		return shouldBeginEditing
	}
	static func buildExpression<T: UITextView>(_ didBeginEditing: DidBeginEditing<T>) -> TextInputDelegateBuilding {
		return didBeginEditing
	}
	static func buildExpression<T: UITextView>(_ shouldChange: ShouldChange<T>) -> TextInputDelegateBuilding {
		return shouldChange
	}
}

public protocol TextInputDelegateBuilding {
	func insertClosure<T: UITextInput>(into store: TextInputDelegateClosureStore<T>)
}

public class TextInputBaseDelegate<TextInputType: UITextInput>: NSObject {
	public convenience init(@TextInputDelegateBuilder<TextInputType> _ closures: () -> TextInputBaseDelegate<TextInputType>) {
		let store = closures()
		self.init(other: store)
	}
	fileprivate init(other: TextInputBaseDelegate) {
		self.closureStore = other.closureStore
	}
	fileprivate init(store: TextInputDelegateClosureStore<TextInputType>) {
		self.closureStore = store
	}
	fileprivate var closureStore: TextInputDelegateClosureStore<TextInputType>
}


public class TextFieldDelegate: TextInputBaseDelegate<UITextField>, UITextFieldDelegate {
	public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		return closureStore.shouldBeginEditing?(textField) ?? true
	}
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		closureStore.didBeginEditing?(textField)
	}
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		closureStore.shouldChange?(textField, range, string) ?? true
	}
}

public class TextViewDelegate: TextInputBaseDelegate<UITextView>, UITextViewDelegate {
	public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		return closureStore.shouldBeginEditing?(textView) ?? true
	}
	public func textViewDidBeginEditing(_ textView: UITextView) {
		closureStore.didBeginEditing?(textView)
	}
	public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		closureStore.shouldChange?(textView, range, text) ?? true
	}
}

public struct ShouldBeginEditing<TextInputType: UITextInput> {
	private let closure: (TextInputType) -> Bool
	public init(_ closure: @escaping (TextInputType) -> Bool) {
		self.closure = closure
	}
}
extension ShouldBeginEditing: TextInputDelegateBuilding {
	public func insertClosure<T>(into store: TextInputDelegateClosureStore<T>) where T : UITextInput {
		store.shouldBeginEditing = closure as? (T) -> Bool
	}
}


public struct DidBeginEditing<TextInputType: UITextInput> {
	private let closure: ((TextInputType) -> Void)
	public init(_ closure: @escaping (TextInputType) -> Void) {
		self.closure = closure
	}
}
extension DidBeginEditing: TextInputDelegateBuilding {
	public func insertClosure<T>(into store: TextInputDelegateClosureStore<T>) where T : UITextInput {
		store.didBeginEditing = closure as? (T) -> Void
	}
}


public struct ShouldChange<TextInputType: UITextInput> {
	let closure: ((TextInputType, NSRange, String) -> Bool)
	public init(_ closure: @escaping (TextInputType, NSRange, String) -> Bool) {
		self.closure = closure
	}
}
extension ShouldChange: TextInputDelegateBuilding {
	public func insertClosure<T: UITextInput>(into store: TextInputDelegateClosureStore<T>) {
		store.shouldChange = closure as? (T, NSRange, String) -> Bool
	}
}

public extension UITextField {
	var sideTideDelegate: TextFieldDelegate? {
		set {
			if newValue != nil {
				objc_setAssociatedObject(self, &Keys.Delegate, newValue, .OBJC_ASSOCIATION_RETAIN)
			} else {
				objc_removeAssociatedObjects(self)
			}
			delegate = newValue
		}
		get {
			guard let delegate = objc_getAssociatedObject(self, &Keys.Delegate) as? TextFieldDelegate else { return nil }
			return delegate
		}
	}
	private struct Keys {
		static var Delegate = "SideTideDelegate"
	}
}

public extension UITextView {
	var sideTideDelegate: TextViewDelegate? {
		set {
			if newValue != nil {
				objc_setAssociatedObject(self, &Keys.Delegate, newValue, .OBJC_ASSOCIATION_RETAIN)
			} else {
				objc_removeAssociatedObjects(self)
			}
			delegate = newValue
		}
		get {
			guard let delegate = objc_getAssociatedObject(self, &Keys.Delegate) as? TextViewDelegate else { return nil }
			return delegate
		}
	}
	private struct Keys {
		static var Delegate = "SideTideDelegate"
	}
}

