//
//  TextFieldDelegate.swift
//  
//  Created by Joachim Deelen on 29.10.20.
//  Copyright © 2020 micabo-software UG. All rights reserved.
//

import UIKit.UITextField

public class TextFieldDelegate: TextInputBaseDelegate<UITextField>, UITextFieldDelegate {
	public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		return closureStore.shouldBeginEditing?(textField) ?? true
	}
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		closureStore.didBeginEditing?(textField)
	}
	public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		return closureStore.shouldEndEditing?(textField) ?? true
	}
	public func textFieldDidEndEditing(_ textField: UITextField) {
		closureStore.didEndEditing?(textField)
	}
	public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
		closureStore.didEndEditingWithReason?(textField, reason)
	}
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		closureStore.shouldChange?(textField, range, string) ?? true
	}
	public func textFieldShouldClear(_ textField: UITextField) -> Bool {
		return closureStore.shouldClear?(textField) ?? true
	}
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return closureStore.shouldReturn?(textField) ?? true
	}
	public func textFieldDidChangeSelection(_ textField: UITextField) {
		closureStore.didChangeSelection?(textField)
	}
}
