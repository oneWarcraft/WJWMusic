//
//  LrcViewCell.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/6.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

class LrcViewCell: UITableViewCell {
    lazy var lrcLable : LrcLable = LrcLable()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LrcViewCell {
    private func setupUI() {
        // 1.将Label添加到cell中
        contentView.addSubview(lrcLable)
        
        // 2.设置属性
        backgroundColor = UIColor.clearColor()
        lrcLable.font = UIFont.systemFontOfSize(13)
        lrcLable.textAlignment = .Center
        lrcLable.textColor = UIColor.whiteColor()
        selectionStyle = .None
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lrcLable.center = contentView.center
        lrcLable.sizeToFit()
    }
}








