//
//  ItemStore.swift
//  Homepwner
//
//  Created by 司开发 on 2019/8/17.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    @discardableResult func createItem() -> Item
    {
        let newItem = Item(random : true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item)
    {
        if let index = allItems.firstIndex(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        
        allItems.insert(movedItem, at: toIndex)
    }
    
    init()
    {
//        for _ in 0..<5{
//            createItem()
//        }
        
        if let archivedItems = NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    func saveChanges() -> Bool {
        print("Saving items to \(itemArchiveURL.path)")
        
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
        
        //return NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: true)
    }
}
