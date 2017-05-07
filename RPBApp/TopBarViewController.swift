//
//  TopBarViewController.swift
//  RPBApp
//
//  Created by Michael Perkins and Ellen Studer on 5/4/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//
import UIKit
import FBSDKLoginKit
/// This class is resposible for the Top Bar that is shown on every screen but the Login and Registration.
/// It contains the logout button and its action when clicked.
class TopBarViewController: UIViewController {

    /// Button that performs the logout functions
    var logoutButton: UIButton!
    
    /// The view of this controller
    var topBar: TopBarView!
    
    /// Handles instatiation of the logout button.  Set the view to TopBarView.  Sets constraints
    override func viewDidLoad() {
        super.viewDidLoad()
        topBar = TopBarView(frame: CGRect.zero)
        //sets this controllers view to the created top bar view.
        self.view = topBar
        logoutButton = {
            logoutButton = UIButton(type: .roundedRect)
            logoutButton.translatesAutoresizingMaskIntoConstraints = false
            
            logoutButton.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 1.0)
            logoutButton.setTitleColor(UIColor.white, for: .normal)
            
            logoutButton.setTitle("Log Out", for: .normal)
            
            return logoutButton
            
            
        }()
        //add the target function for when the logout button is selected
        logoutButton.addTarget(self, action: #selector(TopBarViewController.logout(_:)), for: UIControlEvents.touchUpInside)

        self.view.addSubview(logoutButton)
        self.setElementContraints()

        // Do any additional setup after loading the view.
    }

    /// Responsible for loggin the user out when logout button is clicked.
    ///
    /// - Parameter sender: <#sender description#>
    func logout(_ sender: Any?){
        
        print("Logouy")
        FBSDKAccessToken.setCurrent(nil)
        
        //loginPage return
        let loginVC = LoginViewController()
        self.present(loginVC,animated: true, completion: nil)
        
        
        
    }
    
    /// Sets the constraints of elements within this view controller.
    func setElementContraints(){
        
        //Log out button constraints
        NSLayoutConstraint(
            item: logoutButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: topBar,
            attribute: .top,
            multiplier: 1.0,
            constant: 19.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: logoutButton,
            attribute: .right,
            relatedBy: .equal,
            toItem: topBar,
            attribute: .right,
            multiplier: 1.0,
            constant: -10.0)
            .isActive = true
        
    }
}
