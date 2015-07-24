//
//  ViewController.swift
//  Mines
//
//  Created by Juan Gomez on 22/07/15.
//  Copyright (c) 2015 Codes and Tags. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var sound : AVAudioPlayer = AVAudioPlayer()
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var gameValue = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var mines = [[0, 1, 0, 1, 0],
                 [1, 0, 1, 1, 0],
                 [1, 1, 1, 0, 0],
                 [0, 0, 0, 1, 0],
                 [1, 0, 1, 1, 0]]
    var activeGame = true
     var flag = 0
    
   
    @IBAction func playAgain(sender: AnyObject) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameValue = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        activeGame = true
        flag = 0
        var buttons = UIButton()
        for var i = 0; i < 25; i++ {
            buttons = view.viewWithTag(i) as! UIButton
            buttons.setImage(nil, forState: .Normal)
        }
        play_label.hidden = true
        result.hidden = true
        result.center = CGPoint(x: result.center.x , y: result.center.y - 500)
        result2.hidden = true
        result.center = CGPoint(x: result.center.x, y: result.center.y - 500)
        
    }
    @IBOutlet weak var play_label: UIButton!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var result2: UILabel!
    @IBAction func button(sender: AnyObject) {
        var image = UIImage()
        var counter = 0
        println(gameState[sender.tag])
        println(activeGame)
        if(gameState[sender.tag] == 0 && activeGame == true){
            for var i = 0; i < 5; i++ {
                for var j = 0; j < 5; j++ {
                    gameValue[counter] = mines[i][j]
                    counter++
                }
            }
            if gameValue[sender.tag] == 0{
                image = UIImage(named: "grass.jpg")!
                gameState[sender.tag]  = 1
                flag++
                
            }else{
                var boomSound = NSBundle.mainBundle().pathForResource("bomb", ofType: "mp3")!
                var error : NSError? = nil
                sound = AVAudioPlayer(contentsOfURL: NSURL(string: boomSound), error: &error)
                if error == nil{
                    sound.play()
                }
                image = UIImage(named: "bomb.png")!
               // result.text = "BOOM! You're dead.."
                result.hidden = false
                play_label.hidden = false
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.result.center = CGPoint(x: self.result.center.x, y: self.result.center.y + 500)
                })
                activeGame = false
            }
           
            
            if flag == 5 {
                var winSound = NSBundle.mainBundle().pathForResource("win", ofType: "mp3")
                var error : NSError? = nil
                sound = AVAudioPlayer(contentsOfURL: NSURL(string: winSound!), error: &error)
                if error == nil{
                    sound.play()
                }else{
                    println(error)
                }
                result2.hidden = false
                play_label.hidden = false
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.result2.center = CGPoint(x: self.result2.center.x, y: self.result2.center.y + 500)
                })
                activeGame = false
            }
            
            sender.setImage(image, forState: .Normal)
        }
        
        //println(sender.tag)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        play_label.hidden = true
        result.hidden = true
        result.center = CGPoint(x: result.center.x , y: result.center.y - 500)
        result2.hidden = true
        result.center = CGPoint(x: result.center.x, y: result.center.y - 500)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

