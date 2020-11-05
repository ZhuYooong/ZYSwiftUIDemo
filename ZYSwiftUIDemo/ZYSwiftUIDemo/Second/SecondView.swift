//
//  SecondView.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/27.
//

import SwiftUI

struct SecondView: View {
    let selectData = ScrollableSelectorData("")
    @StateObject var secondData = SecondData(ScrollableSelectorData("").contentsList.first?.title ?? "")
    var selection: Int = 0
    var body: some View {
        ZStack {
            VStack {
                Color(.lightGray).frame(height: 300)
                Spacer()
            }
            List {
                Group {
                    ScrollableSelectorView(userData: self.selectData, selection: Binding<Int>(
                                            get: {
                                                self.selection
                                           },
                                            set: {
                                                self.secondData.contentsList = SecondData(ScrollableSelectorData("").contentsList[$0].title).contentsList
                                            })
                                           )
                    ForEach(secondData.contentsList) { contents in
                        NavigationLink(destination: SecondDetailView(secondDetailModel: SecondDetailData(contents.id).content!)) {
                            SecondCell(secondModel: contents)
                        }
                    }
                }
                .listRowInsets(.none)
            }
        }
        .onAppear {
            self.root.tabNavigationHidden = false
            self.root.tabNavigationTitle = "Second"
        }
    }
    @EnvironmentObject var root: RootViewModel
}
private struct SecondCell: View {
    let secondModel: SecondModel
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                HStack(alignment: .top) {
                    Text(secondModel.title)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.primary)
                    Spacer()
                    Text(secondModel.publishedAt)
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
                Text(secondModel.desc)
                    .lineLimit(1)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            Separator().padding(.leading, 76)
        }
    }
}
struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
