import SwiftUI

struct StudentsList: View {
    @StateObject var viewModel = MainViewModel()
    @State var navigateToNext: Bool = false
    @State var showAlert: Bool = false
    @State var indexToDelete: Int? = nil
    @State var isGrid : Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        VStack {
            CustomNavigation(title: "Student List", leftImage: "", rightImage: "plus.app") {
                navigateToNext = true
            }.padding(.horizontal)
            Toggle(isOn: $isGrid) {
                Text(isGrid ? "Switch to List" : "Switch to Grid")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding()
            
            if isGrid {
                gridView
            }else{
                
                listView
            }
            
            
        }
        .navigationDestination(isPresented: $navigateToNext) {
            UpdateStudent(model: viewModel, currentScreen: .addScreen)
            
        }
        //        .scrollDisabled(true)
    }
    
    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns,spacing: 15) {
                ForEach(viewModel.personList.indices, id: \.self) { index in
                    NavigationLink(destination: StudentsDetailScreen(model: viewModel, personIndex: index)) {
                        CustomImageView(imagePath: viewModel.personList[index].profileImage,
                                        title: viewModel.personList[index].name)
                        .background(RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4))
                        
                        
                    }
                }
            }
            .foregroundColor(Color.black)
            .padding(.horizontal,10)
        }
    }
    
    private var listView : some View {
        
        List{
            ForEach(viewModel.personList.indices, id: \.self){ index in
                VStack{
                    NavigationLink(destination: StudentsDetailScreen(model: viewModel, personIndex: index)) {
                        CustomImageView(imagePath: viewModel.personList[index].profileImage, title: viewModel.personList[index].name)
                    }
                    .swipeActions {
                        Button {
                            indexToDelete = index
                            showAlert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                    
                }
                
            }
            .alert("Notice", isPresented: $showAlert) {
                Button("Yes", role: .destructive) {
                    if let index = indexToDelete {
                        delete(index)
                    }
                }
                Button("No", role: .cancel) {}
            } message: {
                Text("Are you sure you want to delete this student?")
            }
            
        }
    }
    
    
    func delete(_ index: Int) {
        viewModel.personList.remove(at: index)
        indexToDelete = nil
    }
}


struct StudentsList_Previews: PreviewProvider {
    static var previews: some View {
        StudentsList()
    }
}
