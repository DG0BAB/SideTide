SideTide
========
### A **Si**mple **De**clarative **T**ext **I**nput **De**legate.
<p></p>

[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)<br>

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
That's it! Conformance to `UITextFieldDelegate` of the `MyViewController` isn't needed. All the functionality offered by the delegate is right there at the `UITextField` and not somewhere in the implementation/extension of the delegate. This provides much more clarity and makes code easier to understand and maintain.

### Explanation
In the example above an instance of `TextFieldDelegate` gets created, and the methods the delegate should support are added in a declarative way. In this example `ShouldBeginEditing`, `DidBeginEditing` and `ShouldChange`. The closures given for every supported delegate method-type, are executed at the appropriate time, just as they would in a "normal" delegate. In this example, `ShouldBeginEditing` and `DidBeginEditing` just print a message, whereas the `ShouldChange` refuses the charater "o" to be typed into the `UITextField`.

Usage
-----
Using SideTide requires adding it as a `Swift Package Dependency` to your project. To do this in Xcode goto "File->SwiftPackages->Add Package Dependency". In the Search/URL field of the dialog enter `git@github.com:DG0BAB/SideTide.git` if you're using SSH or `https://github.com/DG0BAB/SideTide.git` for HTTPS.

In the swift file where you want SideTide to be avaliable, just enter `import SideTide` at the top.

Depending on the type of input control used, `UITextField` or a `UITextView`, a `TextFieldDelegate` or `TextViewDelegate` has to be created. Both are made available by the above import statement. 

The available mothod-types offered by the SideTide delegates are very intuitive and follow the mothod-names of the corresponding `UITextFieldDelegate` or `UITextViewDelegate` 


### The `TextFieldDelegate` offers the following method-types<br>
- `ShouldBeginEditing(_: @escaping (UITextField) -> Bool)`<br>
- `DidBeginEditing(_: @escaping (UITextField) -> Void)`
- `ShouldEndEditing(_: @escaping (UITextField) -> Bool)`
- `DidEndEditing(_: @escaping (UITextField) -> Void)`
- `DidEndEditingWithReason(_: @escaping (UITextField, UITextField.DidEndEditingReason) -> Void)`
- `ShouldChange(_: @escaping (UITextField, NSRange, String) -> Bool)`
- `ShouldClear(_: @escaping (UITextField) -> Bool)`
- `ShouldReturn(_: @escaping (UITextField) -> Bool)`
- `DidChangeSelection(_: @escaping (UITextField) -> Void)`

The first parameter ($0) to every closure is alsways the instance of the `UITextField` this delegate is associated with. 

### The `TextViewDelegate` offers the following method-types<br>
- `ShouldBeginEditing(_: @escaping (UITextView) -> Bool)`<br>
- `DidBeginEditing(_: @escaping (UITextView) -> Void)`
- `ShouldEndEditing(_: @escaping (UITextView) -> Bool)`
- `DidEndEditing(_: @escaping (UITextView) -> Void)`
- `ShouldChange(_: @escaping (UITextView, NSRange, String) -> Bool)`
- `DidChange(_: @escaping (UITextView) -> Void)`
- `DidChangeSelection(_: @escaping (UITextView) -> Void)`
- `ShouldInteractWithAttachment(_: @escaping (TextInputType, NSTextAttachment, NSRange, UITextItemInteraction) -> Bool)`
- `ShouldInteractWithURL(_: @escaping (TextInputType, URL, NSRange, UITextItemInteraction) -> Bool)`

The first parameter ($0) to every closure is alsways the instance of the `UITextView` this delegate is associated with. 



e example above shows how simple it is to create and assign a delegate to a UITextField. You just create an instance of a `TextFieldDelegate`, which is a Type provided by SideTide, and assign it to the `sideTideDelegate` property. This property is added to every UITextField and UITextView by SideTide. 