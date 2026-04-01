require("./bootstrap");

//import Vue from 'vue'
//import Vue from 'vue';

window.Vue = require("vue").default;

Vue.component("cliente", require("./components/Cliente.vue").default);
Vue.component("tecnico", require("./components/Tecnico.vue").default);
Vue.component("orden", require("./components/Orden.vue").default);
Vue.component("ordentecnico", require("./components/OrdenTecnico.vue").default);
//Vue.component('ejemplo', require('./components/ejemplo.vue').default);
Vue.component("reporteorden", require("./components/ReporteOrden.vue").default);
Vue.component("dashboard", require("./components/Dashboard.vue").default);
Vue.component("user", require("./components/User.vue").default);

//IMPORTAMOS ELEMENT UI
import ElementUI from "element-ui";
import "element-ui/lib/theme-chalk/index.css";
import locale from "element-ui/lib/locale/lang/es"; //cambia el idioma
Vue.use(ElementUI, { locale });
Vue.use(ElementUI);

const app = new Vue({
    el: "#app",
    data: {
        menu: 0,
    },
});
