//
//  LyricScrollView.swift
//  WJWMusic
//
//  Created by 王继伟 on 16/8/6.
//  Copyright © 2016年 WangJiwei. All rights reserved.
//

import UIKit

private let LrcTableViewCellID = "LrcTableViewCell"

protocol LrcScrollViewDelegate : class {
    func lrcScrollView(lrcView : LyricScrollView, currentLrcText : String)
    func lrcScrollView(lrcView : LyricScrollView, progress : Double)
}

class LyricScrollView: UIScrollView {
    
    private lazy var LyricTableView : UITableView = UITableView()

    var currentIndex : Int = 0
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    // MARK:- 定义属性
    weak var lrcDelegate : LrcScrollViewDelegate?
    
    var lrclines : [Lrcline]?
    var lrcfileName : String = "" {
        didSet {
            // 1. 获取歌词
            lrclines = LrcTool.lrcToolWithLrcName(lrcfileName)
            
            // 2. 刷新表格
            LyricTableView.reloadData()
        }
    }
    
    var currentTime : NSTimeInterval = 0 {
        didSet {
            // 1.校验是否有歌词
            guard let lrclines = lrclines else {
                return
            }
            
            // 2.将所有的歌词进行遍历
            let count = lrclines.count
            for i in 0..<count
            {
                // 2.1.获取i位置的歌词
                let currentLrcline = lrclines[i]
                
                // 2.2.获取i+1位置的歌词
                let nextIndex = i + 1
                if nextIndex > count - 1 {
                    break
                }
                let nextLrcline = lrclines[nextIndex]
                
                // 2.3.判断当前时间是否是大于i位置的时间,并且小于i+1位置的时间
                if currentTime >= currentLrcline.lrcTime && currentTime < nextLrcline.lrcTime && currentIndex != i {
                    
                    // 2.3.1.根据i创建对应的indexPath
                    let indexPath = NSIndexPath(forRow: i, inSection: 0)
                    let previousPath = NSIndexPath(forRow: currentIndex, inSection: 0)
                    
                    
                    // 2.3.2.计算当前的i
                    currentIndex = i
                    
                    // 2.3.3.刷新i位置的cell
                    LyricTableView.reloadRowsAtIndexPaths([previousPath, indexPath], withRowAnimation: .None)
                    
                    // 滚动到对应的位置
                    LyricTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Top, animated: true)
                   
                    // 通知代理,切换歌词
                    lrcDelegate?.lrcScrollView(self, currentLrcText: currentLrcline.lrcText)
                }
                
                // 2.4.如果正在显示某一句歌词,那么就给label添加颜色的进度
                if currentIndex == i
                {
                    // 2.4.1.获取当前的进度
                    let progress = (currentTime - currentLrcline.lrcTime) / (nextLrcline.lrcTime - currentLrcline.lrcTime)
                    
                    // 2.4.2.将进度给lrcLabel,让label根据进度显示颜色
                    let indexPath = NSIndexPath(forRow: i, inSection: 0)
                    guard let cell = LyricTableView.cellForRowAtIndexPath(indexPath) as? LrcViewCell else {
                        continue
                    }
                    
                    cell.lrcLable.progress = progress
                    
                    // 2.4.3.通知代理,当前的进度
                    lrcDelegate?.lrcScrollView(self, progress: progress)
                }
            }
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
        LyricTableView.registerClass(LrcViewCell.self, forCellReuseIdentifier: LrcTableViewCellID)
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
        let cell = tableView.dequeueReusableCellWithIdentifier(LrcTableViewCellID, forIndexPath: indexPath) as! LrcViewCell


        // 2.给cell设置数据
        cell.lrcLable.text = lrclines![indexPath.row].lrcText
        
        if indexPath.row == currentIndex {
            cell.lrcLable.font = UIFont.systemFontOfSize(17)
//            cell.lrcLable.textColor = UIColor.greenColor()
        }else
        {
            cell.lrcLable.font = UIFont.systemFontOfSize(13)
//            cell.lrcLable.textColor = UIColor.whiteColor()
        }
        
        return cell
    }
}















