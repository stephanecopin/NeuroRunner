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

class MicrophoneViewModel: NSObject, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioSession: AVAudioSession!
    
    var levelTimer: Timer!

    var peakLevel = [Float]()

    var takingBreathDelegate: TakingBreathDelegate?
    
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
        
        let audioFile = "recordingSession.audioFile.m4a"
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let audioFilename = documentsDirectory.appendingPathComponent(audioFile)
        
        let settings = [AVFormatIDKey : Int(kAudioFormatAppleLossless),
                        AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                        AVNumberOfChannelsKey: 1,
                        AVSampleRateKey: 44100.0 ] as [String : Any]
        
        do {
            audioRecorder =  try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            audioRecorder.isMeteringEnabled = true
            print("ready to record at \(audioFilename)")
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
        if isRecording {
            //Timer to detect audio levels
            levelTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(levelTimerCallback), userInfo: nil, repeats: true)
            audioRecorder.record()
            print("recording to file")
        } else {
            audioRecorder.stop()
            levelTimer.invalidate()
            print("MAX PEAK LEVEL = \(peakLevel.sorted().last!)")
        }
    }
    
    // Reads audio levels from microphone
    func levelTimerCallback() {
    
        audioRecorder.updateMeters()
        
        print("average power = \(audioRecorder.averagePower(forChannel: 0))")
        if audioRecorder.averagePower(forChannel: 0) > -35 {
            takingBreathDelegate?.addToTimeBreathingMicrophone()
        }
        
        // Sorted to detect max level
        peakLevel.append(audioRecorder.averagePower(forChannel: 0))

        
    }
    
    
    
}
