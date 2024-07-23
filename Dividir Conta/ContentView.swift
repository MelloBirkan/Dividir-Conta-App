//
//  ContentView.swift
//  Dividir Conta
//
//  Created by Marcello Gonzatto Birkan on 22/07/24.
//

import SwiftUI

struct ContentView: View {
  @State private var checkAmount = 0.0
  @State private var numberOfPeople = 0
  @State private var tipPercentage = 0
  @State private var isTip = false
  
  @FocusState private var amountIsFocused: Bool
  
  let tipPercentages = Array(1...100)
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)
    let tipValue = (checkAmount / 100) * tipSelection
    let grandTotal = checkAmount + tipValue
    
    return grandTotal / peopleCount
  }
  var body: some View {
    NavigationStack {
      Form {
        Section {
          TextField("Quantia", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "brl"))
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
          
          Picker("Número de pessoas", selection: $numberOfPeople) {
            ForEach(2..<100) {
              Text("\($0) pessoas")
            }
          }
        }
        
        
        if isTip {
          Section("Quanto de gorjeta você quer deixar?") {
            Picker("Porcentagem da gorjeta", selection: $tipPercentage) {
              ForEach(tipPercentages, id: \.self) {
                Text($0, format: .percent)
              }
            }
            .pickerStyle(.navigationLink)
            
            Button("Não deixar gorjeta") {
              withAnimation {
                isTip.toggle()
                tipPercentage = 0
              }
            }
            }
          
          Section("Total com a gorjeta") {
            Text((totalPerPerson * Double(numberOfPeople + 2)), format: .currency(code: Locale.current.currency?.identifier ?? "brl"))
          }
          
        } else {
          Button("Deixar gorjeta") {
            withAnimation {
              tipPercentage = 10
              isTip.toggle()
            }
          }
        }
        
        
        
        Section("Quantidade por pessoa") {
          withAnimation {
            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "brl"))
          }
        }
        
        
      }
      .navigationTitle("Divide Aí")
      .toolbar {
        if amountIsFocused {
          Button("Feito") {
            amountIsFocused = false
          }
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
