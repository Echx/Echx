//
//  TargetMusicMaskView.swift
//  Planck
//
//  Created by Lei Mingyu on 16/04/15.
//  Copyright (c) 2015 Echx. All rights reserved.
//

import UIKit

protocol TargetMusicMaskViewDelegate {
    func didFinishPlaying()
}

class TargetMusicMaskView: UIView {
    private let headphoneImage = UIImage(named: "headphone")
    private var audioPlayerList = [AVAudioPlayer]()
    var delegate: TargetMusicMaskViewDelegate?
    
    override init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        blurView.frame = self.bounds
        self.addSubview(blurView)
        
        let headphoneView = UIImageView(image: self.headphoneImage)
        headphoneView.frame = CGRect(x: 452, y: 324, width: 120, height: 120)
        self.addSubview(headphoneView)
    }
    
    
    func show(targetMusic: XMusic) {
//        self.audioPlayer = AVAudioPlayer(contentsOfURL: SoundFiles.levelUpSound, error: nil)
//        self.audioPlayer!.prepareToPlay()
//        self.audioPlayer!.play()
        let noteSequence = targetMusic.flattenMapping()
        for (note, distance) in noteSequence {
            let audioPlayer = AVAudioPlayer(contentsOfURL: note.getAudioFile(), error: nil)
            self.audioPlayerList.append(audioPlayer)
            audioPlayer.prepareToPlay()
            audioPlayer.playAtTime(audioPlayer.deviceCurrentTime + NSTimeInterval(distance / Constant.lightSpeedBase))
        }
        
    }
    
    func hide() {
        self.removeFromSuperview()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
