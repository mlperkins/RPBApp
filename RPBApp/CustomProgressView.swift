//
//  CustomProgressView.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/10/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

class CustomProgressView: UIView {

    var progressView : UIProgressView = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        progressView.setProgress(0.4, animated: false)
        progressView.trackTintColor = UIColor.black
        let myBlue: UIColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 1.0)
        progressView.progressTintColor = myBlue
        progressView.translatesAutoresizingMaskIntoConstraints = false;
        print("Set style")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
        
}


