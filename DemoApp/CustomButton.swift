//
//  CustumButton.swift
//  DemoApp
//
//  Created by Gopal Kumar on 05/03/26.
//

import SwiftUI


struct CustomButton: View {
    var title: String = "Click Me"
    var hasBorder: Bool = false
    var accentColor: Color = .blue
    var width :CGFloat = 300
    var hight : CGFloat = 50
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.vertical, 12)
                .frame(width: width,height:hight)
                .background(hasBorder ? Color.clear : accentColor)
                .overlay{
                    if hasBorder{
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(accentColor, lineWidth: hasBorder ? 1 : 0)
                    }
                }
                .foregroundColor(hasBorder ? accentColor : .white)
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

struct CustumButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
    }
}
