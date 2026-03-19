const frame = document.querySelector("#content-frame");
const navItems = document.querySelectorAll(".nav-item");
const reloadButton = document.querySelector("#reload-page");

navItems.forEach((item) => {
  item.addEventListener("click", () => {
    const targetPage = item.dataset.page;
    if (!targetPage) {
      return;
    }

    navItems.forEach((button) => button.classList.remove("is-active"));
    item.classList.add("is-active");
    frame.src = targetPage;
  });
});

reloadButton.addEventListener("click", () => {
  if (!frame.contentWindow) {
    frame.src = frame.src;
    return;
  }

  frame.contentWindow.location.reload();
});
