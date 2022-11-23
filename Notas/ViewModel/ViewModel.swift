//
//  ViewModel.swift
//  Notas
//
//  Created by Luis Angel Torres G on 18/11/22.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!

    //CoreData
    func saveData(context: NSManagedObjectContext) {
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha

        do {
            try context.save()
            print("guardado")
            show.toggle()
        } catch let error as NSError {
            print("No guardó", error.localizedDescription)
        }
    }
    
    func deleteData(item: Notas, context: NSManagedObjectContext){
        context.delete(item)
        do{
            try context.save()
        }catch let error as NSError {
            print("Ocurrió error: ", error.localizedDescription)
        }
        
    }
    
    func sendData (item: Notas){
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    func editData(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("Editó exitosamente")
            show.toggle()
        } catch let error as NSError {
            print("error: ", error.localizedDescription)
        }
    }
}
