//
//  AddingPaperSheet.swift
//  Ekushito
//
//  Created by minato on 2020/06/21.
//  Copyright © 2020 minato. All rights reserved.
//

import SwiftUI

struct AddingPaperSheet: View {
    //!need to optimize localized extension
    let paperTypes = ["yupo80MD8GB".localized, "kyasutoYellowSeparator".localized, "kyasutoBlueGura".localized, "artYellowSeparator".localized, "joushitsu".localized]
    let finishTypes = ["yupo".localized, "ipponkiri".localized]
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode //for showing ModalView
    
    //For Paper Entity
    @State private var paperTypeIndex = 1
    @State private var paperWidth = ""
    @State private var numberOfRoll = 1
    @State private var rollLength = "600"
    @State private var isSlitted = true
    
    //DatePicker
    @State private var importDate: Date = Date()
    @State var showDatePicker = true
    
    
    var body: some View {
        NavigationView {
            //Form
            Form {
                Section(header: Text("Paper Details".localized)) {
                    //PaperType
                    Picker(selection: $paperTypeIndex, label: Text("Paper Type".localized)) {
                        ForEach(0 ..< paperTypes.count) {
                            Text(self.paperTypes[$0]).tag($0)
                        }
                    }
                    //isSlitted?
                    Toggle(isOn: $isSlitted) {
                        Text(isSlitted ? "ipponyaiba".localized : "スリット無し")
                            .foregroundColor(.red)
                    }
                    //PaperWidth
                    TextField("Paper Width".localized + " mm", text: $paperWidth).keyboardType(.numberPad)
                    //Number Of Roll
                    Stepper("\(numberOfRoll) \("Roll".localized)", value: $numberOfRoll, in: 1...12)
                    //Lenth of roll
                    TextField("Roll length: \(rollLength) mm", text: $rollLength)
                        .keyboardType(.numberPad)
                    //Total length
                    Text("Total length: \((Int(rollLength) ?? 0) * Int(numberOfRoll)) m")
                    //import date picker
                    DatePicker("Import date", selection: $importDate)
                    
                    
                }
                //Saving
                Button(action: {
                    //Prevent from saving blank dataSet
                    guard self.paperWidth != "" else {return}
                    print("Saving Paper details")
                    let paperX = Paper(context: self.managedObjectContext)
                    //Total 6 sectors
                    paperX.id = UUID()
                    paperX.finish = self.isSlitted ? "ipponyaiba".localized : ""
                    paperX.importDate = self.importDate
                    paperX.type = self.paperTypes[self.paperTypeIndex]
                    paperX.quantity = Int16(self.rollLength)!
                    paperX.width = Int16(self.paperWidth)!
                    paperX.numOfRoll = Int16(self.numberOfRoll)
                    do {
                        try self.managedObjectContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print("Error while saving sample")
                    }
                }) {
                    Text("Saving".localized)
                }
            }
            .navigationBarTitle("Adding Paper".localized)
        }
    }
}

struct AddingPaperSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddingPaperSheet()
    }
}
