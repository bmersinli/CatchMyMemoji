//
//  ViewController.swift
//  CatchMyMemoji
//
//  Created by Beyza Mersinli on 27.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //Variables
    var score = 0
    var timer = Timer()
    var counter = 0
    var memojiArray = [UIImageView]()
    var hideTimer = Timer()
    var highscore = 0
    
    
    
    //Views
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var memoji1: UIImageView!
    @IBOutlet weak var memoji2: UIImageView!
    @IBOutlet weak var memoji3: UIImageView!
    @IBOutlet weak var memoji4: UIImageView!
    @IBOutlet weak var memoji5: UIImageView!
    @IBOutlet weak var memoji6: UIImageView!
    @IBOutlet weak var memoji7: UIImageView!
    @IBOutlet weak var memoji8: UIImageView!
    @IBOutlet weak var memoji9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        //Highscore Check
        
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highscore = 0
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        
        if let  newScore = storedHighscore as? Int {
            highscore = newScore
            highscoreLabel.text = "Highscore: \(highscore)"
        }
        memoji1.isUserInteractionEnabled = true
        memoji2.isUserInteractionEnabled = true
        memoji3.isUserInteractionEnabled = true
        memoji4.isUserInteractionEnabled = true
        memoji5.isUserInteractionEnabled = true
        memoji6.isUserInteractionEnabled = true
        memoji7.isUserInteractionEnabled = true
        memoji8.isUserInteractionEnabled = true
        memoji9.isUserInteractionEnabled = true

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        memoji1.addGestureRecognizer(recognizer1)
        memoji2.addGestureRecognizer(recognizer2)
        memoji3.addGestureRecognizer(recognizer3)
        memoji4.addGestureRecognizer(recognizer4)
        memoji5.addGestureRecognizer(recognizer5)
        memoji6.addGestureRecognizer(recognizer6)
        memoji7.addGestureRecognizer(recognizer7)
        memoji8.addGestureRecognizer(recognizer8)
        memoji9.addGestureRecognizer(recognizer9)
        
        memojiArray = [memoji1, memoji2, memoji3, memoji4, memoji5, memoji6, memoji7, memoji8, memoji9]
        
        //Timer
        counter = 10
        timeLabel.text = String(counter)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideMemoji), userInfo: nil, repeats: true)
        
        hideMemoji()

    }
    
    @objc func hideMemoji() {
        for memoji in memojiArray {
            memoji.isHidden = true
        }
      let random = Int(arc4random_uniform(UInt32(memojiArray.count-1)))
        memojiArray[random].isHidden = false
    }
    
    @objc func increaseScore() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown() {
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for memoji in memojiArray {
                memoji.isHidden = true
            }
            
            //Highscore
            
            if self.score > self.highscore {
                self.highscore = self.score
                highscoreLabel.text = "Highscore: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            
            //Alert
            
            let alert = UIAlertController(title: "Time's Up", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                // replay function
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideMemoji), userInfo: nil, repeats: true)
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }


}

