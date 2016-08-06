//
//  Lrcline.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/6.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class Lrcline: NSObject {
    var lrcTime : NSTimeInterval = 0
    var lrcText : String = ""
    
    init(lrclineString : String) {
        super.init()
        
        lrcText = lrclineString.componentsSeparatedByString("]")[1]
        let range = Range(start: lrclineString.startIndex.advancedBy(1), end: lrclineString.startIndex.advancedBy(9))
        lrcTime = timeWithTimeStr(lrclineString.substringWithRange(range))
    }
    
    private func timeWithTimeStr(timeStr : String) -> NSTimeInterval {
        // 03:21.82
        let min = Double((timeStr as NSString).substringToIndex(2))!
        let second = Double((timeStr as NSString).substringWithRange(NSRange(location: 3, length: 2)))!
        let millisecond = Double((timeStr as NSString).substringFromIndex(6))!
        
        return (min * 60 + second + millisecond * 0.01)
 
    } 
}
