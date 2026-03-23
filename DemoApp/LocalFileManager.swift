//
//  LocalFileManager.swift
//  DemoApp
//
//  Created by Gopal Kumar on 11/03/26.
//

import Foundation
import SwiftUI

class LocalFileManager{
    
    static let shared = LocalFileManager()
    private init(){}
    
    
    
    
    
    func saveImage (image:UIImage,imageName:String,folderName : String){
        
        // create folder
        createFolder(folderName: folderName)
        
        // get path for Image
        guard
            let data = image.pngData(),
            let url = getUrlForImages(imageName: imageName, folderName: folderName)
        else{return}
        // save Image to Path
        do{
            try data.write(to: url)
        }catch let error{
            print("Error Saving Image . imageName : \(imageName) | \(error)")
        }
        
    }
    
    func getImage(ImageName:String,folderName:String) -> UIImage? {
        guard let url = getUrlForImages(imageName: ImageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else{
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    
    private func createFolder(folderName:String){
        guard let url = getUrlForFolder(folderName: folderName) else {return}
        if !FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true,attributes: nil)
            }catch let error {
                print("Error Creating Directory . folderName : \(folderName)  \(error) ")
            }
        }
    }
    
    
    
    private func getUrlForFolder(folderName:String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    
    private func getUrlForImages(imageName : String,folderName : String) -> URL? {
        guard let folderUrl = getUrlForFolder(folderName: folderName) else{
            return nil
        }
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
    
}
