<template>
    <main class="main">
        <!-- Breadcrumb -->
        <!-- <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/">Escritorio</a></li>
    </ol>-->
        <div class="container-fluid">
            <!-- Ejemplo de tabla Listado -->
            <div class="card mt-2">
                <div class="card-header">
                    <i class="fa fa-align-justify"></i> Consulta de Ordenes
                    <!-- <el-button
                        plain
                        type="primary"
                        icon="el-icon-circle-plus"
                        @click="abrirModal('orden', 'registrar')"
                        >Nuevo</el-button
                    > -->
                    <!-- <el-button
                        type="danger"
                        icon="el-icon-document"
                        @click="cargarPdf()"
                        >Reporte</el-button
                    > -->
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <div class="col-md-12">
                            <div class="input-group">
                                <template>
                                    <div class="mr-2 mb-2">
                                        <el-date-picker size="small" v-model="fechaInicio" type="date"
                                            placeholder="Escoge un día" format="yyyy/MM/dd"
                                            value-format="yyyy-MM-dd"></el-date-picker>
                                    </div>
                                </template>

                                <template>
                                    <div class="mr-6 mb-2">
                                        <el-date-picker size="small" v-model="fechaFinal" type="date"
                                            placeholder="Escoge un día" format="yyyy/MM/dd"
                                            value-format="yyyy-MM-dd"></el-date-picker>
                                    </div>
                                </template>
                                <div class=" ">
                                    <el-button size="small" type="primary"
                                        @click="listarReporte(1, fechaInicio, fechaFinal)"><i class="fa fa-search"></i>
                                        Buscar</el-button>

                                </div>

                            </div>
                        </div>
                    </div>
                    <table class="table table-sm table-hover table-responsive ">
                        <thead>
                            <tr>
                                <th>Opciones</th>
                                <th>Id</th>
                                <th>Cliente</th>
                                <th>Tecnico</th>
                                <th>Nombre</th>
                                <th>Marca</th>
                                <th>Modelo</th>
                                <th>Serial</th>
                                <th>Clave</th>
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
                                    <!-- <button type="button" @click="
                                        abrirModal(
                                            'orden',
                                            'actualizar',
                                            orden
                                        )
                                        " class="btn btn-warning btn-sm">
                                        <i class="icon-pencil"></i>
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
                                <td v-text="orden.serial"></td>
                                <td v-text="orden.clave"></td>
                                <td v-text="orden.accesorios"></td>
                                <td v-text="orden.observaciones"></td>
                                <td v-text="orden.fallaEquipo"></td>
                                <td v-text="orden.reparacion"></td>
                                <td v-text="orden.fechaEntrada"></td>
                                <td v-text="orden.fechaEntrega"></td>
                                <td v-text="orden.adelanto"></td>
                                <td v-text="orden.totalPagar"></td>
                                <td v-text="orden.estado"></td>
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
                        <!-- footer de la tabla -->
                        <tfoot style="background-color:#ffffff">

                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th></th>
                            <th>Total adelanto</th>
                            <th>
                                <h3 class="badge bg-success ">s/.{{ sumarTotalAdelanto }}</h3>
                            </th>
                            <th>Cuenta Cobrar</th>
                            <th>
                                <h3 class="badge bg-danger">s/.{{ sumarTotalCuentaCobrar }}</h3>
                            </th>
                            <th class="">Total pagar</th>
                            <th>
                                <h3 class="badge bg-primary">S/.{{ sumarTotal }}</h3>
                            </th>
                            <th></th>

                        </tfoot>

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

                            <li class="page-item" v-if="
                                pagination.current_page <
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
        <div class="modal fade" tabindex="-1" :class="{ mostrar: modal }" role="dialog"
            aria-labelledby="myLargeModalLabel" style="display: none" aria-hidden="true">
            <div class="modal-dialog modal-primary modal-lg" role="document">
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
                                <div class="col-md-4">
                                    <div>
                                        <label class for="text-input">Numero Orden</label>
                                        <div class>
                                            <el-input placeholder="orden" size="mini" v-model="orden_id"
                                                :disabled="true"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class>
                                        <label class for="text-input">Cliente</label>
                                        <div class>
                                            <template>
                                                <el-select size="mini" v-model="idcliente"
                                                    placeholder="Selecciona el cliente">
                                                    <el-option v-for="cliente in arrayCliente" :key="cliente.id"
                                                        :label="cliente.nombre" :value="cliente.id"></el-option>
                                                </el-select>
                                            </template>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div>
                                        <label class for="text-input">Tecnico</label>
                                        <div class>
                                            <template>
                                                <el-select size="mini" v-model="idtecnico"
                                                    placeholder="Selecciona el tecnico">
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
                                                <el-date-picker v-model="fechaEntrega" type="date"
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
                                            <el-input placeholder="Adelanto" size="mini" v-model="adelanto"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Total Pagar</label>
                                        <div class>
                                            <el-input placeholder="Total pagar" size="mini"
                                                v-model.number="totalPagar"></el-input>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <label class for="text-input">Estado</label>
                                        <div class="">
                                            <template>
                                                <el-select v-model="estado" clearable placeholder="Seleciona el estado">
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

                        <button type="button" class="btn btn-danger" @click="cerrarModal()">
                            Cerrar
                        </button>
                        <button type="button" v-if="tipoAccion == 1" class="btn btn-primary" @click="registrarOrden()">
                            Guardar
                        </button>
                        <button type="button" v-if="tipoAccion == 2" class="btn btn-primary" @click="actualizarOrden()">
                            Actualizar
                        </button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
    </main>
