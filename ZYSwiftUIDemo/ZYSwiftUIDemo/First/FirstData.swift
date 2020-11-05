//
//  FirstData.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/27.
//

import SwiftUI
import Foundation
import Combine

final class FirstData: ObservableObject, Identifiable {
    var contentsList: [FirstModel] = []
    let willChange = PassthroughSubject<FirstData, Never>()
    var url: String
    init(_ url: String) {
        self.url = url
        self.updateData()
    }
    func updateData() -> Void {
        Networking.request(method: .GET, urlString: "https://www.v2ex.com/api/topics/hot.json") { (results) in
            var list: [FirstModel] = []
            if let items = results["data"] as? [Dictionary<String, Any>]{
                for item in items {
                    let model = FirstModel(from: item)
                    list.append(model)
                }
                self.contentsList = list
            }
        } error: { (error) in
            print("请求出错了:",error.debugDescription)
        }
    }
}
