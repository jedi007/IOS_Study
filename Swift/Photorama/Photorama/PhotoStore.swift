//
//  PhotoStore.swift
//  Photorama
//
//  Created by 司开发 on 2019/9/1.
//  Copyright © 2019 李杰. All rights reserved.
//

import UIKit
import CoreData

enum ImageResult {
    case Success(UIImage)
    case Failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

class PhotoStore {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    let imageStore = ImageStore()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Photorama")
        container.loadPersistentStores{ (description,error) in
            if let error = error {
                print("Error setting up Core Data(\(error))")
            }
        }
        return container
    }()
    
    func fetchInterestingPhotos(completion: @escaping(PhotosResult)-> Void ) {
        print(#function)
        
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            
//            if let jsonData = data {
////                if let jsonString = String(data: jsonData, encoding: .utf8){
////                    print(jsonString)
////                }
//                do {
//                    let jsonObject = try
//                        JSONSerialization.jsonObject(with: jsonData, options: [])
//                    print(jsonObject)
//                } catch let  error {
//                    print("Error fetching recent photos: \(error)")
//                }
//
//            } else if let requestError = error {
//                print("Error fetching recent photos: \(requestError)")
//            }
//            else {
//                print("Unexpected error with the request")
//            }
            
            let result = self.processPhotosRequest(data: data,error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return FlickrAPI.photos(fromJSON: jsonData, into:persistentContainer.viewContext)
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void)
    {
        guard let photoKey = photo.photoID else {
            preconditionFailure("Photo expected to have a photoID")
        }
        
        if let image = imageStore.image(forKey: photoKey)
        {
            print("find the photo: \(photoKey)")
            OperationQueue.main.addOperation {
                completion(.Success(image))
            }
            return
        }
        
        guard let photoURL = photo.remoteURL else {
            preconditionFailure("Photo expected to have a remoteURL")
        }
        
        
        let request = URLRequest(url: photoURL as URL)
        
        let task = session.dataTask(with: request){
            (data, response, error) -> Void in
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result {
                self.imageStore.setImage(image, forKey: photoKey)
            }
            
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
                
                if data == nil {
                    return .Failure(error!)
                } else {
                    return .Failure(PhotoError.imageCreationError)
                }
        }
        
        return .Success(image)
    }
}
