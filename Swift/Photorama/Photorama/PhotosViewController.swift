//
//  PhotosViewController.swift
//  Photorama
//
//  Created by 司开发 on 2019/9/1.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
//        //因无法访问外网服务器。所以自己构建了diyPhoto
//        store.fetchInterestingPhotos {
//            (photosResult) -> Void in
//
//            switch photosResult {
//            case let .success(photos):
//                print("Successfully found \(photos.count)")
//
//                self.photoDataSource.photos = photos
//            case let .failure(error):
//                print("Error fetching recent photos: \(error)")
//                self.photoDataSource.photos.removeAll()
//            }
//            self.collectionView.reloadSections(IndexSet(integer: 0))
//        }
        
        print("==========Date.init(): \(Date.init())")
        let testUrl = NSURL(string: "https://c-ssl.duitang.com/uploads/item/201209/03/20120903183740_c5Tar.jpeg")
        let diyPhoto = Photo(title: "test", photoID: "123", remoteURL: testUrl! as URL, dateTaken: Date.init() )
        
        var finalPhotos = [Photo]()
        for i in 1...15 {
            print(i)
            finalPhotos.append(diyPhoto)
        }
        photoDataSource.photos = finalPhotos
        
        collectionView.dataSource = photoDataSource
        
        
        
    }
    

}
