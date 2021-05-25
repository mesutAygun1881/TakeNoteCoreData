//
//  DateButton.swift
//  TakeNote
//
//  Created by Mesut Aygün on 25.05.2021.
//

import SwiftUI

struct DateButton: View {
    var title : String
    @ObservedObject var homeData : HomeViewModel
    var body: some View {
        Button(action: {homeData.updateDate(value: title)}, label: {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(homeData.checkDate() == title ? .white : .gray)
                .padding(.vertical , 10)
                .padding(.horizontal , 20)
                .background(
                    homeData.checkDate() == title ?
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .leading
                               , endPoint: .trailing)
                    : LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(7)
        })
    }
}

