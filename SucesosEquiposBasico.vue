<script>
import EquipoBasico from './EquipoBasico.vue'
import participantesJSON from '../assets/participantes.json'

export default {
  components: {
    EquipoBasico
  },
  data() {
    return {
      golesTotales: 0,
      rojasTotales: 0,
      amarillasTotales: 0,
      participantes: [],
      ultimoSuceso: ''
    }
  },
  created() {
    this.participantes = participantesJSON
  },
  methods: {
    golClickeado(nombreSuceso, equipo) {
      console.log("GOL RECIBIDO DESDE ELEMENTO HIJO")
      this.golesTotales++;
      this.ultimoSuceso = nombreSuceso + " del " + equipo;
    },
    amarillaClickeada(nombreSuceso, equipo) {
      console.log("AMARILLA RECIBIDA DESDE ELEMENTO HIJO")
      this.amarillasTotales++;
      this.ultimoSuceso = nombreSuceso + " del " + equipo;
    },
    rojaClickeada(nombreSuceso, equipo) {
      console.log("ROJA RECIBIDA DESDE ELEMENTO HIJO")
      this.rojasTotales++;
      this.ultimoSuceso = nombreSuceso + " del " + equipo;
    }
  }
}
</script>


<template>
  <div class="contenedor-centrado">
    <h3>RESULTADOS TOTALES</h3>
    Goles {{ golesTotales }}
    Amarillas {{ amarillasTotales }}
    Rojas {{ rojasTotales }}
    <hr>
    <h5> Ultimo suceso: <span> {{ ultimoSuceso }} </span> </h5>
  </div>
  <hr>
  <div class="contenedor-equipos">
    <EquipoBasico v-for="participante of participantes" :nombreEquipo="participante.nombre" :idEquipo="participante.id"
      @click-gol="golClickeado" @click-amarilla="amarillaClickeada" @click-roja="rojaClickeada" />
  </div>
</template>      

<style>
.contenedor-centrado {
  text-align: center;
  margin: 5vw;
  margin-top: 56px;
  margin-bottom: 0px;
}
</style>



