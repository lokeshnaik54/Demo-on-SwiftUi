//
//  TextViews.swift
//  DemoApp
//
//  Created by Gopal Kumar on 05/03/26.
//

import SwiftUI

struct CstomTextViews: View {
    var title: String
    var font: Font = .largeTitle
    var textColor: Color = .black
    var backgroundColor: Color = .clear
    var height: CGFloat = 30.0
    var width :CGFloat = .infinity
    var showBorder = false
    var alignnment : Alignment = .leading
    var body: some View {
        HStack{
            Text(title)
                .font(font)
                .foregroundColor(textColor)
                .background(backgroundColor)
                .frame(maxWidth: width, minHeight: height, alignment: alignnment)
                .padding(showBorder ? 8 : 0)
                .overlay {
                    if showBorder {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.gray, lineWidth: 1)
                        
                    }
                }
        }
    }
    
}

struct TextViews_Previews: PreviewProvider {
    static var previews: some View {
        CstomTextViews(title: "Name")
    }
}
