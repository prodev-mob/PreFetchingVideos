//
//  PlayerViewController.swift
//  PreCachingVideosDemo
//
//  Created by Big Sur on 16/11/21.
//

import UIKit
import AVFoundation

class PlayerTblViewCell: UITableViewCell, ASAutoPlayVideoLayerContainer {
    @IBOutlet weak var videoView: AGVideoPlayerView!
    
    var videoLayer: AVPlayerLayer = AVPlayerLayer()
        
    var videoURL: String? {
        didSet {
            if let videoURL = videoURL {
                /*ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)*/
                videoView.videoUrl = URL(string: videoURL)
            }
//            videoLayer.isHidden = videoURL == nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /*
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoLayer.frame = videoBG.frame
        videoLayer.frame.size.height = SCREENHEIGHT()
        videoLayer.frame.size.width = SCREENWIDTH()
        videoLayer.videoGravity = .resizeAspectFill
        videoBG.layer.addSublayer(videoLayer)
        videoLayer.player?.isMuted = false
        */
        
        
        videoView.previewImageUrl = URL(string: "")
        videoView.shouldAutoplay = true
        videoView.shouldAutoRepeat = true
        videoView.showsCustomControls = true
        videoView.isMuted = true
        videoView.minimumVisibilityValueForStartAutoPlay = 0.9 //Value from 0.0 to 1.0, which sets the minimum percentage of the video player's view visibility on the screen to start playback.
        videoView.shouldSwitchToFullscreen = true
    }
    
    func visibleVideoHeight() -> CGFloat {
        return SCREENHEIGHT()
    }
}

class PlayerViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var playerBG: UIView!
    
    var player: AVPlayer!
    var playerLayer : AVPlayerLayer!
    weak open var prefetchDataSource: UITableViewDataSourcePrefetching?
    
    var playerItems: [String] = [
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/c574ab1a5a2ea7a997e1c8da9ba832d2/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/16acea267404484eae3ea55301072378/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/5d95c89fa2de4102b852cf78afdbc261/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/b05cb80158ad4e94822e6e5a08bc3afa/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/c84a7070a58a70a28077c58ab48317b0/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/65d5fbc885f64f0f8ec76d8f74fb7cda/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/9c3491256394c423fc8bd22eae2acf1f/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/e77615bcc8d148e88da646bf53f70ccb/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/e1b7b4c00bfa4d6ab5abdf292ee0da97/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/b05cb80158ad4e94822e6e5a08bc3afa/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/fb3696301aba4249b9f878a8f9d46cce/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/67c215842f3243f6960a254b8edab5a7/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/c574ab1a5a2ea7a997e1c8da9ba832d2/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/16acea267404484eae3ea55301072378/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/5d95c89fa2de4102b852cf78afdbc261/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/b05cb80158ad4e94822e6e5a08bc3afa/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/c84a7070a58a70a28077c58ab48317b0/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/65d5fbc885f64f0f8ec76d8f74fb7cda/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/9c3491256394c423fc8bd22eae2acf1f/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/e77615bcc8d148e88da646bf53f70ccb/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/e1b7b4c00bfa4d6ab5abdf292ee0da97/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/b05cb80158ad4e94822e6e5a08bc3afa/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/fb3696301aba4249b9f878a8f9d46cce/manifest/video.m3u8",
        "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/67c215842f3243f6960a254b8edab5a7/manifest/video.m3u8"
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.appEnteredFromBackground),
                                               name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pausePlayeVideos()
    }
    
    @objc func appEnteredFromBackground() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tblView, appEnteredFromBackground: true)
    }

    func pausePlayeVideos() {
        ASVideoPlayerController.sharedVideoPlayer.pausePlayeVideosFor(tableView: tblView)
    }

}

extension PlayerViewController: UITableViewDelegate, UITableViewDataSource/*, UITableViewDataSourcePrefetching*/ {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playerItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tblView.frame.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTblViewCell", for: indexPath) as! PlayerTblViewCell
        cell.videoURL = self.playerItems[indexPath.row]
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            print("prefetched row is:- \(indexPath.row)")
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerTblViewCell", for: indexPath) as! PlayerTblViewCell
            let videoURL = self.playerItems[indexPath.row]
            cell.videoURL = videoURL
//            ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: videoURL)
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let videoCell = cell as? ASAutoPlayVideoLayerContainer, videoCell.videoURL != nil {
            ASVideoPlayerController.sharedVideoPlayer.removeLayerFor(cell: videoCell)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            pausePlayeVideos()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pausePlayeVideos()
    }
    */
    
}
