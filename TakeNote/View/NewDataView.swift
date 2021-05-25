//
//  NewDataView.swift
//  TakeNote
//
//  Created by Mesut Aygün on 25.05.2021.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var viewContext
    var body: some View {
        VStack{
            HStack{
                Text("\(homeData.updateItem == nil ? "" : "Düzenle" ) Yeni Görev Ekle")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundColor(.red)
                Spacer(minLength: 0)
            }
            .padding()
            Divider()
                .padding(.horizontal)
            .padding()
            TextEditor(text: $homeData.content)
                .padding()
            Divider()
                .padding(.horizontal)
            HStack{
                Text("Tarih")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack{
                DateButton(title: "Bugün", homeData: homeData)
                
                DateButton(title: "Yarın", homeData: homeData)
                    
                DatePicker("", selection : $homeData.date, displayedComponents : .date)
                    .labelsHidden()
            }
            .padding()
            
            
            Button(action: {homeData.writeData(context: viewContext)}, label: {
                Label(
                    title: { Text(homeData.updateItem == nil ? "Şimdi Ekle" : "Düzenle")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.white)
                    }
                    )
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 30)
                .background(
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)
                )
                .cornerRadius(8)
            }).padding()
            
            //disabling button when no data
            .disabled(homeData.content == "" ? true : false)
            .opacity(homeData.content == "" ? 0.5 : 1)
            
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all , edges: .bottom))
    }
}

