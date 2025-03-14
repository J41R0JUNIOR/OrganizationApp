//
//  AddInvestment.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 14/03/25.
//

import SwiftUI

struct AddInvestment: View {
    @State private var selectedType: TypesInvesment = .stocks
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("Add Investment")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                }
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(.backGround2)
                    
                    HStack {
                        ForEach(TypesInvesment.allCases, id: \.self) { type in
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedType == type ? Color.white : Color.clear)
//                                    .animation(.smooth, value: selectedType)
                                
                                
                                Text(type.rawValue.capitalized)
                                    .font(.caption)
                                    .foregroundStyle(.backGround)
                                
                                    .onTapGesture {
                                        selectedType = type
                                    }
                            }
                        }
                    }.padding(3)
                }
                
                .aspectRatio(12, contentMode: .fit)
                TextField("Name", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                
                TextField("Value", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .keyboardType(.numberPad)
                
                Spacer()
                
                
            }
            .padding()
        }
        .foregroundStyle(.white)
        .background(Color.backGround)
    }
}

#Preview {
    AddInvestment()
}

