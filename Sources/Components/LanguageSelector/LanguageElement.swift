//
//  File.swift
//  
//
//  Created by Igor Ferreira on 26/05/2024.
//

import Foundation
import Ignite

struct LanguageElement: InlineElement {
    var attributes: CoreAttributes
    let isActive: Bool
    let target: String
    let locale: Locale
    
    init(
        for page: Page,
        locale: Locale
    ) {
        self.isActive = page.locale.identifier == locale.identifier
        self.locale = locale
        self.target = page.url(for: locale)
        self.attributes = page.body.attributes
    }
    
    func render(context: PublishingContext) -> String {
        Link(target: target) {
            Image(locale.flag, description: locale.description)
                .class("language-icon")
        }
        .render(context: context)
    }
}

extension Locale {
    var flag: String {
        if identifier == "en" {
            "/images/flag_uk.svg"
        } else {
            "/images/flag_brazil.svg"
        }
    }
    var description: String? {
        localizedString(forIdentifier: identifier)
    }
}

extension Page {
    func url(for locale: Locale) -> String {
        guard self.locale.identifier != locale.identifier else {
            return url.path()
        }
        
        if url.pathComponents.count > 1 {
            var newComponents = url.pathComponents
            newComponents.removeFirst()
            newComponents[0] = locale.identifier
            newComponents = newComponents
                .map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
                .filter({ !$0.isEmpty && $0 != "/" })
            return "/\(newComponents.joined(separator: "/"))"
        } else {
            return "/\(locale.identifier)"
        }
    }
}
