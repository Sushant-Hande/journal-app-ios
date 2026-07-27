import Playgrounds
import SwiftUI

@main struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {

    @State private var navigationPath: [AppScreen] = []

    var body: some View {

        NavigationStack(path: $navigationPath) {

            // Default screen
            LoginView(path: $navigationPath)

                .navigationDestination(for: AppScreen.self) { screen in
                    switch screen {
                    case .signUp:
                        SignUpView(path: $navigationPath)
                    }
                }
        }

    }
}

enum AppScreen: Hashable {
    case signUp
}

#Preview {
    ContentView()
}
