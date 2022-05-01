//
//  ContentView.swift
//  DavidAppenborough
//
//  Created by Noah Knudsen on 01/05/2022.
//

import SwiftUI
import Stores

struct ContentView: View {
    var body: some View {
        Text(Stores().text)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
