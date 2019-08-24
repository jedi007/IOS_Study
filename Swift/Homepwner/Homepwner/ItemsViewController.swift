//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by 司开发 on 2019/8/17.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //实测发现目前的Xcode版本，默认就是不会状态重叠的。 所以不再需要该操作
//        let statusBarHeight = UIApplication.shared.statusBarFrame.height
//
//        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
//        tableView.contentInset = insets
//        tableView.scrollIndicatorInsets = insets
        
        //194页
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem)
    {
        print("addNew clicked")
        
        let newItem = itemStore.createItem()
        
        
        
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
//    @IBAction func toggleEditingMode(_ sender: UIButton)
//    {
//        if isEditing {
//            sender.setTitle("Edit", for: .normal)
//
//            setEditing(false, animated: true)
//        }
//        else
//        {
//            sender.setTitle("Done", for: .normal)
//
//            setEditing(true, animated: true)
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ShowItem"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.allItems[row]
                let datailViewController = segue.destination as! DetailViewController
                datailViewController.item = item
                datailViewController.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected segue indentifier.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    //代理方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
        //创建一个新的 UITableViewCell 对象，或者重用一个 UITableViewCell 对象
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        let item = itemStore.allItems[indexPath.row]
        
        print(cell)
        
        cell.nameLabel!.text = item.name
        cell.serialNumberLabel!.text = item.serialNumber
        cell.valueLabel!.text = "$\(item.valueInDollars)"
        
        if item.valueInDollars > 50 {
            cell.valueLabel!.textColor = UIColor.red
        }else{
            cell.valueLabel!.textColor = UIColor.green
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deteleAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                self.itemStore.removeItem(item)
                
                self.imageStore.deleteImage(forKey: item.itemKey)
                
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deteleAction)
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
