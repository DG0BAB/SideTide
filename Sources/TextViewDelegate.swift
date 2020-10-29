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
	public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		closureStore.shouldChange?(textView, range, text) ?? true
	}
}
