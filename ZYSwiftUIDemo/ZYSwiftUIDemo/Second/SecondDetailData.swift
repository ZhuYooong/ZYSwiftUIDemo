//
//  SecondDetailData.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/28.
//

import Foundation
import Foundation
import Combine

final class SecondDetailData: ObservableObject, Identifiable {
    var content: SecondDetailModel?
    let willChange = PassthroughSubject<SecondDetailData, Never>()
    var url: String
    init(_ id: String) {
        self.url = "https://gank.io/api/v2/post//(id)"
        self.updateData()
    }
    func updateData() -> Void {
        Networking.request(method: .GET, urlString: self.url) { (results) in
            if let item = results["data"] as? [String : Any]{
                self.content = SecondDetailModel(from: item)
            }
        } error: { (error) in
            print("请求出错了:",error.debugDescription)
        }
    }
}
