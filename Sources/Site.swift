import Foundation
import Ignite
import ArkanaKeys

@main
struct IgniteWebsite {
    static func main() async {
        let site = ExampleSite()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ExampleSite: Site {
    var name = ArkanaKeys.Global().siteName
    var url = URL(string: ArkanaKeys.Global().hostname)!
    var builtInIconsEnabled = true
    var author = ArkanaKeys.Global().authorName
    var favicon = URL(string: "/favicon.ico")
    
    var homePage = Home(locale: Locale.init(identifier: "en"))
    var theme = MyTheme()
    var robotsConfiguration = Robots()
    
    var pages: [any StaticPage] {
        return ExampleSite.build(pages: [
            Home.self,
            Categories.self
        ], locales: [
            Locale(identifier: "en"),
            Locale(identifier: "pt-BR")
        ])
    }
    
    var layouts: [any ContentPage] {
        Story()
    }
    
    static func build(
        pages: [any LocalizablePage.Type],
        locales: [Locale]
    ) -> [any StaticPage] {
        locales.flatMap({ locale in
            pages.map({ $0.init(locale: locale) })
        })
    }
}


