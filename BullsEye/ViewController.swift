//
//  ViewController.swift
//  BullsEye
//
//  Created by aleksandar lalic on 15/02/2018.
//  Copyright © 2018 Aleksandar Lalic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue: Int = 0
    
    @IBOutlet weak var slider: UISlider!
    
    var targetValue = 0
    
    var score = 0
    
    var round = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentValue = lroundf(slider.value)
        
        startNewGame()
        
        let  thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal") //UIImage(named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let  thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") //UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft") //UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight") //UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        
        
        
        
    }
    
    func startNewGame() {
        round = 0
        score = 0
        startNewRound()
    }
    
    func updateLabels () {
        
        randomNumberLabel.text = "\(targetValue)"
        scoreLable.text = "\(score)"
        roundLabel.text = "\(round)"
    }
    
    func startNewRound() {
        round += 1
        targetValue = 1 + Int(arc4random_uniform(100))
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var randomNumberLabel: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        
        print("The value of slider is now: \(slider.value)")
        
        currentValue = lroundf(slider.value)
    }
    
    
    @IBAction func showAlert() {
        
        let difference : Int = abs(targetValue - currentValue)
        var points = 100 - difference
        let title : String
        if difference == 0{
            title = "Bull'sEye"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty Good!"
        } else {
            title = "Not even close!!!"
        }
        
        score += points // moze i da se napise score = score + pints += je skracena verzija
        
        let message = "You scored \(points) points"
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Awesome", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        }
    
    
    @IBAction func startNewGameButton(_ sender: UIButton) {
        startNewGame()
    }
    
}

