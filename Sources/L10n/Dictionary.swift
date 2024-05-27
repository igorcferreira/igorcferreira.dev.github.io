//
//  File.swift
//  
//
//  Created by Igor Ferreira on 25/05/2024.
//

import Foundation
import Ignite

struct Dictionary {
    let locale: Locale
    
    func localised(
        _ key: String,
        context: PublishingContext
    ) -> String {
        return localised(String.LocalizationValue(key), context: context)
    }
    
    func localised(
        _ key: String.LocalizationValue,
        context: PublishingContext
    ) -> String {
        guard let url = context.url(forResource: "Localizable.bundle") else {
            return "\(key)"
        }
        return String(localized: LocalizedStringResource(
            key,
            locale: locale,
            bundle: .atURL(url)
        ))
    }
}
