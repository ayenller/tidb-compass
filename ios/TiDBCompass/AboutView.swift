import SwiftUI

struct AboutView: View {
    let language: LanguageOption
    let context: PreviewContext

    var body: some View {
        NavigationStack {
            List {
                Section(copy.productSection) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("TiDB Compass")
                            .font(.system(.title2, design: .rounded, weight: .bold))
                        Text(copy.productBody)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 6)
                }

                Section(copy.contextSection) {
                    infoRow(copy.languageLabel, language.label)
                    infoRow(copy.deviceLabel, context.deviceLabel)
                    infoRow(copy.orientationLabel, context.orientationLabel)
                }

                Section(copy.roadmapSection) {
                    bulletRow(copy.roadmap1)
                    bulletRow(copy.roadmap2)
                    bulletRow(copy.roadmap3)
                }
            }
            .navigationTitle(copy.title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func infoRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
        }
    }

    private func bulletRow(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(Color.accentColor)
            Text(text)
        }
        .padding(.vertical, 2)
    }

    private var copy: AboutCopy {
        switch language {
        case .simplifiedChinese:
            return .init(
                title: "关于",
                productSection: "产品",
                productBody: "TiDB Compass 是一个面向销售、售前与伙伴场景的 iOS 演示应用原型，结合原生 SwiftUI 壳和内嵌多语言页面体验。",
                contextSection: "当前上下文",
                languageLabel: "语言",
                deviceLabel: "设备",
                orientationLabel: "方向",
                roadmapSection: "下一步建议",
                roadmap1: "补 App Icon 与 Launch Screen",
                roadmap2: "继续把更多交互从 WebView 迁到原生 SwiftUI",
                roadmap3: "整理签名、真机运行与 TestFlight 发布配置"
            )
        case .japanese:
            return .init(
                title: "情報",
                productSection: "製品",
                productBody: "TiDB Compass は営業、プリセールス、パートナー向けの iOS デモアプリ試作版で、SwiftUI シェルと多言語ページを組み合わせています。",
                contextSection: "現在の状態",
                languageLabel: "言語",
                deviceLabel: "デバイス",
                orientationLabel: "向き",
                roadmapSection: "次の提案",
                roadmap1: "App Icon と Launch Screen を追加",
                roadmap2: "WebView の操作をさらに SwiftUI へ移行",
                roadmap3: "署名、実機実行、TestFlight 配布を整備"
            )
        case .english:
            return .init(
                title: "About",
                productSection: "Product",
                productBody: "TiDB Compass is an iOS demo app prototype for sellers, presales teams, and partners, combining a native SwiftUI shell with embedded multilingual presentation content.",
                contextSection: "Current context",
                languageLabel: "Language",
                deviceLabel: "Device",
                orientationLabel: "Orientation",
                roadmapSection: "Recommended next steps",
                roadmap1: "Add App Icon and Launch Screen",
                roadmap2: "Move more interaction from WebView into native SwiftUI",
                roadmap3: "Prepare signing, device builds, and TestFlight delivery"
            )
        case .portuguese:
            return .init(
                title: "Sobre",
                productSection: "Produto",
                productBody: "TiDB Compass é um protótipo de app iOS para vendas, pré-vendas e parceiros, combinando shell nativo em SwiftUI com conteúdo multilíngue embarcado.",
                contextSection: "Contexto atual",
                languageLabel: "Idioma",
                deviceLabel: "Dispositivo",
                orientationLabel: "Orientação",
                roadmapSection: "Próximos passos recomendados",
                roadmap1: "Adicionar App Icon e Launch Screen",
                roadmap2: "Migrar mais interações do WebView para SwiftUI nativo",
                roadmap3: "Preparar assinatura, builds em dispositivo e TestFlight"
            )
        case .spanish:
            return .init(
                title: "Acerca",
                productSection: "Producto",
                productBody: "TiDB Compass es un prototipo de app iOS para ventas, preventa y partners, que combina un shell nativo en SwiftUI con contenido multilingüe embebido.",
                contextSection: "Contexto actual",
                languageLabel: "Idioma",
                deviceLabel: "Dispositivo",
                orientationLabel: "Orientación",
                roadmapSection: "Siguientes pasos recomendados",
                roadmap1: "Añadir App Icon y Launch Screen",
                roadmap2: "Mover más interacción del WebView a SwiftUI nativo",
                roadmap3: "Preparar firma, builds en dispositivo y entrega por TestFlight"
            )
        }
    }
}

private struct AboutCopy {
    let title: String
    let productSection: String
    let productBody: String
    let contextSection: String
    let languageLabel: String
    let deviceLabel: String
    let orientationLabel: String
    let roadmapSection: String
    let roadmap1: String
    let roadmap2: String
    let roadmap3: String
}
