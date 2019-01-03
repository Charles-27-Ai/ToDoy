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
    //var itemArray = ["Find Mike", "Buy Eggs", "Destroy Dragon"]
    //TODO: 初始化一个以 Model 文件里的 Item 类模板为原型的 数据组
    var itemArray = [Item]()
    
    //let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    //TODO: viewDidLoad() 设置页面初始化变量（非显示内容）
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //TODO: 打印 FileManager 的 Singleton(default) 设定文件存储位置
        
        print(dataFilePath!)
        
        // 在设定好自建 plist 后，就可以删掉下列初始化数据
//        let newItem = Item()
//        newItem.title = "See doctor"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Meet giraffe"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Care for Nova"
//        itemArray.append(newItem3)
        
        //TODO: 从自建的 plist 中调取存储在本地的数据
        loadItems()
        
        //TODO: [X] 显示 UserDefaults 传入的保存在本地的数据 KEY指向的内容
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        } // safe unwrapping
        // forKey 是本地存储在 sandbox 里的数据指针（KEY）
        
        //TODO: 把自建的 plist 的数据载入 TableViewController
        
    }
    
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //TODO: 给 cell 中填充 itemArray 创建的 dummy 文字（设置显示内容）
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //TODO: 初始化变量
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //TODO: 传递数据
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.textLabel?.text = itemArray[indexPath.row].title // 向 cell 内填充 itemArray 的文字。由于indexPath.row 返回的是一个 OBJECT，所以需要 .title 获得其 Property
        
        //TODO: 使用 Ternary operator 简化条件判断代码 ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none // 跟下面一样
        //cell.accessoryType = item.done == true ? .checkmark : .none // 跟下面一样
//
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
            
    }
    
    
    //MARK: - 每次点击都开关一个隐藏的 flag/check 针对每个 table item
    //TODO: TableView Delegate Methods  每次点击时都被触发(did select row at ...)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(indexPath.row)           // 显示 index number
        //print(itemArray[indexPath.row])// 显示 table cell 的 实际内容（提取内容）
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done // 跟下面一样
//
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
       
        
        // 给每个 cell 在点击时，加个 checkmark （4种 accessory 之一）（没有就加，有就取消）
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //TODO: CALL plist 文件存储函数
        saveItems()
        //TODO: 强制页面刷新（须在改变 flag 之后），CALL tebleView METHOD again
        //tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)  // 点击后底色不会一直灰，而是消失
        
    }
    
    //MARK: - 添加新待办事项 Add New Items to the list
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        //TODO: 初始化一个放置「输入文字」的变量
        var textField = UITextField()
        
        //TODO: 设定弹出窗口 alert
        let alert = UIAlertController(title: "Add New Todoy Item", message: "", preferredStyle: .alert)
        
        //TODO: 设置 弹出窗口 alert 内部的按钮动作
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on UIAlert
            //print(textField.text as Any)
            // 这里是按下 Add Item 递交后显示的内容
            
            //self.itemArray.title.append(textField.text!)
            //TODO: 创建新的 OBJECT，传入新的 Item.title 数据
            //注意：append 的是 OJBECT，不能是文字本身，因为 itemArray 是 OBJECT 的一个 ARRAY 了
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.saveItems()
            
        }
        
        //TODO: 在 弹出窗口中设置文字输入框
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            //TODO: 把输入框的文字 赋值给 local variable -- textField，使得能在 action 中被执行
            textField = alertTextField
            // 注意：在这里 print 的信息，只能在弹出时显示，无法在按钮递交后显示
        }
        
        //TODO: CALL 弹出窗口，使其弹出
        alert.addAction(action)
        
        //TODO: 设定动画
        present(alert, animated: true, completion: nil)
    
    }
    
    //MARK: - 本地数据存储函数 Persistent Data Storage Methods（可创建多个 plist）
    //TODO: Encode 数据进一个 plist
    func saveItems() {
        // 用了自建的 plist就不用 defaults 了
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        //TODO: 刷新页面，否则看不到输入数据
        self.tableView.reloadData()
    }
    //TODO: 从一个 plist 中 Decode 数据
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error in decoding item array: \(error)")
            }
        }
    }
}

