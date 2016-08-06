//
//  LrcLable.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/6.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class LrcLable: UILabel {
    var progress : Double = 0 {
        
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        let drawRect = CGRect(x: 0, y: 0, width: rect.width * CGFloat(progress), height: rect.height)
        UIColor.greenColor().set()
        
        UIRectFillUsingBlendMode(drawRect, .SourceIn)
    }
    
}
