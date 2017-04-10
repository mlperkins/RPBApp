//
//  MainPageViewController.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/6/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    var breakfastProgress: CustomProgressView!
    var lunchProgress: CustomProgressView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        breakfastProgress = CustomProgressView(frame: CGRect.zero, labelText: "BREAKFAST", progressSize: 0.25)
        lunchProgress = CustomProgressView(frame: CGRect.zero, labelText: "LUNCH", progressSize: 0.75)
        
        
        self.view.addSubview(lunchProgress)
        self.view.addSubview(breakfastProgress)
        
        //set position of the progress bars
        breakfastProgress.setViewConstraints(view: view, centerY: 0.3)
        
        lunchProgress.setViewConstraints(view: view, centerY: 0.5)
        
       // view.setNeedsUpdateConstraints()

    }
    override func updateViewConstraints() {
        setViewConstraints()
        super.updateViewConstraints()
    }
    func setViewConstraints(){
        
        
    }
    
        
    
    
}
