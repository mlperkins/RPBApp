//
//  HelpPageViewController.swift
//  RPBApp
//  NOTE: STILL IN PROGRESS.
//  Created by Michael Perkins and Ellen Studer on 4/6/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

/// Responsible for the elements of the help page.  Currently only has top bar.
class HelpPageViewController: UIViewController {
    let topBarController: TopBarViewController = TopBarViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(topBarController.view)
        self.setViewConstraints()
        
        
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    func setViewConstraints(){
        //top Bar constraints
        NSLayoutConstraint(
            item: topBarController.view,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: topBarController.view,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: topBarController.view,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: topBarController.view,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.08,
            constant: 0.0)
            .isActive = true
    }
}
