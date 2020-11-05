//
//  ThirdData.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/29.
//

import Foundation
import Combine

final class ThirdData: ObservableObject, Identifiable {
    var contentsList: [[ThirdModel]] = []
    let willChange = PassthroughSubject<ThirdData, Never>()
    var url: String
    init(_ url: String) {
        self.url = url
        self.updateData()
    }
    func updateData() -> Void {
        Networking.request(method: .GET, urlString: "https://gank.io/api/v2/data/category/Girl/type/Girl/page/1/count/20") { (results) in
            var list: [ThirdModel] = []
            if let items = results["data"] as? [Dictionary<String, Any>]{
                for item in items {
                    let model = ThirdModel(from: item)
                    list.append(model)
                }
                var contents: [[ThirdModel]] = []
                var countIndex = 3;
                var indexList: [ThirdModel] = []
                for index in 0 ..< list.count {
                    if index < countIndex {
                        indexList.append(list[index])
                    }else {
                        contents.append(indexList)
                        countIndex += 3
                        indexList = []
                    }
                }
                self.contentsList = contents
            }
        } error: { (error) in
            print("请求出错了:",error.debugDescription)
        }
    }
}
