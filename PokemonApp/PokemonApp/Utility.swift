//
//  Utility.swift
//  PokemonApp
//
//  Created by Admin on 10/05/2022.
//

import Foundation
import SwiftUI

struct TextView: View {
    enum Heading: String {
        case name
        case weight
        case height
        case baseExperience = "Base Experience"
        case types
        case dateAdded = "Date Added"
        
        var stringValue: String {
            rawValue.capitalized
        }
    }
    
    let heading: Heading
    let value: String
    var fontWeight: Font.Weight = .bold
    var font: Font = .system(size: 18.0)
    var color: Color = .black
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 5.0) {
            Text("\(heading.stringValue): ").font(.system(size: 12.0)).fontWeight(.thin)
            Text(value.capitalized).fontWeight(fontWeight).font(font).foregroundColor(color)
        }
    }
}


struct CapsuleShapedButton: View {
    let label: String
    let color: Color
    let action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.all, 12)
                .background(color)
                .clipShape(Capsule())
        }
    }
}

struct HeadingText: View {
    let title: String
    
    var body: some View {
        Text(title.capitalized)
            .font(.system(size: 24.0))
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.gray)
    }
}
