//
//  MusicModel.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/4.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class MusicModel: NSObject {
    
    var name : String = ""
    var filename : String = ""
    var singer : String = ""
    var singerIcon : String = ""
    var icon : String = ""
    
    init(dict : [String : NSObject]) {
        super.init()
        

        setValuesForKeysWithDictionary(dict)
        
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
