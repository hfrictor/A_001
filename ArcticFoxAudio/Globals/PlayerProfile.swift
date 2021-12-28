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


class PlayerProfile: ObservableObject {
    
    @Published var exitView: Bool = false
    
    @Published var durationLabel: String = ""
    @Published var currentTimestampLabel: String = ""
    
    
    @Published var scrubberSlider: Double = 0.0
    @Published var duration: Double = 0.0
   
    @Published var isDownloading: Bool = false
    @Published var isStreaming: Bool = false
    @Published var beingSeeked: Bool = false
    @Published var loopEnabled = false
    @Published var playPauseButton: Bool = false
    
    
    @Published var downloadId: UInt?
    @Published var durationId: UInt?
    @Published var bufferId: UInt?
    @Published var playingStatusId: UInt?
    @Published var queueId: UInt?
    @Published var elapsedId: UInt?


    @Published var playbackStatus: SAPlayingStatus = .ended
    
    @Published var lastPlayedAudioIndex: Int?
    
    @Published var isPlayable: Bool = false {
            didSet {
                if isPlayable {
                    
                } else {
                   
                }
            }
        }
    
    func playClicked(audioFileURL: String) {
        if audioFileURL != "" {
            print(audioFileURL)
            if self.playbackStatus == .playing {
                SAPlayer.shared.pause()
            } else if self.playbackStatus == .paused {
                SAPlayer.shared.play()
            } else {
            let url = URL(string: audioFileURL)!
            SAPlayer.shared.startRemoteAudio(withRemoteUrl: url)
            SAPlayer.shared.play()
            }
        } else {
            
        }
       
    }
    
    func skipForward() {
        SAPlayer.shared.skipForward()
    }
    
    func skipBackward() {
        SAPlayer.shared.skipBackwards()
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
