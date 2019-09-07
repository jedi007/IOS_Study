//
//  PhotosViewController.swift
//  Photorama
//
//  Created by 司开发 on 2019/9/1.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
//因无法访问外网服务器。所以自己构建了diyPhoto
//        store.fetchInterestingPhotos {
//            (photosResult) -> Void in
//            
//            switch photosResult {
//            case let .success(photos):
//                print("Successfully found \(photos.count)")
//                
//                if let firstPhoto = photos.first {
//                    self.updateImageView(for: firstPhoto)
//                }
//            case let .failure(error):
//                print("Error fetching recent photos: \(error)")
//            }
//        }
        
        print("==========Date.init(): \(Date.init())")
        let testUrl = NSURL(string: "https://c-ssl.duitang.com/uploads/item/201209/03/20120903183740_c5Tar.jpeg")
        let diyPhoto = Photo(title: "test", photoID: "123", remoteURL: testUrl! as URL, dateTaken: Date.init() )
        self.updateImageView(for: diyPhoto)
    }
    
    func updateImageView(for photo: Photo){
        store.fetchImage(for: photo){
            (imageResult) -> Void in
            
            switch imageResult{
            case let .Success(image):
                self.imageView.image = image
            case let .Failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
}
