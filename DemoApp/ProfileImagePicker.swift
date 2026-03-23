import SwiftUI
import PhotosUI

struct ProfileImagePicker: View {
    @Binding var imagePath: String
    @State private var internalUIImage: UIImage? = nil
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            HStack {
                Spacer()
                if let uiImage = internalUIImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .cornerRadius(40)
                        .clipped()
                } else {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                            .font(.system(size: 80))
                        Text("Select Photo").font(.caption)
                    }
                    .frame(width: 150, height: 150)
                    .background(Color(.systemGray6))
                    .cornerRadius(40)
                    .foregroundColor(.gray)
                }
                Spacer()
            }
        }
        .onAppear {
            if !imagePath.isEmpty {
                internalUIImage = SavingAndGetting.shared.getProfileImage(named: imagePath)
            }
        }
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let fetched = UIImage(data: data) {
                        self.internalUIImage = fetched
                        
                        let idString = imagePath.isEmpty ? UUID().uuidString : imagePath
                        
                        if let id = UUID(uuidString: idString) {
                            SavingAndGetting.shared.saveProfileImage(image: fetched, id: id)
                            self.imagePath = idString
                        }

                }
            }
        }
    }
}

struct ProfileImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImagePicker(imagePath: .constant(""))
    }
}
