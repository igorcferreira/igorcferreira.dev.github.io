//
//  File.swift
//  
//
//  Created by Igor Ferreira on 25/05/2024.
//

import Foundation
import Ignite

struct TopBar: Component {
    let page: Page
    
    init(for page: Page) {
        self.page = page
    }
    
    func body(context: PublishingContext) -> [any PageElement] {
        NavigationBar {
            LanguageSelector(attributes: page.body.attributes) {
                LanguageElement(
                    for: page,
                    locale: Locale(identifier: "en")
                )
                .class("sidebar-nav-item")
                
                LanguageElement(
                    for: page,
                    locale: Locale(identifier: "pt-BR")
                )
                .class("sidebar-nav-item")
            }.class("sidebar-nav-item")
            Link(page.dictionary.localised("Home", context: context), target: Home(locale: page.locale))
                .class("sidebar-nav-item")
            Link(page.dictionary.localised("Categories", context: context), target: Categories(locale: page.locale))
                .class("sidebar-nav-item")
            Link(page.dictionary.localised("Mastodon", context: context), target: "https://mastodon.social/@igorcferreira")
                .relationship(.me)
                .class("sidebar-nav-item")
        }
        .class("sidebar", "sidebar-nav")
    }
}

extension Page {
    var dictionary: Dictionary {
        Dictionary(locale: locale)
    }
    var locale: Locale {
        url.locale
    }
}

extension URL {
    var locale: Locale {
        return if pathComponents.count > 1 {
            Locale(identifier: pathComponents[1])
        } else {
            Locale(identifier: "en")
        }
    }
}
