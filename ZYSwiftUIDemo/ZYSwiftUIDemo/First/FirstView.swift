//
//  FirstView.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/23.
//

import SwiftUI

struct FirstView: View {
    let contentsList: [FirstModel] = FirstData("").contentsList
    var body: some View {
        ZStack {
            VStack {
                Color(.lightGray).frame(height: 300)
                Spacer()
            }
            List {
                Group {
                    BannerScrollView(imageWidth: UIScreen.main.bounds.size.width, imageHeight: 200, banner: BannerData("", width: UIScreen.main.bounds.size.width, height: 200))
                        .frame(width: UIScreen.main.bounds.size.width, height: 200).onDisappear {
                            print("BannerScrollView disappear")
                    }
                    ForEach(contentsList) { contents in
                        NavigationLink(destination: WebView(urlString: contents.url)) {
                            FirstCell(firstModel: contents)
                        }
                    }
                }
                .listRowInsets(.none)
            }
        }
        .onAppear {
            self.root.tabNavigationHidden = false
            self.root.tabNavigationTitle = "First"
        }
    }
    @EnvironmentObject var root: RootViewModel
}
private struct FirstCell: View {
    let firstModel: FirstModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                NetworkImage().environmentObject(NetworkImageData(firstModel.member.avatar_normal))
                    .frame(width: 48, height: 48)
                    .cornerRadius(8)
                VStack(alignment: .leading, spacing: 5) {
                    Text(firstModel.title)
                        .lineLimit(1)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    HStack(alignment: .top) {
                        Text(firstModel.member.username)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(.primary)
                        Spacer()
                        Text(firstModel.node.title)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            Separator().padding(.leading, 76)
        }
    }
}
struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
