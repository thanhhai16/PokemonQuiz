//
//  THSettingViewController.swift
//  THPokemonQuiz
//
//  Created by Hai on 11/20/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit
import AVFoundation

class THSettingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let shared = THSettingViewController()
    
    @IBOutlet weak var colectionViewGen: UICollectionView!
    
    @IBOutlet weak var switchSound: UISwitch!
    
    @IBOutlet weak var switchMusic: UISwitch!
    
    var gens : [Bool]?
    
    var last = true
    
    var sound : Bool?
    var music : Bool?
    var lastCheck : Int?
    var genFalse : [Bool]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.colectionViewGen.delegate = self
        self.colectionViewGen.dataSource = self
        if (UserDefaults.standard.value(forKey: "Gens") == nil) {
            self.gens = [true, true, true, true, true, true]
        }else{
            self.gens = UserDefaults.standard.value(forKey: "Gens") as? [Bool]
        }
        self.soundMusic()
        
        self.setupUI()

        print(self.sound)
        
    }
    @IBAction func invokeSwitchSound(_ sender: AnyObject) {
        if self.switchSound.isOn == true {
            THPlayer.shared.playSound(nameSound: Enable)
            self.sound = true
            UserDefaults.standard.set(self.sound, forKey: "Sound")
        } else {
            self.sound = false
            UserDefaults.standard.set(self.sound, forKey: "Sound")
        }
        return
    }
    
    @IBAction func invokeSwitchMusic(_ sender: AnyObject) {
        if self.switchMusic.isOn == true {
            if self.sound == true {
                THPlayer.shared.playSound(nameSound: Enable)
            } else{
            }
            self.music = true
            UserDefaults.standard.set(self.music, forKey: "Music")
        }else {
            if self.sound == true {
                THPlayer.shared.playSound(nameSound: Disable)
            } else {
            }
            self.music = false
            UserDefaults.standard.set(self.music, forKey: "Music")
        }
        THPlayer.shared.playMusic(nameSound: Main, music: self.music!)
        print("music", music)
    }
    func lastCheckGen() {
        self.genFalse = self.gens?.filter { $0 == false }
        lastCheck = self.genFalse?.count
        print("last " , self.lastCheck)
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
        colectionViewGen.reloadData()
        self.soundMusic()
        self.lastCheckGen()
    }
    
    func setupUI() {
        self.switchMusic.transform = .init(scaleX: 0.8, y: 0.8)
        self.switchSound.transform = .init(scaleX: 0.8, y: 0.8)
        if self.sound == true {
            self.switchSound.isOn = true
        } else {
            self.switchSound.isOn = false
        }
        if self.music == true {
            self.switchMusic.isOn = true

        } else {
            self.switchMusic.isOn = false

        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokemonGen", for: indexPath)
        let imageGen = cell.contentView.viewWithTag(2) as! UIImageView
        
        let nameImage = "Background_Gen" + String(indexPath.row + 1)
        imageGen.image = UIImage(named: nameImage)
        let label = cell.contentView.viewWithTag(1) as! UILabel
        
        label.text = "GENERATION " + String(indexPath.row + 1)
        print("gen \(indexPath.row):",gens?[indexPath.row])
        if self.gens?[indexPath.row] == false {
            cell.contentView.alpha = 0.5
        } else {
            cell.contentView.alpha = 1
        }
        
        
        return cell
    }
    @IBAction func invokeBtn(_ sender: AnyObject) {
        let viewControler = self.navigationController?.viewControllers[0] as! ViewController
        self.navigationController?.popToViewController(viewControler, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.colectionViewGen.frame.width * 165/343  , height: self.colectionViewGen.frame.height * 60/279)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.gens?[indexPath.row] == true) {
            if self.lastCheck! < 5 {
            if self.sound == true {
                THPlayer.shared.playSound(nameSound: Disable)
            }
            self.gens?[indexPath.row] = false
            self.saveGen()
            self.viewWillAppear(true)
            } else {
                return
            }
        } else {
            if self.sound == true {
                THPlayer.shared.playSound(nameSound: Enable)
            }
            self.gens?[indexPath.row] = true
            self.saveGen()
            self.viewWillAppear(true)
        }
    }
    func saveGen () {
        UserDefaults.standard.set(self.gens , forKey: "Gens")
        print(UserDefaults.standard.value(forKey: "Gens"))
    }
    
}


