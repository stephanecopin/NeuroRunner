//
//  Microphone.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import AVFoundation

class Microphone: NSObject, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioSession: AVAudioSession!
    

    
    var isMicrophoneEnabled = false
    var minBreathingLevel: Float = -35

    var peakLevel = [Float]()
    
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
        
        // This URL path ensures that data is not stored to phone
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
    
    func calibrateAmbientNoise() {
// TODO:       minBreathingLevel = new calibrated setting in relation to ambient noise
    }
}

extension Microphone {
    
    func recordAudio(isRecording: Bool) {
        if isRecording && isMicrophoneEnabled {
            // Send data to inputTimer
            audioRecorder.record()
            print("recording")
        } else if isMicrophoneEnabled {
            audioRecorder.stop()
            // Invalidate inputTimer
        }
    }
    
    func levelTimerCallback() {
        audioRecorder.updateMeters()
        
        if audioRecorder.averagePower(forChannel: 0) > minBreathingLevel {
            // Indicate that an action / input is taking place
            
        } else {
            // Set back to inactive
        }
    }
    
}
