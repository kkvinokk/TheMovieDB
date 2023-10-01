//
//  UIImageView+Extension.swift
//  IDMDemoApp
//
//  Created by Abhishek Madhavrao Binniwale (BLR GSS) on 13/03/22.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(path: String, contentMode: UIView.ContentMode) {
        let apiUrl = APIURL(environment: .development)
        let basepath = apiUrl.imageBaseURL()
        let link = "\(basepath)/\(path)"

        URLSession.shared.dataTask( with: URL(string: link)!, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
