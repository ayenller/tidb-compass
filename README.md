# TiDB Compass

一个轻量的 APP 壳示例，用来承载可独立更新的 TiDB 介绍静态页面。

## 文件结构

- `index.html`：APP 壳
- `assets/app.css`：APP 壳样式
- `assets/app.js`：APP 壳交互
- `content/tidb-sales-kit.html`：可独立更新的 TiDB 介绍页

## 使用方式

直接在浏览器打开 `index.html` 即可预览。

## 更新内容

如果后续需要由后台持续更新介绍内容，优先替换 `content/tidb-sales-kit.html`。
这样可以不改 APP 壳，只更新页面内容与文案结构。
