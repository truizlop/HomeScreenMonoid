import Bow

struct App: Equatable {
    let name: String
}

enum HomeScreenItem: Equatable {
    case nothing
    case single(App)
    case group(NEA<App>, title: String)
}

extension HomeScreenItem: Semigroup {
    func combine(_ other: HomeScreenItem) -> HomeScreenItem {
        switch (self, other) {
        case (_, .nothing): return self
        case (.nothing, _): return other
        
        case let (.single(left), .single(right)):
            return .group(NEA.of(left, right), title: "")
            
        case let (.single(app), .group(nea, title: title)):
            return .group(NEA.of(app) + nea, title: title)
            
        case let (.group(nea, title: title), .single(app)):
            return .group(nea + NEA.of(app), title: title)
            
        case let (.group(left, title: leftTitle), .group(right, title: rightTitle)):
            return .group(left + right, title: leftTitle + rightTitle)
        }
    }
}

extension HomeScreenItem: Monoid {
    static func empty() -> HomeScreenItem {
        .nothing
    }
}
