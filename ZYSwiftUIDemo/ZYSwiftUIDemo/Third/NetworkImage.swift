//
//  NetworkImage.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/11/2.
//

import SwiftUI

struct NetworkImage: View {
    @EnvironmentObject var userData: NetworkImageData

    var body: some View {
        Group {
            if self.userData.imgData == nil{
                Image(systemName: "SwiftUI_Icon")
            } else {
                Image(uiImage: self.userData.imgData!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct NetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImage()
    }
}
