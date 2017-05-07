//
//  MainPageViewController.swift
//  RPBApp
//
//  Created by Michael Perkins and Ellen Studer on 4/6/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//
import Alamofire
import UIKit
import FBSDKLoginKit

/// Controller of the main page of the application.  Responsible accessing WEB API to retreive user rewards data and for the display of rewards.
class MainPageViewController: UIViewController {
    
    //Top bar for this page
    let topBarController: TopBarViewController = TopBarViewController()
    
    //custom progress views to display rewards
    var breakfastProgress: CustomProgressView!
    var lunchProgress: CustomProgressView!
    var coffeeProgress: CustomProgressView!
    var smoothieProgress: CustomProgressView!
    
    //progress points, will be updated by database.
    var breakPoints: Int! = 0
    var lunchPoints: Int! = 0
    var coffeePoints: Int! = 0
    var smoothiePoints: Int! = 0
    
    
    //Image Logo
    let logoView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "rpblogo-1"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
        
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {

        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Function that updates user rewards when the view is about to appear again.  Automatically called when view is about to appear.
    ///
    /// - Parameter animated: Decides whether the view appearing is animated.
    override func viewWillAppear(_ animated: Bool) {
        self.retrieveUserRewards()
    }
    
    /// Creates custom views and adds them all to the main view upon load.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        //Instantiates the custom progress bars to
        breakfastProgress = CustomProgressView(frame: CGRect.zero, labelText: "Breakfast", progressSize: (Float(breakPoints)), progressColor: UIColor.init(red: 115/255, green: 168/255, blue: 57/255, alpha: 1.0))
        
        coffeeProgress = CustomProgressView(frame: CGRect.zero, labelText: "Coffee", progressSize: (Float(coffeePoints)), progressColor: UIColor.init(red: 221/255, green: 86/255, blue: 0/255, alpha: 1.0))
        
        smoothieProgress = CustomProgressView(frame: CGRect.zero, labelText: "Smoothies", progressSize: (Float(smoothiePoints)), progressColor: UIColor.init(red: 47/255, green: 164/255, blue: 231/255, alpha: 1.0))
        
        lunchProgress = CustomProgressView(frame: CGRect.zero, labelText: "Lunch", progressSize: (Float(lunchPoints)), progressColor: UIColor.init(red: 3/255, green: 60/255, blue: 115/255, alpha: 0.8))
        
        
        //Adds the subviews to the main view
        self.view.addSubview(topBarController.view)
        self.view.addSubview(logoView)
        self.view.addSubview(lunchProgress)
        self.view.addSubview(coffeeProgress)
        self.view.addSubview(smoothieProgress)
        self.view.addSubview(breakfastProgress)
        
        
        //Set position of the progress bars. The customProgressView class handles all constraints except the position on the y axis
        breakfastProgress.setViewConstraints(view: view, centerY: 0.6)
        coffeeProgress.setViewConstraints(view: view, centerY: 0.8)
        smoothieProgress.setViewConstraints(view: view, centerY: 1.0)
        lunchProgress.setViewConstraints(view: view, centerY: 1.2)
       
        //Update user rewards initially
        self.retrieveUserRewards()
        
        //sets all view constraints
        view.setNeedsUpdateConstraints()

    }
    
    /// Called by the retrieveUserRewards() function to update the progress bars after retrieving user data.
    func updateProgressBars(){
        
        breakfastProgress.updateProgress(updateProgressFloat: Float(self.breakPoints))
        lunchProgress.updateProgress(updateProgressFloat: Float(self.lunchPoints))
        smoothieProgress.updateProgress(updateProgressFloat: Float(self.smoothiePoints))
        coffeeProgress.updateProgress(updateProgressFloat: Float(self.coffeePoints))
        
    }
    
    /// Retrieves user rewards from the WEB API and updates the progress bars.
    func retrieveUserRewards(){
        //getting the user that is logged in email
        let email: String! = GlobalVariables.sharedManager.profile!.email
        
        let parameters: Parameters = ["email": email]
        
        //The PHP script used to get the users reward points.
        let url = "http://www.ellenstuder.com/ellen/getPoints.php"
        
        //Alamo fire request to returns JSON
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON{ response in
            
            //Checks to see if the response was successful or failed.
            switch(response.result) {
            //If successful parse JSON and set the class variables to the values retrieved.
            //If unscuccessful change nothing.
            case .success(_):
                if let JSON = response.result.value as? [[String:AnyObject]]{
                    if JSON.isEmpty == false{
                        print(JSON)
                        self.breakPoints = Int(JSON[0]["breakfast_points"] as! String)!
                        self.lunchPoints = Int(JSON[0]["lunch_points"] as! String)!
                        self.coffeePoints = Int(JSON[0]["coffee_points"] as! String)!
                        self.smoothiePoints = Int(JSON[0]["smoothie_points"] as! String)!
                        print(self.breakPoints)
                        self.updateProgressBars()
                        
                    }
                }
                break
            case .failure(_):
                break
                
            }
            
            
            
        }
        
        
        
    }
    
    
    /// Updates all view constriants
    override func updateViewConstraints() {
        setViewConstraints()
        super.updateViewConstraints()
    }
    
    /// Sets the view constraints of all elements within the view.
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
        
        //Logo constraints
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
            multiplier: 0.99,
            constant: 0.0)
            .isActive = true
        
        //height constraint
        NSLayoutConstraint(
            item: logoView,
            attribute: .height,
            relatedBy: .equal,
            toItem: view,
            attribute: .height,
            multiplier: 0.13,
            constant: 0.0)
            .isActive = true
        //align with top of view
        NSLayoutConstraint(
            item: logoView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: 40.0)
            .isActive = true
    }

        
    
    
}
