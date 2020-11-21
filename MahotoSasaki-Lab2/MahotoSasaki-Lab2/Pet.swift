//
//  Pet.swift
//  MahotoSasaki-Lab2
//
//  Created by Mahoto Sasaki on 9/12/20.
//  Copyright © 2020 mo3aru. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class Pet {
    let name:String
    var color:UIColor?
    let image:UIImage?
    var happinessLevel:Int
    var foodLevel:Int
    var totalTimesPlayed:Int
    var totalTimesFed:Int
    let maxFoodLevel:Int
    let maxHappinessLevel:Int
    
    var happyMessage:String
    var foodMessage:String
    
    func play() {
        if foodLevel > 0 {
            if happinessLevel < maxHappinessLevel {
                happinessLevel += 1
            }
            foodLevel -= 1
            totalTimesPlayed += 1
        }
    }
    
    func feed() {
        if foodLevel < maxFoodLevel {
            foodLevel += 1
            totalTimesFed += 1
        }
    }
    
    func needingLove() {
        if happinessLevel > 0 {
            happinessLevel -= 1
        }
    }
    
    func gettingHungry(){
        if foodLevel > 0 {
            foodLevel -= 1
        }
    }
    
    func getHappyMessage() -> String {
        if happinessLevel == maxHappinessLevel {
            happyMessage = "I'm happy :)"
        } else if happinessLevel > 0 {
            happyMessage = ""
        } else {
            happyMessage = "I need love :("
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        return happyMessage
    }
    
    func getFoodMessage() -> String {
        if foodLevel == maxFoodLevel {
            foodMessage = "I'm full :)"
        } else if foodLevel > 0 {
            foodMessage = ""
        } else {
            foodMessage = "I'm hungry :("
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
        return foodMessage
    }
    
    init(name:String, color:UIColor, image:UIImage){
        self.name = name
        self.color = color
        self.image = image
        happinessLevel = 0
        foodLevel = 0
        totalTimesPlayed = 0
        totalTimesFed = 0
        maxFoodLevel = 10
        maxHappinessLevel = 10
        happyMessage = ""
        foodMessage = ""
    }
}
