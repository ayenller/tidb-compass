const frame = document.querySelector("#content-frame");
const navItems = document.querySelectorAll(".nav-item");
const reloadButton = document.querySelector("#reload-page");
const languageButtons = document.querySelectorAll(".language-pill");
const deviceLanguage = document.querySelector("#device-language");

const shellMessages = {
  "zh-CN": {
    langLabel: "中文",
    strings: {
      "shell.badge": "iOS 销售使能应用",
      "shell.languageLabel": "语言",
      "shell.navLabel": "页面入口",
      "shell.homePage": "TiDB 介绍主页",
      "shell.useCasesLabel": "推荐使用方式",
      "shell.useCase1": "面向销售：快速讲清 TiDB 的业务价值。",
      "shell.useCase2": "面向售前：按客户诉求筛选信息重点。",
      "shell.useCase3": "面向伙伴：统一对外讲法与对比框架。",
      "shell.updateLabel": "内容更新",
      "shell.updateBody": "保持 iOS APP 壳稳定，仅更新内嵌的静态 HTML 内容页即可。",
      "shell.modeLabel": "客户沟通模式",
      "shell.title": "一个支持多语言的 TiDB iOS 介绍应用壳",
      "shell.status": "多语言内容已就绪",
      "shell.reload": "刷新内容"
    }
  },
  "ja-JP": {
    langLabel: "日本語",
    strings: {
      "shell.badge": "iOS セールスイネーブルメント",
      "shell.languageLabel": "言語",
      "shell.navLabel": "ページ",
      "shell.homePage": "TiDB 紹介ホーム",
      "shell.useCasesLabel": "推奨用途",
      "shell.useCase1": "営業向け: TiDB の価値を短時間で説明。",
      "shell.useCase2": "プリセールス向け: 顧客要件で重点を絞り込み。",
      "shell.useCase3": "パートナー向け: 一貫した対外ストーリーを維持。",
      "shell.updateLabel": "コンテンツ更新",
      "shell.updateBody": "iOS アプリシェルは固定し、埋め込み HTML のみ差し替えて更新できます。",
      "shell.modeLabel": "顧客説明モード",
      "shell.title": "多言語対応の TiDB iOS 紹介アプリシェル",
      "shell.status": "多言語コンテンツ準備完了",
      "shell.reload": "再読み込み"
    }
  },
  "en-US": {
    langLabel: "English",
    strings: {
      "shell.badge": "iOS Sales Enablement",
      "shell.languageLabel": "Language",
      "shell.navLabel": "Pages",
      "shell.homePage": "TiDB Overview",
      "shell.useCasesLabel": "Recommended Use",
      "shell.useCase1": "For sellers: explain TiDB's business value quickly.",
      "shell.useCase2": "For presales: focus by customer priority.",
      "shell.useCase3": "For partners: keep a consistent external story.",
      "shell.updateLabel": "Content Update",
      "shell.updateBody": "Keep the iOS app shell stable and update only the embedded static HTML page.",
      "shell.modeLabel": "Customer Mode",
      "shell.title": "A multilingual TiDB iOS app shell for customer storytelling",
      "shell.status": "Localized content ready",
      "shell.reload": "Reload"
    }
  },
  "pt-BR": {
    langLabel: "Português",
    strings: {
      "shell.badge": "Enablement de Vendas iOS",
      "shell.languageLabel": "Idioma",
      "shell.navLabel": "Páginas",
      "shell.homePage": "Visão geral do TiDB",
      "shell.useCasesLabel": "Uso recomendado",
      "shell.useCase1": "Para vendas: explique rapidamente o valor do TiDB.",
      "shell.useCase2": "Para pré-vendas: filtre pelo que o cliente mais prioriza.",
      "shell.useCase3": "Para parceiros: mantenha uma narrativa consistente.",
      "shell.updateLabel": "Atualização de conteúdo",
      "shell.updateBody": "Mantenha o shell do app iOS estável e atualize apenas a página HTML incorporada.",
      "shell.modeLabel": "Modo de conversa com cliente",
      "shell.title": "Um shell de app iOS multilíngue para apresentar o TiDB",
      "shell.status": "Conteúdo localizado pronto",
      "shell.reload": "Recarregar"
    }
  },
  "es-ES": {
    langLabel: "Español",
    strings: {
      "shell.badge": "Enablement comercial para iOS",
      "shell.languageLabel": "Idioma",
      "shell.navLabel": "Páginas",
      "shell.homePage": "Visión general de TiDB",
      "shell.useCasesLabel": "Uso recomendado",
      "shell.useCase1": "Para ventas: explica rápido el valor de TiDB.",
      "shell.useCase2": "Para preventa: filtra por la prioridad del cliente.",
      "shell.useCase3": "Para partners: mantén una narrativa consistente.",
      "shell.updateLabel": "Actualización de contenido",
      "shell.updateBody": "Mantén estable el shell de la app iOS y actualiza solo la página HTML embebida.",
      "shell.modeLabel": "Modo de conversación con cliente",
      "shell.title": "Un shell de app iOS multilingüe para presentar TiDB",
      "shell.status": "Contenido localizado listo",
      "shell.reload": "Recargar"
    }
  }
};

function updateFrameSource(language) {
  const activeNavItem = document.querySelector(".nav-item.is-active");
  const targetPage = activeNavItem?.dataset.page || "./content/tidb-sales-kit.html";
  frame.src = `${targetPage}?lang=${encodeURIComponent(language)}`;
}

function applyShellLanguage(language) {
  const pack = shellMessages[language] || shellMessages["en-US"];
  document.documentElement.lang = language;
  deviceLanguage.textContent = pack.langLabel;

  document.querySelectorAll("[data-i18n]").forEach((node) => {
    const key = node.dataset.i18n;
    const value = pack.strings[key];
    if (value) {
      node.textContent = value;
    }
  });
}

function setLanguage(language) {
  languageButtons.forEach((button) => {
    button.classList.toggle("is-active", button.dataset.lang === language);
  });

  localStorage.setItem("tidb-compass-lang", language);
  applyShellLanguage(language);
  updateFrameSource(language);
}

navItems.forEach((item) => {
  item.addEventListener("click", () => {
    const targetPage = item.dataset.page;
    if (!targetPage) {
      return;
    }

    navItems.forEach((button) => button.classList.remove("is-active"));
    item.classList.add("is-active");
    updateFrameSource(localStorage.getItem("tidb-compass-lang") || "zh-CN");
  });
});

languageButtons.forEach((button) => {
  button.addEventListener("click", () => {
    const language = button.dataset.lang;
    if (language) {
      setLanguage(language);
    }
  });
});

reloadButton.addEventListener("click", () => {
  if (!frame.contentWindow) {
    updateFrameSource(localStorage.getItem("tidb-compass-lang") || "zh-CN");
    return;
  }

  frame.contentWindow.location.reload();
});

setLanguage(localStorage.getItem("tidb-compass-lang") || "zh-CN");
