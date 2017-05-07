//
//  ProfileModel.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/5/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import Foundation

/// Profile of a user
struct UserProfile{
    let firstName: String
    let email: String
    let password: String
    //var userImage: NSData //most likely will be changed
    
    init(n: String, e: String, p: String) {
        firstName = n
        email = e
        password = p
        
    
    }
   /* func getEmail() -> String{
        return email
    }
    func getPassword() -> String {
        return password
    }
    func getUserImage() -> NSData {
        return userImage
    }
    mutating func setUserImage(image: NSData){
        self.userImage = image
        print("User image successfully changed")
        
    }*/
    
}



