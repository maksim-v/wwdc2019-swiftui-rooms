//
//  ContentView.swift
//  rooms
//
//  Created by Максим Варвашевич on 06.04.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store = RoomStore()
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button(action: addRoom) {
                        Text("Add room")
                    }
                }
                
                Section {
                    ForEach(store.rooms) { room in
                        RoomCell(room: room)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                }
            }
            .navigationBarTitle(Text("Rooms"))
            .navigationBarItems(trailing: EditButton())
            .listStyle(.grouped)
        }
    }
    
    func addRoom() {
        store.rooms.append(Room(name: "Hall 2", capacity: 2000))
    }
    
    func delete(at offsets: IndexSet) {
        store.rooms.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        store.rooms.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(store: RoomStore(rooms: testData))
            
            ContentView(store: RoomStore(rooms: testData))
                .environment(\.sizeCategory, .extraExtraExtraLarge)
            
            ContentView(store: RoomStore(rooms: testData))
                .environment(\.colorScheme, .dark)
        }
    }
}

struct RoomCell: View {
    let room: Room;
    
    var body: some View {
        NavigationLink(destination: RoomDetail(room: room)) {
            Image(room.thumbnailName).resizable()
                .frame(width: 40.0, height: 40.0).cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text(room.name)
                Text("\(room.capacity) people")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
