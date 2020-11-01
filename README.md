SideTide
========
### A **Si**mple **De**clarative **T**ext **I**nput **De**legate.
<p></p>

[![Swift Package Manager compatible](https://img.shields.io/static/v1?label=SwiftPM&message=compatible&color="green"&style=plastic)](https://github.com/apple/swift-package-manager) [![Version](https://img.shields.io/static/v1?label=Version&message=1.0.0&color=blue&style=plastic)](https://github.com/apple/swift-package-manager)<br>

- **Si**mple<br>
Greatly simplyfies how delegates for UITextField and UITextView are created and assigned.  

- **De**clarative<br>
The delegate itself and all the methods that it should handle are declared in a declarative way. If you ever heard of SwiftUI you may get the idea instantly.

- **T**ext **I**nput **De**legate<br>
Useable for any controls that conform to the UITextInput protocol and that can be assigned a delegate, like UITextField and UITextView.

Example
-------
```swift
import SideTide

final class MyViewController: UIViewController {
    @IBOutlet weak var phoneNumberInputField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
		
        phoneNumberInputField.sideTideDelegate = TextFieldDelegate {
            ShouldBeginEditing { _ in print("Should begin was called."); return true }
            DidBeginEditing { _ in print("Did begin was calles") }
            ShouldChange { (_, range, string) in return string == "o" ? false : true }
        }
    }
}
```
That's it! All code that makes up the delegate is right there, directly at the `UITextField`. It's no longer spread over code, somewhere in the implementation/extension of the `UITextFieldDelegate`. Even further: There is no need to conform to `UITextFieldDelegate` at all. If there are multiple text fields or text views there's no need to check which text field is actually handled by the delegate. This avoids if/else hell, provides more clarity and makes code easier to understand and maintain.

### Description
In the example above an instance of `TextFieldDelegate` gets created, and the methods the delegate should support are added in a declarative way. In this example `ShouldBeginEditing`, `DidBeginEditing` and `ShouldChange` are handled by the delegate. The closures given for every delegate method-type are called at the appropriate time, just as they would using a "normal" `UITextFieldDelegate`. In this example, `ShouldBeginEditing` and `DidBeginEditing` just print a message, whereas the `ShouldChange` refuses the charater "o" to be typed into the `UITextField`.

Usage
-----
Using SideTide requires adding it as a `Swift Package Dependency` to your project. To do this in Xcode goto "File->SwiftPackages->Add Package Dependency". In the Search/URL field of the dialog enter `git@github.com:DG0BAB/SideTide.git` if you're using SSH or `https://github.com/DG0BAB/SideTide.git` for HTTPS.

In the swift file where you want SideTide to be avaliable, just enter `import SideTide` at the top.

Depending on the type of input control used, `UITextField` or `UITextView`, a `TextFieldDelegate` or a `TextViewDelegate` has to be created. Both are made available by the above import statement. 

The mothod-types offered by the SideTide delegates are very intuitive and follow the method-names of the corresponding `UITextFieldDelegate` or `UITextViewDelegate` 

### The `TextFieldDelegate` offers the following method-types<br>
- `ShouldBeginEditing(_: @escaping (UITextField) -> Bool)`
- `DidBeginEditing(_: @escaping (UITextField) -> Void)`
- `ShouldEndEditing(_: @escaping (UITextField) -> Bool)`
- `DidEndEditing(_: @escaping (UITextField) -> Void)`
- `DidEndEditingWithReason(_: @escaping (UITextField, UITextField.DidEndEditingReason) -> Void)`
- `ShouldChange(_: @escaping (UITextField, NSRange, String) -> Bool)`
- `ShouldClear(_: @escaping (UITextField) -> Bool)`
- `ShouldReturn(_: @escaping (UITextField) -> Bool)`
- `DidChangeSelection(_: @escaping (UITextField) -> Void)`

The first parameter ($0) to every closure is alsways the instance of the `UITextField` the delegate is associated with. 

### The `TextViewDelegate` offers the following method-types<br>
- `ShouldBeginEditing(_: @escaping (UITextView) -> Bool)`
- `DidBeginEditing(_: @escaping (UITextView) -> Void)`
- `ShouldEndEditing(_: @escaping (UITextView) -> Bool)`
- `DidEndEditing(_: @escaping (UITextView) -> Void)`
- `ShouldChange(_: @escaping (UITextView, NSRange, String) -> Bool)`
- `DidChange(_: @escaping (UITextView) -> Void)`
- `DidChangeSelection(_: @escaping (UITextView) -> Void)`
- `ShouldInteractWithAttachment(_: @escaping (TextInputType, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)`
- `ShouldInteractWithURL(_: @escaping (TextInputType, URL, NSRange, UITextItemInteraction) -> Bool)`

The first parameter ($0) to every closure is alsways the instance of the `UITextView` the delegate is associated with. 

### The `sideTideDelegate` property
After an instance of the delegate is created it should be assigend to the `sideTideDelegate` property of the `UITextField` or `UITextView`. The `sideTideDelegate` property is provided as an extensions by the SideTide package. In contrary to the normal `delegate` property the `sideTideDelegate` property is holding a strong reference to the delegate. This makes direct assignment during creation possible (as shown in the example above). It's possible to assign the created delegate to the normal `delegate` property, but since it's a weak reference, it will be deallocated immediately. This doesn't happen when using the `sideTideDelegate` property. Assigning a value to the `sideTideDelegate` also assigns that value to the `delegate` property of the `UITextField` or `UITextView`.