//
//  UIImageView+Download.swift
//  BudTechnicalTask
//
//  Created by Kristina Nenkova on 22/09/2018.
//  Copyright © 2018 Kristina Nenkova. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    struct Holder {
        static var dataTask: URLSessionDataTask = URLSessionDataTask()
    }
    var computedDataTask: URLSessionDataTask {
        get {
            return Holder.dataTask
        }
        set(newValue) {
            Holder.dataTask = newValue
        }
    }
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        self.image = placeHolder
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: URLString) {
            self.computedDataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("Can't download image from URL: \(String(describing: error))")
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            })
            self.computedDataTask.resume()
        }
    }
    
    func cancelImageDownload() {
        self.computedDataTask.cancel()
    }
}
