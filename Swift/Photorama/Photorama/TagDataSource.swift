//
//  TagDataSource.swift
//  Photorama
//
//  Created by 司开发 on 2019/9/17.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit
import CoreData

class TagDataSource: NSObject,UITableViewDataSource {
    
    var tags: [Tag] = []
    
    //MARK: - delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tags.count: \(tags.count)")
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        print("indexPath.row: \(indexPath.row)")
        let tag = tags[indexPath.row]
        cell.textLabel?.text = tag.name
        
        return cell
    }
    
    
    
    
}
