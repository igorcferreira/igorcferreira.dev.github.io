import Foundation
import Ignite

protocol LocalizablePage: StaticPage {
    var locale: Locale { get }
    var path: String { get }
    var dictionary: Dictionary { get }
    
    init(locale: Locale)
}

extension LocalizablePage {
    var dictionary: Dictionary { Dictionary(locale: locale) }
}

struct Home: LocalizablePage {
    let title: String = "Home"
    let locale: Locale
    let path: String
    
    init(locale: Locale) {
        self.locale = locale
        self.path = "/\(locale.identifier)/"
    }
    
    func body(context: PublishingContext) -> [BlockElement] {
        if let content = context.content(ofType: locale.identifier).sorted(by: \.date, order: .reverse).first {
            return Story().body(content: content, context: context)
        } else {
            return []
        }
    }
}
