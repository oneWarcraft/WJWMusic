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





