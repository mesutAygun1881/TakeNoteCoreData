//
//  HomeViewModel.swift
//  TakeNote
//
//  Created by Mesut Aygün on 25.05.2021.
//

import SwiftUI
import CoreData

class HomeViewModel : ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    @Published var updateItem : Task!

    //yeni data sayfasını eklemek için
    @Published var isNewData = false
    
    let calender = Calendar.current
    func checkDate() -> String {
        
        if calender.isDateInToday(date) {
            return "Bugün"
        }
        else {
            return "Diğer Gün"
        }
    }
    func updateDate(value : String) {
        if value == "Bugün"{date = Date()}
        else if value == "Yarın" {
            date = calender.date(byAdding: .day, value: 1 , to: Date())!
        }
        else {
            
        }
    }
    
    func writeData(context : NSManagedObjectContext) {
        if updateItem != nil {
            updateItem.date = date
            updateItem.content = content
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
        }
        else{
            let newsTask = Task(context: context)
            newsTask.date = date
            newsTask.content = content
            
            //saving data
            
            do{
                
                try context.save()
                isNewData.toggle()
            }catch{
                
                print(error.localizedDescription)
            }
        }
        
     
    }
    
    func EditItem(item : Task) {
        updateItem = item
        date = item.date!
        content = item.content!
        isNewData.toggle()
    }
}

