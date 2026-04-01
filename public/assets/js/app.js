(function () {
  const base = (window.APP_BASE_PATH || '').replace(/\/$/, '');

  function normalizarInterna(url) {
    if (!url || !url.startsWith('/')) return url;
    if (url.startsWith('//')) return url;
    if (!base) return url;
    if (url === base || url.startsWith(base + '/')) return url;
    return base + url;
  }

  document.querySelectorAll('a[href]').forEach((el) => {
    const href = el.getAttribute('href');
    if (href && href.startsWith('/')) {
      el.setAttribute('href', normalizarInterna(href));
    }
  });

  document.querySelectorAll('form[action]').forEach((el) => {
    const action = el.getAttribute('action');
    if (action && action.startsWith('/')) {
      el.setAttribute('action', normalizarInterna(action));
    }
  });

  document.querySelectorAll('[data-confirmar]').forEach((el) => {
    el.addEventListener('click', (e) => {
      if (!confirm(el.dataset.confirmar || '¿Confirmas esta acción?')) {
        e.preventDefault();
      }
    });
  });

  const layout = document.querySelector('.app-layout');
  const sidebars = document.querySelectorAll('.js-app-sidebar');
  const menuToggles = document.querySelectorAll('[data-menu-toggle]');
  const menuBreakpoint = window.matchMedia('(max-width: 767.98px)');

  function cerrarMenu() {
    if (!layout) return;
    layout.classList.remove('menu-abierto');
  }

  function alternarMenu() {
    if (!layout) return;
    layout.classList.toggle('menu-abierto');
  }

  menuToggles.forEach((btn) => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      alternarMenu();
    });
  });

  document.addEventListener('click', (e) => {
    if (!layout || !menuBreakpoint.matches || !layout.classList.contains('menu-abierto')) return;
    const dentroSidebar = Array.from(sidebars).some((sidebar) => sidebar.contains(e.target));
    const botonToggle = Array.from(menuToggles).some((btn) => btn.contains(e.target));
    if (!dentroSidebar && !botonToggle) {
      cerrarMenu();
    }
  });

  window.addEventListener('resize', () => {
    if (!menuBreakpoint.matches) {
      cerrarMenu();
    }
  });

  // UX transversal de formularios: marca campos requeridos y evita doble envío.
  document.querySelectorAll('form').forEach((form) => {
    form.querySelectorAll('[required]').forEach((campo) => {
      const id = campo.getAttribute('id');
      if (!id) return;
      const label = form.querySelector(`label[for="${id}"]`);
      if (!label) return;
      if (label.querySelector('.campo-requerido')) return;
      const marcador = document.createElement('span');
      marcador.className = 'campo-requerido';
      marcador.textContent = '*';
      label.appendChild(marcador);
    });

    form.addEventListener('submit', () => {
      if (!form.checkValidity()) {
        return;
      }

      form.classList.add('form-enviando');
      form.querySelectorAll('button[type="submit"], input[type="submit"]').forEach((btn) => {
        if (btn.dataset.locked === '1') return;
        btn.dataset.locked = '1';
        if (!btn.dataset.originalText) {
          btn.dataset.originalText = btn.tagName === 'INPUT' ? (btn.value || '') : (btn.innerHTML || '');
        }
        if (btn.tagName === 'INPUT') {
          btn.value = 'Guardando...';
        } else {
          btn.innerHTML = 'Guardando...';
        }
        btn.disabled = true;
      });
    });
  });
})();
