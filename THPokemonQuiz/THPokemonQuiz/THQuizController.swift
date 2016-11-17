//
//  THQuizController.swift
//  THPokemonQuiz
//
//  Created by Hai on 11/18/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit

class THQuizController: UIViewController {

    @IBOutlet weak var scoreLb: UILabel!
    @IBOutlet weak var btnD: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
       

    }

    func setupUI ()  {
        
        self.scoreLb.text = "\(self.score)"
        
        self.btnA.layer.cornerRadius = 20
        self.btnB.layer.cornerRadius = 20
        self.btnC.layer.cornerRadius = 20
        self.btnD.layer.cornerRadius = 20
        
        self.btnA.setTitle("Pikachu", for: .normal)
        self.btnB.setTitle("Con khac", for: .normal)
        self.btnC.setTitle("Pokemon", for: .normal)
        self.btnD.setTitle("Con Nguoi", for: .normal)
        
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysTemplate)
        self.pokemonImage.tintColor = UIColor.black
        
        self.cardView.layer.cornerRadius = 10
        
    }
    @IBAction func invokeBtnA(_ sender: AnyObject) {
        self.choiceAnswer(answer: self.btnA.title(for: .normal)!, button: self.btnA, anotherButton: [self.btnB, self.btnC, self.btnD])
    }
    @IBAction func invokeBtnB(_ sender: AnyObject) {
         self.choiceAnswer(answer: self.btnB.title(for: .normal)!, button: self.btnB, anotherButton: [self.btnA, self.btnC, self.btnD])
        
    }
    @IBAction func invokeBtnC(_ sender: AnyObject) {
         self.choiceAnswer(answer: self.btnC.title(for: .normal)!, button: self.btnC, anotherButton: [self.btnB, self.btnA, self.btnD])
    }
    @IBAction func invokeBtnD(_ sender: AnyObject) {
         self.choiceAnswer(answer: self.btnD.title(for: .normal)!, button: self.btnD, anotherButton: [self.btnB, self.btnC, self.btnA])
    }
    func choiceAnswer (answer : String , button : UIButton, anotherButton : [UIButton] ) {
        if (answer == "Pikachu") {
            button.backgroundColor = UIColor.green
            for btn in anotherButton {
                btn.isUserInteractionEnabled = false
            }
            self.score += 1
            self.scoreLb.text = "\(self.score)"
        } else {
            button.backgroundColor = UIColor.red
            for btn in anotherButton {
                if btn.title(for: .normal) == "Pikachu" {
                    btn.backgroundColor = UIColor.green
                }
                btn.isUserInteractionEnabled = false
            }
        }
        self.pokemonImage.image = self.pokemonImage.image?.withRenderingMode(.alwaysOriginal)
    }
    @IBAction func invokeBackBtn(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
   }
