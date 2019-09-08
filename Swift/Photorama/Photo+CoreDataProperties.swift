//
//  Photo+CoreDataProperties.swift
//  Photorama
//
//  Created by 司开发 on 2019/9/8.
//  Copyright © 2019 李杰. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoID: String?
    @NSManaged public var remoteURL: NSURL?
    @NSManaged public var dateTaken: NSDate?
    @NSManaged public var title: String?

}
