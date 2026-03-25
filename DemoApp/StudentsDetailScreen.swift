//
//  ContentView.swift
//  DemoApp
//
//  Created by Gopal Kumar on 05/03/26.
//

import SwiftUI


struct StudentsDetailScreen: View {
    @ObservedObject var model: MainViewModel
    var temp3personIndex: Int = 0
    var personIndex: Int = 0
    var temppersonIndex: Int = 0
    var temp2personIndex: Int = 0

    @State var navigateToNext : Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            CustomNavigation(title:"Student Details")
                .padding(.leading,20)
            
            detailRow("Name :", value: model.personList[personIndex].name)
            detailRow("Email :", value: model.personList[personIndex].email)
            detailRow("PhoneNo :", value: model.personList[personIndex].phoneNo)
            detailRow("FatherName :", value: model.personList[personIndex].fatherName)
            detailRow("MotherName :", value: model.personList[personIndex].motherName)
            
            CustomButton(title: "Edit", action: {
                navigateToNext = true
            }) .padding(.leading,50)
                .padding(.trailing,50)
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $navigateToNext) {
            UpdateStudent(model: model, currentScreen: .updateScreen, personIndex: personIndex)
        }
    }
    func detailRow(_ label: String, value: String) -> some View {
        HStack(spacing: 10) {
            CstomTextViews(title: label, font: .system(size: 20), width: 140, alignnment: .topLeading)
                .bold()
            CstomTextViews(title: value, font: .system(size: 20), width: .infinity, showBorder: false, alignnment: .leading)
        }.padding(.leading,40)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StudentsDetailScreen(model: MainViewModel())
    }
}
