//
//  RewardsModel.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/5/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import Foundation

struct Rewards{
    var breakfastRewards: Int = 0
    var lunchRewards: Int = 0
    var smoothiesRewards: Int = 0
    var coffeeRewards: Int = 0
    
    
    //breakfast points are in 0, lunch in 1, smoothies in 2 and coffee in 3
    func getAllRewards() -> [Int]{
        var allRewards: [Int] = []
        allRewards[0] = breakfastRewards
        allRewards[1] = lunchRewards
        allRewards[2] = smoothiesRewards
        allRewards[3] = coffeeRewards
        return allRewards
    }
    mutating func incrementBreakfast() -> Int {
        breakfastRewards += 1
        return breakfastRewards
    }
    mutating func incrementLunch() -> Int{
        lunchRewards += 1
        return lunchRewards
    }
    mutating func incrementSmoothies() -> Int{
        smoothiesRewards += 1
        return smoothiesRewards
    }
    mutating func incrementCoffee() -> Int{
        coffeeRewards += 1
        return coffeeRewards
    }
    mutating func checkUpdates(){
        
        //code to check the most recent data in database
        
    }
}
