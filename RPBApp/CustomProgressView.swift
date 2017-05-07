//
//  CustomProgressView.swift
//  RPBApp
//
//  Created by Michael Perkins and Ellen Studer on 4/10/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

/// The custom progress views that are seen on the MainPageControllerView.  Handles customization of the ProgressViews like color, size, its labels and handles the updating of its status.
class CustomProgressView: UIView {

    var progressView : UIProgressView!
    //Text label seen above the progress view
    var label : UILabel!
    //Number label seen inside the progress view
    var numberLabel: UILabel!
    var progress : Float!
    
    /// Initializes the progress view. Sets all  class variables
    ///
    /// - Parameters:
    ///   - frame: default for a UIView. Always is CGRect.zero
    ///   - labelText: The label of the progress bar seen above it
    ///   - progressSize: Starting progress number
    ///   - progressColor: The color of the progress bars
    init(frame: CGRect, labelText: String, progressSize: Float, progressColor: UIColor){
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
        numberLabel = {
            let numlabel = UILabel()
            numlabel.text = "\(Int(self.progress*10))/10"
            numlabel.textColor = UIColor.black
            numlabel.translatesAutoresizingMaskIntoConstraints = false;
            return numlabel
        }()
        progressView = {
            let view = UIProgressView(progressViewStyle: UIProgressViewStyle.default)
            view.setProgress(progress/10, animated: true)
            view.trackTintColor = UIColor.white
            view.progressTintColor = progressColor
            view.trackTintColor = UIColor.init(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.8)
            view.translatesAutoresizingMaskIntoConstraints = false;
            return view
        }()
        progressView.addSubview(label)
        progressView.addSubview(numberLabel)
        self.addSubview(progressView)
        
    }
    /// Updates the progress of the progress bar
    ///
    /// - Parameter updateProgressFloat: The number to which to set the progress bar to.
    func updateProgress(updateProgressFloat: Float) {
        
        //Dividing by 10 because progress of a UIProgressView is from 0 to 1.
        self.progress = updateProgressFloat/10
        //Multiply by 10 to get the number to be displayed as an INT
        self.numberLabel.text = "\(Int(self.progress*10))/10"
        progressView.setProgress(progress, animated: true)

    }
    
    /// Sets the view constraints of the progress bars
    ///
    /// - Parameters:
    ///   - view: the view in which to set constraints with
    ///   - centerY: the position, vertically, which the progress bar will be set on the view
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
            attribute: .left,
            relatedBy: .equal,
            toItem: progressView,
            attribute: .left,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: label,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: progressView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: numberLabel,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: progressView,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        NSLayoutConstraint(
            item: numberLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: progressView,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
        
}


