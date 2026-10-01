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

document.addEventListener("DOMContentLoaded", () => {

  const modal = document.getElementById("experience-modal");
  const image = document.getElementById("experience-image");
  const eyebrow = document.getElementById("experience-eyebrow");
  const title = document.getElementById("experience-title");
  const text = document.getElementById("experience-text");
  const signature = document.getElementById("experience-signature");

  if (!modal) return;

  const experiences = {
    yoga: {
      image: "assets/images/yoga.png"
    },

    horarios: {
      image: "assets/images/horarios.png"
    },

    tarifas: {
      image: "assets/images/tarifas.png",
      eyebrowES: "CLASES",
      eyebrowEN: "CLASSES",
      titleES: "Tarifas",
      titleEN: "Rates",
      textES: "",
      textEN: "",
      signatureES: "",
      signatureEN: ""
    }
  };

  const triggers = document.querySelectorAll("[data-experience]");

  function getLanguage() {
    return document.documentElement.getAttribute("lang") || "es";
  }

  function openExperience(type) {
    const data = experiences[type];

    if (!data) return;

    const lang = getLanguage();

    if (image && data.image) {
      image.src = data.image;
    }

    if (data.eyebrowES && eyebrow) {
      eyebrow.textContent =
        lang === "en" ? data.eyebrowEN : data.eyebrowES;
    }

    if (data.titleES && title) {
      title.textContent =
        lang === "en" ? data.titleEN : data.titleES;
    }

    if (data.textES !== undefined && text) {
      text.textContent =
        lang === "en" ? data.textEN : data.textES;
    }

    if (data.signatureES !== undefined && signature) {
      signature.textContent =
        lang === "en" ? data.signatureEN : data.signatureES;
    }

    modal.dataset.experience = type;
    modal.classList.add("is-open");
    modal.setAttribute("aria-hidden", "false");

    document.body.classList.add("experience-open");
  }

  triggers.forEach((trigger) => {
    trigger.addEventListener("click", () => {
      openExperience(trigger.dataset.experience);
    });
  });

  modal
    .querySelectorAll("[data-close-experience]")
    .forEach((element) => {
      element.addEventListener("click", () => {
        modal.classList.remove("is-open");
        modal.setAttribute("aria-hidden", "true");

        document.body.classList.remove("experience-open");
      });
    });

});
