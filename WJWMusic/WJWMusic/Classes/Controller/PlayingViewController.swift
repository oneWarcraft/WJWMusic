//
//  PlayingViewController.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/4.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class PlayingViewController: UIViewController {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var progressView: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.setThumbImage(UIImage(named: "player_slider_playback_thumb"), forState: .Normal)
        
        // 展示数据和播放歌曲
        startPlayingMusic()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupIconViewCorner()
    }

}

// MARK:- 设置UI界面内容
extension PlayingViewController {
    private func setupIconViewCorner() {
        iconView.layer.cornerRadius = iconView.bounds.width * 0.5
        iconView.layer.masksToBounds = true
        iconView.layer.borderWidth = 10
        iconView.layer.borderColor = UIColor.darkGrayColor().CGColor
    }
}

// 开始播放歌曲，并展示数据
extension PlayingViewController {
    private func startPlayingMusic () {
        guard let currentMusic = MusicTool.currentMusic else {
            return
        }
        
        iconView.image = UIImage(named: currentMusic.icon)
    }
}
