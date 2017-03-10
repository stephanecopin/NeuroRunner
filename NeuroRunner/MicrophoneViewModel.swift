//
//  AirGameViewModel.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import AVFoundation

protocol MicrophoneDelegate {
    
    func recordAudio(isRecording: Bool)
    
}

protocol BreathingViewUpdate {
    
    func breathingDetected(isDetected: Bool)
    
}

class MicrophoneViewModel: NSObject, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioSession: AVAudioSession!
    
    var levelTimer: Timer!
    
    var peakLevel = [Float]()
    var minBreathingLevel: Float = -35
    
    var takingBreathDelegate: TakingBreathDelegate?
    var breathingViewUpdateDelegate: BreathingViewUpdate?
    
    var isMicrophoneEnabled = true
    
    override init() {
        super.init()
        configure()
        setUpRecorder()
    }
    
    func configure() {
        
        audioSession = AVAudioSession.sharedInstance()
        
        // Request microphone permission
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setActive(true)
            audioSession.requestRecordPermission() { [] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("microphone permissions granted")
                    } else {
                        print("microphone permissions denied")
                    }
                }
            }
        } catch {
            print("failed to set up recordingSession")
        }
        
    }
    
    func setUpRecorder() {
        
        let urlPathNull = URL.init(fileURLWithPath: "/dev/null")
        
        let settings = [AVFormatIDKey : Int(kAudioFormatAppleLossless),
                        AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                        AVNumberOfChannelsKey: 1,
                        AVSampleRateKey: 44100.0 ] as [String : Any]
        
        do {
            audioRecorder =  try AVAudioRecorder(url: urlPathNull, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            audioRecorder.isMeteringEnabled = true
            print("ready to record!")
        } catch {
            if let err = error as Error? {
                print("AVAudioRecorder error: \(err.localizedDescription)")
                audioRecorder = nil
            }
        }
        
    }
}

extension MicrophoneViewModel: MicrophoneDelegate {
    
    func recordAudio(isRecording: Bool) {
        if isRecording && isMicrophoneEnabled {
            //Timer to detect audio levels
            levelTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(levelTimerCallback), userInfo: nil, repeats: true)
            audioRecorder.record()
            print("recording")
        } else if isMicrophoneEnabled {
            audioRecorder.stop()
            levelTimer.invalidate()
        }
    }
    
    func levelTimerCallback() {
        audioRecorder.updateMeters()
        
        if audioRecorder.averagePower(forChannel: 0) > minBreathingLevel {
            takingBreathDelegate?.addToTimeBreathingMicrophone()
            breathingViewUpdateDelegate?.breathingDetected(isDetected: true)
        } else {
            breathingViewUpdateDelegate?.breathingDetected(isDetected: false)
        }

    }
    
    
}
