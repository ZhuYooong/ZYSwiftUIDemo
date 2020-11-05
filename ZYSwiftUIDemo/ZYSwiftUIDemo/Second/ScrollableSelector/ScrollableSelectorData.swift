//
//  ScrollableSelectorData.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/27.
//

import Foundation
import Combine

final class ScrollableSelectorData: ObservableObject, Identifiable {
    var contentsList: [ScrollableSelectorModel] = []
    let willChange = PassthroughSubject<ScrollableSelectorData, Never>()
    var url: String
    init(_ url: String) {
        self.url = url
        self.updateData()
    }
    func updateData() -> Void {
        Networking.request(method: .GET, urlString: "https://gank.io/api/v2/categories/Article") { (results) in
            var list: [ScrollableSelectorModel] = []
            if let items = results["data"] as? [Dictionary<String, Any>]{
                for item in items {
                    let model = ScrollableSelectorModel(from: item)
                    list.append(model)
                }
                self.contentsList = list
            }
        } error: { (error) in
            print("请求出错了:",error.debugDescription)
        }
    }
}
