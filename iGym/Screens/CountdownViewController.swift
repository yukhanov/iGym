//
//  CountdownViewController.swift
//  iGym
//
//  Created by Юханов Сергей Сергеевич on 29/05/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit
import AVFoundation

class CountdownViewController: UIViewController {
    
    var seconds = 30
    var timer = Timer()
    var audioPlayer = AVAudioPlayer()

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let audioPath = Bundle.main.path(forResource: "timer", ofType: ".mp3")
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        } catch {
            //ERROR
        }

        
    }


    @IBAction func slider(_ sender: UISlider) {
        seconds = Int(sender.value)
        label.text = String(seconds) + " секунд"
    }
    
    @IBAction func startTapped(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
        sliderOutlet.isHidden = true
        startButton.isHidden = true
    }
    @IBAction func stopTapped(_ sender: Any) {
        timer.invalidate()
        seconds = 30
        sliderOutlet.setValue(30, animated: true)
        label.text = "30 секунд"
        
        audioPlayer.stop()
        sliderOutlet.isHidden = false
        startButton.isHidden = false
    }
    
    @objc func counter() {
        seconds -= 1
        label.text = String(seconds) + " секунд"
        if (seconds == 0) {
            timer.invalidate()
            sliderOutlet.isHidden = false
            startButton.isHidden = false
            audioPlayer.play()
        }
    }
    
}
