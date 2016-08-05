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
    
    @IBOutlet weak var playOrPauseBTN: UIButton!
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // 添加iconView的旋转动画
        addIconViewAnimation()
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
    
    private func addIconViewAnimation() {
        // 1.创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        // 2.给动画设置属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = M_PI * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 30
        
        // 3.将动画添加到layer中
        iconView.layer.addAnimation(rotationAnim, forKey: nil)
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
        progressTimer = NSTimer(timeInterval: 1.0, target: self, selector: #selector(PlayingViewController.updateProgressInfo), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(progressTimer!, forMode: NSRunLoopCommonModes)
        
        updateProgressInfo()
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

// MARK:- 事件监听函数
extension PlayingViewController {
    
    @IBAction func sliderDownClick(sender: UISlider) {
        removeProgressTimer()
    }
    
    
    @IBAction func SliderTouchUpInsideClick(sender: UISlider) {
        // 1.获取当前拖拽的进度
        let showTime = Double(sender.value) * (player?.duration ?? 0)
        player?.currentTime = showTime
        
        // 2.添加定时器
        addProgressTimer()
        
    }
    
    @IBAction func SliderValueChangedClick(sender: UISlider) {
        // 1.获取当前拖拽的进度
        let value = Double(sender.value)
        
        // 2.根据进度计算时间
        let showTime = value * (player?.duration ?? 0)
        
        // 3.显示当前的进度的时间
        curTime_Lable.text = timStrWithTime(showTime)
    }
    
    
    @IBAction func SliderTapClick(sender: UITapGestureRecognizer) {
        
        // 1.获取点击的x的位置
        let x = sender.locationInView(progressView).x
        
        // 2.计算比例
        let ratio = Double( x / progressView.bounds.width)
        
        // 3.计算当前需要播放的时间
        player?.currentTime = (player?.duration ?? 0) * ratio
        
        // 4.更新进度
        updateProgressInfo()
    }
    
}

// 响应按钮点击事件
extension PlayingViewController {
    
    @IBAction func playOrPauseBTNClick(sender: UIButton) {
        
        sender.selected = !playOrPauseBTN.selected
        
        startPlayingMusic()
        
        if sender.selected
        {
            player?.pause()
            removeProgressTimer()
            
            // 暂停动画
            iconView.layer.pauseAnim()
        }
        else
        {
            player?.play()
            addProgressTimer()
            
            // 恢复动画
            iconView.layer.resumeAnim()
        }
        

    }
    
    @IBAction func getPreviousSongBTNClick(sender: UIButton)
    {
        // 1.获取上一首歌曲
        guard let previousSong = MusicTool.getPreviousSong() else {
            return
        }
        
        MusicTool.currentMusic = previousSong
        
        // 2.播放歌曲
        startPlayingMusic()
    }
    
    @IBAction func getNextSongBTNClick(sender: UIButton)
    {
        // 1.获取上一首歌曲
        guard let nextSong = MusicTool.getNextSong() else {
            return
        }
        
        MusicTool.currentMusic = nextSong
        
        // 2.播放歌曲
        startPlayingMusic()
    }
}

