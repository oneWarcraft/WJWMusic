//
//  PlayingViewController.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/4.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit
import AVFoundation

class PlayingViewController: UIViewController {
    
    // MARK:- 定义属性
    var progressTimer : NSTimer?
    weak var player : AVAudioPlayer?
    
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var progressView: UISlider!
    @IBOutlet weak var IconViewImage: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var SongName_Lable: UILabel!
    @IBOutlet weak var singerName_Lable: UILabel!
    @IBOutlet weak var curTime_Lable: UILabel!
    @IBOutlet weak var totalTime_Lable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.setThumbImage(UIImage(named: "player_slider_playback_thumb"), forState: .Normal)
    
        
        // 展示数据和播放歌曲
        startPlayingMusic()
    }
    
    // 修改状态栏颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
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
        bgImageView.image = UIImage(named: currentMusic.icon)
        SongName_Lable.text = currentMusic.name
        singerName_Lable.text = currentMusic.singer
        
        // 3.播放当前歌曲
        guard let player = MusicPlayerTool.playMusicWithName(currentMusic.filename) else {
            return
        }
        
        self.player = player
        
        // 4.显示总时长
        totalTime_Lable.text = timStrWithTime(player.duration)
        
        // 5.添加监听进度的定时器
        addProgressTimer()
    }
    
    private func timStrWithTime(time : NSTimeInterval) -> String {
        let min = Int(time + 0.5) / 60
        let second = Int(time + 0.5) % 60
        return String(format: "%02d:%02d", arguments: [min, second])
    }
}

// MARK:- 对定时器的操作
extension PlayingViewController {
    private func addProgressTimer() {
        progressTimer = NSTimer(timeInterval: 1.0, target: self, selector: "updateProgressInfo", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(progressTimer!, forMode: NSRunLoopCommonModes)
    }
    
    private func removeProgressTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    @objc private func updateProgressInfo() {
        guard let player = player else {
            return
        }
        curTime_Lable.text = timStrWithTime(player.currentTime)
        
        progressView.value = Float(player.currentTime / player.duration)
    }
}

