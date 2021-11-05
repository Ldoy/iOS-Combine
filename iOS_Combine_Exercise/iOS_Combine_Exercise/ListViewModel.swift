//
//  View.swift
//  iOS_Combine_Exercise
//
//  Created by Do Yi Lee on 2021/11/05.
//

import SwiftUI
import Combine

struct Event: Identifiable {
    var title: String
    var description: String
    var id: UUID
}

class ListViewModel: ObservableObject {
    //output??
    @Published var modalViewModel = [ModalViewModel]()
    //@State var isPresentedModal: Bool = false
    
    init(isTestView: Bool) {
        if isTestView {
            self.modalViewModel = [
                ModalViewModel(event: Event(title: "hoho",
                                            description: "haha", id: UUID())),
                ModalViewModel(event: Event(title: "hehe",
                                            description: "huhu", id: UUID()))
            ]
        } else {
            
        }
    }
    
    // input
    func appendNewEvent() {
        self.modalViewModel.append(ModalViewModel(event: Event(title: "", description: "", id: UUID())))
    }
    
    func onTouchShowModalButton() {
      //  self.isPresentedModal.toggle()
    }
}

class ModalViewModel: ObservableObject, Identifiable {
    @Published var event: Event
    
    //왜 있는지 아직 모르겠다.
    var title: String = ""
    var description: String = ""
    
    //modalViewModeldl identifiable 채택해야 하기 때문
    var id = UUID()
    
    private var cancellable = Set<AnyCancellable>()
    
    init(event: Event) {
        self.event = event
        
        $event.map { $0.title }
            .assign(to: \.title, on: self)
            .store(in: &cancellable)
        
        $event.map { $0.description }
            .assign(to: \.description, on: self)
            .store(in: &cancellable)
    }
    
    func onSubmmit(event: Event) {
        self.event = event
    }
}


enum InputError: Error {
    case inpuError
}

