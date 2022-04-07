//
//  RoomStore.swift
//  rooms
//
//  Created by Максим Варвашевич on 06.04.2022.
//

import SwiftUI
import Combine

class RoomStore : ObservableObject {
    @Published var rooms = [Room]()
    
    init(rooms: [Room] = []) {
        self.rooms = rooms
    }
    
    var didChange = PassthroughSubject<Void, Never>();
}
