//
//  QRViewController.swift
//  RPBApp
//
//  Created by Michael Perkins on 5/3/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//
import Alamofire
import UIKit

/// responsible for adding rewards to the users profile.  Not implemented with QR code yet
class QRViewController: UIViewController {

    let topBarController: TopBarViewController = TopBarViewController()
    
    
    let breakfastButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(red: 115/255, green: 168/255, blue: 57/255, alpha: 1.0)
        button.addTarget(self, action: #selector(QRViewController.addBreakPoint(_:)), for: UIControlEvents.touchUpInside)

        button.setTitle("Scan Breakfast QR", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        return button
        
    }()
    let lunchButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(red: 3/255, green: 60/255, blue: 115/255, alpha: 0.8)
        button.addTarget(self, action: #selector(QRViewController.addLunchPoint(_:)), for: UIControlEvents.touchUpInside)

        button.setTitle("Scan Lunch QR", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        return button
        
    }()
    let smoothieButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(red: 47/255, green: 164/255, blue: 231/255, alpha: 1.0)
        button.addTarget(self, action: #selector(QRViewController.addSmoothiePoint(_:)), for: UIControlEvents.touchUpInside)

        button.setTitle("Scan Smoothie QR", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        return button
        
    }()
    
    let coffeeButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.init(red: 221/255, green: 86/255, blue: 0/255, alpha: 1.0)
        button.addTarget(self, action: #selector(QRViewController.addCoffeePoint(_:)), for: UIControlEvents.touchUpInside)
        
        button.setTitle("Scan Coffee QR", for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        return button
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(smoothieButton)
        self.view.addSubview(coffeeButton)
        self.view.addSubview(lunchButton)
        self.view.addSubview(topBarController.view)
        self.view.addSubview(breakfastButton)
        
        self.setViewConstraints()
        
        // Do any additional setup after loading the view.
    }
    func backToMainPage(){
        
        let mainVC = TabController()
        self.present(mainVC, animated: true, completion: nil)
        
    }
    func addBreakPoint(_ sender: Any?){
        let email: String! = GlobalVariables.sharedManager.profile!.email
        let url: String! = "http://www.ellenstuder.com/ellen/addPoint.php"
        let parameters: Parameters = ["type" : "breakfast", "email": email]

        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            print(response.timeline) //metrics for testing
           
            print(response.result.isSuccess)   // result of response serialization
            self.backToMainPage()
        }
        
        
    }
    func addLunchPoint(_ sender: Any?){
        let email: String! = GlobalVariables.sharedManager.profile!.email
        let url: String! = "http://www.ellenstuder.com/ellen/addPoint.php"
        let parameters: Parameters = ["type" : "lunch", "email": email]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            print(response.timeline) //metrics
           
            print(response.result.isSuccess)   // result of response serialization
            self.backToMainPage()
        }
        
        
    }
    func addSmoothiePoint(_ sender: Any?){
        let email: String! = GlobalVariables.sharedManager.profile!.email
        let url: String! = "http://www.ellenstuder.com/ellen/addPoint.php"
        let parameters: Parameters = ["type" : "smoothie", "email": email]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            print(response.timeline) //metrics
           
            print(response.result.isSuccess)   // result of response serialization
            self.backToMainPage()
        }
        
        
    }
    func addCoffeePoint(_ sender: Any?){
        let email: String! = GlobalVariables.sharedManager.profile!.email
        let url: String! = "http://www.ellenstuder.com/ellen/addPoint.php"
        let parameters: Parameters = ["type" : "coffee", "email": email]
        
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            print(response.timeline) //metrics
           
            print(response.result.isSuccess)   // result of response serialization
            self.backToMainPage()
        }
        
        
    }
    
    func setViewConstraints() {
        //breakfast button constraints
        NSLayoutConstraint(
            item: breakfastButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: breakfastButton,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 0.5,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: breakfastButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: breakfastButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.1,
            constant: 0.0)
            .isActive = true
        
        //lunch button
        NSLayoutConstraint(
            item: lunchButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: lunchButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: smoothieButton,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30.0)
            .isActive = true
        NSLayoutConstraint(
            item: lunchButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: lunchButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.1,
            constant: 0.0)
            .isActive = true
        
        //smoothie button
        NSLayoutConstraint(
            item: smoothieButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: smoothieButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: coffeeButton,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30.0)
            .isActive = true
        NSLayoutConstraint(
            item: smoothieButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: smoothieButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.1,
            constant: 0.0)
            .isActive = true
        
        //coffee button
        NSLayoutConstraint(
            item: coffeeButton,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: coffeeButton,
            attribute: .top,
            relatedBy: .equal,
            toItem: breakfastButton,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 30.0)
            .isActive = true
        NSLayoutConstraint(
            item: coffeeButton,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 0.4,
            constant: 0.0)
            .isActive = true
        NSLayoutConstraint(
            item: coffeeButton,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.1,
            constant: 0.0)
            .isActive = true
        
        
        
        
        //top bar constraints
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
