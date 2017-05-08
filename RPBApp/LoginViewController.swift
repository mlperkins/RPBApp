//
//  LoginViewController.swift
//  RPBApp
//
//  Created by Michael Perkins and Ellen Studer on 4/5/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//
import Alamofire
import UIKit
import FBSDKLoginKit
import CoreData

/// This class is responsible for presenting the login view to the user.
class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    //Login button
    let loginUser : UIButton = {
        let button = UIButton(type: UIButtonType.roundedRect)
        button.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8 )
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: UIControlState.normal)
        
        return button
        
        
    }()
    
    
    //Image Logo
    let logoView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "RPBLogo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
        
    }()
    //username textField
    var username: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        return view
        
    }()
    //password textField
    var password: UITextField  = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.isSecureTextEntry = true
        return view
        
    }()
    //FB login button
    let FBLoginButton : FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.tintColor = UIColor.gray
        return button
        
        
    }()
    //Register now 
    let registerNow : UIButton = {
        let button = UIButton(type: UIButtonType.infoDark)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Not a registered? Register now!", for: UIControlState.normal)
        
        return button
        
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Loads the view and sets button target functions.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self delegation for any override func
        FBLoginButton.delegate = self
        username.delegate = self
        password.delegate = self
        
        //add the target functions for the buttons on the page
        registerNow.addTarget(self, action: #selector(LoginViewController.goToRegisterPage(_:)), for: UIControlEvents.touchUpInside)
        loginUser.addTarget(self, action: #selector(LoginViewController.loginUserClicked(_:)), for: UIControlEvents.touchUpInside)
        
        //background
        view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 1.0)
        
        view.addSubview(FBLoginButton)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(logoView)
        view.addSubview(registerNow)
        view.addSubview(loginUser)
        self.setTextFieldStyles()
        view.setNeedsUpdateConstraints()
        
    
        
    }
    
    /// Handles all logic for logging in a user when the login button is clicked
    ///
    /// - Parameter sender: Default
    func loginUserClicked(_ sender: Any?){
        //Alert controller for feedback
        var alertController: UIAlertController = UIAlertController()
        
        //all data from text fields needed for logging in are set
        let usernameText: String! = username.text
        let passwordText: String! = password.text
        
        let parameters: Parameters = ["email": usernameText, "password" : passwordText]
        
        //the URL to the PHP script responsible for login
        let url = "http://www.ellenstuder.com/ellen/verifyLogin.php"
        
        //alamo fire is used to retrieve info in JSON format.
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            print(response.timeline) //metrics for testing
            switch(response.result) {
                //if successful check the contents
                case .success(_):
                    //if the JSON can become a dictionary
                    if let JSON = response.result.value as? [[String:AnyObject]]{
                        //if the dictionary isnt empty
                        if JSON.isEmpty == false{
                            //populate user profile and set the global profile to current
                            let userProfile = UserProfile.init(n: JSON[0]["f_name"] as! String,e: JSON[0]["email"] as! String, p: "")
                            GlobalVariables.sharedManager.profile = userProfile
                            //go to the home page of the app
                            self.goToHomePage()
                        }
                        
                    }
                    //JSON could not be converted to dictionary meaning user was not found in database
                    else{
                        alertController = UIAlertController(title: "Login Unsuccessful", message: "Invalid Credentials", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default))
                        self.present(alertController, animated: true, completion: nil)
                    }
                    break
                case .failure(_):
                    break
                
            }
            
            
        }
        
    }
    
    /// Takes user to the register page
    ///
    /// - Parameter sender: Default
    func goToRegisterPage(_ sender: Any?) {
        
        let regVC = RegisterViewController()
        self.present(regVC,animated: true, completion: nil)
        
        
        
    }
    
    /// Takes user to the main page via tab bar controller
    func goToHomePage(){
        //VC segue
        let mainVC = TabController()
        
        self.present(mainVC, animated: true, completion: nil)
    }
    //FACEBOOK LOGIN FUNCS - Do not log user into app (YET)
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let man = FBSDKLoginManager()
        man.logOut()
        print("Did log out of Facebook")
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Successful login with Facebook")
        let del = UIApplication.shared.delegate as! AppDelegate
        del.getFBInfo()
       
        
    }
    
    
    //Resign keboard
    /// Resign keyboard when user is using the rest boxes
    ///
    /// - Parameter textField: which text field is being used
    /// - Returns: True - resign keyboard False - dont resign keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Dismisses the Keyboard by making the text field resign
        // first responder
        textField.resignFirstResponder()
        
        // returns false. Instead of adding a line break, the text
        // field resigns
        return false
  
    }
    
    /// Updates view constraints of elements in the view
    override func updateViewConstraints() {
        setViewConstraints()
        super.updateViewConstraints()
    }
    
    /// Adds placeholders to the text boxes
    func setTextFieldStyles() {
        
        username.placeholder = "Enter Email"
        password.placeholder = "Enter Password"
        
    }
    
    /// Sets the view constraints of elements within the view.
    func setViewConstraints() {
        
        //login button constraints
        NSLayoutConstraint(
            item: loginUser,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: loginUser,
            attribute: .top,
            relatedBy: .equal,
            toItem: registerNow,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: loginUser,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.35,
            constant: 0.0)
            .isActive = true
        
        //Register button constraints
        NSLayoutConstraint(
            item: registerNow,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: registerNow,
            attribute: .top,
            relatedBy: .equal,
            toItem: password,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 5.0)
            .isActive = true
        
        //Facebook button centered
        NSLayoutConstraint(
            item: FBLoginButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        //Facebok button width
        NSLayoutConstraint(
            item: FBLoginButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.8,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: FBLoginButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: loginUser,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 20.0)
            .isActive = true

        //Layout constraints for username box
        
        //set username alignment horizontally
        NSLayoutConstraint(
            item: username,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        //set username width
        NSLayoutConstraint(
            item: username,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.5,
            constant: 0.0)
            .isActive = true
        
        //set alignment vertically
        NSLayoutConstraint(
            item: username,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 0.5,
            constant: 0.0)
            .isActive = true
        
        
        // Layout constraints for password box
        
        //set distance from bottom of username text field
        NSLayoutConstraint(
            item: password,
            attribute: .top,
            relatedBy: .equal,
            toItem: username,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 10.0)
            .isActive = true
        //set alignment
        NSLayoutConstraint(
            item: password,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        //set width
        NSLayoutConstraint(
            item: password,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.5,
            constant: 0.0)
            .isActive = true
        
        
        //Layout constraints for Logo view
        
        //align horizontally
        NSLayoutConstraint(
            item: logoView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        //width constraint
        NSLayoutConstraint(
            item: logoView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.6,
            constant: 0.0)
            .isActive = true
        
        
        
        //distance from username constraint
        NSLayoutConstraint(
            item: logoView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: username,
            attribute: .top,
            multiplier: 1.0,
            constant: -40.0)
            .isActive = true
        
    
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
