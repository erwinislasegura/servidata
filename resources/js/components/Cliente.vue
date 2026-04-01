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
                    <div class="">
                        <i class="fa fa-align-justify"></i> Clientes
                        <el-button size="small" plain type="primary" icon="el-icon-circle-plus"
                            @click="abrirModal('cliente', 'registrar')">Nuevo</el-button>
                        <el-button size="small" type="danger" icon="el-icon-document"
                            @click="cargarPdf()">Reporte</el-button>
                    </div>
                </div>
                <div class="card-body">
                    <div class="form-group row">
                        <div class="col-md-6">
                            <div class="input-group">
                                <div class="mr-1 mb-2">
                                    <el-select size="small" v-model="criterio" placeholder="Select">
                                        <el-option v-for="item in valores" :key="item.value" :label="item.label"
                                            :value="item.value"></el-option>
                                    </el-select>
                                </div>
                                <div class="mr-1 mb-2">
                                    <el-input size="small" @keyup.native.enter="
                                        listarCliente(1, buscar, criterio)
                                        " placeholder="Texto a buscar" v-model="buscar"></el-input>
                                </div>

                                <div>
                                    <el-button size="small" icon="el-icon-search" type="primary" @click="
                                        listarCliente(1, buscar, criterio)
                                        ">Buscar</el-button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table class="table table-sm table-hover table-responsive-sm">
                        <thead>
                            <tr>
                                <th>Opciones</th>
                                <th>Nombre</th>
                                <th>Tipo Documento</th>
                                <th>Número</th>
                                <th>Dirección</th>
                                <th>Teléfono</th>
                                <th>Email</th>
                                <th>Estado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="cliente in arrayCliente" :key="cliente.id">
                                <td>
                                    <button type="button" @click="
                                        abrirModal(
                                            'cliente',
                                            'actualizar',
                                            cliente
                                        )
                                        " class="btn btn-warning btn-sm">
                                        <i class="icon-pencil"></i>
                                    </button>
                                    &nbsp;
                                    <template v-if="cliente.condicion">
                                        <button type="button" @click="
                                            desactivarCliente(cliente.id)
                                            " class="btn btn-danger btn-sm">
                                            <i class="icon-trash"></i>
                                        </button>
                                    </template>
                                    <template v-else>
                                        <button type="button" @click="activarCliente(cliente.id)"
                                            class="btn btn-info btn-sm">
                                            <i class="icon-check"></i>
                                        </button>
                                    </template>
                                </td>
                                <td v-text="cliente.nombre"></td>
                                <td v-text="cliente.tipo_documento"></td>
                                <td v-text="cliente.num_documento"></td>
                                <td v-text="cliente.direccion"></td>
                                <td v-text="cliente.telefono"></td>
                                <td v-text="cliente.email"></td>
                                <td>
                                    <div v-if="cliente.condicion">
                                        <span class="badge badge-success">Activo</span>
                                    </div>
                                    <div v-else>
                                        <span class="badge badge-danger">Desactivado</span>
                                    </div>
                                </td>
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
        <div class="modal fade" tabindex="-1" :class="{ mostrar: modal }" role="dialog" aria-labelledby="myModalLabel"
            style="display: none" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-scrollable " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title" v-text="tituloModal"></h6>
                        <button type="button" class="close" @click="cerrarModal()" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action method="post" enctype="multipart/form-data" class="form-horizontal">
                            <div class="form-group row">
                                <label class="col-md-3 form-control-label" for="text-input">Nombre</label>
                                <div class="col-md-9">
                                    <el-input placeholder="Nombre del cliente" size="small" v-model="nombre"></el-input>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-3 form-control-label" for="text-input">Tipo documento</label>
                                <div class="col-md-9">
                                    <el-select size="small" v-model="tipo_documento" placeholder="Select">
                                        <el-option v-for="item in options" :key="item.value" :label="item.label"
                                            :value="item.value"></el-option>
                                    </el-select>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-3 form-control-label" for="text-input">Numero</label>
                                <div class="col-md-9">
                                    <el-input size="small" placeholder="Numero de documento"
                                        v-model="num_documento"></el-input>
                                    <!-- <input class="form-control" type="text" v-model="num_documento" placeholder="Numero de documento" > -->
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-3 form-control-label" for="text-input">Direccion</label>
                                <div class="col-md-9">
                                    <el-input placeholder="Dirección" size="small" v-model="direccion"></el-input>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-3 form-control-label" for="text-input">Telefono</label>
                                <div class="col-md-9">
                                    <el-input placeholder="Telefono" size="small" v-model="telefono"></el-input>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-3 form-control-label" for="text-input">Email</label>
                                <div class="col-md-9">
                                    <el-input placeholder="Email@gmail.com" size="small" v-model="email"></el-input>
                                </div>
                            </div>

                            <div v-show="errorCliente" class="form-group row div-error">
                                <div class="text-center text-error">
                                    <div v-for="error in errorMostrarMsjCliente" :key="error" v-text="error"></div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" @click="cerrarModal()">
                            Cerrar
                        </button>
                        <button type="button" v-if="tipoAccion == 1" class="btn btn-primary"
                            @click="registrarCliente()">
                            Guardar
                        </button>
                        <button type="button" v-if="tipoAccion == 2" class="btn btn-primary"
                            @click="actualizarCliente()">
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
                    value: "DNI",
                    label: "DNI",
                },
                {
                    value: "RUC",
                    label: "RUC",
                },
                {
                    value: "PASS",
                    label: "PASS",
                },
            ],
            valores: [
                {
                    value: "nombre",
                    label: "Nombre",
                },
                {
                    value: "num_documento",
                    label: "Documento",
                },
                {
                    value: "Email",
                    label: "Email",
                },
                {
                    value: "telefono",
                    label: "Telefono",
                },
            ],
            cliente_id: 0,
            nombre: "",
            tipo_documento: "DNI",
            num_documento: "",
            direccion: "",
            telefono: "",
            email: "",
            arrayCliente: [],
            modal: 0,
            tituloModal: "",
            tipoAccion: 0,
            errorCliente: 0,
            errorMostrarMsjCliente: [],
            pagination: {
                total: 0,
                current_page: 0,
                per_page: 0,
                last_page: 0,
                from: 0,
                to: 0,
            },
            offset: 3,
            criterio: "nombre",
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
    },
    methods: {
        guardar() {
            this.$message({
                message: "Cliente Guardado con éxito.",
                type: "success",
            });
        },
        editar() {
            this.$message({
                message: "Cliente Actualizado con éxito.",
                type: "success",
            });
        },
        //carga pdf clientes
        cargarPdf() {
            window.open("/cliente/listarPdf", "_blank");
        },
        listarCliente(page, buscar, criterio) {
            let me = this;
            var url =
                "/cliente?page=" +
                page +
                "&buscar=" +
                buscar +
                "&criterio=" +
                criterio;
            axios
                .get(url)
                .then(function (response) {
                    var respuesta = response.data;
                    me.arrayCliente = respuesta.clientes.data;
                    me.pagination = respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
        },
        cambiarPagina(page, buscar, criterio) {
            let me = this;
            me.pagination.current_page = page;
            me.listarCliente(page, buscar, criterio);
        },
        registrarCliente() {
            //validando campos categoria
            if (this.validarCliente()) {
                return;
            }

            let me = this;

            axios
                .post("/cliente/registrar", {
                    nombre: this.nombre,
                    tipo_documento: this.tipo_documento,
                    num_documento: this.num_documento,
                    direccion: this.direccion,
                    telefono: this.telefono,
                    email: this.email,
                })
                .then(function (response) {
                    me.cerrarModal();
                    me.listarCliente(1, "", "nombre");
                    me.guardar();
                })
                .catch(function (error) {
                    console.log(error);
                });
        },
        actualizarCliente() {
            //validando campos categoria
            if (this.validarCliente()) {
                return;
            }

            let me = this;
            axios
                .put("/cliente/actualizar", {
                    nombre: this.nombre,
                    tipo_documento: this.tipo_documento,
                    num_documento: this.num_documento,
                    direccion: this.direccion,
                    telefono: this.telefono,
                    email: this.email,
                    id: this.cliente_id,
                })
                .then(function (response) {
                    me.cerrarModal();
                    me.listarCliente(1, "", "nombre");
                    me.editar();
                })
                .catch(function (error) {
                    console.log(error);
                });
        },
        desactivarCliente(id) {
            Swal.fire({
                title: "Estas seguro de desactivar este cliente?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Aceptar",
            }).then((result) => {
                if (result.value) {
                    let me = this;
                    axios
                        .put("/cliente/desactivar", {
                            id: id,
                        })
                        .then(function (response) {
                            me.listarCliente(1, "", "nombre");
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                }
            });
        },
        activarCliente(id) {
            Swal.fire({
                title: "Estas seguro de activar este proveedor?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Aceptar",
            }).then((result) => {
                if (result.value) {
                    let me = this;
                    axios
                        .put("/cliente/activar", {
                            id: id,
                        })
                        .then(function (response) {
                            Swal.fire(
                                "Activado!",
                                "El registro ha sido desactivado con éxito.",
                                "success"
                            );
                            me.listarCliente(1, "", "nombre");
                        })
                        .catch(function (error) {
                            console.log(error);
                        });
                }
            });
        },

        validarCliente() {
            this.errorCliente = 0;
            this.errorMostrarMsjCliente = [];

            if (!this.nombre)
                this.errorMostrarMsjCliente.push(
                    "El nombre deL cliente no puede estar vacío."
                );

            if (this.errorMostrarMsjCliente.length) this.errorCliente = 1;

            return this.errorCliente;
        },
        cerrarModal() {
            this.modal = 0;
            this.tituloModal = "";
            this.nombre = "";
            this.tipo_documento = "";
            this.num_documento = "";
            this.direccion = "";
            this.telefono = "";
            this.email = "";
            this.errorCliente = 0;
        },
        abrirModal(modelo, accion, data = []) {
            switch (modelo) {
                case "cliente": {
                    switch (accion) {
                        case "registrar": {
                            this.modal = 1;
                            this.tituloModal = "Registrar Cliente";
                            this.nombre = "";
                            this.tipo_documento = "DNI";
                            this.num_documento = "";
                            this.direccion = "";
                            this.telefono = "";
                            this.email = "";
                            this.tipoAccion = 1;
                            break;
                        }
                        case "actualizar": {
                            this.modal = 1;
                            this.tituloModal = "Actualizar cliente";
                            this.tipoAccion = 2;
                            this.cliente_id = data["id"];
                            this.nombre = data["nombre"];
                            this.tipo_documento = data["tipo_documento"];
                            this.num_documento = data["num_documento"];
                            this.direccion = data["direccion"];
                            this.telefono = data["telefono"];
                            this.email = data["email"];

                            break;
                        }
                    }
                }
            }
        },
    },
    mounted() {
        this.listarCliente(1, this.buscar, this.criterio);
    },
};
</script>
<style>
.modal-content {
    width: 100% !important;
    border-radius: 10px;
    margin-top: 20px;
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
