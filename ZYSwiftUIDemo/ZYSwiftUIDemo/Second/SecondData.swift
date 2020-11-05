//
//  SecondData.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/27.
//

import Foundation
import Combine

final class SecondData: ObservableObject, Identifiable {
    var contentsList: [SecondModel] = []
    let willChange = PassthroughSubject<SecondData, Never>()
    var url: String
    init(_ title: String) {
        self.url = "https://gank.io/api/v2/data/category/GanHuo/type/\(title)/page/1/count/10"
        self.updateData()
    }
    func updateData() -> Void {
        Networking.request(method: .GET, urlString: self.url) { (results) in
            var list: [SecondModel] = []
            if let items = results["data"] as? [Dictionary<String, Any>]{
                for item in items {
                    let model = SecondModel(from: item)
                    list.append(model)
                }
                self.contentsList = list
            }
        } error: { (error) in
            print("请求出错了:",error.debugDescription)
        }
    }
}
