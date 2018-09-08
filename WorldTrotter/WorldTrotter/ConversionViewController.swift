//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by seohui on 08/09/2018.
//  Copyright © 2018 seohui. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var celsiousLabel: UILabel!
    @IBOutlet var textField: UITextField!   // for keyboard disappear
    
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
    }
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    var fahrenheitValue: Double? {  // property observer. property의 값이 바뀔 때 마다 호출됨.
        didSet {    // property 값이 바뀐 후 호출됨
            updateCelsiousLabel()
        }
        // initializer에서 property값이 바뀔 때 에는 property observer가 호출되지 않는다.
    }
    
    var celsiusValue: Double? {
            if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    func updateCelsiousLabel() {
        if let value = celsiusValue
        {
            celsiousLabel.text = numberFormatter.string(from: NSNumber(value: value))
        }
        else
        {
            celsiousLabel.text = "???"
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func textField( _ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        let isCharacter = string.rangeOfCharacter(from: CharacterSet.letters)
        
        if existingTextHasDecimalSeparator != nil &&
            replacementTextHasDecimalSeparator != nil
        {
            return false
        }
        else if (isCharacter != nil)
        {
            return false
        }
        else
        {
            return true
        }
    }
    
}
