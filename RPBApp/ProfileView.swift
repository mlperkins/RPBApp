//
//  ProfileViewController.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/10/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import UIKit

class ProfileView: UIView{
    
    var profile : ProfileModel!

    init(frame: CGRect, email: String, password: String){
     profile = ProfileModel(email)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
