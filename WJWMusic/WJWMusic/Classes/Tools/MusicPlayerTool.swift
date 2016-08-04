//
//  MusicPlayerTool.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/4.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit
import AVFoundation

class MusicPlayerTool: NSObject {
    static var player : AVAudioPlayer?
}

extension MusicPlayerTool {
    class func playMusicWithName(musicName : String) -> AVAudioPlayer? {
    
        // 1.获取文件的URL
        guard let url = NSBundle.mainBundle().URLForResource(musicName, withExtension: nil) else {
            return nil
        }
        
        // 2.判断该url是否是正在播放的资源
        if player?.url != nil {
            if player!.url!.isEqual(url) {
                player?.play()
                return player
            }
        }
        
        // 3.创建player对象
        guard let tempPlayer = try? AVAudioPlayer(contentsOfURL: url) else {
            return nil
        }
        
        self.player = tempPlayer
        
        // 3.播放音乐
        tempPlayer.play()
        
        return tempPlayer
    }
    
    class func pauseMusic() {
        player?.pause()
    }
    
    class func stopMusic() {
        player?.currentTime = 0
        player?.stop()
    }
}





