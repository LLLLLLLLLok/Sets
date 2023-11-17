//
//  ContentView.swift
//  Sets
//
//  Created by f1235791 on 17/11/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    
    var body: some View {
        SetFindingView()
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
    
}
