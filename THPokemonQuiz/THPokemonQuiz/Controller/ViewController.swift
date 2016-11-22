//
//  ViewController.swift
//  THPokemonQuiz
//
//  Created by Hai on 11/17/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLB: UILabel!
    @IBOutlet weak var hightScoreLB: UILabel!
    
    @IBOutlet weak var btnPlay: UIButton!
    var score = 0
    var sound : Bool?
    var music : Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreLB.text = "0"
        
    }
    func soundMusic () {
        if UserDefaults.standard.value(forKey: "Sound") != nil {
            self.sound = UserDefaults.standard.value(forKey: "Sound") as? Bool
        } else {
            self.sound = true
        }
        if UserDefaults.standard.value(forKey: "Music") != nil {
            self.music = UserDefaults.standard.value(forKey: "Music") as? Bool
        }else {
            self.music = true
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.soundMusic()
        print(self.music)
        THPlayer.shared.playMusic(nameSound: Main, music: self.music!)
        setHighScore()
        self.scoreLB.text = "\(self.score)"
    }
    func setHighScore() {
        if (UserDefaults.standard.value(forKey: "Score") != nil){
            self.score = UserDefaults.standard.value(forKey: "Score") as! Int
        } else {
            self.score = 0
        }
        if ( UserDefaults.standard.value(forKey: "high") == nil) {
            UserDefaults.standard.set(score, forKey: "high")
        } else {
            let hightscore = UserDefaults.standard.value(forKey: "high") as! Int
            if score > hightscore {
                UserDefaults.standard.set(score, forKey: "high")
                hightScoreLB.text = "NEW HIGH SCORE: \(self.score)"
            } else {
                hightScoreLB.text = "HIGH SCORE: \(hightscore)"
                
            }
        }
        
    }
    
    @IBAction func invokePlayBtn(_ sender: AnyObject) {
        THPlayer.shared.playerMusic?.pause()
        let quizController = self.storyboard?.instantiateViewController(withIdentifier: "THQuizController") as! THQuizController
        self.navigationController?.pushViewController(quizController, animated: true)
    }
    
    @IBAction func invokeSettingBtn(_ sender: AnyObject) {
        let settingController = self.storyboard?.instantiateViewController(withIdentifier: "THSettingViewController") as! THSettingViewController
        
        self.navigationController?.pushViewController(settingController, animated: true)
    }

}

