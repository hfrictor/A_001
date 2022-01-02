//
//  PlayerProfile.swift
//  ArcticFoxAudio
//
//  Created by hayden frea on 12/27/21.
//


import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import SwiftAudioPlayer
import AVFoundation
import AVFAudio
import MediaPlayer


class PlayerProfile: ObservableObject {
    
    @Published var chapters_audio = []
    @Published var chapters_text = []
    @Published var current_chapter = 0
    @Published var current_time = "00:00"
    @Published var current_book = ""
    
    @Published var exitView: Bool = false
    
    @Published var durationLabel: String = ""
    @Published var currentTimestampLabel: String = ""
    
    @Published var volumeSlider: CGFloat = 0.5
    @Published var speedSlider: CGFloat = 0.5
    
    @Published var scrubberSlider: Double = 0.0
    @Published var duration: Double = 0.0
   
    @Published var isDownloading: Bool = false
    @Published var isStreaming: Bool = false
    @Published var beingSeeked: Bool = false
    @Published var loopEnabled = false
    @Published var playPauseButton: Bool = false
    @Published var streamButton: Bool = false
    
    
    @Published var downloadId: UInt?
    @Published var durationId: UInt?
    @Published var bufferId: UInt?
    @Published var playingStatusId: UInt?
    @Published var queueId: UInt?
    @Published var elapsedId: UInt?
    @Published var bufferProgress: Float?


    @Published var playbackStatus: SAPlayingStatus = .ended
    
    @Published var lastPlayedAudioIndex: Int?
    
    @Published var isPlayable: Bool = false {
            didSet {
                if isPlayable {
                    
                } else {
                   
                }
            }
        }
    
    func playClicked() {
        if self.chapters_audio.count != 0 {
            if self.chapters_audio[self.current_chapter] as! String != "" {
                
                print(self.chapters_audio[self.current_chapter])
                if self.playbackStatus == .playing {
                    SAPlayer.shared.pause()
                } else if self.playbackStatus == .paused {
                    SAPlayer.shared.play()
                } else {
                    let url = URL(string: self.chapters_audio[self.current_chapter] as! String)!
                    SAPlayer.shared.startRemoteAudio(withRemoteUrl: url)
                    SAPlayer.shared.play()
                }
                
            } else {
                print("Error playing the file, check the playClicked() function")
            }
    } else {
        print("Nothing to play in chapters_audio")
    }
    }
    
    func skipForward() {
        SAPlayer.shared.skipForward()
    }
    
    func skipBackward() {
        SAPlayer.shared.skipBackwards()
    }
    
    func setSpeed() {
        let speed = (self.speedSlider + 0.6)
        print(speed)
        if let node = SAPlayer.shared.audioModifiers[0] as? AVAudioUnitTimePitch {
            node.rate = Float(speed)
            SAPlayer.shared.playbackRateOfAudioChanged(rate: Float(speed))
        } else {
            print("Cannot change the speed of the audio. ( setSpeed() func )")
        }
    }
   
    func setVolume() {
        print(self.volumeSlider)
        MPVolumeView.setVolume(Float(self.volumeSlider))
    }
    
    func subscribeToChanges() {
        durationId = SAPlayer.Updates.Duration.subscribe { [weak self] (duration) in
            guard let self = self else { return }
            self.durationLabel = SAPlayer.prettifyTimestamp(duration)
            self.duration = duration
        }
        
        elapsedId = SAPlayer.Updates.ElapsedTime.subscribe { [weak self] (position) in
            guard let self = self else { return }
            
            self.currentTimestampLabel = SAPlayer.prettifyTimestamp(position)
            
            guard self.duration != 0 else { return }
            
            self.scrubberSlider = Double(Float(position/self.duration))
        }
        
        bufferId = SAPlayer.Updates.StreamingBuffer.subscribe{ [weak self] (buffer) in
                    guard let self = self else { return }
                    
                    self.bufferProgress = Float(buffer.bufferingProgress)
                    
                    if buffer.bufferingProgress >= 0.79 {
                        self.streamButton = false
                    } else {
                        self.streamButton = true
                    }
                    
                    self.isPlayable = buffer.isReadyForPlaying
                }
        
        playingStatusId = SAPlayer.Updates.PlayingStatus.subscribe { [weak self] (playing) in
            guard let self = self else { return }
            
            self.playbackStatus = playing
            
            switch playing {
            case .playing:
                self.isPlayable = true
                self.playPauseButton = true
                return
            case .paused:
                self.isPlayable = true
                self.playPauseButton = false
                return
            case .buffering:
                self.isPlayable = false
                return
            case .ended:
                if !self.loopEnabled {
                    self.isPlayable = false
                }
                return
            }
        }
        
        
        
        
        
       
    }
    
    func unsubscribeFromChanges() {
        
        guard let durationId = self.durationId,
              let elapsedId = self.elapsedId,
              let downloadId = self.downloadId,
              let queueId = self.queueId,
              let bufferId = self.bufferId,
              let playingStatusId = self.playingStatusId else { return }
        
        SAPlayer.Updates.Duration.unsubscribe(durationId)
        SAPlayer.Updates.ElapsedTime.unsubscribe(elapsedId)
        SAPlayer.Updates.AudioDownloading.unsubscribe(downloadId)
        SAPlayer.Updates.AudioQueue.unsubscribe(queueId)
        SAPlayer.Updates.StreamingBuffer.unsubscribe(bufferId)
        SAPlayer.Updates.PlayingStatus.unsubscribe(playingStatusId)
    }
    
        
}

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
}
