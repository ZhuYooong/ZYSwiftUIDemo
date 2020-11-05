//
//  SecondDetailModel.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/28.
//

import Foundation

struct SecondDetailModel: Codable, Identifiable {
    static func == (lhs: SecondDetailModel, rhs: SecondDetailModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let title: String
    let author: String
    let content: String
    let type: String
    let images: [String]
    
    init(from: Dictionary<String, Any>) {
        self.id = from["_id"] as! String
        self.title = from["title"] as! String
        self.author = from["author"] as! String
        self.content = from["content"] as! String
        self.type = from["type"] as! String
        self.images = from["images"] as! [String]
    }
}
