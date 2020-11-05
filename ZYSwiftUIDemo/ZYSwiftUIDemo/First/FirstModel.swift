//
//  FirstModel.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/23.
//

import Foundation

struct FirstModel: Codable, Identifiable {
    static func == (lhs: FirstModel, rhs: FirstModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let url: String
    let created: Int
    let node: FirstNodeModel
    let member: FirstMemberModel
    
    init(from: Dictionary<String, Any>) {
        self.id = from["id"] as! Int
        self.title = from["title"] as! String
        self.url = from["url"] as! String
        self.created = from["created"] as! Int
        self.member = FirstMemberModel(from: from["member"] as! Dictionary<String, Any>)
        self.node = FirstNodeModel(from: from["node"] as! Dictionary<String, Any>)
    }
}
struct FirstNodeModel: Codable, Identifiable {
    let id: Int
    let title: String
    let avatar_normal: String
    
    init(from: Dictionary<String, Any>) {
        self.id = from["id"] as! Int
        self.title = from["title"] as! String
        self.avatar_normal = from["avatar_normal"] as! String
    }
}
struct FirstMemberModel: Codable, Identifiable {
    var id: Int
    let username: String
    let avatar_normal: String
    
    init(from: Dictionary<String, Any>) {
        self.id = from["id"] as! Int
        self.username = from["username"] as! String
        self.avatar_normal = from["avatar_normal"] as! String
    }
}
