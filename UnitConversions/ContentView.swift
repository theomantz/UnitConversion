//
//  ContentView.swift
//  UnitConversions
//
//  Created by Theodore Mantz on 7/1/21.
//

import SwiftUI

struct ContentView: View {
//    Initialize state variables to hold user input values
    @State private var conversionType = 0
    @State private var inputSystem = 0
    @State private var outputSystem = 0
    
//    Initialize conversion type array
    let conversionTypes = ["Temperature", "Length", "Volume"]
    let systems = ["Metric", "Imperial"]
    let tempMeasures = ["Fahrenheit", "Celsius", "Kelvin"]
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("What type of conversion do you need?")){
                    Picker("Conversion Type", selection: $conversionType) {
                        ForEach(0 ..< conversionTypes.count) {
                            Text("\(self.conversionTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section (header: Text("Converting From")){
                    Picker("From Units", selection: $inputSystem) {
                        ForEach(0 ..< systems.count) {
                            Text("\(self.systems[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section (header: Text("Converting To")) {
                    Picker("To Units", selection: $outputSystem) {
                        ForEach(0 ..< systems.count) {
                            Text("\(self.systems[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("UnitConverter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
