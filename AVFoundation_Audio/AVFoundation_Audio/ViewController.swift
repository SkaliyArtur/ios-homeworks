//
//  ViewController.swift
//  AVFoundation_Audio
//
//  Created by Niki Pavlove on 18.02.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var Player = AVAudioPlayer()
    let fm = FileManager.default
    var path = Bundle.main.resourcePath
    var songs = [String]()
    let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil)
    var counter = 0
    
    @IBOutlet weak var trackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reaadyToPlay()
    }

    @IBAction func PlayButton(_ sender: Any) {
            if Player.isPlaying {
                Player.stop()
            } else {
                play()
            }
        }
    
    @IBAction func StopButton(_ sender: Any) {
        if Player.isPlaying {
            Player.stop()
            Player.currentTime = 0
        }
        else {
            print("Already stopped!")
        }
    }
    @IBAction func backward(_ sender: Any) {
        guard let urls = urls else {return}
        if counter == 0 {
            counter = urls.count - 1
            reaadyToPlay()
            play()
        } else {
            counter -= 1
            reaadyToPlay()
            play()
        }
    }
    
    
    @IBAction func forward(_ sender: Any) {
        guard let urls = urls else {return}
        if counter == urls.count - 1 {
            counter = 0
            reaadyToPlay()
            play()
        } else {
            counter += 1
            reaadyToPlay()
            play()
        }
    }
    
    //Добавляем в массив все файоы формата мп3
//    private func makeSongsArray() {
//        guard let path = path else {return}
//            do {
//                let items = try fm.contentsOfDirectory(atPath: path)
//                for item in items {
//                    if item.hasSuffix("mp3") {
//                        songs.append(item)
//                        print(item)
//                    }
//                }
//            } catch {
//                print("error")
//            }
//    }
    private func play() {
            Player.play()
            trackLabel.text = Player.url?.lastPathComponent
    }
    private func reaadyToPlay() {
        do {
            guard let urls = urls else {return}
            Player = try AVAudioPlayer(contentsOf: urls[counter])
            Player.prepareToPlay()
           }
           catch {
               print(error)
           }
    }
}
