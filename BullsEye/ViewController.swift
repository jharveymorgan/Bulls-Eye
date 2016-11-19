//
//  ViewController.swift
//  BullsEye
//
//  Created by Jordan Harvey-Morgan on 5/23/16.
//  Copyright © 2016 Jordan Harvey-Morgan. All rights reserved.
//

import UIKit
// import Core Animation
import QuartzCore

class ViewController: UIViewController {
    
    // establish variable for currentValue of slider
    var currentValue = 0
    // establish variable for targetValue user is trying to get
    var targetValue = 0
    // establish variable to keep count of score
    var score = 0
    // establish variable to keep count of rounds
    var round = 0
    
    // establish a variable named 'slider' that can be connected to a UISlider object. created so slider can be used throughout viewController
    @IBOutlet weak var slider: UISlider!
    
    // establish a variable named 'targetLabel' that can be connected to a label. 
    // created so that the label can hold whatever the current targetValue is
    @IBOutlet weak var targetLabel: UILabel!
    
    // establish a variable named 'scoreLabel' so that it can be connected to a label
    // created so htat the label can hold whatever the current score is
    @IBOutlet weak var scoreLabel: UILabel!
    
    // establish a variable to connect to a label in order to update the rounds
    @IBOutlet weak var roundLabel: UILabel!
    
    // viewDidLoad only called once when app starts up
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // call startNewRound() when app opens
        startNewRound()
        // call updateLabels() when app opens to tell user the targetValue
        updateLabels()
        
        // image for slider - Thumb
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: UIControlState())
        // image for slider - Thumb (Highlighted)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        // set color of highlighted trail behind slider position
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        // slider track left, so the slider track is green
        if let trackLeftImage = UIImage(named: "SliderTrackLeft") {
            let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
            slider.setMinimumTrackImage(trackLeftResizable, for: UIControlState())
        }
        // slider track right, so the slider track is grey
        if let trackRightImage = UIImage(named: "SliderTrackRight") {
            let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
            slider.setMaximumTrackImage(trackRightResizable, for: UIControlState())
        }
        
        // change title
        title = "Bull's Eye Home Page" // or self.title = "Bull's Eye Home Page"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // create alert
    // create action for alert that is connected to the "Hit Me" button
    // no parameters
    @IBAction func showAlert() {
        // establish variable and find difference between slider.value and targetValue
        let difference = abs(currentValue - targetValue)
        // calculate score
        var points = 100 - difference
        
        // if statements for title, depending on how well the user did
        // give bonus points base on how user did
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference <= 5 {
            title = "So close!"
            // if user is 1 point away
            if difference == 1 {
                points += 50
            }
        } else if difference <= 10 {
            title = "Almost had it!"
        } else {
            title = "Not even close..."
        }
        
        // update score
        score += points
        
        // create message that tells user how many points they got
        let message = "You scored \(points) points!"
        
        // text for Alert message
        // 'alert' is local
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Button to dismiss alert
        // 'action' is local
        // use a closure
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in self.startNewRound(); self.updateLabels()})
        
            // testing second button in alert
            // let action2 = UIAlertAction(title: "Test", style: .Default, handler: nil)
        
        // use alert variable (with defined message)
        // use action variable (with defined message for single button)
        alert.addAction(action)
        
            // add second button to alert
            // alert.addAction(action2)
        
        // what does this do ??
        // I think makes the alert pop up in whatever viewController is up
        // OR present the alert message in the ViewController
        present(alert, animated: true, completion: nil)
        
    }
    
    // Get value of slider
    // create action for alert that is connected to slider
    // method (sliderMoved) called when the slider is moved, I think
    // 'slider' is the paramater, but it is local. Meaning, only available within sliderMoved method
    @IBAction func sliderMoved(_ slider: UISlider) {
        // get value of slider, by rounding to nearest whole number
        currentValue = lroundf(slider.value)
        
    }
    
    // 'Start Over' button
    @IBAction func startOver(_ sender: UIButton) {
        //set up new game
        startNewGame()
        updateLabels()
        
        // animation
        let transition = CATransition()
        transition.type = kCATransitionFade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        view.layer.add(transition, forKey: nil)
    }
    
    // start a new game
    func startNewGame() {
        // set score
        score = 0
        // set round
        round = 0
        // call startNewRound to set up game
        startNewRound()
    }
    
    // method for starting a new round of the game
    func startNewRound() {
        // update round
        round += 1
        // generate a new target value for the round
        targetValue = 1 + Int(arc4random_uniform(100))
        // reset position of slider
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    // method to update the label with each new targetValue
    func updateLabels() {
        // print out targetValue in the label
        targetLabel.text = String(targetValue) // or = "\(targetValue)"
        // print out the score in the label
        scoreLabel.text = String(score)
        // print out the round in the label
        roundLabel.text = String(round)
    }

}

