//
//  SavingAndGettingImage.swift
//  DemoApp
//
//  Created by Gopal Kumar on 12/03/26.
//

import Foundation
import UIKit

class SavingAndGetting {
    static let shared = SavingAndGetting()
    private let fileManager = LocalFileManager.shared
    private let folderName = "Image_Storage"
    
    func saveProfileImage(image: UIImage, id: UUID) {
        fileManager.saveImage(image: image, imageName: id.uuidString, folderName: folderName)
    }
    
    func getProfileImage(named imageName: String?) -> UIImage? {
        guard let name = imageName, !name.isEmpty else { return nil }
        return fileManager.getImage(ImageName: name, folderName: folderName)
    }
}
