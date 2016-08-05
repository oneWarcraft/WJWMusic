//
//  CALayer-Extension.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/5.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

extension CALayer {
    func pauseAnim() {
        let pauseTime = convertTime(CACurrentMediaTime(), fromLayer: nil)
        speed = 0
        timeOffset = pauseTime
    }
    
    func resumeAnim() {
        let pauseTime = timeOffset
        speed = 1.0
        timeOffset = 0
        beginTime = 0
        let timeInteval = convertTime(CACurrentMediaTime(), fromLayer: nil) - pauseTime
        
        beginTime = timeInteval
    }
}






