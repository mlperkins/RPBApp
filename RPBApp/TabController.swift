//
//  MainViewController.swift
//  RPBApp
//
//  Created by Michael Perkins and Ellen Studer on 4/5/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

/// The class that controls all the different views that can be selected on the tab bar seen at the bottom of the application.
class TabController: UITabBarController, UITabBarControllerDelegate {

    /// Loads the view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    /// Adds all the tab bar items and their controllers to an array.  Automatically called when logged in
    ///
    /// - Parameter animated: whether the view is animated of not
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let MainTab = MainPageViewController()
        let MainPageIcon = UITabBarItem(title: "My Points", image: #imageLiteral(resourceName: "RPBLogo_icon"), selectedImage: #imageLiteral(resourceName: "RPBLogo_icon"))
        
        MainTab.tabBarItem = MainPageIcon
        
        let HelpTab = HelpPageViewController()
        let HelpPageIcon = UITabBarItem(title: "Help",image: #imageLiteral(resourceName: "Button-help-icon"), selectedImage: #imageLiteral(resourceName: "Button-help-icon") )
        
        HelpTab.tabBarItem = HelpPageIcon
        
        let PromotionTab = PromotionViewController()
        let PromotionPageIcon = UITabBarItem(title: "Promotion",image: #imageLiteral(resourceName: "Button-help-icon"), selectedImage: #imageLiteral(resourceName: "Button-help-icon") )
        
        PromotionTab.tabBarItem = PromotionPageIcon
        
        let QRTab = QRViewController()
        let QRPageIcon = UITabBarItem(title: "QR",image: #imageLiteral(resourceName: "Button-help-icon"), selectedImage: #imageLiteral(resourceName: "Button-help-icon") )

        QRTab.tabBarItem = QRPageIcon
        
        
        let controllers : [UIViewController] = [MainTab,HelpTab,PromotionTab,QRTab]
        self.viewControllers = controllers
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(String(describing: viewController.title)) ?")
        return true;
    }
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
