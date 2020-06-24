//
//  ContentView.swift
//  Ekushito
//
//  Created by minato on 2020/06/21.
//  Copyright © 2020 minato. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    

    var body: some View {
        VStack {
            //TabView
            TabView {
                PaperView()
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("用紙")
                }
                InkView()
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("インキ")
                }
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
