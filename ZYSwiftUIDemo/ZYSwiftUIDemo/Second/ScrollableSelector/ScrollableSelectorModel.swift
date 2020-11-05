//
//  ScrollableSelectorModel.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/27.
//

import Foundation

struct ScrollableSelectorModel: Codable, Identifiable {
    static func == (lhs: ScrollableSelectorModel, rhs: ScrollableSelectorModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let title: String
    let type: String
    let desc: String
    let coverImageUrl: String
    
    init(from: Dictionary<String, Any>) {
        self.id = from["_id"] as! String
        self.title = from["title"] as! String
        self.type = from["type"] as! String
        self.desc = from["desc"] as! String
        self.coverImageUrl = from["coverImageUrl"] as! String
    }
}
