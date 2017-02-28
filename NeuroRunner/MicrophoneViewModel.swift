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
    
    var peakLevel = [Float]()
}

extension MicrophoneViewModel: MicrophoneDelegate {
    
    func recordAudio(isRecording: Bool) {
        if isRecording {
            levelTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(levelTimerCallback), userInfo: nil, repeats: true)
            audioRecorder.record()
            print("recording file at \(audioRecorder.url)")
        } else {
            audioRecorder.stop()
            levelTimer.invalidate()
            print("MAX PEAK LEVEL = \(peakLevel.sorted().last)")
        }
    }
    
    func levelTimerCallback() {
    
        audioRecorder.updateMeters()
        peakLevel.append(audioRecorder.averagePower(forChannel: 0))
        
    }
    
}
