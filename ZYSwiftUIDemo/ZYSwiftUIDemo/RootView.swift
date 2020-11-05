//
//  RootView.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/23.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var model = RootViewModel()
    
    let firstView = FirstView()
    let secondView = SecondView()
    let thirdView = ThirdView()
    let fourthView = FourthView()
    var body: some View {
        NavigationView {
            TabView(selection: $model.tabSelection) {
                firstView
                    .tabItem { Item(index: $model.tabSelection, style: .first) }
                    .tag(0)
                secondView
                    .tabItem { Item(index: $model.tabSelection, style: .second) }
                    .tag(1)
                thirdView
                    .tabItem { Item(index: $model.tabSelection, style: .third) }
                    .tag(2)
                fourthView
                    .tabItem { Item(index: $model.tabSelection, style: .fourth) }
                    .tag(3)
            }
            .accentColor(.green) // 选中某个 Tab 时，Item 的高亮颜色
            .navigationBarHidden(model.tabNavigationHidden)
            .navigationBarItems(trailing: model.tabNavigationBarTrailingItems)
            .navigationBarTitle(model.tabNavigationTitle, displayMode: .inline)
            .environmentObject(model)
        }
    }
}
private struct Item: View {
    @Binding var index: Int
    let style: Style
    var body: some View {
        VStack {
            if index == style.rawValue {
                style.selectedImage.resizable().frame(width: 20, height: 20, alignment: .center)
            } else {
                style.image.resizable().frame(width: 20, height: 20, alignment: .center)
            }
            Text(style.text)
        }
    }
}

extension Item {
    enum Style: Int {
        case first
        case second
        case third
        case fourth
        
        var image: Image {
            switch self {
            case .first:     return Image("First")
            case .second:  return Image("Second")
            case .third: return Image("Third")
            case .fourth:       return Image("Fourth")
            }
        }
        
        var selectedImage: Image {
            switch self {
            case .first:     return Image("First_Select")
            case .second:  return Image("Second_Select")
            case .third: return Image("Third_Select")
            case .fourth:       return Image("Fourth_Select")
            }
        }
        
        var text: String {
            switch self {
            case .first:     return "First"
            case .second:  return "Second"
            case .third: return "Third"
            case .fourth:       return "Fourth"
            }
        }
    }
}
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
