import SwiftUI
import Swinject

enum Screen: Identifiable {
    case home
    case settings
    case onboarding
    case authorizedRoot
    case login
    case requestPermissions
    case configEditor
    case nighscoutConfig

    var id: Int { String(reflecting: self).hashValue }
}

extension Screen {
    func view(resolver: Resolver) -> AnyView {
        switch self {
        case .home:
            return Home.Builder(resolver: resolver).buildView()
        case .settings:
            return Settings.Builder(resolver: resolver).buildView()
        case .onboarding:
            return Onboarding.Builder(resolver: resolver).buildView()
        case .authorizedRoot:
            return AuthotizedRoot.Builder(resolver: resolver).buildView()
        case .login:
            return Login.Builder(resolver: resolver).buildView()
        case .requestPermissions:
            return RequestPermissions.Builder(resolver: resolver).buildView()
        case .configEditor:
            return ConfigEditor.Builder(resolver: resolver).buildView()
        case .nighscoutConfig:
            return NightscoutConfig.Builder(resolver: resolver).buildView()
        }
    }

    func tab(resolver: Resolver) -> AuthotizedRoot.Tab {
        let tabView = view(resolver: resolver)
        switch self {
        case .home:
            return .init(
                rootScreen: self,
                view: tabView,
                image: Image(systemName: "house"),
                text: Text("Home")
            )
        case .settings:
            return .init(
                rootScreen: self,
                view: tabView,
                image: Image(systemName: "gear"),
                text: Text("Settings")
            )
        case .authorizedRoot,
             .configEditor,
             .login,
             .nighscoutConfig,
             .onboarding,
             .requestPermissions:
            fatalError("Tab for this screen \(self) did not specified")
        }
    }

    func modal(resolver: Resolver) -> Main.Modal {
        .init(screen: self, view: view(resolver: resolver))
    }
}
