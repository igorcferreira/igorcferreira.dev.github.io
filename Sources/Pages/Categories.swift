//
//  File.swift
//  
//
//  Created by Igor Ferreira on 27/05/2024.
//

import Foundation
import Ignite

struct Categories: LocalizablePage {
    let title: String = "Categories"
    let locale: Locale
    let path: String
    
    init(locale: Locale) {
        self.locale = locale
        self.path = "/\(locale.identifier)/categories"
    }
    
    func body(context: PublishingContext) async -> [any BlockElement] {
        let map = context.categories(for: locale)
        Group {
            for key in map.keys {
                Group {
                    Group {
                        Button(key)
                            .class("btn")
                            .data("toggle", "collapse")
                            .data("target", "#group-\(key)")
                            .aria("expanded", "true")
                            .aria("controls", "group-\(key)")
                    }
                    .id("heading-\(key)")
                    .class("card-header")
                    
                    Group {
                        Group {
                            for content in map[key] ?? [] {
                                Link(target: content.path) {
                                    Text(content.title)
                                }
                            }
                        }
                        .class("card-body")
                    }
                    .id("group-\(key)")
                    .class("collapse", "show")
                    .aria("labelledby", "heading-\(key)")
                    .data("parent", "#accordion")
                }
                .class("card")
                .style("margin: .5em")
            }
        }
        .class("accordion")
    }
}

extension PublishingContext {
    func categories(for locale: Locale) -> [String: [Content]] {
        let tags: [String] = content(ofType: locale.identifier)
            .flatMap({ $0.tags })
        var contentMap = [String: [Content]]()
        for tag in tags {
            contentMap[tag] = content(ofType: locale.identifier)
                .filter({ $0.tags.contains([tag]) })
        }
        return contentMap
    }
}
