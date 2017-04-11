//
//  CustomProgressView.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/10/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

class CustomProgressView: UIView {

    var updateConstraints: Bool? = true;
    var progressView : UIProgressView!
    var label : UILabel!
    var progress : Float = 0.5
    
    init(frame: CGRect, labelText: String, progressSize: Float){
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.progress = progressSize
        label = {
            label = UILabel()
            label.text = labelText
            label.textColor = UIColor.black
            label.translatesAutoresizingMaskIntoConstraints = false;
            return label
        }()
        progressView = {
            let view = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
            view.setProgress(progress, animated: true)
            view.trackTintColor = UIColor.yellow
            let myBlue: UIColor = UIColor.init(red: 0/255, green: 191/255, blue: 1.0, alpha: 1.0)
            view.progressTintColor = myBlue
            view.translatesAutoresizingMaskIntoConstraints = false;
            return view
        }()
        progressView.addSubview(label)
        self.addSubview(progressView)
    }
    func setViewConstraints(view: UIView, centerY: CGFloat){
        
        //SET PROGRESS VIEW CONSTRAINTS
        //width constraint
        NSLayoutConstraint(
            item: progressView,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.75,
            constant: 0.0)
            .isActive = true
        //height constraint
        NSLayoutConstraint(
            item: progressView,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.05,
            constant: 0.0)
            .isActive = true
        
        //x coord constraint
        NSLayoutConstraint(
            item: progressView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        //y coord constraint
        NSLayoutConstraint(
            item: progressView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: centerY,
            constant: 0.0)
            .isActive = true
        
        
        //SET LABEL CONSTRAINTS
        NSLayoutConstraint(
            item: label,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: progressView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: label,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: progressView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        
    }
    func incrementProgressBar(){
        progress += 0.1
        progressView.setProgress(progress, animated: true)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
        
}


