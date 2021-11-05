//
//  Listview.swift
//  iOS_Combine_Exercise
//
//  Created by Do Yi Lee on 2021/11/05.
//

import SwiftUI

struct EventListView: View {
    @ObservedObject var listViewModel: ListViewModel
    @State var isPresentedModal = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(listViewModel.modalViewModel) { vm in
                    NavigationLink(destination: {
                        ModalView(modalViewModel: vm)
                    }, label: {
                        CellView(cell: vm.event)
                    })
                }
            }.toolbar(content: {
                Button(action: {
                    self.isPresentedModal = true
                }, label: {
                    Text("+")
                }).sheet(isPresented: $isPresentedModal) {
                    self.isPresentedModal = false
                } content: {
                    ModalView(modalViewModel: self.listViewModel.modalViewModel.last!)
                }
            })
            .onTapGesture(perform: {
                self.isPresentedModal = true
            })
            
        }.navigationViewStyle(.stack)

        
    }
}

struct ModalView: View {
    @ObservedObject var modalViewModel: ModalViewModel

    var body: some View {
        VStack {
            Text(modalViewModel.title)
            TextField("", text: $modalViewModel.title)
                .background(Color.yellow)
        }
        
    }
}

struct CellView: View {
    var cell: Event
    var body: some View {
        VStack {
            Text(self.cell.title)
            Text(self.cell.description)
        }
    }
}
