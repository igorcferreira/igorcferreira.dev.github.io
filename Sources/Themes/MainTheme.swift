import Foundation
import Ignite
import ArkanaKeys

struct MyTheme: Theme {
    func render(page: Page, context: PublishingContext) -> HTML {
        HTML {
            Head(for: page, in: context) {
                MetaLink(href: "/css/sidebar.css", rel: .stylesheet)
                MetaLink(href: "/css/prism-default-dark.css", rel: .stylesheet)
                Script(file: URL("/script/theme.js"))   
                Script(file: URL("/script/syntax-highlighting.js"))
                MetaLink(href: URL("/apple-touch-icon-precomposed.png"), rel: "apple-touch-icon")
                MetaLink(href: URL("https://mastodon.social/@igorcferreira"), rel: "me")
                MetaTag(name: "apple-mobile-web-app-title", content: context.site.name)
                MetaTag(name: "fediverse:creator", content: "@igorcferreira@mastodon.social")
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
