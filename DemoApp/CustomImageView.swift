//
//  CustomImageView.swift
//  DemoApp
//
//  Created by Gopal Kumar on 11/03/26.
//

import SwiftUI


struct CustomImageView: View {
    let imagePath: String
    let title: String
    
    var body: some View {
        HStack(spacing: 15) {
            if let uiImage = SavingAndGetting.shared.getProfileImage(named: imagePath) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
            Text(title)
                .font(.headline)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct CustomImageView_Previews: PreviewProvider {
    static var previews: some View {
        CustomImageView( imagePath: "", title: "ABC")
    }
}
