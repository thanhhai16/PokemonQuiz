//
//  THPlayer.swift
//  THPokemonQuiz
//
//  Created by Hai on 11/22/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import Foundation
import AVFoundation

class THPlayer : AVPlayer {
    
    static let shared = THPlayer()
    
    var playerMusic : AVPlayer?
    var playerSound : AVPlayer?
    
    func playSound(nameSound: String) {
        let path = Bundle.main.path(forResource: nameSound, ofType: nil)
        let url = URL(fileURLWithPath: path!)
        self.playerSound = AVPlayer(url: url)
        self.playerSound?.play()

    }
    
    func playMusic(nameSound: String, music : Bool) {
    let path = Bundle.main.path(forResource: nameSound, ofType: nil)
    let url = URL(fileURLWithPath: path!)
    playerMusic = AVPlayer(url: url)
    if music == true {
    self.playerMusic?.play()
    } else {
    self.playerMusic?.pause()
    }
    }

}
