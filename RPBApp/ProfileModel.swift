//
//  ProfileModel.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/5/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import Foundation

struct UserProfile{
    let email: String
    let password: String
    var userImage: NSData //most likely will be changed
    
    
    init(e: String, p: String, image: NSData) {
        email = e
        password = p
        userImage = image
    
    }
    func getEmail() -> String{
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
        
    }
}
