//
//  IndexSlipView.swift
//  MyAppTestKit
//
//  Created by zdh on 2024/12/24.
//

import Foundation
import UIKit

protocol IndexTableViewSource: AnyObject  {
    func indexTitlesForTableView(tableView: UITableView) -> [String]
}

class IndexedTableView: UITableView {
    
    private let btnWidth: Double = 50
    
    private var containerView: UIView = UIView.init()
    
    private var reusePool: ViewReusePool = ViewReusePool.init()
    
    weak var indexedDataSource: IndexTableViewSource?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func reloadData() {
        super.reloadData()
        containerView.backgroundColor = UIColor.white
        self.superview?.insertSubview(containerView, aboveSubview: self)
        
        // 标记所有视图为可重用状态
        reusePool.reset()
        
        reloadIndexBar()
    }
    
    func reloadIndexBar() {
        // 获取字母索引条需要的titles
        var arrayTitles: [String] = []
        if let titles = indexedDataSource?.indexTitlesForTableView(tableView: self) {
            arrayTitles = titles
        }
        
        if arrayTitles.isEmpty {
            containerView.isHidden = true
            return
        }
        
        let count: Int = arrayTitles.count
        let btnWidth: CGFloat = 60
        let btnHeight: CGFloat = self.frame.size.height / Double(count)
        
        for i in 0...count {
            if i < count {
                let title = arrayTitles[i]
                var btn: UIButton? = reusePool.dequeueReusableView() as? UIButton
                if btn == nil {
                    btn = UIButton.init(frame: .zero)
                    btn?.backgroundColor = UIColor.white
                    // 注册button到重用池中
                    reusePool.addUsingView(view: btn)
                    print("新创建一个UIButon")
                } else {
                    print("Buton重用了")
                }
                
                containerView.addSubview(btn!)
                btn?.setTitle(title, for: .normal)
                btn?.setTitleColor(UIColor.black, for: .normal)
                btn?.frame = CGRect.init(x: 0, y: CGFloat(i) * btnHeight, width: btnWidth, height: btnHeight)
                
            }
            
            
        }
        
        containerView.isHidden = false
        containerView.backgroundColor = UIColor.yellow
        containerView.frame = CGRect.init(x: self.frame.origin.x + self.frame.size.width - btnWidth, y: self.frame.origin.y, width: btnWidth, height: self.frame.size.height)
        
        
    }
    
    
    
}
