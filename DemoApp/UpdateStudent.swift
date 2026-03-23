//
//  DetailView.swift
//  DemoApp
//
//  Created by Gopal Kumar on 05/03/26.
//

import SwiftUI
import PhotosUI

enum ScreenType{
    case updateScreen
    case addScreen
    
    var title: String {
        switch self {
        case .updateScreen:
            return "Update Student"
        case .addScreen:
            return "Add Student"
            
        }
    }
}

enum GenderSelect : String ,CaseIterable{
    
    case male = "Male"
    case female = "Female"
    case others = "Others"
}

struct UpdateStudent: View {
    
    @ObservedObject var model: MainViewModel
    
    @State var currentScreen : ScreenType
    @State var showAlert: Bool = false
    @State private var alertMessage = ""
    @State var name = ""
    @State var mobile = ""
    @State var email = ""
    @State var fatherName = ""
    @State var motherName = ""
    @State var age = ""
    @State var gender = ""
    @State var selectedDate : Date = Date.now
    @State private var showDatePicker = false
    
    
    @State var profileImagePath: String = ""
    var personIndex: Int = 0
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            CustomNavigation(title: currentScreen.title)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    
                    ProfileImagePicker(imagePath: $profileImagePath)
                        .padding(.vertical, 20)
                    
                    detailsView
                    
                    actionButton
                    
                }
                .navigationBarBackButtonHidden(true)
            }
            .onAppear {
                if currentScreen == .updateScreen,
                   model.personList.indices.contains(personIndex) {
                    let student = model.personList[personIndex]
                    name = student.name
                    email = student.email
                    mobile = student.phoneNo
                    fatherName = student.fatherName
                    motherName = student.motherName
                    
                    profileImagePath = student.profileImage
                }
            }
            .alert("Notice", isPresented: $showAlert) {
                if ["submit", "Add", "Cancle"].contains(alertMessage) {
                    Button("No", role: .cancel) {}
                    Button("Yes") {
                        if currentScreen == .updateScreen && alertMessage == "submit" {
                            updateLogic()
                        } else if alertMessage == "Add" {
                            add()
                        }
                        dismiss()
                    }
                } else {
                    Button("OK", role: .cancel) {}
                }
            } message: {
                Text(alertMessage == "submit" ? "Are you Sure You Want to Update" :
                        alertMessage == "Add" ? "Are You Sure You Want to Add" :
                        alertMessage == "Cancle" ? "Are You Sure You Want to Cancel" : alertMessage)
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
    func updateLogic() {
        model.personList[personIndex].name = name
        model.personList[personIndex].email = email
        model.personList[personIndex].phoneNo = mobile
        model.personList[personIndex].fatherName = fatherName
        model.personList[personIndex].motherName = motherName
        model.personList[personIndex].age = age
        model.personList[personIndex].gender = gender
        
        
        model.personList[personIndex].profileImage = profileImagePath
    }
    
    func add() {
        let student = Student(name: name, phoneNo: mobile, email: email, fatherName: fatherName, motherName: motherName,profileImage: profileImagePath)
        
        model.personList.append(student)
    }
    
    private var detailsView: some View {
        VStack(spacing: 10) {
            CustomTextField(fieldType: .name, title: "Name ", placeholder: "Enter Your Name", isMandatory: true, text: $name)
            CustomTextField(fieldType: .email, title: "Email ", placeholder: "Enter Your Email", isMandatory: true, text: $email)
            CustomTextField(fieldType: .phoneNo, title: "Phone No ", placeholder: "Enter Your Phone Number", isMandatory: true, text: $mobile)
            CustomTextField(fieldType: .name, title: "Father Name ", placeholder: "Enter Your Father Name", text: $fatherName)
            CustomTextField(fieldType: .name, title: "Mother Name ", placeholder: "Enter Your Mother Name", isMandatory: false, text: $motherName)
            
            ageSelectorTextField
            
            genderSeletion
            
            
        }
    }
    
    private var ageSelectorTextField : some View {
        CustomTextField(fieldType: .name,title: "Age / Birthdate",placeholder: "Tap to select date",text: $age)
            .onTapGesture {
                showDatePicker = true
            }
            .popover(isPresented: $showDatePicker) {
                VStack {
                    DatePicker(
                        "", selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    HStack {
                        Button("Cancel", role: .cancel) {
                            showDatePicker = false
                        }
                        .padding(.leading, 20)
                        Spacer()
                        Button("Done") {
                            age = selectedDate.formatted(date: .abbreviated, time: .omitted)
                            showDatePicker = false
                        }
                        .padding(.trailing, 20)
                    }
                    .padding(.bottom, 10)
                }
                .presentationDetents([.medium])
                .frame(minWidth: 300, minHeight: 400)
            }
    }
    
    private var genderSeletion : some View {
        Menu{
            ForEach(GenderSelect.allCases, id: \.self) { option in
                Button(option.rawValue) {
                    gender = option.rawValue
                }
            }
        }label: {
            CustomTextField(fieldType: .name,title: "Gender",placeholder: "Tap to select Gender",text: $gender)
                .tint(.black)
        }
    }
    
    private var actionButton : some View {
        HStack {
            CustomButton(title: "Cancel", width: 150) {
                alertMessage = "Cancle"
                showAlert = true
            }
            CustomButton(title: currentScreen == .updateScreen ? "Update" : "Add", width: 150) {
                let error = validate()
                if error.isEmpty {
                    alertMessage = currentScreen == .updateScreen ? "submit" : "Add"
                    showAlert = true
                } else {
                    alertMessage = error
                    showAlert = true
                }
            }
        }
        .padding(.top, 50)
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    func validate() -> String {
        if name.isEmpty { return "Please enter Name" }
        if email.isEmpty { return "Please Enter Email" }
        if mobile.isEmpty { return "please Enter Phone Number" }
        return ""
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateStudent(model:MainViewModel(), currentScreen: ScreenType.addScreen)
    }
}
