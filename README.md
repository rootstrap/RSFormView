[![Maintainability](https://api.codeclimate.com/v1/badges/7f79bedea0280ec94444/maintainability)](https://codeclimate.com/repos/5cd33d2d08760b668c0049c7/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/7f79bedea0280ec94444/test_coverage)](https://codeclimate.com/repos/5cd33d2d08760b668c0049c7/test_coverage)

# RSFormView


## What is it?

RSFormView is a library that helps you build fully customizable forms for data entry in a few minutes. 

## Installation

RSFormView is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "RSFormView"
```
## Usage

1. Add a FormView to your view controller, you can do this either programatically or via Storyboards.


Programatically: 
```swift
let formView = FormView(frame: frame)
view.addSubview(formView)
```
Storyboards:
Add a `UIView` to your view controller and change the class name to `FormView`.

2. Set your view controller as FormViewDelegate:
```swift
class YourViewController: FormViewDelegate { ... }
```
and implement
```swift
func didUpdateFields(allFieldsValid: Bool)
```
This function will be called any time a user enters any data in the form, so its a great place to update other views dependant of the entered data.

3. Set your view controller as the FormView delegate
```swift
formView.delegate = self
```

4. Set a FormViewModel to your formView


A `FormViewModel` can be any class that implements the `FormViewModel` delegate. 
For a class to implement `FormViewModel` delegate  you only need to define an array of `FormItem`
Each `FormItem` will determine the behavior and validation of each text field in your form. 
`FormItem` can be a text field, two text fields in line or a "section header"

5. Configure your form looks


Create a `FormConfigurator` change any colors or fonts you need and set it to your form view
```swift
let configurator = FormConfigurator()
configurator.textColor = UIColor.red
formView.formConfirator = yourFormConfigurator
```
6. Collect data


Any text entry made in your form will be collected in your `FormViewModel`  `items`. 
Since you may have more than one text field per item a better way for collecting your data is taking use of the `fields()` function of the `FormViewModel`, like this:
```swift
var user = User()
formViewModel.fields().forEach {
  switch $0.name {
  case "First Name":
    user.firstName = $0.value
  case "Birthdate":
    user.birthdate = $0.value
  default:
    print("\($0.name): \($0.value)")
  }
}
```