</template>

<script>
export default {
    data() {
        return {
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
            arrayReporte: [],
            modal: 0,
            tituloModal: "",
            tipoAccion: 0,
            errorOrden: 0,
            errorMostrarMsjOrden: [],
            //report
            listado: 1,
            arrayReporte: [],
            fechaInicio: '',
            fechaFinal: '',
            sumTotal: '',
            sumTotalAdelanto: '',
            sumCuentaCobrar: '',
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
        /*calcularTotal: function(){
                 var resultado=0.0;
                 for(var i=0;i<this.arrayOrden.length;i++){
                     resultado=resultado+(this.arrayOrden[i].precio*this.arrayOrden[i].cantidad-this.arrayDetalle[i].descuento)
                 }
                 return resultado;
             }, */
        sumarTotal: function () {
            // this.listarReporte(page,fechaInicio,fechaFinal);
            let sumTotal = 0;
            for (let i = 0; i < this.arrayOrden.length; i++) {
                sumTotal = sumTotal + parseFloat(this.arrayOrden[i].totalPagar);
                //console.log(sumTotal);
            }
            return (sumTotal).toFixed(2);
        },
        //sumar el saldo
        sumarTotalAdelanto: function () {
            // this.listarReporte(page,fechaInicio,fechaFinal);
            let sumTotalAdelanto = 0;
            for (let i = 0; i < this.arrayOrden.length; i++) {
                sumTotalAdelanto = sumTotalAdelanto + parseFloat(this.arrayOrden[i].adelanto);
                //console.log(sumTotalAdelanto);
            }
            //console.log(sumTotalAdelanto);
            return (sumTotalAdelanto).toFixed(2);
        },
        //sumar el cuenta cobrar
        sumarTotalCuentaCobrar: function () {
            // this.listarReporte(page,fechaInicio,fechaFinal);
            let sumCuentaCobrar = 0;
            sumCuentaCobrar = (this.sumarTotal) - (this.sumarTotalAdelanto);
            //console.log(sumCuentaCobrar);
            return (sumCuentaCobrar).toFixed(2);
        }
    },
    created: function () {
        const hoy = new Date();
        console.log(hoy)
        //var fechass=hoy.getDate()+'-'+(hoy.getMonth()+1)+'-'+hoy.getFullYear();
        var fechasso = hoy.getFullYear() + '-' + (hoy.getMonth() + 1) + '-' + hoy.getDate();

        //console.log(fechasso);
        //console.log(fechass);
        this.listarReporte(1, fechasso, fechasso);

    },
    methods: {
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
                "/orden?page=" +
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
                    // console.log(arrayOrden);
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
                    //me.pagination = respuesta.pagination;
                    // console.log(arrayCategoria);
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
                    //window.open('/orden/pdf/'+ response.data.id);
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
                            this.modal = 1;
                            this.tituloModal = "Actualizar Orden";
                            this.tipoAccion = 2;
                            this.orden_id = data["id"];
                            this.idcliente = data["idcliente"];
                            // console.log(this.idcliente);
                            this.idtecnico = data["idtecnico"];
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
            }
            this.selectCliente();
            this.selectTecnico();
        },
        pdfOrden(id) {
            window.open('/orden/pdf/' + id, '_blank');
        },
        //metodo para filtrar
        listarReporte(page, fechaInicio, fechaFinal) {
            let me = this;
            var url = '/orden/reportes?page=' + page + '&fechaInicio=' + fechaInicio + '&fechaFinal=' + fechaFinal;
            axios.get(url).then(function (response) {
                var respuesta = response.data;
                me.arrayOrden = respuesta.ordenes.data;
                me.pagination = respuesta.pagination;
                //this.sumarTotal();
                //console.log(me.arrayReporte);
            })
                .catch(function (error) {
                    console.log(error);
                });
        }
    },
    mounted() {
        //this.listarOrden(1,fechaInicio,fechaFinal);
    },
};
</script>
<style>
.modal-content {
    width: 100% !important;

    border-radius: 10px;
    margin-top: 5px;
    position: absolute !important;
}

.mostrar {
    display: list-item !important;
    opacity: 1 !important;
    position: absolute !important;
    background-color: #3c29297a !important;
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
