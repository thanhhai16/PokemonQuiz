//
//  ViewController.swift
//  THPokemonQuiz
//
//  Created by Hai on 11/17/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func invokePlayBtn(_ sender: AnyObject) {
        let quizController = self.storyboard?.instantiateViewController(withIdentifier: "THQuizController") as! THQuizController
        
        self.navigationController?.pushViewController(quizController, animated: true)
    }

}

