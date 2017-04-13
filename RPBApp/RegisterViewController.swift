//
//  RegisterViewController.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/12/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    //constants 
    private let TEXTFIELD_CENTERX_MULTI: CGFloat = 0.9
    
    //text fields
    let desiredEmail : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        
        return view
        
    }()
    let desiredPassword : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        
        return view
        
    }()
    let desiredPasswordCheck : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        
        return view
        
    }()
    
    //labels/titles
    let headerTitle : UILabel = {
        let label = UILabel()
        label.text = "RPB Registration"
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
        
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        desiredEmail.delegate = self
        desiredPassword.delegate = self
        desiredPasswordCheck.delegate = self
        view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 0.3)
        
        
        view.addSubview(desiredPasswordCheck)
        view.addSubview(desiredPassword)
        view.addSubview(desiredEmail)
        view.addSubview(headerTitle)
        
        self.setTextFieldStyles()
        self.updateViewConstraints()
        
        // Do any additional setup after loading the view.
    }

    //Resign keboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Dismisses the Keyboard by making the text field resign
        // first responder
        textField.resignFirstResponder()
        
        // returns false. Instead of adding a line break, the text
        // field resigns
        return false
        
    }
    override func updateViewConstraints() {
        setViewConstraints()
        super.updateViewConstraints()
    }
    func setTextFieldStyles() {
        
        //place holders
        desiredEmail.placeholder = "Enter email"
        desiredPassword.placeholder = "Enter password"
        desiredPasswordCheck.placeholder = "Re-enter password"

        
        desiredEmail.clearsOnBeginEditing = true
        desiredPassword.clearsOnBeginEditing = true
        desiredPasswordCheck.clearsOnBeginEditing = true

        
        
        
        
    }
    func setViewConstraints(){
        //constraints for email text box
        NSLayoutConstraint(
            item: desiredEmail,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: TEXTFIELD_CENTERX_MULTI,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: desiredEmail,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        //width
        NSLayoutConstraint(
            item: desiredEmail,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.65,
            constant: 0.0)
            .isActive = true
        
        //constraints for password text box
        NSLayoutConstraint(
            item: desiredPassword,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: TEXTFIELD_CENTERX_MULTI,
            constant: 0.0)
            .isActive = true
        //to email box
        NSLayoutConstraint(
            item: desiredPassword,
            attribute: .top,
            relatedBy: .equal,
            toItem: desiredEmail,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30.0)
            .isActive = true
        //width
        NSLayoutConstraint(
            item: desiredPassword,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.65,
            constant: 0.0)
            .isActive = true
        
        
        
        //constraints for password check text box
        NSLayoutConstraint(
            item: desiredPasswordCheck,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: TEXTFIELD_CENTERX_MULTI,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: desiredPasswordCheck,
            attribute: .top,
            relatedBy: .equal,
            toItem: desiredPassword,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
            .isActive = true
        //width
        NSLayoutConstraint(
            item: desiredPasswordCheck,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.65,
            constant: 0.0)
            .isActive = true
        
        
        //constraints for title header
        NSLayoutConstraint(
            item: headerTitle,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: headerTitle,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 0.15,
            constant: 0.0)
            .isActive = true
        
        
    }
    
    
    
    
    
    
    
    

}
