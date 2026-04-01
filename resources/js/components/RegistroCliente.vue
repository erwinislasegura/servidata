<template>
    <el-row :gutter="20">
        <el-col :xs="24" :md="16" :span="16">
            <div class="">
                <label class="form-control-label" for="text-input">Nombre</label>
                <div class="">
                    <el-input size="small" placeholder="Nombre del cliente" v-model="nombre"></el-input>
                </div>
            </div>
        </el-col>
        <el-col :xs="24" :md="16" :span="16">
            <div class="">
                <label class=" form-control-label" for="text-input">Tipo documento</label>
                <div class="">
                    <el-select size="small" v-model="tipo_documento" placeholder="Select">
                        <el-option v-for="item in optionsCli" :key="item.value" :label="item.label"
                            :value="item.value"></el-option>
                    </el-select>
                </div>
            </div>
        </el-col>
        <el-col :xs="24" :md="16" :span="16">
            <div class="form-group row">
                <label class=" form-control-label" for="text-input">Numero</label>
                <div class="">
                    <el-input size="small" placeholder="Numero de documento" v-model="num_documento"></el-input>
                    <!-- <input class="form-control" type="text" v-model="num_documento" placeholder="Numero de documento" > -->
                </div>
            </div>
        </el-col>
        <el-col :xs="24" :md="16" :span="16">
            <div class="form-group row">
                <label class=" form-control-label" for="text-input">Direccion</label>
                <div class="">
                    <el-input size="small" placeholder="Dirección" v-model="direccion"></el-input>
                </div>
            </div>
        </el-col>
        <el-col :xs="24" :md="16" :span="16">
            <div class="form-group ">
                <label class=" form-control-label" for="text-input">Telefono</label>
                <div class="">
                    <el-input size="small" placeholder="Telefono" v-model="telefono"></el-input>
                </div>
            </div>
        </el-col>
        <el-col :xs="24" :md="16" :span="16">
            <div class="form-group ">
                <label class=" form-control-label" for="text-input">Email</label>
                <div class="">
                    <el-input size="small" placeholder="Email@gmail.com" v-model="email"></el-input>
                </div>
            </div>
            <div v-show="errorCliente" class="form-group row div-error">
                <div class="text-center text-error">
                    <div v-for="error in errorMostrarMsjCliente" :key="error" v-text="error"></div>
                </div>
            </div>
            <!-- <button type="button" class="btn btn-primary" @click="registrarCliente()">
                Registrar cliente
            </button> -->
            <el-button @click="registrarCliente()" type="primary">Registrar</el-button>
        </el-col>


        <!-- <button type="button" class="btn btn-primary" @click="updateClient()">
            update
        </button> -->





    </el-row>
</template>
<script>

export default {
    props: {


    },

    data() {
        return {

            //propiedades de cliente
            cliente_id: 0,
            nombre: "",
            tipo_documento: "DNI",
            num_documento: "",
            direccion: "",
            telefono: "",
            email: "",
            //para select
            optionsCli: [
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
            errorCliente: 0,
            errorMostrarMsjCliente: [],
        }
    },
    methods: {
        limpiar() {
            this.cliente_id = "";
            this.nombre = "";
            this.tipo_documento = "DNI"
            this.num_documento = "";
            this.direccion = "";
            this.telefono = "";
            this.email = "";
        },
        updateClient() {
            this.$emit('escuchar');

        },

        guardar() {
            this.$message({
                message: "Cliente Guardado con éxito.",
                type: "success",
            });
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
                    //me.cerrarModal();
                    //me.listarCliente(1, "", "nombre");
                    me.guardar();
                    me.updateClient();//chancando para actualizar en select
                    me.limpiar();//limpia los controles
                })
                .catch(function (error) {
                    console.log(error);
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

    }
}
</script>