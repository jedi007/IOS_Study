//
//  Photo.swift
//  Photorama
//
//  Created by 司开发 on 2019/9/1.
//  Copyright © 2019 李杰. All rights reserved.
//

import Foundation

class Photo {
    
    let title: String
    let remoteURL: URL
    var photoID: String
    let dateTaken: Date
    
    init(title: String, photoID: String, remoteURL: URL, dateTaken: Date) {
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
}

extension Photo: Equatable {
    //MARK: - Equatable协议
    static func == (lhs: Photo, rhs: Photo) -> Bool
    {
        return lhs.photoID == rhs.photoID
    }
}
