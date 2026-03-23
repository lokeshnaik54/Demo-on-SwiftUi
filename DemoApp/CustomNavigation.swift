//
//  CustumNavigation.swift
//  DemoApp
//
//  Created by Gopal Kumar on 06/03/26.
//

import SwiftUI

struct CustomNavigation: View {
    var title: String = ""
    var leftImage: String? = "arrow.left"
    var rightImage: String?
    var alignment : Alignment?
    var action  : (() -> Void)?
    var color : Color?
    var height : CGFloat?
    var width : CGFloat?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Text(title)
                .font(.headline)
                .frame(maxWidth: width,maxHeight: height, alignment: .center)
            HStack {
                if let left = leftImage {
                    Button(action: {
                        if action != nil {
                            action?()
                        }else{
                            dismiss()
                        }
                    }) {
                        Image(systemName: left)
                    } .frame(alignment: alignment ?? Alignment.trailing)
                        .foregroundColor(color ?? Color.black)
                }
                Spacer()
                if let right = rightImage {
                    Button(action: {
                        if action != nil {
                            action?()
                        }else{
                            dismiss()
                        }
                    })
                    {
                        Image(systemName: right)
                            .resizable()
                            .frame(width: 25,height: 25)
                    }
                    .frame(alignment: alignment ?? Alignment.trailing)
                        .foregroundColor(color ?? Color.black)
                }
            }
            .padding(.horizontal)
            .frame(height: 44)
        }.frame(alignment: alignment ?? Alignment.topLeading)
    }
}

struct CustumNavigation_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigation(leftImage: "arrow.left", alignment: .leading)
    }
}
