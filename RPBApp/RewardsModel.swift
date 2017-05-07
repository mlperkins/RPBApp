//
//  RewardsModel.swift
//  RPBApp
//
//  Created by Michael Perkins on 4/5/17.
//  Copyright © 2017 Michael Perkins. All rights reserved.
//

import Foundation

struct Rewards{
    var breakfastRewards: Float = 0
    var lunchRewards: Float = 0
    var smoothiesRewards: Float = 0
    var coffeeRewards: Float = 0
    
    init(b: Float, l: Float, s: Float, c: Float) {
        breakfastRewards = b
        lunchRewards = l
        smoothiesRewards = s
        coffeeRewards = c
    }
    //breakfast points are in 0, lunch in 1, smoothies in 2 and coffee in 3
    func getAllRewards() -> [Float]{
        var allRewards: [Float] = []
        allRewards[0] = breakfastRewards
        allRewards[1] = lunchRewards
        allRewards[2] = smoothiesRewards
        allRewards[3] = coffeeRewards
        return allRewards
    }
    mutating func incrementBreakfast() -> Float {
        breakfastRewards += 1
        return breakfastRewards
    }
    mutating func incrementLunch() -> Float{
        lunchRewards += 1
        return lunchRewards
    }
    mutating func incrementSmoothies() -> Float{
        smoothiesRewards += 1
        return smoothiesRewards
    }
    mutating func incrementCoffee() -> Float{
        coffeeRewards += 1
        return coffeeRewards
    }
    mutating func checkUpdates(){
        
        //code to check the most recent data in database
        
    }
}
