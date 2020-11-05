//
//  SecondModel.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/27.
//

import Foundation

struct SecondModel: Codable, Identifiable {
    static func == (lhs: SecondModel, rhs: SecondModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let title: String
    let publishedAt: String
    let desc: String
    let views: Int
    
    init(from: Dictionary<String, Any>) {
        self.id = from["_id"] as! String
        self.title = from["title"] as! String
        self.publishedAt = from["publishedAt"] as! String
        self.desc = from["desc"] as! String
        self.views = from["views"] as! Int
    }
}
