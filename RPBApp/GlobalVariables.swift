//
//  SingletonManager.swift
//  SingletonExample
//
//  Created by Chris Cantley on 11/25/14.
//  Copyright (c) 2014 Chris Cantley. All rights reserved.
//
/// Responsible for allowing access to select variables from all components.
class GlobalVariables {
    
    // These are the properties stored
    var profile: UserProfile?
    
    var userRewards: Rewards?
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
    }
}
