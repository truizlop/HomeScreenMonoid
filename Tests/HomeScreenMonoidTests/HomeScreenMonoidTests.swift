import XCTest
import SwiftCheck
import Bow
import BowGenerators
import BowLaws
@testable import HomeScreenMonoid

extension String {
    static var nonEmptyArbitrary: Gen<String> {
        String.arbitrary.suchThat(not <<< \.isEmpty)
    }
}

extension App: Arbitrary {
    public static var arbitrary: Gen<App> {
        String.nonEmptyArbitrary.map(App.init)
    }
}

extension HomeScreenItem: Arbitrary {
    public static var arbitrary: Gen<HomeScreenItem> {
        let nothingGen = Gen<HomeScreenItem>.pure(.nothing)
        let singleGen = App.arbitrary.map(HomeScreenItem.single)
        let groupGen = Gen.zip(
            NEA<App>.arbitrary,
            String.nonEmptyArbitrary
        ).map(HomeScreenItem.group)
        
        return Gen.one(of: [nothingGen, singleGen, groupGen])
    }
}

final class HomeScreenMonoidTests: XCTestCase {
    func testSemigroupLaws() {
        SemigroupLaws<HomeScreenItem>.check()
    }
    
    func testMonoidLaws() {
        MonoidLaws<HomeScreenItem>.check()
    }
}
