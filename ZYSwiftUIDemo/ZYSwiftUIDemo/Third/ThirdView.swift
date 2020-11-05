//
//  ThirdView.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/29.
//

import SwiftUI

struct ThirdView: View {
    let contentsList: [[ThirdModel]] = ThirdData("").contentsList
    var itemWidth: CGFloat {
            (UIScreen.main.bounds.width - 40) / 3
        }
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(0 ..< self.contentsList.count) { index in
                    HStack(spacing: 10) {
                        ForEach(self.contentsList[index]) { content in
                            NavigationLink(destination: SecondDetailView(secondDetailModel: SecondDetailData(content.id).content!)) {
                                ThirdCell(model: content).frame(width: itemWidth, height: itemWidth)
                                    .clipped()
                            }
                        }
                    }
                }
            }
            
        }.frame(height: 320)
        .onAppear {
            self.root.tabNavigationHidden = false
            self.root.tabNavigationTitle = "Third"
        }
    }
    @EnvironmentObject var root: RootViewModel
}
struct ThirdCell: View {
    var model: ThirdModel
    
    let golden = Color.init(red: 0.73, green: 0.67, blue: 0.54)
    var body: some View {
        ZStack {
            NetworkImage().environmentObject(NetworkImageData(model.images.first ?? ""))
            .background(Color(red: 0xf4/0xff, green: 0xf4/0xff, blue: 0xf4/0xff))
            
            Text(model.title)
                .font(.system(size: 10))
            .foregroundColor(golden)
                .padding(4)
        }.padding(.bottom, 10)
    }
}
struct ThirdView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdView()
    }
}
