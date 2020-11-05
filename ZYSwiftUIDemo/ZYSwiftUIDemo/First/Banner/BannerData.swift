//
//  BannerData.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/23.
//

import SwiftUI
import Foundation
import Combine

final class BannerData: ObservableObject, Identifiable {
    let willChange = PassthroughSubject<BannerData, Never>()
    var bannes: [BannerImageModel] = []
    var url: String
    init(_ url: String, width: CGFloat, height: CGFloat) {
        self.url = url
        self.updateData(imageWidth: width, imageHeight: height)
    }
    func updateData(imageWidth: CGFloat, imageHeight: CGFloat) -> Void {
        Networking.request(method: .GET, urlString: "https://gank.io/api/v2/banners") { (results) in
            var list: [BannerImageModel] = []
            if let items = results["data"] as? [Dictionary<String, Any>]{
                for item in items {
                    let model = BannerImageModel(from: item)
                    list.append(model)
                }
                self.bannes = list
            }
        } error: { (error) in
            print("请求出错了:",error.debugDescription)
        }
    }
}

