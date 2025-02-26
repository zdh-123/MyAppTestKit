//
//  IndexSlipVC.swift
//  MyAppTestKit
//
//  Created by zdh on 2024/12/24.
//

import Foundation
import UIKit
import SnapKit

/// 索引条页面，该页面用来验证复用机制使用的，使用到UItableview
public class IndexSlipVC: UIViewController {
    
    private var tableView = IndexedTableView.init(frame: .zero, style: .plain)
    
    
    
    private var datasouce: [String] = []
    
    private var change: Bool = false
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "索引条页面"
        
        view.backgroundColor = UIColor.white
        
        tableView.frame = CGRect.init(x: 0, y: 140, width: self.view.frame.size.width, height: self.view.frame.size.height - 140)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "indexCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.indexedDataSource = self
        view.addSubview(tableView)
        
        var refreshBtn = UIButton.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 40))
        refreshBtn.setTitle("刷新table", for: .normal)
        refreshBtn.backgroundColor = UIColor.red
        refreshBtn.addTarget(self, action: #selector(doAction), for: .touchUpInside)
        view.addSubview(refreshBtn)
        
        for i in 0...100 {
            datasouce.append("\(i)")
            
        }
    }
    
    @objc private func doAction() {
        print("刷新数据")
        tableView.reloadData()
    }
    
    
}

extension IndexSlipVC: UITableViewDataSource, UITableViewDelegate, IndexTableViewSource {
    func indexTitlesForTableView(tableView: UITableView) -> [String] {
        if change {
            change = false
            return ["A","B","C","D","E","F","G","H","I","J","K",]
        } else {
            change = true
            return ["A","B","C","D","E","F"]
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasouce.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "indexCell", for: indexPath)
        cell.textLabel?.text = datasouce[indexPath.row]
        return cell
        
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    
    
    
}
