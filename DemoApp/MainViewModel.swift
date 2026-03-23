import Foundation
import UIKit
import Combine

class MainViewModel: ObservableObject {
    @Published var personList: [Student] = []
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.personList = StorageManager.shared.fetchPeople()
        Update()
    }
    
    private func Update() {
        $personList
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { people in
                StorageManager.shared.saveUserData(people)
                print("Data saved")
            }
            .store(in: &cancellables)
    }
   
}


