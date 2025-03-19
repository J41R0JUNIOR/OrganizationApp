//
//  AddButton_C.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 18/03/25.
//

import SwiftUI

struct AddButton_C: View {
    @State private var showOptions: Bool = false
    @State private var showAddInvestment: Bool = false
    @State private var showAddWallet: Bool = false

    var body: some View {
        ZStack {
            if showOptions {
                VStack(spacing: 20) {
                  
                    HStack {
                        
                        Button {
                            showAddWallet = true
                            showOptions = false
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.backGround1)
                                    .shadow(radius: 1.5)
                           
                                Image(systemName: "wallet.bifold")
                            }
                            .frame(width: 40, height: 40)
                        }
                        
                        Spacer()
                        
                        Button {
                            showAddInvestment = true
                            showOptions = false
                        } label: {
                    
                            ZStack {
                                Circle()
                                    .foregroundStyle(.backGround1)
                                    .shadow(radius: 1.5)
                           
                                Image(systemName: "dollarsign")
                            }
                            .frame(width: 40, height: 40)
                        }
                    }
                    .font(.callout)
                    .aspectRatio(0,contentMode: .fit)
                    
                    Button {
                        showOptions = false
                    } label: {
                      
                        Image(systemName: "xmark.circle.fill")
                    }
                    .foregroundStyle(.red)
                }
                
            } else {
                Button {
                    showOptions = true
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                       
                }
                .transition(.opacity.combined(with: .scale))
            }
        }
        .font(.largeTitle)
        .foregroundStyle(.main3)
        
        .sheet(isPresented: $showAddInvestment) {
            AddInvestment_V(isPresented: $showAddInvestment)
        }
        .sheet(isPresented: $showAddWallet) {
            AddWallet_V(isPresented: $showAddWallet)
        }
        
        .task {
            self.showOptions = false
        }
    }
}

#Preview {
    AddButton_C()
}

#Preview {
    Balance_V()
}

