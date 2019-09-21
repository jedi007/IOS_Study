//
//  TagsViewController.swift
//  Photorama
//
//  Created by 司开发 on 2019/9/17.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit
import CoreData

class TagsViewController: UITableViewController
{
    var store: PhotoStore!
    var photo: Photo!
    
    var selectedIndexPaths = [NSIndexPath]()
    
    let tagDataSource = TagDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = tagDataSource
        tableView.delegate = self
        
        updateTags()
    }
    
    func updateTags(){
        store.fetchAllTags {
            (tagsResult) in
            
            switch tagsResult {
                case let .Success(tags):
                    print("tags: \(tags)")
                    self.tagDataSource.tags = tags
                    
                    if(tags.count > 0)
                    {
                        print("hui diao tags: \(tags[0].name)")
                    }
                
                    guard let photoTags = self.photo.tags as? Set<Tag> else {
                        return
                    }
                    
                    print("photoTags: \(photoTags)")
                
                    for tag in photoTags {
                        if let index = self.tagDataSource.tags.firstIndex(of: tag)
                        {
                            print("index is : \(index)")
                            let indexPath = IndexPath(row: index, section: 0)
                            self.selectedIndexPaths.append(indexPath as NSIndexPath)
                        }
                    }
                
                self.tableView.reloadData()
                case let .failed(error):
                    print("Error fetching tags: \(error)")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt is called")
        let tag = tagDataSource.tags[indexPath.row]
        
        if let index = selectedIndexPaths.firstIndex(of: indexPath as NSIndexPath) {
            selectedIndexPaths.remove(at: index)
            photo.removeFromTags(tag)
        } else {
            selectedIndexPaths.append(indexPath as NSIndexPath)
            photo.addToTags(tag)
        }
        
        do {
            try store.persistentContainer.viewContext.save()
        } catch {
            print( "Core Data save failed: \(error).")
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay cell is called")
        if selectedIndexPaths.firstIndex(of: indexPath as NSIndexPath) != nil {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
//        cell.accessoryType = UITableViewCellAccessoryNone;//cell没有任何的样式
//
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//cell的右边有一个小箭头，距离右边有十几像素；
//
//        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;//cell右边有一个蓝色的圆形button；
//
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;//cell右边的形状是对号；
    }
    
    @IBAction func done(_ sender: UIBarButtonItem){
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewTag(_ sender: UIBarButtonItem){
        let alertController = UIAlertController(title: "Add Tag", message: nil, preferredStyle: .alert)
        
        alertController.addTextField {
            (textField) -> Void in
            textField.placeholder = "tag name"
            textField.autocapitalizationType = .words
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
            (action) -> Void in
            
            if let tagName = alertController.textFields?.first?.text {
                let context = self.store.persistentContainer.viewContext
                let newTag = NSEntityDescription.insertNewObject(forEntityName: "Tag", into: context)
                newTag.setValue(tagName, forKey: "name")
                
                print("will add new tagname: \(newTag)")
                
                do {
                    try self.store.persistentContainer.viewContext.save()
                    print("save success")
                } catch let error {
                    print(" Core Data save failed: \(error)")
                }
                self.updateTags()
            }
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated:true, completion:nil)
    }
    
    
}
