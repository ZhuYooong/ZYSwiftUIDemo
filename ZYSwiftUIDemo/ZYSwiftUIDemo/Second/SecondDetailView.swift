//
//  SecondDetailView.swift
//  ZYSwiftUIDemo
//
//  Created by 朱勇 on 2020/10/28.
//

import SwiftUI

struct SecondDetailView: View {
    @State private var uiImage: UIImage? = nil
    let placeholderImage = UIImage(named: "SwiftUI_Background")!
    
    var secondDetailModel : SecondDetailModel
    var body: some View {
        LazyVStack(alignment: .center, spacing: 15.0) {
            Text(secondDetailModel.title)
                .font(.title)
            HStack {
                Text(secondDetailModel.type)
                    .font(.subheadline)
                Spacer()
                Text(secondDetailModel.author)
                    .font(.subheadline)
            }
            if self.secondDetailModel.images.count > 0 {
                Image(uiImage: self.uiImage ?? placeholderImage)
                    .resizable()
                    .onAppear(perform: downloadWebImage)
            }
            Text(secondDetailModel.content)
                .font(.body)
        }
    }
    func downloadWebImage() {
        guard let url = URL(string: self.secondDetailModel.images.first ?? "") else {
            print("Invalid URL.")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                self.uiImage = image
            }else {
                print("error: \(String(describing: error))")
            }
        }.resume()
    }
}

struct SecondDetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
