//
//  view.swift
//  iOS_Combine_Exercise
//
//  Created by Do Yi Lee on 2021/11/05.
//

import SwiftUI



struct view_Previews: PreviewProvider {
    static var previews: some View {
        EventListCellView(cell: Event(title: "", description: "", id: UUID()))
    }
}
