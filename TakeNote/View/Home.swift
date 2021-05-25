//
//  Home.swift
//  TakeNote
//
//  Created by Mesut Aygün on 25.05.2021.
//

import SwiftUI

struct Home: View {
    
    @StateObject var homeData = HomeViewModel()
    //fetch data
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key : "date",ascending : true)],animation: .spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var viewContext
    var body: some View {
        
        ZStack(alignment : Alignment(horizontal: .trailing, vertical: .bottom), content : {
            VStack{
                HStack{
                    Text("Görevler")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                ScrollView(.vertical , showsIndicators : false , content:{
                    LazyVStack(alignment: .leading , spacing : 20) {
                        ForEach(results) { task in
                            VStack(alignment : .leading, spacing : 5 , content : {
                                Text(task.content ?? "")
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                Text(task.date ?? Date(),style:  .date)
                                    .fontWeight(.bold)
                            })
                            .foregroundColor(.black)
                            .contextMenu{
                                Button(action: {
                                    homeData.EditItem(item: task)
                                }, label: {
                                    Text("Edit")
                                })
                                
                                Button(action: {
                                    viewContext.delete(task)
                                    try! viewContext.save()
                                }, label: {
                                    Text("Delete")
                                })
                            }
                        }
                    }
                    .padding()
                })
            }
            Button(action: {homeData.isNewData.toggle()}, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                    AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .center)
                    )
                    .clipShape(Circle())
            })
            .padding()
        })
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all , edges: .all))
        
       
        .sheet(isPresented: $homeData.isNewData, content: {
            NewDataView(homeData: homeData)
        })
    }


}
