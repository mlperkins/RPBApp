//
//  MainViewController.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/5/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

class TabController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
       // self.view.window!.rootViewController = self

        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let MainTab = MainPageViewController()
        let MainPageIcon = UITabBarItem(title: "Rewards", image: #imageLiteral(resourceName: "RPBLogo_icon"), selectedImage: #imageLiteral(resourceName: "RPBLogo_icon"))
        
        MainTab.tabBarItem = MainPageIcon
        
        let HelpTab = HelpPageViewController()
        let HelpPageIcon = UITabBarItem(title: "Help",image: #imageLiteral(resourceName: "Button-help-icon"), selectedImage: #imageLiteral(resourceName: "Button-help-icon") )
        
        
        HelpTab.tabBarItem = HelpPageIcon
        
        let controllers : [UIViewController] = [MainTab,HelpTab]
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
