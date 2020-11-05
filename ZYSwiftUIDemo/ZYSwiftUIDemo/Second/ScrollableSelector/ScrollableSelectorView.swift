//
//  ScrollableSelectorView.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/26.
//

import SwiftUI

struct ScrollableSelectorView: View {
    let userData: ScrollableSelectorData
    @Binding var selection: Int
    func text(for index: Int) -> some View {
        Group {
            if index == selection {
                Text(userData.contentsList[index].title)
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(4)
                    .cornerRadius(8)
                    .onTapGesture {
                        self.selection = index
                }
            } else {
                Text(userData.contentsList[index].title)
                    .font(.headline)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        self.selection = index
                }
            }
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            HStack(alignment: .center, spacing: 12) {
                ForEach(0 ..< userData.contentsList.count, id: \.self) {
                    self.text(for: $0).id($0)
                }
            }
            .padding([.leading, .trailing], 4)
        }
        .frame(height: 36)
        .cornerRadius(8)
    }
}

struct ScrollableSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
