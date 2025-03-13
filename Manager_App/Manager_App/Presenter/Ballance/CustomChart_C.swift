//
//  Graphic_C.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 13/03/25.
//
import SwiftUI

struct CustomChart_C: View {
    @Binding var data: [Investment]
    @State private var selectedType: String? = nil
    
    var total: Double {
        data.reduce(0) { $0 + $1.value }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.main1)
//                .opacity(0.5)
            
            HStack {
                ZStack {
                    ForEach(getSlices(), id: \.0.id) { invested, startAngle, endAngle in
                        PieSliceShape(startAngle: startAngle, endAngle: endAngle)
                            .fill(invested.color)
                            .scaleEffect(selectedType == nil || selectedType == invested.type ? 1 : 0.8)
                            .animation(.spring(), value: selectedType)
                            .onTapGesture {
                                selectedType = selectedType == invested.type ? nil : invested.type
                            }
                    }
                    
                    if let selected = selectedType, let invested = data.first(where: { $0.type == selected }) {
                        Text("\(invested.type) \(invested.symbol.rawValue)\(Int(invested.value))")
                            .foregroundStyle(.main3)
                            .font(.headline)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.backGround.opacity(0.9)))
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                
                LegendGridView(data: data)
            }
            .padding()
        }
    }
    
    func getSlices() -> [(Investment, Angle, Angle)] {
        var slices: [(Investment, Angle, Angle)] = []
        var startAngle = Angle.degrees(0)
        
        for invested in data {
            let endAngle = startAngle + Angle.degrees((invested.value / total) * 360)
            slices.append((invested, startAngle, endAngle))
            startAngle = endAngle
        }
        return slices
    }
}

struct PieSliceShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var innerRadiusRatio: CGFloat = 0.6
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * innerRadiusRatio
        
        let startOuter = CGPoint(
            x: center.x + outerRadius * cos(CGFloat(startAngle.radians)),
            y: center.y + outerRadius * sin(CGFloat(startAngle.radians))
        )
        
        let endInner = CGPoint(
            x: center.x + innerRadius * cos(CGFloat(endAngle.radians)),
            y: center.y + innerRadius * sin(CGFloat(endAngle.radians))
        )
        
        
        path.move(to: startOuter)
        path.addArc(center: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addLine(to: endInner)
        path.addArc(center: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: true)
        path.addLine(to: startOuter)
        path.closeSubpath()
        
        return path
    }
}


struct LegendGridView: View {
    let data: [Investment]
    
    let columns = [
        GridItem(),GridItem()
    ]
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.main3)
            
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(data) { item in
                    HStack {
                        Rectangle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(item.color)
                            .cornerRadius(2)
                        
                        Text(item.type)
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .scaledToFit()
                    .foregroundStyle(.backGround2)
//                    .padding(8)
                }
            }
            .scaledToFit()
        }
        .scaledToFit()
    }
}

#Preview {
    CustomChart_C(data: .constant([
        .init(type: "BTC", value: 10, color: .red),
        .init(type: "ETH", value: 40, color: .blue),
        .init(type: "CDB", value: 12, color: .green),
        .init(type: "Stocks", value: 50, color: .orange),
        .init(type: "NFT", value: 30, color: .purple),
    ]))
}

#Preview {
    Balance_V()
}
