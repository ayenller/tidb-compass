import SwiftUI
import UIKit

struct ContentView: View {
    @AppStorage("tidb_compass_language") private var selectedLanguage = LanguageOption.simplifiedChinese.rawValue
    @State private var reloadKey = UUID()
    @State private var showingSettings = false
    @State private var selectedTab: RootTab = .preview

    var body: some View {
        GeometryReader { proxy in
            let context = PreviewContext(
                lang: selectedLanguage,
                device: UIDevice.current.userInterfaceIdiom == .pad ? "ipad" : "iphone",
                orientation: proxy.size.width > proxy.size.height ? "landscape" : "portrait"
            )

            TabView(selection: $selectedTab) {
                previewScreen(context: context, width: proxy.size.width)
                    .tabItem {
                        Label(languageCopy.previewTab, systemImage: "safari")
                    }
                    .tag(RootTab.preview)

                AboutView(language: languageCopy, context: context)
                    .tabItem {
                        Label(languageCopy.aboutTab, systemImage: "info.circle")
                    }
                    .tag(RootTab.about)
            }
            .tint(.accentColor)
            .sheet(isPresented: $showingSettings) {
                SettingsView(
                    selectedLanguage: $selectedLanguage,
                    reloadAction: { reloadKey = UUID() },
                    currentContext: context
                )
            }
        }
    }

    @ViewBuilder
    private func previewScreen(context: PreviewContext, width: CGFloat) -> some View {
        NavigationStack {
            VStack(spacing: 0) {
                header(context: context, width: width)
                Divider()
                CompassWebView(context: context, reloadKey: reloadKey)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }

    @ViewBuilder
    private func header(context: PreviewContext, width: CGFloat) -> some View {
        let compact = width < 720

        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("TiDB Compass")
                        .font(.system(size: compact ? 28 : 34, weight: .bold, design: .rounded))

                    Text(languageCopy.badge)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.secondary)
                }

                Spacer(minLength: 0)

                if compact {
                    compactActions
                } else {
                    regularActions
                }
            }

            if compact {
                statusRow(context: context)
            } else {
                HStack(spacing: 12) {
                    statusPill(title: languageCopy.deviceTitle, value: context.deviceLabel)
                    statusPill(title: languageCopy.orientationTitle, value: context.orientationLabel)
                    statusPill(title: languageCopy.languageTitle, value: languageCopy.name)
                }
            }
        }
        .padding(.horizontal, compact ? 18 : 24)
        .padding(.top, compact ? 14 : 18)
        .padding(.bottom, 14)
        .background(.ultraThinMaterial)
    }

    private var compactActions: some View {
        HStack(spacing: 10) {
            languageMenu
            settingsButton
            reloadButton
        }
    }

    private var regularActions: some View {
        HStack(spacing: 12) {
            languageMenu
            settingsButton
            reloadButton
        }
    }

    private var languageMenu: some View {
        Menu {
            Picker(languageCopy.languageTitle, selection: $selectedLanguage) {
                ForEach(LanguageOption.allCases) { option in
                    Text(option.label).tag(option.rawValue)
                }
            }
        } label: {
            Label(languageCopy.name, systemImage: "globe")
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.9), in: Capsule())
        }
        .tint(.primary)
    }

    private var reloadButton: some View {
        Button {
            reloadKey = UUID()
        } label: {
            Label(languageCopy.reload, systemImage: "arrow.clockwise")
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color.accentColor.opacity(0.12), in: Capsule())
        }
        .buttonStyle(.plain)
    }

    private var settingsButton: some View {
        Button {
            showingSettings = true
        } label: {
            Label(languageCopy.settings, systemImage: "slider.horizontal.3")
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.9), in: Capsule())
        }
        .buttonStyle(.plain)
    }

    private func statusRow(context: PreviewContext) -> some View {
        HStack(spacing: 10) {
            statusPill(title: languageCopy.deviceTitle, value: context.deviceLabel)
            statusPill(title: languageCopy.orientationTitle, value: context.orientationLabel)
        }
    }

    private func statusPill(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased())
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(.secondary)
            Text(value)
                .font(.system(size: 14, weight: .semibold))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.82), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var languageCopy: LanguageOption {
        LanguageOption(rawValue: selectedLanguage) ?? .simplifiedChinese
    }
}

enum RootTab {
    case preview
    case about
}

struct PreviewContext {
    let lang: String
    let device: String
    let orientation: String

    var deviceLabel: String {
        device == "ipad" ? "iPad" : "iPhone"
    }

    var orientationLabel: String {
        orientation == "landscape" ? "Landscape" : "Portrait"
    }
}

enum LanguageOption: String, CaseIterable, Identifiable {
    case simplifiedChinese = "zh-CN"
    case japanese = "ja-JP"
    case english = "en-US"
    case portuguese = "pt-BR"
    case spanish = "es-ES"

    var id: String { rawValue }

    var label: String {
        switch self {
        case .simplifiedChinese: return "中文"
        case .japanese: return "日本語"
        case .english: return "English"
        case .portuguese: return "Português"
        case .spanish: return "Español"
        }
    }

    var name: String { label }

    var badge: String { "iOS Sales Storytelling" }

    var reload: String {
        switch self {
        case .simplifiedChinese: return "刷新"
        case .japanese: return "再読み込み"
        case .english: return "Reload"
        case .portuguese: return "Recarregar"
        case .spanish: return "Recargar"
        }
    }

    var settings: String {
        switch self {
        case .simplifiedChinese: return "设置"
        case .japanese: return "設定"
        case .english: return "Settings"
        case .portuguese: return "Ajustes"
        case .spanish: return "Ajustes"
        }
    }

    var previewTab: String {
        switch self {
        case .simplifiedChinese: return "预览"
        case .japanese: return "プレビュー"
        case .english: return "Preview"
        case .portuguese: return "Preview"
        case .spanish: return "Preview"
        }
    }

    var aboutTab: String {
        switch self {
        case .simplifiedChinese: return "关于"
        case .japanese: return "情報"
        case .english: return "About"
        case .portuguese: return "Sobre"
        case .spanish: return "Acerca"
        }
    }

    var languageTitle: String {
        switch self {
        case .simplifiedChinese: return "语言"
        case .japanese: return "言語"
        case .english: return "Language"
        case .portuguese: return "Idioma"
        case .spanish: return "Idioma"
        }
    }

    var deviceTitle: String {
        switch self {
        case .simplifiedChinese: return "设备"
        case .japanese: return "デバイス"
        case .english: return "Device"
        case .portuguese: return "Dispositivo"
        case .spanish: return "Dispositivo"
        }
    }

    var orientationTitle: String {
        switch self {
        case .simplifiedChinese: return "方向"
        case .japanese: return "向き"
        case .english: return "Orientation"
        case .portuguese: return "Orientação"
        case .spanish: return "Orientación"
        }
    }
}
