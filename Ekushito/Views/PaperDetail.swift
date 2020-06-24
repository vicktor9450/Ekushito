//
//  PaperDetail.swift
//  Ekushito
//
//  Created by minato on 2020/06/25.
//  Copyright © 2020 minato. All rights reserved.
//

import SwiftUI

struct PaperDetail: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var quantityEdit: String = ""
    @ObservedObject var paper: Paper
    
    var body: some View {
        VStack {
            TextField("Paper name", text: $quantityEdit)
            Button(action: {
                self.paper.quantity = Int16(self.quantityEdit)!
                do {
                    try self.managedObjectContext.save()
                } catch {
                    print("Error while saving edited data with \(error)")
                }
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            }
        }
        .onAppear(perform: {
            self.quantityEdit = String(self.paper.quantity)
        })
    }
}

struct PaperDetail_Previews: PreviewProvider {
    static var previews: some View {
        PaperDetail(paper: Paper())
    }
}
