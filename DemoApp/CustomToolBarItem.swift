//
//  CustumToolBarItem.swift
//  DemoApp
//
//  Created by Gopal Kumar on 05/03/26.
//

import SwiftUI

struct CustomToolBarItem: View {


    var title: String
    var image: Image
    var width:CGFloat = 20
    var hight :CGFloat = 20
    var color :Color = .black
    var alignment : Alignment?
    var font : Font = .system(size: 10)
    
    var back: (() -> Void)?
    var forward: (() -> Void)?
    

    var body: some View {
        VStack(spacing: 0) {
            Button {
                forward?()
                back?()
            } label: {
                VStack {
                    image
                        .foregroundColor(color)
                        .frame(width: width,height:hight,alignment: alignment ?? Alignment.bottomTrailing)
                    Text(title)
                        .font(font)
                        .foregroundColor(color)
                }
            }
        }
    }
}

//struct CustumToolBarItem_Previews: PreviewProvider {
//    static var previews: some View {
//        CustumToolBarItem()
//    }
//}
