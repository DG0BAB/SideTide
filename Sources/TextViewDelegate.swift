//
//  TextViewDelegate.swift
//  
//  Created by Joachim Deelen on 29.10.20.
//  Copyright © 2020 micabo-software UG. All rights reserved.
//

import UIKit.UITextView

public class TextViewDelegate: TextInputBaseDelegate<UITextView>, UITextViewDelegate {
	public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		return closureStore.shouldBeginEditing?(textView) ?? true
	}
	public func textViewDidBeginEditing(_ textView: UITextView) {
		closureStore.didBeginEditing?(textView)
	}
	public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
		return closureStore.shouldEndEditing?(textView) ?? true
	}
	public func textViewDidEndEditing(_ textView: UITextView) {
		closureStore.didEndEditing?(textView)
	}
	public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		closureStore.shouldChange?(textView, range, text) ?? true
	}
	public func textViewDidChange(_ textView: UITextView) {
		closureStore.didChange?(textView)
	}
	public func textViewDidChangeSelection(_ textView: UITextView) {
		closureStore.didChangeSelection?(textView)
	}
	public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		closureStore.shouldInteractWithAttachment?(textView, textAttachment, characterRange, interaction) ?? true
	}
	public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		closureStore.shouldInteractWithURL?(textView, URL, characterRange, interaction) ?? true
	}
}
