//
//  Home.swift
//  Notas
//
//  Created by Luis Angel Torres G on 18/11/22.
//

import SwiftUI

struct Home: View {
    @StateObject var model = ViewModel()
//    @FetchRequest(
//        entity: Notas.entity(),
//        sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)],
//        animation: .spring()
//    ) var results: FetchedResults<Notas>
    @FetchRequest(
        entity: Notas.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(
            format: "nota CONTAINS[c] 'IMPORTANTE'",
            Date() as CVarArg
        ),
        animation: .spring()
    ) var results: FetchedResults<Notas>

    var body: some View {
        NavigationView {
            List {
                ForEach(results) { item in
                    VStack(alignment: .leading) {
                        Text(item.nota ?? "Sin nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(
                        ContextMenu(menuItems: {
                            Button(action: {
                                model.sendData(item: item)
                            }) {
                                Label(title: {
                                    Text("Editar")
                                }, icon: {
                                    Image(systemName: "pencil")
                                })
                            }
                            Button(action: { }) {
                                Label(title: {
                                    Text("Eliminar")
                                }, icon: {
                                    Image(systemName: "trash")
                                })
                            }
                        })
                    )
                }
            }.navigationBarTitle("Notas")
                .navigationBarItems(
                trailing: Button(action: {
                    model.nota = ""
                    model.fecha = Date()
                    model.updateItem = nil
                    model.show.toggle()
                }) {
                    Image(systemName: "plus").font(.title).foregroundColor(.blue)
                }
            ).sheet(isPresented: $model.show, content: {
                AddView(model: model)
            })
        }
    }
}
