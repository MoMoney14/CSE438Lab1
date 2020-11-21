//
//  ViewController.swift
//  MahotoSasaki-Lab2
//
//  Created by Mahoto Sasaki on 9/11/20.
//  Copyright © 2020 mo3aru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var petView: UIView!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var playedLabel: UILabel!
    @IBOutlet weak var happinessDisplayView: DisplayView!
    @IBOutlet weak var fedLabel: UILabel!
    @IBOutlet weak var foodLevelDisplayView: DisplayView!
    
    @IBOutlet weak var happyMessageLabel: UILabel!
    @IBOutlet weak var foodMessageLabel: UILabel!
    
    var currentPet:Pet?
    var petArray = [Pet]()
    
    var timer = Timer()
    var lightModeColor = [#colorLiteral(red: 1, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.5792533755, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.7948480248, blue: 0, alpha: 1), #colorLiteral(red: 0.5613378286, green: 1, blue: 0, alpha: 1), #colorLiteral(red: 0.9828439355, green: 0.5925622582, blue: 1, alpha: 1)]
    var lightModeDict = [String:UIColor]()
    var darkModeColor = [#colorLiteral(red: 0.5483330488, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.2385930717, blue: 0.5181404948, alpha: 1), #colorLiteral(red: 0.4816702604, green: 0.5005233288, blue: 0.1056167558, alpha: 1), #colorLiteral(red: 0, green: 0.5093609691, blue: 0.156251967, alpha: 1), #colorLiteral(red: 0.3019272983, green: 0.05646890402, blue: 0.3376825452, alpha: 1)]
    var darkModeDict = [String:UIColor]()
    var petName:[String] = ["Dog", "Cat", "Bird", "Bunny", "Fish"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var index = 0
        for pet in petName {
           lightModeDict[pet] = lightModeColor[index]
           darkModeDict[pet] = darkModeColor[index]
           index += 1
        }
        
        //https://stackoverflow.com/questions/56457395/how-to-check-for-dark-mode-in-ios
        if traitCollection.userInterfaceStyle == .dark {
            for pet in petName {
                createImage(imageName: pet, color: darkModeDict[pet] ?? UIColor.white)
            }
        } else {
            for pet in petName {
                createImage(imageName: pet, color: lightModeDict[pet] ?? UIColor.white)
            }
        }
        currentPet = petArray[0]
        petImageView.image = currentPet?.image
        
        updateDisplay()
        updateColor()
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
    }
    
    //https://stackoverflow.com/questions/56457395/how-to-check-for-dark-mode-in-ios
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.userInterfaceStyle == .dark {
            for pet in petArray {
                pet.color = darkModeDict[pet.name] ?? UIColor.white
            }
        } else {
            for pet in petArray {
                pet.color = lightModeDict[pet.name] ?? UIColor.white
            }
        }
        updateColor()
    }
    
    @objc func startTimer(){
        currentPet?.needingLove()
        currentPet?.gettingHungry()
        updateDisplay()
    }
    
    func createImage(imageName:String, color:UIColor) {
        let image = UIImage(named: imageName)
        if let image = image {
            let pet = Pet(name: imageName, color: color, image: image)
            petArray.append(pet)
        }
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        currentPet?.play()
        updateDisplay()
    }
    
    @IBAction func feedButtonPressed(_ sender: UIButton) {
        currentPet?.feed()
        updateDisplay()
    }
    
    @IBAction func dogButtonPressed(_ sender: UIButton) {
        if let text = sender.currentTitle {
            switchCurrentPet(buttonName: text)
        }
    }
    
    @IBAction func catButtonPressed(_ sender: UIButton) {
        if let text = sender.currentTitle {
            switchCurrentPet(buttonName: text)
        }
    }
    
    @IBAction func birdButtonPressed(_ sender: UIButton) {
        if let text = sender.currentTitle {
            switchCurrentPet(buttonName: text)
        }
    }
    
    @IBAction func bunnyButtonPressed(_ sender: UIButton) {
        if let text = sender.currentTitle {
            switchCurrentPet(buttonName: text)
        }
    }
    
    @IBAction func fishButtonPressed(_ sender: UIButton) {
        if let text = sender.currentTitle {
            switchCurrentPet(buttonName: text)
        }
    }
    
    func switchCurrentPet(buttonName:String){
        for pet in petArray {
            if pet.name == buttonName {
                if currentPet !== pet {
                    currentPet = pet
                    petImageView.image = currentPet?.image
                    updateDisplay()
                    updateColor()
                }
            }
        }
    }
    
    func updateDisplay(){
        playedLabel.text = "played: \(currentPet?.totalTimesPlayed ?? 0)"
        fedLabel.text = "fed: \(currentPet?.totalTimesFed ?? 0)"
        let happinessLevel = currentPet?.happinessLevel ?? 0
        let maxHappinessLevel = currentPet?.maxHappinessLevel ?? 10
        happinessDisplayView.animateValue(to: CGFloat(happinessLevel)/CGFloat(maxHappinessLevel))
        let foodLevel = currentPet?.foodLevel ?? 0
        let maxFoodLevel = currentPet?.maxFoodLevel ?? 10
        foodLevelDisplayView.animateValue(to: CGFloat(foodLevel)/CGFloat(maxFoodLevel))
        
        happyMessageLabel.text = currentPet?.getHappyMessage()
        foodMessageLabel.text = currentPet?.getFoodMessage()
    }
    
    func updateColor() {
        petView.backgroundColor = currentPet?.color
        happinessDisplayView.color = currentPet?.color ?? UIColor.black
        foodLevelDisplayView.color = currentPet?.color ?? UIColor.black
    }
}

