//
//  UIImage+fromURL.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
            
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let imageData = data {
                DispatchQueue.main.async { self.image = UIImage(data: imageData) }
            } else {
                // TODO: handle error
                print("Error loading image \(url.absoluteString)");
            }
        }
            
        dataTask.resume()
    }
}
