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
    
    var groupedInvestments: [(type: String, totalValue: Double, color: String)] {
        let groupedDict = Dictionary(grouping: data) { $0.type }
        
        return groupedDict.map { type, investments in
            let totalValue = investments.reduce(0) { $0 + $1.value }
            
            switch TypesInvesment(rawValue: type)! {

                case .bonds:
                    return (type, totalValue, Color.red.toHex())
                case .stocks:
                    return (type, totalValue, Color.green.toHex())
                case .commodities:
                    return (type, totalValue, Color.yellow.toHex())
                case .cryptos:
                    return (type, totalValue, Color.orange.toHex())
                case .reits:
                    return (type, totalValue, Color.blue.toHex())
            }
        }
        .sorted { $0.type < $1.type } 
    }
    
    var total: Double {
        groupedInvestments.reduce(0) { $0 + $1.totalValue }
    }
    
    var body: some View {
        if !groupedInvestments.isEmpty {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.main1)
                
                HStack {
                    ZStack {
                        ForEach(getSlices(), id: \.0) { type, startAngle, endAngle, color in
                            PieSliceShape(startAngle: startAngle, endAngle: endAngle)
                                .fill(Color(hex: color))
                                .scaleEffect(selectedType == nil || selectedType == type ? 1 : 0.8)
                                .animation(.spring(), value: selectedType)
                                .onTapGesture {
                                    selectedType = selectedType == type ? nil : type
                                }
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    
                    VStack {
                        Spacer()
                        if let selected = selectedType {
                            if let category = groupedInvestments.first(where: { $0.type == selected }) {
                                Text("\(category.type) \(Int(category.totalValue))")
                                    .foregroundStyle(.main3)
                                    .font(.headline)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.backGround.opacity(0.9)))
                            }
                        }
                        
                        LegendGridView(data: groupedInvestments)
                    }
                }
                .padding()
            }
        }
    }
    
    func getSlices() -> [(String, Angle, Angle, String)] {
        var slices: [(String, Angle, Angle, String)] = []
        var startAngle = Angle.degrees(0)
        
        for investment in groupedInvestments {
            let endAngle = startAngle + Angle.degrees((investment.totalValue / total) * 360)
            slices.append((investment.type, startAngle, endAngle, investment.color))
            startAngle = endAngle
        }
        return slices
    }
}

struct LegendGridView: View {
    let data: [(type: String, totalValue: Double, color: String)]
    
    let columns = [
        GridItem(), GridItem()
    ]
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.main3)
            
            LazyVGrid(columns: columns, spacing: 1) {
                ForEach(data, id: \.type) { item in
                    HStack {
                        Rectangle()
                            .frame(width: 12, height: 12)
                            .foregroundColor(Color(hex: item.color))
                            .cornerRadius(2)
                        
                        Text(item.type)
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    .scaledToFit()
                    .foregroundStyle(.backGround2)
                }
            }
            .scaledToFit()
        }
        .scaledToFit()
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

#Preview {
    Balance_V()
}
