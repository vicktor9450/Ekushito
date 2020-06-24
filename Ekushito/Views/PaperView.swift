//
//  PaperView.swift
//  Ekushito
//
//  Created by minato on 2020/06/21.
//  Copyright © 2020 minato. All rights reserved.
//

import SwiftUI

struct PaperView: View {

    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Paper.entity(),
                  sortDescriptors: [
                    NSSortDescriptor(keyPath: \Paper.width, ascending: true),
                    NSSortDescriptor(keyPath: \Paper.type, ascending: true)])
    var papers: FetchedResults<Paper>
    
    @State private var showAddingSheet: Bool = false
    
    var body: some View {
        VStack {//List and Nav View
            NavigationView {
                List {
                    ForEach(papers, id: \.self) { paper in
//                        NavigationLink(destination: PaperDetail) { }
                        HStack {
                            Text(paper.type)
                                .font(.body)
                            Text("\(paper.width)mm")
                                .font(.caption)
                            Text("\(paper.quantity)m x\(paper.numOfRoll)")
                                .font(.caption)
                            Text("\(paper.finish)")
                            Spacer()
                            Text(paper.importDate.toLocalString())
                        }
                    }
                    .onDelete(perform: cellDelete)
                }
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
                )}
        }
    }
    
    func cellDelete(at offsets: IndexSet) {
        for index in offsets {
            let paper = papers[index]
            managedObjectContext.delete(paper)
        }
    }
}
struct PaperView_Previews: PreviewProvider {
    static var previews: some View {
        PaperView()
    }
}
