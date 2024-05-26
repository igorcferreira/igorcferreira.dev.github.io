import Foundation
import Ignite
import ArkanaKeys

struct MyTheme: Theme {
    func render(page: Page, context: PublishingContext) -> HTML {
        HTML {
            Head(for: page, in: context) {
                MetaLink(href: "/css/sidebar.css", rel: .stylesheet)
                MetaLink(href: URL("/apple-touch-icon-precomposed.png"), rel: "apple-touch-icon")
                MetaTag(name: "apple-mobile-web-app-title", content: context.site.name)
                Script(file: URL("/script/theme.js"))
            }
            Body {
                TopBar(for: page)
                
                Group {
                    page.body
                    IgniteFooter()
                }
                .class("content")
            }
            .addCustomAttribute(name: "data-bs-theme", value: "auto")
        }
    }
}
