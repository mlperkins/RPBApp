//
//  MainPageViewController.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/6/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    var breakfastProgress: CustomProgressView
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        breakfastProgress = CustomProgressView()

        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(breakfastProgress)
        view.setNeedsUpdateConstraints()

    }
    override func updateViewConstraints() {
        setViewConstraints()
        super.updateViewConstraints()
    }
    func setViewConstraints(){
        
        NSLayoutConstraint(
            item: breakfastProgress,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.75,
            constant: 0.0)
            .isActive = true
        //height constraint
        NSLayoutConstraint(
            item: breakfastProgress,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.05,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: breakfastProgress,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: breakfastProgress,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        print("set constraints")
    }
        
    
    
}
