//
//  VideoObject.swift
//  AutoPlayVideo
//
//  Created by Ashish Singh on 12/4/17.
//  Copyright © 2017 Ashish. All rights reserved.
//

import UIKit
import AVFoundation
class ASVideoContainer {
    var url: String
    var playOn: Bool {
        didSet {
            player.isMuted = ASVideoPlayerController.sharedVideoPlayer.mute
            playerItem.preferredPeakBitRate = ASVideoPlayerController.sharedVideoPlayer.preferredPeakBitRate
            if playOn && playerItem.status == .readyToPlay {
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, policy: .default, options: .defaultToSpeaker)
                player.play()
                
                if let duration = player.currentItem?.asset.duration {
                    let seconds = CMTimeGetSeconds(duration)
                    print("Seconds :: \(seconds)")
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                        // check if player is still playing
                        if self.player.rate != 0 {
                            //print("OK")
                            //print("Player reached 1 seconds")
                            /*
                            if APP_DELEGATE.isWatchFromSingleView {
                                postNotification(with: NC_CallForWatchCount)
                            }
                            else {
                                //ASVideoPlayerController.sharedVideoPlayer.delegate?.didfinishWatchCount()
                                DispatchQueue.main.async {
                                    postNotification(with: NC_CallForWatchTrendingCount)
                                }
                            }
                            */
                        }
                    }
                }
            }
            else{
                player.pause()
            }
        }
    }
    
    let player: AVPlayer
    let playerItem: AVPlayerItem
    
    init(player: AVPlayer, item: AVPlayerItem, url: String) {
        self.player = player
        self.playerItem = item
        self.url = url
        playOn = false
    }
}
