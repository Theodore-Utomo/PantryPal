import SwiftUI

struct ContentView: View {
    @State private var recipesVM = RecipeViewModel()
    @State private var selectedTab: Tab = .recipes
    
    enum Tab {
        case recipes
        case favorites
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabContent(selectedTab: selectedTab)
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct TabContent: View {
    @State var recipesVM = RecipeViewModel()
    let selectedTab: ContentView.Tab
    
    var body: some View {
        switch selectedTab {
        case .recipes:
            NavigationStack {
                List(recipesVM.recipes) { recipe in
                    Text(recipe.title)
                        .font(.title2)
                }
                .listStyle(.plain)
                .navigationTitle("Recipes")
                .task {
                    await recipesVM.getData()
                }
            }
        case .favorites:
            NavigationStack {
                Text("Favorites")
                    .font(.title)
                    .navigationTitle("Favorites")
            }
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: ContentView.Tab
    
    var body: some View {
        HStack {
            Spacer()
            
            // Recipes Tab Button
            Button(action: {
                selectedTab = .recipes
            }) {
                VStack {
                    Image(systemName: "book.fill")
                    Text("Recipes")
                }
            }
            .foregroundStyle(selectedTab == .recipes ? .blue : .gray)
            
            Spacer()
            
            // Favorites Tab Button
            Button(action: {
                selectedTab = .favorites
            }) {
                VStack {
                    Image(systemName: "star.fill")
                    Text("Favorites")
                }
            }
            .foregroundStyle(selectedTab == .favorites ? .blue : .gray)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(Capsule())
        .shadow(radius: 10)
    }
}

#Preview {
    ContentView()
}
