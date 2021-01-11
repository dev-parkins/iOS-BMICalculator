//
//  UITextFieldDoneCancelToolbar.swift
//  Christopher_Parkins_BMI Calculator Project
//
//  Created by Testing Lab on 11/15/20.
//

import Foundation
import UIKit

extension UITextField {
    @IBInspectable var done: Bool {
        get {
            return self.done;
        }
        set(hasDone){
            addDoneButtonKeyBoard();
        }
    }
    
    func addDoneButtonKeyBoard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50));
        doneToolbar.barStyle = .default;
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done:UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction));
        
        let items = [flexSpace, done];
        doneToolbar.items = items;
        doneToolbar.sizeToFit();
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder();
    }
}
