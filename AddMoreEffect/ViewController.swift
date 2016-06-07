//
//  ViewController.swift
//  AddMoreEffect
//
//  Created by Bruce on 16/6/7.
//  Copyright © 2016年 Bruce. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    lazy var engine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let intput = engine.inputNode!
        let output = engine.outputNode
        
        let distortion = AVAudioUnitDistortion()
        distortion.loadFactoryPreset(.SpeechGoldenPi)
        distortion.preGain = 1
        distortion.wetDryMix = 40
        
//        将distortion附着到 音频引擎
        engine.attachNode(distortion)
        
        let reverb = AVAudioUnitReverb()
//        设置混响效果器 为教堂的效果
        reverb.loadFactoryPreset(.LargeRoom)
//        设置混响的干湿比 是从0-100的值 干湿比影响到咱们混响与原声的一个混合比例
        reverb.wetDryMix = 40
        
//        把混响附着到音频引擎
        engine.attachNode(reverb)
        
        
//        开始连接各个节点
        engine.connect(intput, to: distortion, format: intput.inputFormatForBus(0))
        engine.connect(distortion, to: reverb, format: intput.inputFormatForBus(0))
        engine.connect(reverb, to: output, format: intput.inputFormatForBus(0))
        
//        开启引擎
        try! engine.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

