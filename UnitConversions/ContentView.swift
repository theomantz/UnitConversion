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
    @State private var inputUnits = 0
    @State private var outputUnits = 0
    @State private var input = ""
    
//    Initialize conversion type array
    let conversionTypes = ["Temperature", "Length", "Volume"]
    let systems = ["Metric", "Imperial"]
    let measures = [
        [["Celsius"], ["Fahrenheit"]],
        [["Meter", "Kilometer"], ["Foot", "Yard", "Mile"]],
        [["Millileter", "Liter"], ["Pint", "Quart", "Gallon"]]
    ]
    
    var output: Double {
        let type = conversionTypes[conversionType]
        let iSystem = systems[inputSystem]
        let oSystem = systems[outputSystem]
        let iUnit = measures[conversionType][inputSystem][inputUnits]
        let oUnit = measures[conversionType][inputSystem][inputUnits]
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Conversion Type")){
                    Picker("Conversion Type", selection: $conversionType) {
                        ForEach(0 ..< conversionTypes.count) {
                            Text("\(self.conversionTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section (header: Text("Converting From")){
                    Picker("From System", selection: $inputSystem) {
                        ForEach(0 ..< systems.count) {
                            Text("\(self.systems[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("Input Units", selection: $inputUnits) {
                        ForEach(0 ..< measures[conversionType][inputSystem].count) {
                            Text("\(self.measures[conversionType][inputSystem][$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("Input", text: $input)
                        .keyboardType(.decimalPad)
                }
                Section (header: Text("Converting To")) {
                    Picker("To System", selection: $outputSystem) {
                        ForEach(0 ..< systems.count) {
                            Text("\(self.systems[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("Output Units", selection: $outputUnits) {
                        ForEach(0 ..< measures[conversionType][outputSystem].count) {
                            Text("\(self.measures[conversionType][outputSystem][$0])")
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
