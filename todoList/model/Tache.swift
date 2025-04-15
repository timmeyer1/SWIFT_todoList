//
//  Tache.swift
//  todoList
//
//  Created by Stagiaire on 15/04/2025.
//

import Foundation

struct Tache: Identifiable {
    let id = UUID()
    var titre: String
    var estFaite: Bool
}
