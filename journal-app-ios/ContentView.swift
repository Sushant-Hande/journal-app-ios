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

    @State private var authViewModel: AuthViewModel = AuthViewModel(
        authRepository: AuthRepositoryImpl(
            networkServiceProtocol: NetworkManager()
        )
    )

    var body: some View {

        NavigationStack(path: $navigationPath) {

            // Default screen
            SplashView(path: $navigationPath)

                .navigationDestination(for: AppScreen.self) { screen in
                    switch screen {
                    case .login:
                        LoginView(path: $navigationPath)
                    
                    case .signUp:
                        SignUpView(path: $navigationPath)
                   
                    case .dashboard:
                        DashboardView()
                    }
                }
        }
        .environment(authViewModel)
    }
}

enum AppScreen: Hashable {
    case login
    case signUp
    case dashboard
}

#Preview {
    ContentView()
}
