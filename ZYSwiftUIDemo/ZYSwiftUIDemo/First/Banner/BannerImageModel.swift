//
//  BannerImageModel.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/23.
//

import SwiftUI
import UIKit

struct BannerImageModel {
    static func == (lhs: BannerImageModel, rhs: BannerImageModel) -> Bool {
        return lhs.title == rhs.title
    }
    
    var title: String
    var url: String
    var image: String
    
    init(title: String, image: String, url: String) {
        self.title = title
        self.image = image
        self.url = url
    }
    
    init(from: Dictionary<String, Any>) {
        self.title = from["title"] as! String
        self.url = from["url"] as! String
        self.image = from["image"] as! String
    }
}

