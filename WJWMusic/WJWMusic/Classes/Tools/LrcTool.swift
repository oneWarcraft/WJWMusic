//
//  LrcTool.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/6.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class LrcTool: NSObject {
    class func lrcToolWithLrcName(lrcName : String) -> [Lrcline]? {
        // 1.读取歌词文件的路径
        guard let lrcPath = NSBundle.mainBundle().pathForResource(lrcName, ofType: nil) else {
            return nil
        }
        
        // 2.读取歌词文件
        guard let lrcString = try? String(contentsOfFile: lrcPath) else {
            return nil
        }
        
        // 3.获取歌词的数组
        let lrcArray = lrcString.componentsSeparatedByString("\n")
        
        
        // 4.遍历数组
        var tempArray = [Lrcline]()
        for lrclineString in lrcArray {
            // 4.1.过滤不需要的歌词
            if lrclineString.containsString("[ti:") || lrclineString.containsString("[al:") ||
               lrclineString.containsString("[ar:") || !lrclineString.containsString("[") {
                continue
            }

            // 4.2.将字符串转成模型对象
            tempArray.append(Lrcline(lrclineString: lrclineString))
        }
        
        return tempArray
    }
}



