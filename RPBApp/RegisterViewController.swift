//
//  RegisterViewController.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/12/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//
import Alamofire
import UIKit

/// Responsible for the register page elements
class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    //constants 
    //changes where the text fields line up horizontally ( move left <1 move right >1)
    private let TEXTFIELD_CENTERX_MULTI: CGFloat = 0.9
    
    //register button
    let registerNow : UIButton = {
        let button = UIButton(type: UIButtonType.roundedRect)
        button.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register Now", for: UIControlState.normal)
        //add button targets
        button.addTarget(self, action: #selector(RegisterViewController.registerClicked(_:)), for: UIControlEvents.touchUpInside)
        return button
        
        
    }()
    
    //back to login button
    let backToLogin : UIButton = {
        let button = UIButton(type: UIButtonType.roundedRect)
        button.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Back to Login", for: UIControlState.normal)
        
        button.addTarget(self, action: #selector(RegisterViewController.returnToLogin(_:)), for: UIControlEvents.touchUpInside)
        return button
        
        
    }()
    
    
    //text fields
    let firstName : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        
        return view
        
    }()
    let lastName : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        
        return view
        
    }()
    let desiredEmail : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        
        return view
        
    }()
    let desiredPassword : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSecureTextEntry = true

        view.borderStyle = .roundedRect
        
        return view
        
    }()
    let desiredPasswordCheck : UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSecureTextEntry = true

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
    let firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    let lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Desired Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Desired Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Adds views and delegates work
    override func viewDidLoad() {
        super.viewDidLoad()
        //Delegate work for override functions
        firstName.delegate = self
        lastName.delegate = self
        desiredEmail.delegate = self
        desiredPassword.delegate = self
        desiredPasswordCheck.delegate = self
        view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 1.0)
        
        

        
        //add text fields
        view.addSubview(firstName)
        view.addSubview(lastName)
        view.addSubview(desiredPasswordCheck)
        view.addSubview(desiredPassword)
        view.addSubview(desiredEmail)
        
        
        //add labels
        view.addSubview(firstNameLabel)
        view.addSubview(lastNameLabel)
        view.addSubview(headerTitle)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        
        //addButtons
        view.addSubview(registerNow)
        view.addSubview(backToLogin)
        
        self.setTextFieldStyles()
        self.updateViewConstraints()
        
    }
    
    /// Goes back to login page when back to login page is clicked
    ///
    /// - Parameter sender: Default
    func returnToLogin(_ sender: Any?){
        let loginVC = LoginViewController()
        self.present(loginVC, animated: false, completion: nil)
        
    }
   
    /// Verifies registration when register button is clicked
    ///
    /// - Parameter sender: Default
    func registerClicked(_ sender: Any?){
        //Alert controller for feedback to user
        var alertController: UIAlertController = UIAlertController()
        
        //Checks all fields are filled, if not warns the user with pop up alert
        if(firstName.text != "" && lastName.text != ""){
            if(desiredEmail.text != ""){
                if(desiredPassword.text == desiredPasswordCheck.text){
                    if desiredPassword.text != "" {
                        //all variables needed to register
                        let firstN: String! = firstName.text
                        let lastN: String! = lastName.text
                        let email: String! = desiredEmail.text
                        let dPass: String! = desiredPassword.text
                        
                        var successResponse: Bool = false
                        
                        
                        let parameters: Parameters = ["f_name" : firstN, "l_name" : lastN, "email": email, "p_word" : dPass]
                        //URL to PHP script for registration
                        let url = "http://www.ellenstuder.com/ellen/createUser.php"
                        Alamofire.request(url, method: .post, parameters: parameters).responseJSON{ response in
                            //If the response is successful it means the user already exist within the database
                            //If the response is a failure it means the user was added to the database because the user wasn't found.
                            print("Success: \(response.result.isSuccess)")
                            successResponse = response.result.isSuccess
                            if(successResponse == false){
                                print("User successfully added")
                                alertController = UIAlertController(title: "Registration Successful", message: "Return to login page", preferredStyle: UIAlertControllerStyle.alert)
                                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ UIAlertAction in
                                    self.returnToLogin(nil)
                                })
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                            else{
                                print("Email already exist")
                                alertController = UIAlertController(title: "Registration Unsuccessful", message: "Email already exist", preferredStyle: UIAlertControllerStyle.alert)
                                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
                                self.present(alertController, animated: true, completion: nil)
                            }
                        
                            
                        }
                    }
                    else{
                        alertController = UIAlertController(title: "Registration Unsuccessful", message: "Password has no value", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                else{
                    
                    alertController = UIAlertController(title: "Registration Unsuccessful", message: "Passwords do not match", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            else{
                alertController = UIAlertController(title: "Registration Unsuccessful", message: "Please enter valid email", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
                self.present(alertController, animated: true, completion: nil)
            }
            
            
            
            
        }
        else{
            print("First and last name invalid")
            alertController = UIAlertController(title: "Registration Unsuccessful", message: "Please enter both a first and last name", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
            self.present(alertController, animated: true, completion: nil)
        }
        
        
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
    /// Updates view constraints of the
    override func updateViewConstraints() {
        setViewConstraints()
        super.updateViewConstraints()
    }
    
    /// Set placeholders of the text boxes
    func setTextFieldStyles() {
        
        //place holders
        firstName.placeholder = "First name"
        lastName.placeholder = "Last name"
        desiredEmail.placeholder = "Enter email"
        desiredPassword.placeholder = "Enter password"
        desiredPasswordCheck.placeholder = "Re-enter password"

        

        
    }
    
    /// Sets constraints of all elements within the view
    func setViewConstraints(){
        //first name constraints
        NSLayoutConstraint(
            item: firstName,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: TEXTFIELD_CENTERX_MULTI,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: firstName,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: firstName,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.65,
            constant: 0.0)
            .isActive = true
        //first name label constraints
        NSLayoutConstraint(
            item: firstNameLabel,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: firstName,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: firstNameLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: firstName,
            attribute: .left,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        //last name constraints
        NSLayoutConstraint(
            item: lastName,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: TEXTFIELD_CENTERX_MULTI,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: lastName,
            attribute: .top,
            relatedBy: .equal,
            toItem: firstName,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30.0)
            .isActive = true
        NSLayoutConstraint(
            item: lastName,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.65,
            constant: 0.0)
            .isActive = true
        //last name label constraints
        NSLayoutConstraint(
            item: lastNameLabel,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: lastName,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: lastNameLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: lastName,
            attribute: .left,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        
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
            attribute: .top,
            relatedBy: .equal,
            toItem: lastName,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30.0)
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
        
        //constraints for email label
        NSLayoutConstraint(
            item: emailLabel,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: desiredEmail,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: emailLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: desiredEmail,
            attribute: .left,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        //constraints for password label
        NSLayoutConstraint(
            item: passwordLabel,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: desiredPassword,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: passwordLabel,
            attribute: .left,
            relatedBy: .equal,
            toItem: desiredPassword,
            attribute: .left,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        //constraints for registerNow button
        NSLayoutConstraint(
            item: registerNow,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: TEXTFIELD_CENTERX_MULTI,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: registerNow,
            attribute: .top,
            relatedBy: .equal,
            toItem: desiredPasswordCheck,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
            .isActive = true
        NSLayoutConstraint(
            item: registerNow,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.35,
            constant: 0.0)
            .isActive = true
        
        //constraints for back to login button
        NSLayoutConstraint(
            item: backToLogin,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: TEXTFIELD_CENTERX_MULTI,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: backToLogin,
            attribute: .top,
            relatedBy: .equal,
            toItem: registerNow,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
            .isActive = true
        NSLayoutConstraint(
            item: backToLogin,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.45,
            constant: 0.0)
            .isActive = true
        
    }
    
    
    
    
    
    
    
    

}
