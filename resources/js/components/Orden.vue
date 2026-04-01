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
                    <i class="fa fa-align-justify"></i> Ordenes
                    <el-button plain type="primary" icon="el-icon-circle-plus"
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
                                    <!-- <button type="button" @click="pdfOrden(orden.id)" class="btn btn-primary btn-sm">
                                        <i class="fas fa-print"></i>


                                    </button> -->
                                    <el-button @click="pdfOrden(orden.id)" size="mini" type="primary"><i
                                            class="fas fa-print"></i></el-button>
                                    <el-button @click="modalentregar(orden)" class="mt-1" type="success" size="mini"
                                        :disabled="orden.estado === 'Entregado'">
                                        Entregar
                                    </el-button>
                                    <el-button class="mt-1" @click="generateBarcode(orden.id)" size="mini"><i
                                            class="fas fa-barcode"></i> Etiquetas</el-button>
                                    <!-- <el-button @click="printBarcode()">Default</el-button> -->
                                    &nbsp;


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
                        <template>
                            <el-tabs v-model="activeName" @tab-click="handleClick">
                                <el-tab-pane label="Datos del equipo" name="first">
                                    <form action method="post" enctype="multipart/form-data" class="form-horizontal">
                                        <div v-show="errorOrden" class="form-group row div-error">
                                            <div class="text-center text-error">
                                                <div v-for="error in errorMostrarMsjOrden" :key="error" v-text="error">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4 col-6  d-none d-sm-blocke">
                                            <div>
                                                <label class for="text-input">Numero Orden</label>
                                                <div class>
                                                    <el-input placeholder="orden" size="mini" v-model="orden_id"
                                                        :disabled="true"></el-input>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">

                                            <div class="col-md-6 col-6">
                                                <div class>
                                                    <label class for="text-input">Cliente</label>
                                                    <!-- <el-button type="text" @click="centerDialogVisible = true"> nuevo</el-button> -->
                                                    <div class>
                                                        <template>
                                                            <el-select size="mini" v-model="idcliente"
                                                                placeholder="Selecciona el cliente">
                                                                <el-option v-for="cliente in arrayCliente"
                                                                    :key="cliente.id" :label="cliente.nombre"
                                                                    :value="(cliente.id)"></el-option>
                                                            </el-select>
                                                            <div class="m-2">
                                                                <el-button size="mini" v-if="tipoAccion == 1"
                                                                    type="primary" icon="el-icon-circle-plus"
                                                                    @click="centerDialogVisible = true">
                                                                    New</el-button>
                                                            </div>

                                                        </template>


                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-6">
                                                <div>
                                                    <label class for="text-input">Tecnico</label>
                                                    <div class>
                                                        <template>
                                                            <el-select @change="buscaruser()" size="mini"
                                                                v-model="idtecnico" placeholder="Selecciona el tecnico">
                                                                <el-option v-for="tecnico in arrayTecnico"
                                                                    :key="tecnico.id" :label="tecnico.nombre"
                                                                    :value="tecnico.id"></el-option>
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
                                                        <el-input placeholder="Marca" size="mini"
                                                            v-model="marca"></el-input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div>
                                                    <label class for="text-input">Modelo</label>
                                                    <div class>
                                                        <el-input placeholder="Modelo" size="mini"
                                                            v-model="modelo"></el-input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div>
                                                    <label class for="text-input">Serial</label>
                                                    <div class>
                                                        <el-input placeholder="Serial" size="mini"
                                                            v-model="serial"></el-input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div>
                                                    <label class for="text-input">Clave</label>
                                                    <div class>
                                                        <el-input placeholder="Clave" size="mini"
                                                            v-model="clave"></el-input>
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
                                                        <el-input placeholder="Adelanto" size="mini"
                                                            v-model="adelanto"></el-input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div>
                                                    <label class for="text-input">Total Pagar</label>
                                                    <div class>
                                                        <el-input placeholder="Total pagar" size="mini"
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
                                                        <!-- <input type="file" @change="handleFileUpload" /> -->
                                                        <!-- <input type="file" @change="onFileChange" /> -->
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                        <!-- fin form -->
                                    </form>
                                </el-tab-pane>
                                <el-tab-pane label="Imagen" name="second">
                                    <!-- tomar foto componente -->
                                    <template>
                                        <div class="row">
                                            <div v-if="tipoAccion == 1" class=" col-12 col-md-12">
                                                <div class="m-2">
                                                    <el-button @click="startCamera()" size="mini" type="primary"
                                                        plain>abrir
                                                        camara</el-button>
                                                    <el-button @click="end()" size="mini" type="danger" plain>Cerrar
                                                        camara</el-button>
                                                    <!-- Botones  capturar foto-->
                                                    <el-button @click="capturarImagen" icon="el-icon-camera-solid"
                                                        circle></el-button>
                                                </div>
                                                <!-- Vista previa de la cámara -->
                                                <video ref="video" autoplay width="320" height="240"></video>

                                                <!-- Canvas para mostrar la imagen capturada -->
                                                <canvas ref="canvas" width="320" height="240"
                                                    style="display: none;"></canvas>


                                                <!-- <button @click="capturarImagen">Capturar Imagen</button> -->
                                                <!-- <button @click="registrarOrden" v-if="imagen">Registrar Orden</button> -->
                                            </div>

                                        </div>


                                    </template>
                                    <!-- fin del componente tomar foto -->
                                    <div>
                                        <!-- Mostrar imagen si existe -->

                                        <!-- <img :src="{imagen}" alt="Imagen de la Orden" /> -->
                                        <!-- <img :src="`/storage/${imagen}`" alt="Imagen de la Orden" />


                                        <img :src="`/${imagen}`" alt="Imagen de la Orden" width="320" height="240" /> -->
                                        <div class="text-center" v-if="imagen">
                                            <img class="rounded float-start img-responsive" :src="`/storage/${imagen}`"
                                                alt="Imagen de la Orden" width="320" height="240" />
                                        </div>

                                        <!-- Mensaje si no hay imagen -->
                                        <div v-else>
                                            <p>No hay imagen disponible</p>
                                        </div>
                                    </div>


                                </el-tab-pane>

                            </el-tabs>
                        </template>

                    </div>
                    <div class="modal-footer">

                        <!-- <button type="button" class="btn btn-danger" @click="cerrarModal()">
                            Cerrar
                        </button> -->
                        <el-button type="danger" @click="cerrarModal()">Cerrar</el-button>
                        <!-- <button type="button" v-if="tipoAccion == 1" class="btn btn-primary" @click="registrarOrden()">
                            Guardar
                        </button> -->
                        <el-button type="primary" v-if="tipoAccion == 1" @click="registrarOrden()">Registrar
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

        <!-- modal entregar -->
        <el-dialog title="Vamos entregar el equipo" :visible.sync="centerDialogVisibleentregar" width="30%" center>
            <el-row :gutter="20">
                <el-col :xs="24" :md="12" :span="12">
                    <div class="">
                        <label>Nombre del equipo</label>
                        <el-input size="small" placeholder="nombre del equipo" v-model="nombreEquipo"></el-input>
                    </div>
                </el-col>
                <el-col :xs="24" :md="12" :span="12">
                    <div class="">
                        <label>Marca</label>
                        <el-input size="small" placeholder="marca del equipo" v-model="marca"></el-input>
                    </div>
                </el-col>

            </el-row>
            <el-row :gutter="20">
                <el-col :xs="24" :md="12" :span="12">
                    <div class="">
                        <label>Modelo</label>
                        <el-input size="small" placeholder="modelo del equipo" v-model="modelo"></el-input>
                    </div>
                </el-col>
                <el-col :xs="24" :md="12" :span="12">
                    <div class="">
                        <label>Accesorio</label>
                        <el-input size="small" placeholder="Accesorio" v-model="accesorios"></el-input>
                    </div>
                </el-col>

            </el-row>
            <el-row :gutter="20">
                <el-col :xs="24" :md="12" :span="12">
                    <div class="">
                        <label>Adelanto</label>
                        <el-input @keyup.native.enter="calcularsaldo()" size="small" placeholder="Adelanto"
                            v-model="adelanto"></el-input>
                    </div>
                </el-col>
                <el-col :xs="24" :md="12" :span="12">
                    <div class="">
                        <label>Total pagar</label>
                        <el-input size="small" placeholder="Total a pagar" v-model="totalPagar"></el-input>
                    </div>
                </el-col>

            </el-row>
            <el-row :gutter="20">
                <el-col :xs="24" :md="24" :span="24">
                    <div class="">
                        <label class="text-primary"> El cliente tiene un Saldo de :</label>

                        <el-input class="text-primary" size="small" placeholder="Adelanto" v-model="saldo"></el-input>
                    </div>
                </el-col>


            </el-row>

            <!-- <span>It should be noted that the content will not be aligned in center by default</span> -->
            <span slot="footer" class="dialog-footer">
                <el-button type="danger" @click="cerrarModal(), centerDialogVisibleentregar = false">Cerrar</el-button>
                <el-button type="primary" @click="actualizarOrdenEntregar()">Guardar cambios</el-button>
                <!-- <el-button @click="centerDialogVisibleentregar = false">Cancel</el-button> -->
                <!-- <el-button type="primary" @click="centerDialogVisibleentregar = false">Confirm</el-button> -->
            </span>
        </el-dialog>
        <!-- fin modal entregar -->




    </main>
