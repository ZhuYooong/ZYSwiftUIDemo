//
//  FourthView.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/11/3.
//

import SwiftUI
import Combine

struct FourthView: View {
    @State var name: String = ""
    @State var password: String = ""
    
    @State var value = 0
    
    @State var rating = 0.5
    
    @State var isOn = false
    
    @ObservedObject var server = DateServer()
    var speaceDate: Range<Date>?
    
    @ObservedObject private var source = dataSource()
    
    @State var showAlert = false
    init() {
        let soon = Calendar.current.date(byAdding: .year,
                                         value: -1,
                                         to: server.date) ?? Date()
        let later = Calendar.current.date(byAdding: .year,
                                          value: 1,
                                          to: server.date) ?? Date()
        speaceDate = soon..<later
    }
    var body: some View {
        LazyVStack {
            Image("SwiftUI_Icon").resizable().frame(width: 80, height: 80,
                                                    alignment: .center).clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.white, lineWidth: 4)
                    .shadow(radius: 10)
                )
            Group {
                Form {
                    TextField("Name", text: $name)
                    TextField("Password", text: $password)
                }
                Separator().padding(.leading, 52)
                HStack {
                    Stepper(value: $value, step: 2, onEditingChanged: { c in
                        print(c)
                    }) {
                        Text("Stepper Value: \(self.value)")
                    }.padding(50)
                }
                Separator().padding(.leading, 52)
                HStack {
                    Text("Slider Value: \(self.rating)")
                    Slider(value: $rating)
                        .padding(30)
                }
                Separator().padding(.leading, 52)
                HStack {
                    Toggle(isOn: $isOn) {
                        Text("State: \(self.isOn == true ? "开":"关")")
                    }.padding(20)
                    Spacer()
                }
                Separator().padding(.leading, 52)
                HStack(spacing: 10) {
                    Text("日期选择").bold()
                    DatePicker(selection: $server.date, in: server.spaceDate, displayedComponents: .date, label: {
                        Text("")
                    })
                }
                .padding(.top)
                Line()
            }
            List {
                ForEach(source.items, id: \.self) { idx in
                    Text("Hello \(idx)")
                    }
                    .onDelete(perform: deletePlace)
                    .onMove(perform: movePlace)
            }
            .listStyle(GroupedListStyle())
            .background(Color.white)
            
            Button(action: {
                self.showAlert = true
            }) {
                Text("Show Alert")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 30,height: 45)
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("温馨提示"),
                      message: Text("确认要退出吗\n一旦退出，所有信息不会保存"),
                      primaryButton: .destructive(Text("确认")) { print("已退出") },
                      secondaryButton: .cancel())
            })
            .background(Color.orange)
            .cornerRadius(5)
        }
        .background(Color.white)
        .onAppear {
            self.root.tabNavigationHidden = false
            self.root.tabNavigationTitle = "Fourth"
            self.root.tabNavigationBarTrailingItems = .init(EditButton())
        }
    }
    @EnvironmentObject var root: RootViewModel
    func deletePlace(at offset: IndexSet) {
        if let last = offset.last {
            source.items.remove(at: last)
            print(source.items.count)
        }
    }
    func movePlace(from source: IndexSet, to destination: Int) {
        print(source,destination)
    }
}
class DateServer: ObservableObject {
    var didChange = PassthroughSubject<DateServer,Never>()
    var date: Date = Date() {
        didSet {
            didChange.send(self)
            print("Date Changed: \(date)")
        }
    }
    var spaceDate: ClosedRange<Date>  {
        let soon = Calendar.current.date(byAdding: .year,
                                         value: -1,
                                         to: date) ?? Date()
        
        let later = Calendar.current.date(byAdding: .year,
                                          value: 1,
                                          to: date) ?? Date()
        let speaceDate = soon...later
        return speaceDate
    }
}
class dataSource: ObservableObject {
    public var didChange = PassthroughSubject<Void, Never>()
    public var items: [Int] {
        didSet {
            didChange.send(())
        }
    }
    init() {
        self.items = (0..<3).map { $0 }
    }
}
private struct Line: View {
    var body: some View {
        Rectangle()
            .foregroundColor(Color(.lightGray))
            .frame(height: 8)
    }
}
struct FourthView_Previews: PreviewProvider {
    static var previews: some View {
        FourthView()
    }
}
