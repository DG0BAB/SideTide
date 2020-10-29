//
//  UITextView+SideTide.swift
//  
//  Created by Joachim Deelen on 29.10.20.
//  Copyright © 2020 micabo-software UG. All rights reserved.
//

import UIKit.UITextView
import ObjectiveC

public extension UITextView {
	/// The text field's `SideTide.TextViewDelegate`
	/// Setting this property also sets the `delegate` property of the `UITextView`
	/// The given delegate is stored with a strong reference
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
