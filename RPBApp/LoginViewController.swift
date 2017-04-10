//
//  LoginViewController.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/5/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//
import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    //Image Logo
    let logoView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "RPBLogo"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
        
    }()
    //username textField
    var username: UITextField! = {
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
        return view
        
    }()
    let FBLoginButton : FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
        
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self delegation for any override func
        FBLoginButton.delegate = self
        username.delegate = self
        password.delegate = self
        
        //background
        view.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 0.3)
        
        view.addSubview(FBLoginButton)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(logoView)
        self.setTextFieldStyles()
        view.setNeedsUpdateConstraints()
        
    
        
    }
    
    
    
    //FACEBOOK LOGIN FUNCS
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of Facebook")
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        print("Successful login with Facebook")
        getFBInfo()
        
        //VC segue
        let mainVC = TabController()
        
        self.present(mainVC, animated: true, completion: nil)
        
    }
    
    func getFBInfo(){
        
        
        if (FBSDKAccessToken.current()) != nil{
            
            FBSDKGraphRequest (graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, Error) in
                if(Error == nil) {
                    print ("result \(String(describing: result))")
                }
                else{
                    print("Error \(String(describing: Error))")
                }
            
            })
        
        
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
    override func updateViewConstraints() {
        setViewConstraints()
        super.updateViewConstraints()
    }
    func setTextFieldStyles() {
        
        //place holders
        let usernameHolder = NSAttributedString(string: "Enter email", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        let passwordHolder = NSAttributedString(string: "Enter password", attributes: [NSForegroundColorAttributeName: UIColor.lightGray])
        
        username.attributedPlaceholder = usernameHolder
        password.attributedPlaceholder = passwordHolder
        
        username.clearsOnBeginEditing = true
        password.clearsOnBeginEditing = true
        
        
        
        
    }
    func setViewConstraints() {
        
        
        
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
            toItem: view,
            attribute: .bottom,
            multiplier: 0.8,
            constant: 0.0)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
