<template>
    <main class="main">
        <!-- Breadcrumb -->
        <!-- <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/">Escritorio</a></li>
    </ol>-->
        <div class="container-fluid">
            <!-- Ejemplo de tabla Listado -->
            <div class="card mt-4">
                <div class="card-header">
                    <i class="fa fa-align-justify"></i> Ordenes del tecnico
                    <el-button disabled plain type="primary" icon="el-icon-circle-plus"
                        @click="abrirModal('orden', 'registrar')">Nuevo</el-button>
                    <!-- <el-button
                        type="danger"
                        icon="el-icon-document"
                        @click="cargarPdf()"
                        >Reporte</el-button
                    > -->
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <div class="col-md-6">
                            <div class="input-group">
                                <div class="mr-1 mb-1">
                                    <el-select v-model="criterio" placeholder="Select">
                                        <el-option v-for="item in valores" :key="item.value" :label="item.label"
                                            :value="item.value"></el-option>
                                    </el-select>
                                </div>
                                <div class="mr-1 mb-1">
                                    <el-input @keyup.native.enter="
                                        listarOrden(1, buscar, criterio)
                                        " placeholder="Texto a buscar" v-model="buscar"></el-input>
                                </div>

                                <div>
                                    <el-button icon="el-icon-search" type="primary" @click="
                                        listarOrden(1, buscar, criterio)
                                        ">Buscar</el-button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table class="table table-sm table-hover table-responsive ">
                        <thead>
                            <tr>
                                <th>Acciones</th>
                                <th>Nro Orden</th>
                                <th>Cliente</th>
                                <th>Tecnico</th>
                                <th>Nombre</th>
                                <th>Marca</th>
                                <th>Modelo</th>
                                <!-- <th>Serial</th>
                                <th>Clave</th> -->
                                <th>Accesorios</th>
                                <th>Observaciones</th>
                                <th>FallaEquipo</th>
                                <th>Reparacion</th>
                                <th>FechaEntrada</th>
                                <th>FechaEntrega</th>
                                <th>Adelanto</th>
                                <th>TotalPagar</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="orden in arrayOrden" :key="orden.id">
                                <td>
                                    <button type=" button" @click="
                                        abrirModal(
                                            'orden',
                                            'actualizar',
                                            orden
                                        )
                                        " class="btn btn-warning btn-sm">
                                        <i class="icon-pencil"></i>
                                    </button>
                                    <!-- <button type="button" @click="pdfOrden(orden.id)" class="btn btn-primary btn-sm">
                                        <i class="fas fa-print"></i>
                                    </button> -->
                                    <button type="button" @click="pdfOrden(orden.id)" class="btn btn-primary btn-sm">
                                        <i class="fas fa-print"></i>
                                    </button>

                                    &nbsp;
                                    <!-- <template v-if="orden.condicion">
                                        <button
                                            type="button"
                                            @click="
                                                desactivarOrden(orden.id)
                                            "
                                            class="btn btn-danger btn-sm"
                                        >
                                            <i class="icon-trash"></i>
                                        </button>
                                    </template>
