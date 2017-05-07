//
//  TopBarView.swift
//  RPBApp
//
//  Created by Michael Perkins and Ellen Studer on 5/4/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

/// This class is the view of TopBarViewController.
class TopBarView: UIView {
    
    /// A label that welcomes user like "Welcome, *Users first name*"
    var welcomeUser : UILabel!

    
    /// Initialization of TopBarView.  Changes background color and instatiates the welcomeUser.
    /// Sets element constraints
    /// - Parameter frame: Required for overwriting init in UIView.  Generally CGRect.zero
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.backgroundColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 1.0)
        
        welcomeUser = {
            let welcome = UILabel()
            welcome.translatesAutoresizingMaskIntoConstraints = false
            welcome.text = "Welcome, \(GlobalVariables.sharedManager.profile!.firstName)"
            welcome.textColor = UIColor.white
            
            return welcome
        }()
        self.addSubview(welcomeUser)
        self.setElementContraints()
    }
   
   
    /// Sets element contraints
    func setElementContraints(){
        
        //set welcomeUser variable constraints.
        NSLayoutConstraint(
            item: welcomeUser,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 22.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: welcomeUser,
            attribute: .left,
            relatedBy: .equal,
            toItem: self,
            attribute: .left,
            multiplier: 1.0,
            constant: 10.0)
            .isActive = true
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
