//
//  ThirdModel.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/29.
//

import Foundation

struct ThirdModel: Codable, Identifiable {
    static func == (lhs: ThirdModel, rhs: ThirdModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let title: String
    let publishedAt: String
    let desc: String
    let views: Int
    let images: [String]
    
    init(from: Dictionary<String, Any>) {
        self.id = from["_id"] as! String
        self.title = from["title"] as! String
        self.publishedAt = from["publishedAt"] as! String
        self.desc = from["desc"] as! String
        self.views = from["views"] as! Int
        self.images = from["images"] as! [String]
    }
}
