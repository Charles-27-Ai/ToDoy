//
//  ViewController.swift
//  ToDoy
//
//  Created by CA@CA on 2019-01-01.
//  Copyright © 2019 Red Nova Engine. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    // 选定 Table View Controller 比 普通的好，可以省很多链接与 delegate 声明
    let itemArray = ["Find Mike", "Buy Eggs", "Destroy Dragon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    //TODO: 给 cell 中填充 itemArray 创建的 dummy 文字
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: 初始化变量
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //TODO: 传递数据
        cell.textLabel?.text = itemArray[indexPath.row] // 向 cell 内填充 itemArray 的文字
        
        return cell
            
    }
    
    
    //MARK: - 每次点击都开关一个隐藏的 flag/check 针对每个 table item
    //TODO: TableView Delegate Methods  每次点击时都被触发(did select row at ...)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(indexPath.row)           // 显示 index number
        print(itemArray[indexPath.row])// 显示 table cell 的 实际内容（提取内容）
        
        // 给每个 cell 在点击时，加个 checkmark （4种 accessory 之一）（没有就加，有就取消）
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)  // 点击后底色不会一直灰，而是消失
        
    }
}

