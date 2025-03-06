//
//  AddInvestment.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 06/03/25.
//

import SwiftUI

struct AddInvestment_C: View {
    var body: some View {
        TextField("Identifier", text: .constant(""))
        TextField("Value", text: .constant(""))
        TextField("Qtd", text: .constant(""))
    }
}

#Preview {
    AddInvestment_C()
}
