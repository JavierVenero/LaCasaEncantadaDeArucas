document.addEventListener("DOMContentLoaded", () => {

  const buttonES = document.getElementById("lang-es");
  const buttonEN = document.getElementById("lang-en");

  const translatableElements =
    document.querySelectorAll("[data-es][data-en]");

  function setLanguage(lang) {

    if (lang !== "es" && lang !== "en") {
      lang = "es";
    }

    translatableElements.forEach((element) => {
      const translation = element.getAttribute(`data-${lang}`);

      if (translation !== null) {
        element.textContent = translation;
      }
    });

    if (buttonES) {
      buttonES.classList.toggle("active", lang === "es");
      buttonES.setAttribute(
        "aria-pressed",
        lang === "es" ? "true" : "false"
      );
    }

    if (buttonEN) {
      buttonEN.classList.toggle("active", lang === "en");
      buttonEN.setAttribute(
        "aria-pressed",
        lang === "en" ? "true" : "false"
      );
    }

    document.documentElement.setAttribute("lang", lang);

    try {
      localStorage.setItem("casaEncantadaLanguage", lang);
    } catch (error) {
      console.warn("No se pudo guardar el idioma.", error);
    }
  }

  if (buttonES) {
    buttonES.addEventListener("click", () => {
      setLanguage("es");
    });
  }

  if (buttonEN) {
    buttonEN.addEventListener("click", () => {
      setLanguage("en");
    });
  }

  let savedLanguage = "es";

  try {
    savedLanguage =
      localStorage.getItem("casaEncantadaLanguage") || "es";
  } catch (error) {
    savedLanguage = "es";
  }

  setLanguage(savedLanguage);

});