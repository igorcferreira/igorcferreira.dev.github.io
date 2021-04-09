---
layout: post
category: SwiftUI
title: titles.post.dynamic_link
i18ntitle: titles.post.dynamic_link
description: descriptions.post.dynamic_link
tags: [iOS, SwiftUI]
---

Por causa de uma [thread no Twitter](https://twitter.com/thwittem/status/1143272885588549632), eu criei um [pequeno gist](https://gist.github.com/igorcferreira/b302ea59830ce1a3ee2558fa996505ea) com uma tentativa de simular o use de DynamicNavigationDestinationLink para mostrar um conteúdo carregado de uma fonte externa. Isso pode ser útil para quem está em busca da fonte de um crash.

```swift
import SwiftUI
import PlaygroundSupport

struct RootView: View {
    var body: some View {
        NavigationView {
            MainView()
        }
    }
}

struct MainView: View {
    
    let destination = DynamicNavigationDestinationLink(id: \String.self) { state in
        SecondaryView(input: state)
    }
    @State var loading: Bool = false
    
    var body: some View {
        VStack {
            Text(loading ? "Loading" : "Main View")
            if !loading {
                Button(action: self.navigate) {
                    Text("Random number")
                }
            }
        }
    }
    
    func navigate() {
        self.loading = true
        let number = (1...100).randomElement() ?? 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loading = false
            self.destination.presentedData?.value = "\(number)"
        }
    }
}

struct SecondaryView: View {
    @State var input: String
    
    var body: some View {
        Text(input)
    }
}

PlaygroundPage.current.liveView = UIHostingController(rootView: RootView())
PlaygroundPage.current.needsIndefiniteExecution = true
```

P.s.: Esse código foi feito em um Playground porque eu prefiro essa ferramenta para executar testes/exemplos de SwiftUI no Mojave.