<template v-else>
                                        <button
                                            type="button"
                                            @click="activarOrden(orden.id)"
                                            class="btn btn-info btn-sm"
                                        >
                                            <i class="icon-check"></i>
                                        </button>
                                    </template> -->
                                </td>
                                <td v-text="orden.id"></td>
                                <td v-text="orden.Cliente"></td>
                                <td v-text="orden.Tecnico"></td>
                                <td v-text="orden.nombreEquipo"></td>
                                <td v-text="orden.marca"></td>
                                <td v-text="orden.modelo"></td>
                                <!-- <td v-text="orden.serial"></td> -->
                                <!-- <td v-text="orden.clave"></td> -->
                                <td v-text="orden.accesorios"></td>
                                <td v-text="orden.observaciones"></td>
                                <td v-text="orden.fallaEquipo"></td>
                                <td v-text="orden.reparacion"></td>
                                <td v-text="orden.fechaEntrada"></td>
                                <td v-text="orden.fechaEntrega"></td>
                                <td v-text="orden.adelanto"></td>
                                <td v-text="orden.totalPagar"></td>
                                <td> <span class="badge " :class="estadoColor(orden.estado)">{{
                                    orden.estado }}</span></td>
                                <!-- <td v-text="orden.estado" :class="estadoColor(orden.estado)"></td> -->
                                <!-- <td>
                                    <div v-if="orden.condicion">
                                        <span class="badge badge-success"
                                            >Activo</span
                                        >
                                    </div>
                                    <div v-else>
                                        <span class="badge badge-danger"
                                            >Desactivado</span
                                        >
                                    </div>
                                </td> -->
                            </tr>
                        </tbody>
                    </table>
                    <nav>
                        <ul class="pagination">
                            <li class="page-item" v-if="pagination.current_page > 1">
                                <a class="page-link" href="#" @click.prevent="
                                    cambiarPagina(
                                        pagination.current_page - 1,
                                        buscar,
                                        criterio
                                    )
                                    ">Ant</a>
                            </li>
                            <li class="page-item" v-for="page in pagesNumber" :key="page"
                                :class="[page == isActived ? 'active' : '']">
                                <a class="page-link" href="#" @click.prevent="
                                    cambiarPagina(page, buscar, criterio)
                                    " v-text="page"></a>
                            </li>

                            <li class="page-item" v-if="pagination.current_page <
                                pagination.last_page
                            ">
                                <a class="page-link" href="#" @click.prevent="
                                    cambiarPagina(
                                        pagination.current_page + 1,
                                        buscar,
                                        criterio
                                    )
                                    ">Sig</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
            <!-- Fin ejemplo de tabla Listado -->
        </div>
        <!--Inicio del modal agregar/actualizar-->
        <div class="modal fade " tabindex="-1" :class="{ mostrar: modal }" role="document"
            aria-labelledby="myLargeModalLabel" style="display: none" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-scrollable  " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" v-text="tituloModal"></h6>
                        <button type="button" class="close" @click="cerrarModal()" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action method="post" enctype="multipart/form-data" class="form-horizontal">
                            <div v-show="errorOrden" class="form-group row div-error">
                                <div class="text-center text-error">
                                    <div v-for="error in errorMostrarMsjOrden" :key="error" v-text="error"></div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4 col-6  d-none d-sm-blocke">
                                    <div>
                                        <label class for="text-input">Numero Orden</label>
                                        <div class>
                                            <el-input placeholder="orden" size="mini" v-model="orden_id"
                                                :disabled="true"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6">
                                    <div class>
                                        <label class for="text-input">Cliente</label>
                                        <!-- <el-button type="text" @click="centerDialogVisible = true"> nuevo</el-button> -->
                                        <div class>
                                            <template>
                                                <el-select disabled size="mini" v-model="idcliente"
                                                    placeholder="Selecciona el cliente">
                                                    <el-option v-for="cliente in arrayCliente" :key="cliente.id"
                                                        :label="cliente.nombre" :value="(cliente.id)"></el-option>
                                                </el-select>
                                                <div>
                                                    <el-button v-if="tipoAccion == 1" type="text"
                                                        @click="centerDialogVisible = true">
                                                        nuevo</el-button>
                                                </div>

                                            </template>


                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 col-6">
                                    <div>
                                        <label class for="text-input">Tecnico</label>
                                        <div class>
                                            <template>
                                                <el-select @change="buscaruser()" disabled size=" mini"
                                                    v-model="idtecnico" placeholder="Selecciona el tecnico">
                                                    <el-option v-for="tecnico in arrayTecnico" :key="tecnico.id"
                                                        :label="tecnico.nombre" :value="tecnico.id"></el-option>
                                                </el-select>
                                            </template>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Nombre del equipo</label>
                                        <div class>
                                            <el-input placeholder="Nombre equipo" size="mini"
                                                v-model="nombreEquipo"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Marca</label>
                                        <div class>
                                            <el-input placeholder="Marca" size="mini" v-model="marca"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Modelo</label>
                                        <div class>
                                            <el-input placeholder="Modelo" size="mini" v-model="modelo"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Serial</label>
                                        <div class>
                                            <el-input placeholder="Serial" size="mini" v-model="serial"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Clave</label>
                                        <div class>
                                            <el-input placeholder="Clave" size="mini" v-model="clave"></el-input>
                                            <!-- <div class="block">
                        <el-date-picker
                          v-model="fechaVencimiento"
                          type="date"
                          placeholder="Escoge un día"
                          format="yyyy/MM/dd"
                          value-format="yyyy-MM-dd"                          
                          size="mini"
                        ></el-date-picker>
                      </div> -->
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Accesorios</label>
                                        <div class>
                                            <el-input placeholder="Accesorios" size="mini"
                                                v-model="accesorios"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Observaciones</label>
                                        <div class>
                                            <el-input placeholder="Observaciones" size="mini"
                                                v-model="observaciones"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Falla de Equipo</label>
                                        <div class>
                                            <el-input placeholder="Falla del equipo" size="mini"
                                                v-model="fallaEquipo"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Reparacion</label>
                                        <div class>
                                            <el-input placeholder="Reparacion" size="mini"
                                                v-model="reparacion"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Fecha Entrada</label>
                                        <div class>
                                            <div class="block">
                                                <el-date-picker v-model="fechaEntrada" type="date"
                                                    placeholder="Escoge un día" format="yyyy/MM/dd"
                                                    value-format="yyyy-MM-dd" size="mini"></el-date-picker>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Fecha de Entrega</label>
                                        <div class>
                                            <div class="block">
                                                <el-date-picker disabled v-model="fechaEntrega" type="date"
                                                    placeholder="Escoge un día" format="yyyy/MM/dd"
                                                    value-format="yyyy-MM-dd" size="mini"></el-date-picker>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Adelanto</label>
                                        <div class>
                                            <el-input disabled placeholder="Adelanto" size="mini"
                                                v-model="adelanto"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Total Pagar</label>
                                        <div class>
                                            <el-input disabled placeholder="Total pagar" size="mini"
                                                v-model="totalPagar"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Estado</label>
                                        <div class="">
                                            <template>
                                                <el-select size="mini" v-model="estado" clearable
                                                    placeholder="Seleciona el estado"
                                                    :disabled="estado === 'Entregado'">
                                                    <el-option v-for="estado in estados" :key="estado.value"
                                                        :label="estado.label" :value="estado.value">
                                                    </el-option>
                                                </el-select>
                                            </template>
                                            <!-- <el-input placeholder="lote" size="mini" v-model.number="descuento"></el-input> -->
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!-- fin form -->
                        </form>
                    </div>
                    <div class="modal-footer">

                        <!-- <button type="button" class="btn btn-danger" @click="cerrarModal()">
                            Cerrar
                        </button> -->
                        <el-button type="danger" @click="cerrarModal()">Cerrar</el-button>
                        <!-- <button type="button" v-if="tipoAccion == 1" class="btn btn-primary" @click="registrarOrden()">
                            Guardar
                        </button> -->
                        <el-button type="primary" v-if="tipoAccion == 1"
                            @click="registrarOrden(), outerVisible = true">Registrar
                            orden</el-button>
                        <el-button type="primary" v-if="tipoAccion == 2"
                            @click="actualizarOrden(), outerVisible = true">Actualizar
                            orden</el-button>

                        <!-- <button type="button" v-if="tipoAccion == 2" class="btn btn-primary" @click="actualizarOrden()">
                            Actualizar
                        </button> -->
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <el-dialog title="Registro de cliente.." :visible.sync="centerDialogVisible" width="25%" center>
            <cliente @escuchar=" selectCliente()"></cliente>
            <span slot="footer" class="dialog-footer">
                <!-- <el-button @click="centerDialogVisible = false">Cancel</el-button> -->
                <!-- <el-button type="primary" @click="centerDialogVisible = false">Cancelar</el-button> -->

            </span>
        </el-dialog>
        <!-- abre imprimir -->
        <template>
            <!-- <el-button type="text" @click="outerVisible = true">o</el-button> -->

            <el-dialog title="Imprime tu documento" :visible.sync="outerVisible">
                <el-dialog width="30%" title="Inner Dialog" :visible.sync="innerVisible" append-to-body>
                </el-dialog>
                <!-- //aqui el pdf -->
                <!-- <button class="btn btn-primary" @click="fetchPdf(orden_id)">cargar pdf</button> -->
                <embed :src="pdfUrl" type="application/pdf" width="100%" height="500px" />
                <div slot="footer" class="dialog-footer">
                    <el-button @click="outerVisible = false">Cancel</el-button>
                    <!-- <el-button @click="pdfOrden(id)">innmm</el-button> -->
                    <!-- <el-button type="primary" @click="innerVisible = true">open the inner Dialog</el-button> -->
                </div>
            </el-dialog>
        </template>
        <!-- carga modal vuejs -->


    </main>
