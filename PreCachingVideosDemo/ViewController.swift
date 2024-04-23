//
//  ViewController.swift
//  PreCachingVideosDemo
//
//  Created by Big Sur on 16/11/21.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/c574ab1a5a2ea7a997e1c8da9ba832d2/manifest/video.m3u8")
        ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/16acea267404484eae3ea55301072378/manifest/video.m3u8")
        ASVideoPlayerController.sharedVideoPlayer.setupVideoFor(url: "https://customer-99s5h3qz2w1h6bv9.cloudflarestream.com/5d95c89fa2de4102b852cf78afdbc261/manifest/video.m3u8")
    }

    @IBAction func goToPlayerClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