</template>

<script>
import printJS from 'print-js';
import cliente from './RegistroCliente.vue';
export default {
    components: { cliente },
    data() {
        return {
            text: '',
            barcodeUrl: '',
            error: null,   // Mensaje de error
            imagen: null,
            activeName: 'first',
            stream: null, // Guardará el MediaStream activo
            isCameraActive: false, // Indica si la cámara está activa
            photo: null, // Almacena la imagen capturada en formato base64
            centerDialogVisibleentregar: false,
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
                {
                    value: "fechaEntrega",
                    label: "Fecha Entrega",
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
            saldo: 0,
            mensageerror: '',
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

        printBarcode() {

            printJS({
                printable: this.barcodeUrl,
                type: 'image',
                style: 'img { width: 100%; max-width: 600px; }',
                documentTitle: 'Código de Barras del orden'
            });
        },
        printBarcod2e() {
            const printWindow = document.createElement('iframe');
            printWindow.style.display = 'none'; // Ocultar el iframe
            document.body.appendChild(printWindow);

            const content = `
      <!DOCTYPE html>
      <html>
        <head>
          <title>Imprimir Código de Barras</title>
          <style>
            body {
              text-align: center;
              margin: 0; /* Eliminar márgenes para un mejor ajuste */
              padding: 20px; /* Espaciado adicional si es necesario */
            }
            img {
              width: 100%; /* Ajusta el tamaño de la imagen según sea necesario */
              max-width: 600px; /* Puedes establecer un límite de ancho */
            }
          </style>
        </head>
        <body>
          <h2>Código de Barras</h2>
          <img src="${this.barcodeUrl}" alt="Código de Barras" />
        </body>
      </html>
    `;

            printWindow.contentWindow.document.open();
            printWindow.contentWindow.document.write(content);
            printWindow.contentWindow.document.close();

            // Esperar a que el contenido se cargue antes de imprimir
            printWindow.onload = function () {
                printWindow.contentWindow.print();
                document.body.removeChild(printWindow); // Eliminar el iframe después de imprimir
            };
        },


        generateBarcode(id) {
            if (id) {
                this.barcodeUrl = `/api/barcode/${id}`;
                this.printBarcode();
            }
            //printBarcode();

        },
        end() {
            const video = this.$refs.video;

            const stream = video.srcObject;
            const tracks = stream.getTracks();
            tracks.forEach((track) => track.stop());
            video.srcObject = null;
        },
        capturarImagen() {
            const canvas = this.$refs.canvas;
            const video = this.$refs.video;

            // Dibujar el cuadro del video en el canvas
            const context = canvas.getContext("2d");
            context.drawImage(video, 0, 0, canvas.width, canvas.height);

            // Convertir el contenido del canvas a un Blob (imagen)
            canvas.toBlob((blob) => {
                this.imagen = new File([blob], "captura.jpg", { type: "image/jpeg" });
                // Detener la cámara
                const stream = video.srcObject;
                const tracks = stream.getTracks();
                tracks.forEach((track) => track.stop());
                video.srcObject = null;
            }, "image/jpeg");
        },
        onFileChange(event) {
            this.imagen = event.target.files[0];
        },
        handleClick(tab, event) {
            console.log(tab, event);
            //this.startCamera();

        },
        stopCamera() {
            //console.log('heelo')
            if (this.stream) {
                // Detener todas las pistas del stream
                this.stream.getTracks().forEach((track) => track.stop());
                this.stream = null;
                this.isCameraActive = false;
                console.log("Cámara detenida.");
            }
        },
        async startCamera() {
            try {
                const video = this.$refs.video;
                const stream = await navigator.mediaDevices.getUserMedia({ video: true });
                video.srcObject = stream;
            } catch (error) {
                console.error("Error al acceder a la cámara:", error);
                if (error.name === "NotAllowedError") {
                    alert("El acceso a la cámara está bloqueado. Habilítalo en la configuración del navegador.");
                } else if (error.name === "NotFoundError") {
                    alert("No se encontró ninguna cámara en tu dispositivo.");
                } else {
                    alert("No se pudo acceder a la cámara. Verifica los permisos.");
                }
            }
        },
        capturarImagen() {
            const canvas = this.$refs.canvas;
            const video = this.$refs.video;

            // Dibujar el cuadro del video en el canvas
            const context = canvas.getContext("2d");
            context.drawImage(video, 0, 0, canvas.width, canvas.height);

            // Detener el flujo de video
            const stream = video.srcObject;
            const tracks = stream.getTracks(); // Obtener las pistas del stream
            tracks.forEach((track) => track.stop()); // Detener cada pista

            // Ocultar el video y mostrar el canvas
            video.style.display = "none";
            canvas.style.display = "block";

            // Convertir el contenido del canvas a un Blob (imagen)
            canvas.toBlob((blob) => {
                this.imagen = new File([blob], "captura.jpg", { type: "image/jpeg" });
                console.log("Imagen capturada:", this.imagen);
            }, "image/jpeg");
        },

        async uploadPhoto() {
            if (!this.photo) {
                alert("Primero toma una foto");
                return;
            }

            // Enviar la foto al backend
            const formData = new FormData();
            formData.append("image", this.photo);

            try {
                await axios.post("/api/upload-image", formData, {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                });
                alert("Imagen subida con éxito");
            } catch (error) {
                console.error(error);
                alert("Error al subir la imagen");
            }
        },
        calcularsaldo() {
            //this.adelanto = "";
            // this.totalPagar = "";
            // this.saldo = "";
            let saldo = this.totalPagar - this.adelanto
            this.saldo = saldo

        },
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
        guardar(mensaje) {
            this.$message({
                message: mensaje,
                //message: "Orden Guardado con éxito.",
                type: "success",
            });
            this.outerVisible = true

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
        capturaeeror(error) {
            this.$message.error(error);
        },
        registrarOrden() {
            // Validando campos técnico
            if (this.validarOrden()) {
                return;
            }

            let me = this;

            // Crear una instancia de FormData
            let formData = new FormData();

            // Agregar los campos al FormData
            formData.append("idcliente", this.idcliente);
            formData.append("idtecnico", this.idtecnico);
            formData.append("idusuario", this.idusuario);
            formData.append("nombreEquipo", this.nombreEquipo);
            formData.append("marca", this.marca);
            formData.append("modelo", this.modelo);
            formData.append("serial", this.serial);
            formData.append("clave", this.clave);
            formData.append("accesorios", this.accesorios);
            formData.append("observaciones", this.observaciones);
            formData.append("fallaEquipo", this.fallaEquipo);
            formData.append("reparacion", this.reparacion);
            formData.append("fechaEntrada", this.fechaEntrada);
            formData.append("fechaEntrega", this.fechaEntrega);
            formData.append("adelanto", this.adelanto);
            formData.append("totalPagar", this.totalPagar);
            formData.append("estado", this.estado);

            // Agregar la imagen si existe
            if (this.imagen) {
                formData.append("imagen", this.imagen);
            }

            // Enviar la solicitud con Axios
            axios
                .post("/orden/registrar", formData, {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                })
                .then(function (response) {
                    me.cerrarModal();
                    me.listarOrden(1, "", "nombre");
                    const msg = (response.data.message);
                    me.guardar(msg);

                    me.fetchPdf(response.data.id);
                    // Abre la página para imprimir
                    //if (this.validarOrden()) {
                    // this.outerVisible = true;

                    // me.fetchPdf(response.data.id);
                    //}

                })
                .catch(function (error) {
                    //console.error(error);
                    if (error.response.status === 422) {
                        let errors = error.response.data.errors;
                        let errorMessage = Object.values(errors).flat().join(', ');
                        //this.$message.error('Errores de validación: ');
                        me.mensageerror = errorMessage;
                        me.capturaeeror(errorMessage);
                        //me.limpiar();
                    } else {
                        //this.$message.error('Error: ' + error.response.data.message);
                        let e = error.response.data.message
                        me.mensageerror = e
                        me.capturaeeror(e);
                        //me.limpiar();
                        me.open4();
                    }
                });
        },

        actualizarOrdenEntregar() {
            let me = this;
            me.estado = 'Entregado';
            axios
                .put("/orden/actualizar", {
                    idcliente: this.idcliente,
                    idtecnico: this.idtecnico,
                    idusuario: this.idusuario,
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
                    idusuario: this.idusuario,
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
            this.capturaeeror(this.errorMostrarMsjOrden);
            return this.errorOrden;

        },
        cerrarModal() {
            this.saldo = 0
            this.modal = 0;
            this.tituloModal = "";
            this.idcliente = "";
            this.imagen = null;
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
            this.stopCamera();
            this.imagen = null;
        },
        modalentregar(data = []) {
            //this.modal = 1;
            //this.tituloModal = "Actualizar Orden";
            //this.tipoAccion = 2;

            this.orden_id = data["id"];
            this.idcliente = data["idcliente"];
            this.idtecnico = data["idtecnico"];
            this.idusuario = data["idusuario"]

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
            this.centerDialogVisibleentregar = true
            this.calcularsaldo();

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
                            //console.log(data);
                            //this.selectCliente();
                            this.modal = 1;
                            this.tituloModal = "Actualizar Orden";
                            this.tipoAccion = 2;
                            this.orden_id = data["id"];
                            this.idcliente = data["idcliente"];
                            this.idtecnico = data["idtecnico"];
                            this.idusuario = data["idusuario"]

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
                            this.imagen = data["imagen"];
                            console.log(this.imagen);
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
        //this.startCamera();

    },

};
</script>
<style scoped>
video {
    border: 2px solid #ccc;
    border-radius: 8px;
    margin-bottom: 10px;
}

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
