//
//  LyricScrollView.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/6.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

private let LrcTableViewCell = "LrcTableViewCell"

class LyricScrollView: UIScrollView {
    
    private lazy var LyricTableView : UITableView = UITableView()
    
    var currentTime : NSTimeInterval = 0
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    // MARK:- 定义属性
    var lrclines : [Lrcline]?
    var lrcfileName : String = "" {
        didSet {
            // 1. 获取歌词
            lrclines = LrcTool.lrcToolWithLrcName(lrcfileName)
            
            // 2. 刷新表格
            LyricTableView.reloadData()
        }
    }
    
    
    
    // MARK:- 重写构造函数
    override func awakeFromNib() {
        
        setupTableView()
    }
}

// MARK:- 创建歌词的TableView
extension LyricScrollView {
    private func setupTableView() {
        // 1.添加tableView
        addSubview(LyricTableView)
        
        // 2.设置tableView属性
        LyricTableView.backgroundColor = UIColor.clearColor()
        LyricTableView.dataSource = self
        LyricTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: LrcTableViewCell)
        LyricTableView.rowHeight = 35
        LyricTableView.separatorStyle = .None
    }
    
    override func layoutSubviews() {
        LyricTableView.frame = bounds
        LyricTableView.frame.origin.x = bounds.width
        
        LyricTableView.contentInset = UIEdgeInsets(top: bounds.height * 0.5, left: 0, bottom: bounds.height * 0.5, right: 0)
    }
}

extension LyricScrollView : UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrclines?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 1.创建Cell
        let cell = tableView.dequeueReusableCellWithIdentifier(LrcTableViewCell, forIndexPath: indexPath)

        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.font = UIFont.systemFontOfSize(13)
        cell.textLabel?.textAlignment = .Center
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.selectionStyle = .None
        
        // 2.给cell设置数据
        cell.textLabel?.text = lrclines![indexPath.row].lrcText
        
        return cell
    }
}















