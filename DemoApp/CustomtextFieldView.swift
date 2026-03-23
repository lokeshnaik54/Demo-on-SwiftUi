//
//  CustumtextFieldView.swift
//  DemoApp
//
//  Created by Gopal Kumar on 05/03/26.
//

import SwiftUI

enum TextFieldType{
    case name
    case email
    case phoneNo
    
    var textFieldType : String {
        switch self{
        case .name : return #"^[a-zA-Z][a-zA-Z\s]*$"#
        case .email : return #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        case .phoneNo : return #"^(?:\+91|91|0)?[6-9]\d{9}$"#
        }
    }
    
    var minLength : Int {
        switch self {
        case .name : return 3
        case .email: return 10
        case .phoneNo: return 10
        }
    }
    var maxLength :Int {
        switch self {
        case .name : return 50
        case .email: return 100
        case .phoneNo: return 13
        }
    }
  var keyboardType: UIKeyboardType {
        switch self {
        case .name:    return .alphabet
        case .email:   return .emailAddress
        case .phoneNo: return .phonePad
        }
    }
}

struct CustomTextField: View {
    
    let fieldType : TextFieldType?
    var title: String?
    var placeholder: String?
    var showBorder = false
    var font: Font = .caption
    var forground : Color = .gray
    var color:Color = .gray.opacity(0.5)
    var alignment : Alignment = .leading
    var height: CGFloat = 30.0
    var width :CGFloat = .infinity
    var isMandatory : Bool = false
    @Binding var text: String
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack{
                Text(title ?? "")
                    .bold(true)
                if isMandatory{
                    Text("*")
                        .foregroundColor(Color.red)
                }
            }.padding(.top,10)
            
            textFieldView
            
            if errorMessage != nil {
                Text(errorMessage ?? "")
                    .foregroundColor(Color.red)
            }
        }.padding(.leading,10)
            .padding(.trailing,10)
    }
    
    private var textFieldView: some View {
        TextField(placeholder ?? "", text: $text)
            .padding(10)
            .frame(maxWidth: width, minHeight: height, alignment: alignment)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 1)
            )
            .textInputAutocapitalization(.never)
            .keyboardType(UIKeyboardType(rawValue: (fieldType?.keyboardType)!.rawValue) ?? .default)
            .onChange(of: text) { newValue in
                validateInput(newValue)
                if newValue.count >= fieldType?.maxLength ?? 0{
                    text = String(text.prefix(fieldType?.maxLength ?? 0))
                }
            }
        
    }
    
    func validateInput(_ value: String) {
        guard let type = fieldType else { return }
        if isMandatory{
        if value.isEmpty {
            errorMessage = "Please Enter \(type)"
            return
        }
            if fieldType != .email && value.count < fieldType?.minLength ?? 0 {
                errorMessage = "please enter minimum length \(fieldType?.minLength ?? 0)"
            } else if value.count > fieldType?.maxLength ?? 0 {
                errorMessage = "too long, enter at most \(fieldType?.maxLength ?? 0) characters"
            } else {
                let predicate = NSPredicate(format: "SELF MATCHES %@", type.textFieldType)
                if !predicate.evaluate(with: value) {
                    errorMessage = "please enter valid \(type)"
                } else {
                    errorMessage = nil
                }
            }
        }
        print(errorMessage as Any)
    }
    
}
