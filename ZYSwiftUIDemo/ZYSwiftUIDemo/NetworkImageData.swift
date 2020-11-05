//
//  NetworkImageData.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/11/2.
//

import Foundation
import SwiftUI
import Combine

var kMiniCacheForImg = [String: UIImage?](minimumCapacity: 100)

final class NetworkImageData: ObservableObject, Identifiable {
    let willChange = PassthroughSubject<NetworkImageData, Never>()
    var imageURL: String
    
    @Published var imgData: UIImage? = nil
    
    init(_ imageURL: String) {
        self.imageURL = imageURL
        
        self.downloadImage()
    }
    
    func downloadImage() -> Void {
        if self.imgData != nil {
            return
        }
        if self.imageURL.hasPrefix("http://") || self.imageURL.hasPrefix("https://") {
            guard let url = URL(string: self.imageURL) else {
                print("imageURL error")
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let image = UIImage(data: data) {
                    self.imgData = image
                }else {
                    print("error: \(String(describing: error))")
                }
            }.resume()
        } else {
            self.imgData = UIImage.init(named: self.imageURL)
        }
    }
}
