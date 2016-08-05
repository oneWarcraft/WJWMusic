//
//  MusicTool.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/4.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class MusicTool: NSObject {
    static var musics : [MusicModel] = {
       let filePath = NSBundle.mainBundle().pathForResource("Musics.plist", ofType: nil)!
        
        let array = NSArray(contentsOfFile: filePath)!
        
        var tempArray = [MusicModel]()
        for dict in array as! [[String : NSObject]] {
            tempArray.append(MusicModel(dict: dict))
        }
        
        return tempArray
    }()
    
    static var currentMusic : MusicModel? = MusicTool.musics[2]
}

// MARK:- 获取上一首和下一首歌曲
extension MusicTool {
    class func getPreviousSong() -> MusicModel? {
        // 1.判断当前歌曲是否有值
        guard let currentM = currentMusic else {
            return nil
        }
        
        // 2.获取当前的索引
        let currentSontIndex = musics.indexOf(currentM)!
        
        // 3.获取上一首歌曲的索引
        var previousIndex = currentSontIndex - 1
        if previousIndex < 0 {
            previousIndex = musics.count - 1
        }
        
        return musics[previousIndex]
    }
    
    class func getNextSong() -> MusicModel? {
        // 1.判断当前歌曲是否有值
        guard let currentM = currentMusic else {
            return nil
        }
        
        // 2.获取当前的索引
        let curSongIndex = musics.indexOf(currentM)!
        
        // 3.获取下一首歌曲的索引
        var nextSongIndex = curSongIndex + 1
        if nextSongIndex > musics.count - 1 {
            nextSongIndex = 0
        }
        
        return musics[nextSongIndex]
    }
    
}



