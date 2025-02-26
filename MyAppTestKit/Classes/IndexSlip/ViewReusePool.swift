//
//  ViewReusePool.swift
//  MyAppTestKit
//
//  Created by zdh on 2025/1/22.
//

import Foundation

class ViewReusePool: NSObject {
    
    /// 待使用的
    var waitUsedQueue: Set<NSObject> = []
    
    /// 正在使用的
    var usingQueue: Set<NSObject> = []
    
    
    override init() {
        super.init()
        
    }
    
    
    // 从重用池中取出一个可重用的view
    func dequeueReusableView() -> UIView? {
        
        if let randomView: UIView = waitUsedQueue.randomElement() as? UIView {
            waitUsedQueue.remove(randomView)
            usingQueue.insert(randomView)
            return randomView
        }
        
        return nil
    }
    
    // 向重用池中添加一个视图
    func addUsingView(view: UIView?) {
        if let usingView = view {
            usingQueue.insert(usingView)
        }
    }
    
    // 重置方法，将当前使用中的视图移动到可重用队列中去
    func reset() {
        for itemView in usingQueue {
            waitUsedQueue.insert(itemView)
        }
        usingQueue.removeAll()
    }
    
}