</template>

<script>
import cliente from './RegistroCliente.vue'
export default {
    components: { cliente },
    data() {
        return {
            showModal: false,
            pdfUrl: '',
            //
            outerVisible: false,
            innerVisible: false,
            //

            centerDialogVisible: false,
            input: "",
            //para select
            options: [
                {
                    value: "id",
                    label: "id",
                },


            ],
            valores: [
                {
                    value: "id",
                    label: "Numero Orden",
                },


            ],
            //para estados
            estados: [
                {
                    value: "Ingresado",
                    label: "Ingresado",
                },
                {
                    value: "Reparando",
                    label: "Reparando",
                },
                {
                    value: "Reparacion finalizado",
                    label: "Reparacion finalizado",
                },
                {
                    value: "Entregado",
                    label: "Entregado",
                },

            ],
            value: '',
            orden_id: 0,
            idcliente: "",
            idtecnico: "",
            idusuario: '',
            nombreEquipo: "",
            marca: "",
            modelo: "",
            serial: "",
            clave: "",
            accesorios: "",
            observaciones: "",
            fallaEquipo: "",
            reparacion: "",
            fechaEntrada: "",
            fechaEntrega: "",
            adelanto: "",
            totalPagar: "",
            estado: "",
            arrayOrden: [],
            arrayCliente: [],
            arrayTecnico: [],
            arrayusuario: [],
            modal: 0,
            tituloModal: "",
            tipoAccion: 0,
            errorOrden: 0,
            errorMostrarMsjOrden: [],
            //report
            listado: 1,

            pagination: {
                total: 0,
                current_page: 0,
                per_page: 0,
                last_page: 0,
                from: 0,
                to: 0,
            },
            offset: 3,
            criterio: "id",
            buscar: "",
            nuevocliente: false,
        };
    },
    computed: {
        isActived: function () {
            return this.pagination.current_page;
        },
        pagesNumber: function () {
            if (!this.pagination.to) {
                return [];
            }
            var from = this.pagination.current_page - this.offset;
            if (from < 1) {
                from = 1;
            }
            var to = from + this.offset * 2;
            if (to >= this.pagination.last_page) {
                to = this.pagination.last_page;
            }
            var pagesArray = [];
            while (from <= to) {
                pagesArray.push(from);
                from++;
            }
            return pagesArray;
        },
    },
    methods: {
        estadoColor(estado) {
            // Devuelve una clase según el valor del estado
            switch (estado) {
                case 'Ingresado':
                    return 'azul';
                case 'Reparando':
                    return 'amarillo';
                case 'Reparacion finalizado':
                    return 'verde';
                case 'Entregado':
                    return 'celeste';
                default:
                    return '';
            }
        },
        fetchPdf(id) {
            // Hacer la solicitud GET a la API de Laravel
            axios.get('/orden/pdf/' + id, { responseType: 'arraybuffer' })
                .then(response => {
                    // Crear un Blob con la respuesta para convertirla en una URL de objeto
                    const blob = new Blob([response.data], { type: 'application/pdf' });
                    this.pdfUrl = URL.createObjectURL(blob);
                    this.showModal = true;
                })
                .catch(error => {
                    console.error('Error fetching PDF:', error);
                });
        },
        closeModal() {
            this.showModal = false;
            // Liberar la URL del objeto para liberar memoria
            URL.revokeObjectURL(this.pdfUrl);
        },
        guardar() {
            this.$message({
                message: "Orden Guardado con éxito.",
                type: "success",
            });
        },
        editar() {
            this.$message({
                message: "Orden Actualizado con éxito.",
                type: "success",
            });
        },
        //carga pdf clientes

        listarOrden(page, buscar, criterio) {
            let me = this;
            var url =
                "/ordentecnico?page=" +
                page +
                "&buscar=" +
                buscar +
                "&criterio=" +
                criterio;
            axios
                .get(url)
                .then(function (response) {
                    var respuesta = response.data;
                    me.arrayOrden = respuesta.ordenes.data;
                    //console.log(me.arrayOrden);
                    me.pagination = respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
        },
        cambiarPagina(page, buscar, criterio) {
            let me = this;
            me.pagination.current_page = page;
            me.listarOrden(page, buscar, criterio);
        },
        selectCliente() {
            let me = this;
            var url = "/cliente/selectCliente";

            axios
                .get(url)
                .then(function (response) {
                    var respuesta = response.data;
                    me.arrayCliente = respuesta.clientes;

                })
                .catch(function (error) {
                    console.log(error);
                });
        },
        buscaruser() {
            let me = this;
            var url = '/user/selectuser?filtro=' + me.idtecnico;

            axios.get(url).then(function (response) {
                var respuesta = response.data;
                // console.log(respuesta);
                me.arrayusuario = respuesta.users;
                //console.log(me.arrayusuario);
                if (me.arrayusuario.length > 0) {
                    me.idusuario = me.arrayusuario[0]['idusuario'];
                    //console.log(me.idusuario);

                }


            })
                .catch(function (error) {
                    console.log(error);
                });

        },

        selectTecnico() {
            let me = this;
            var url = "/tecnico/selectTecnico";

            axios
                .get(url)
                .then(function (response) {
                    var respuesta = response.data;
                    me.arrayTecnico = respuesta.tecnicos;
                    //me.pagination = respuesta.pagination;
                    // console.log(arrayCategoria);
                })
                .catch(function (error) {
                    console.log(error);
                });
        },
        registrarOrden() {
            //validando campos tecnico
            if (this.validarOrden()) {
                return;
            }

            let me = this;

            axios
                .post("/orden/registrar", {
                    idcliente: this.idcliente,
                    idtecnico: this.idtecnico,
                    nombreEquipo: this.nombreEquipo,
                    marca: this.marca,
                    modelo: this.modelo,
                    serial: this.serial,
                    clave: this.clave,
                    accesorios: this.accesorios,
                    observaciones: this.observaciones,
                    fallaEquipo: this.fallaEquipo,
                    reparacion: this.reparacion,
                    fechaEntrada: this.fechaEntrada,
                    fechaEntrega: this.fechaEntrega,
                    adelanto: this.adelanto,
                    totalPagar: this.totalPagar,
                    estado: this.estado
                })
                .then(function (response) {
                    me.cerrarModal();
                    me.listarOrden(1, "", "nombre");
                    me.guardar();

                    //abre la pagina para imprimir
                    //window.open('/orden/pdf/' + response.data.id);
                    // me.fetchPdf(me.orden_id);
                    me.fetchPdf((response.data.id));

                })
                .catch(function (error) {
                    console.log(error);
                });
        },
        actualizarOrden() {
            //validando campos orden
            if (this.validarOrden()) {
                return;
            }

            let me = this;
            axios
                .put("/orden/actualizar", {
                    idcliente: this.idcliente,
                    idtecnico: this.idtecnico,
                    nombreEquipo: this.nombreEquipo,
                    marca: this.marca,
                    modelo: this.modelo,
                    serial: this.serial,
                    clave: this.clave,
                    accesorios: this.accesorios,
                    observaciones: this.observaciones,
                    fallaEquipo: this.fallaEquipo,
                    reparacion: this.reparacion,
                    fechaEntrada: this.fechaEntrada,
                    fechaEntrega: this.fechaEntrega,
                    adelanto: this.adelanto,
                    totalPagar: this.totalPagar,
                    estado: this.estado,
                    id: this.orden_id
                })
                .then(function (response) {
                    me.cerrarModal();
                    me.listarOrden(1, "", "nombre");
                    me.editar();
                    //imprime al update
                    me.fetchPdf(me.orden_id);

                })
                .catch(function (error) {
                    // console.log(error.response.data);
                });
        },
        desactivarOrden(id) {
            Swal.fire({
                title: "Estas seguro de desactivar este tecnico..?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Aceptar",
            }).then((result) => {
                if (result.value) {
                    let me = this;
                    axios
                        .put("/tecnico/desactivar", {
                            id: id,
                        })
                        .then(function (response) {
                            me.listarTecnico(1, "", "nombre");
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                }
            });
        },
        activarOrden(id) {
            Swal.fire({
                title: "Estas seguro de activar este tecnico.?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Aceptar",
            }).then((result) => {
                if (result.value) {
                    let me = this;
                    axios
                        .put("/tecnico/activar", {
                            id: id,
                        })
                        .then(function (response) {
                            Swal.fire(
                                "Activado!",
                                "El registro ha sido desactivado con éxito.",
                                "success"
                            );
                            me.listarTecnico(1, "", "nombre");
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                }
            });
        },

        validarOrden() {
            this.errorOrden = 0;
            this.errorMostrarMsjOrden = [];


            if (!this.idcliente)
                this.errorMostrarMsjOrden.push(
                    "Seleccionar el cliente "
                );

            else if (!this.idtecnico)
                this.errorMostrarMsjOrden.push(
                    "Seleccionar el tecnico "
                );
            else if (!this.nombreEquipo)
                this.errorMostrarMsjOrden.push(
                    "El nombre del equipo no puede estar vacío."
                );
            else if (!this.marca)
                this.errorMostrarMsjOrden.push(
                    "Ingresa la marca del equipo "
                );
            else if (!this.modelo)
                this.errorMostrarMsjOrden.push(
                    "Ingresa el modelo del equipo "
                );
            else if (!this.serial)
                this.errorMostrarMsjOrden.push(
                    "Ingresa el serial del equipo "
                );
            else if (!this.clave)
                this.errorMostrarMsjOrden.push(
                    "Ingresa la clave del equipo "
                );
            else if (!this.accesorios)
                this.errorMostrarMsjOrden.push(
                    "Ingresa los accesorios del equipo "
                );
            else if (!this.observaciones)
                this.errorMostrarMsjOrden.push(
                    "Ingresa las observaciones del equipo "
                );
            else if (!this.fallaEquipo)
                this.errorMostrarMsjOrden.push(
                    "Ingresa la falla del equipo "
                );
            else if (!this.reparacion)
                this.errorMostrarMsjOrden.push(
                    "El campo reparacion no puede estar vacia "
                );
            else if (!this.fechaEntrada)
                this.errorMostrarMsjOrden.push(
                    "Selecciona la fecha de entrada "
                );
            else if (!this.fechaEntrega)
                this.errorMostrarMsjOrden.push(
                    "Selecciona la fecha de entrega"
                );

            else if (!this.adelanto)
                this.errorMostrarMsjOrden.push(
                    "El campo adelanto no puede estar vacion."
                );
            else if (!this.totalPagar)
                this.errorMostrarMsjOrden.push(
                    "Ingresa el monto total  a pagar"
                );
            else if (parseInt(this.adelanto) > parseInt(this.totalPagar))
                this.errorMostrarMsjOrden.push(
                    "El campo adelanto no puede ser mayor que total a pagar"
                );
            else if (!this.estado)
                this.errorMostrarMsjOrden.push(
                    "Selecciona el estado para el orden"
                );




            if (this.errorMostrarMsjOrden.length) this.errorOrden = 1;

            return this.errorOrden;
        },
        cerrarModal() {
            this.modal = 0;
            this.tituloModal = "";
            this.idcliente = "";
            this.idtecnico = "";
            this.idusuario = "";
            this.nombreEquipo = "";
            this.marca = "";
            this.modelo = "";
            this.serial = "";
            this.clave = "";
            this.accesorios = "";
            this.observaciones = "";
            this.fallaEquipo = "";
            this.reparacion = "";
            this.fechaEntrada = "";
            this.fechaEntrega = "";
            this.adelanto = "";
            this.totalPagar = "";
            this.estado = "null"
            this.errorOrden = 0;
        },
        abrirModal(modelo, accion, data = []) {
            switch (modelo) {
                case "orden": {
                    switch (accion) {
                        case "registrar": {
                            this.modal = 1;
                            this.tituloModal = "Registrar Orden";
                            this.idcliente = "";
                            this.idtecnico = "";
                            this.idusuario = "";
                            this.nombreEquipo = "";
                            this.marca = "";
                            this.modelo = "";
                            this.serial = "";
                            this.clave = "";
                            this.accesorios = "";
                            this.observaciones = "";
                            this.fallaEquipo = "";
                            this.reparacion = "";
                            this.fechaEntrada = "";
                            this.fechaEntrega = "";
                            this.adelanto = "";
                            this.totalPagar = "";
                            this.estado = ""
                            this.tipoAccion = 1;
                            break;
                        }
                        case "actualizar": {
                            console.log(data);
                            //this.selectCliente();
                            this.modal = 1;
                            this.tituloModal = "Actualizar Orden";
                            this.tipoAccion = 2;
                            this.orden_id = data["id"];
                            this.idcliente = data["idcliente"];
                            this.idtecnico = data["idtecnico"];
                            this.idusuario = data["idusuario"];
                            this.nombreEquipo = data["nombreEquipo"];
                            this.marca = data["marca"];
                            this.modelo = data["modelo"];
                            this.serial = data["serial"];
                            this.clave = data["clave"];
                            this.accesorios = data["accesorios"];
                            this.observaciones = data["observaciones"];
                            this.fallaEquipo = data["fallaEquipo"];
                            this.reparacion = data["reparacion"];
                            this.fechaEntrada = data["fechaEntrada"];
                            this.fechaEntrega = data["fechaEntrega"];
                            this.adelanto = data["adelanto"];
                            this.totalPagar = data["totalPagar"];
                            this.estado = data["estado"];
                            break;
                        }
                    }


                }
                    this.selectCliente();
                    this.selectTecnico();
                    this.buscaruser();

            }

        },
        pdfOrden(id) {
            window.open('/orden/pdf/' + id, '_blank');
        },
    },
    mounted() {
        this.listarOrden(1, this.buscar, this.criterio);
        //this.buscaruser(3);

    },

};
</script>
<style scoped>
.verde {
    background-color: #4caf50;
    color: white;
}

.amarillo {
    background-color: #ffeb3b;
    color: black;
}

.celeste {
    background-color: #54c2ee;
    color: white;
}

.azul {
    background-color: #3652f4;
    color: white;
}

.modal-content {
    width: 100%;

    border-radius: 10px;

    position: absolute !important;


}

.mostrar {
    display: list-item !important;
    opacity: 1 !important;
    position: absolute !important;
    background-color: #3c29297a !important;
    width: 100%;
    /* Ocupa todo el ancho */
    height: 100%;
    /* Ocupa toda la altura */
}

.div-error {
    display: flex;
    justify-content: center;
}

.text-error {
    color: red !important;
    font-weight: bold;
}
</style>
