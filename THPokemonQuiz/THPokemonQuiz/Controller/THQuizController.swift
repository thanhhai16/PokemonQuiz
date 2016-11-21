//
//  THQuizController.swift
//  THPokemonQuiz
//
//  Created by Hai on 11/18/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import AVFoundation

class THQuizController: UIViewController {
    
    @IBOutlet weak var progress: RPCircularProgress!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet var btns: [UIButton]!
    @IBOutlet weak var pokemonIDLb: UILabel!
    @IBOutlet weak var scoreLb: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    var pokemons = DataManager.shared.filterPokemon(gens: UserDefaults.standard.value(forKey: "Gens") as! [Bool], pokemons: DataManager.shared.selectPokemons())
    var pokemonNames = DataManager.shared.filterPokemon(gens: UserDefaults.standard.value(forKey: "Gens") as! [Bool], pokemons: DataManager.shared.selectPokemons())
    
    var score = 0
    var gens = UserDefaults.standard.value(forKey: "Gens") as! [Bool]
    
    var trueBtn : Int?
    var truePokemonID : Int?
    var sound : Bool?
    var music : Bool?
    var player = AVPlayer()
    var playerSound = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.pokemonIDLb.isHidden = true
        self.setPokemon()
        self.progressTime()
        self.soundMusic()
        self.playMusic(nameSound: Play)
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

    
    
    func setPokemon () {
        
        self.truePokemonID = Int(arc4random()) % (self.pokemons.count)
        self.trueBtn = Int(arc4random()) % 4
        
        var anotherBtn = btns
        anotherBtn?.remove(at: trueBtn!)
        var anotherPokemon = self.pokemonNames
        anotherPokemon.remove(at: self.truePokemonID!)
        
        self.btns[self.trueBtn!].setTitle("\(self.pokemons[truePokemonID!].name!)", for: .normal)
        
        for btn in anotherBtn! {
            let random = Int(arc4random()) % (anotherPokemon.count)
            let title = anotherPokemon[random].name
            btn.setTitle(title, for: .normal)
            anotherPokemon.remove(at: random)
        }
        
        self.pokemonImage.image = UIImage(named: "\(self.pokemons[self.truePokemonID!].images!)")
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysTemplate)
        self.pokemonImage.tintColor = UIColor.black
        
        let color = UIColor().HexToColor(hexString: "\(self.pokemons[self.truePokemonID!].color!)")
        self.backgroundView.backgroundColor = color
        
        self.pokemonIDLb.text = (self.pokemons[self.truePokemonID!].tag!) + " " + (self.pokemons[self.truePokemonID!].name!)
        
    }
    
    
    func setupUI ()  {
        self.scoreLb.text = "\(self.score)"
        
        for btn in btns {
            btn.layer.cornerRadius = 20
        }
        
        self.cardView.layer.cornerRadius = 10
        
    }
    
    func progressTime () {
        DispatchQueue.main.async {
            self.progress.updateProgress(1, animated: true, initialDelay: 0, duration: 30, completion: {
                self.playerSound.pause()
                self.player.pause()
                UserDefaults.standard.set(self.score, forKey: "Score")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.navigationController?.popViewController(animated: true)

                })

            })
        }
        }
    @IBAction func invokeBtnA(_ sender: UIButton) {
        var anotherBtn = self.btns
        let index = self.btns.index(of: sender)!
        anotherBtn?.remove(at: index)
        UIView.transition(with: self.cardView, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.pokemonIDLb.isHidden = false
            self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysOriginal)
        }) { (complete) in
            self.choiceAnswer(answer: sender.title(for: .normal)!, button: sender, anotherButton: anotherBtn!)
            self.pokemons.remove(at: self.truePokemonID!)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.nextPokemon()
            })

        }

            }
    func nextPokemon() {
        setPokemon()
        self.pokemonIDLb.isHidden = true
        for btn in btns {
            btn.isUserInteractionEnabled = true
            btn.backgroundColor = UIColor.white
        }
    }
    
    func choiceAnswer (answer : String , button : UIButton, anotherButton : [UIButton] ) {
            if (answer == self.pokemons[self.truePokemonID!].name!) {
            button.backgroundColor = UIColor.green
            for btn in anotherButton {
                btn.isUserInteractionEnabled = false
            }
            self.score += 1
            self.scoreLb.text = "\(self.score)"
            self.playSound(nameSound: True)
            
        } else {
            button.backgroundColor = UIColor.red
            for btn in anotherButton {
                if btn.title(for: .normal) == self.pokemons[self.truePokemonID!].name! {
                    btn.backgroundColor = UIColor.green
                }
                btn.isUserInteractionEnabled = false
            }
            self.playSound(nameSound: False)
        }
        
    }
    @IBAction func invokeBackBtn(_ sender: AnyObject) {
        playerSound.pause()
        player.pause()
        UserDefaults.standard.set(self.score, forKey: "Score")
        self.navigationController?.popViewController(animated: true)
    }
    
    func playMusic(nameSound: String) {
        let path = Bundle.main.path(forResource: nameSound, ofType: nil)
        let url = URL(fileURLWithPath: path!)
        player = AVPlayer(url: url)
        if self.music == true {
            player.play()
        } else {
            player.pause()
        }
    }
    
    func playSound(nameSound: String) {
        let path = Bundle.main.path(forResource: nameSound, ofType: nil)
        let url = URL(fileURLWithPath: path!)
        playerSound = AVPlayer(url: url)
        if self.sound == true {
            playerSound.play()
        }else{
            return
        }
        
    }


}
