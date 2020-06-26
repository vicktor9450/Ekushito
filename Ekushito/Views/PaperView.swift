//
//  demoGroupCoreData.swift
//  Ekushito
//
//  Created by minato on 2020/06/26.
//  Copyright © 2020 minato. All rights reserved.
//

import SwiftUI
struct PaperView: View {
    
    //CoreData
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Paper.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Paper.importDate, ascending: true)
        ]
    ) var papers: FetchedResults<Paper>
    
    //Supporting Sorting FetchRequestResult
    func update(_ result : FetchedResults<Paper>)-> [[Paper]]{
        return  Dictionary(grouping: result){ (element : Paper)  in
            dateFormatter.string(from: element.importDate)
        }.values.sorted() { $0[0].importDate < $1[0].importDate}
    }
    //Supporting delete cell
    func removeCell(at offsets: IndexSet) {
        for index in offsets {
            let paper = papers[index]
            managedObjectContext.delete(paper)
        }
    }
    
    //Supporting format Date
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short //Modify to show other kindda date show in dateGroup
        return formatter
    }
    
    //Supporing ShowModalView: AddingSheet
    @State private var showAddingSheet: Bool = false

    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(update(papers), id: \.self) { (section: [Paper]) in
                        Section(header: Text( self.dateFormatter.string(from: section[0].importDate))) {
                            ForEach(section, id: \.self) { paper in
                                HStack {
                                    Text(paper.type)
                                        .font(.body)
                                    Text("\(paper.width)mm")
                                        .font(.caption)
                                    Text("\(paper.quantity)m x\(paper.numOfRoll)")
                                        .font(.caption)
                                    Text("\(paper.finish)")
                                }
                            }
                            .onDelete(perform: self.removeCell)
                            
                        }
                    }
                }
                .id(papers.count)   //?
                .navigationBarTitle("hello")    //Navigation Title
                .sheet(isPresented: $showAddingSheet) {
                    AddingPaperSheet().environment(\.managedObjectContext, self.managedObjectContext)
                }
                .navigationBarTitle("用紙管理", displayMode: .inline)
                    //edit button
                    .navigationBarItems(trailing:
                        Button(action: {
                            print("Opening AddingPaperSheet")
                            self.showAddingSheet.toggle()
                        }) {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 32, height: 32, alignment: .center)
                        }
                )
            }
        }
    }
}


struct PaperView_Previews: PreviewProvider {
    static var previews: some View {
        PaperView()
    }
}
