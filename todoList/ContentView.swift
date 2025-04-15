import SwiftUI

struct ContentView: View {
    @State private var nouvellesTaches: [Tache] = []
    @State private var titreNouvelleTache: String = ""
    
    private let sauvegardeCle = "mesTaches"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Ajouter une tâche", text: 
                                $titreNouvelleTache)
                    .padding(10)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    Button(action: ajouterTache) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.accentColor)
                    }
                    .disabled(titreNouvelleTache
                        .trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()
                
                List {
                    ForEach(nouvellesTaches.indices, id: \.self) { index in
                        HStack {
                            Text(nouvellesTaches[index].titre)
                                .strikethrough(nouvellesTaches[index].estFaite, color: .red)
                            
                            Spacer()
                            
                            Image(systemName: nouvellesTaches[index].estFaite ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(nouvellesTaches[index].estFaite ? .black : .gray)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            nouvellesTaches[index].estFaite.toggle()
                            sauvegarder()
                        }
                    }
                    .onDelete(perform: supprimerTache)
                }
            }
            .navigationTitle("Ma Todo Liste")
            .onAppear(perform: charger)
        }
    }
    
    // MARK: Espace & Fonctions
    
    func ajouterTache() {
        guard !titreNouvelleTache.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let nouvelle = Tache(titre: titreNouvelleTache, estFaite: false)
        nouvellesTaches.append(nouvelle)
        titreNouvelleTache = ""
        sauvegarder()
    }
    
    func sauvegarder() {
        if let donnees = try? JSONEncoder().encode(nouvellesTaches) {
            UserDefaults.standard.set(donnees, forKey: sauvegardeCle)
        }
    }
    
    func charger() {
        if let donnees = UserDefaults.standard.data(forKey: sauvegardeCle) {
            if let tachesDecodees = try? JSONDecoder().decode([Tache].self, from: donnees) {
                nouvellesTaches = tachesDecodees
            }
        }
    }
    
    func supprimerTache(at offsets: IndexSet) {
        nouvellesTaches.remove(atOffsets: offsets)
        sauvegarder()
    }
}

#Preview {
    ContentView()
}
