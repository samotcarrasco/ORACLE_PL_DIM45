<script>
export default {
  props: {
    nombreEquipo: String,
    idEquipo: String
  },
  emits: ['clickGol', 'clickAmarilla', 'clickRoja'],
  data() {
    return {
      contadorGoles: 0,
      contadorAmarillas: 0,
      contadorRojas: 0
    }
  },
  methods: {
    clickGol() {
      this.contadorGoles++;
      this.$emit('clickGol','Gol',this.nombreEquipo)
    },
    clickAmarilla() {
      this.contadorAmarillas++;
      this.$emit('clickAmarilla','Tarjeta Amarilla',this.nombreEquipo)
    },
    clickRoja() {
      this.contadorRojas++;
      this.$emit('clickRoja','Tarjeta Roja',this.nombreEquipo)
    },
  }
}
</script>

<template>
  <div>
    <button class="gol" @click="clickGol">¡¡GOL!! </button>
    <button class="roja" @click="clickAmarilla">ROJA</button>
    <button class="amarilla" @click="clickRoja">AMARILLA</button>

    <b>{{ idEquipo }} - {{ nombreEquipo }} </b> Goles: <b>{{ contadorGoles }}</b> 
    Amarillas <b :class="{ amarillas:contadorAmarillas > 0 }">{{ contadorAmarillas }}</b> Rojas <b :class="{ rojas:contadorRojas > 0 }">{{ contadorRojas }}</b>
    <br>
  </div>
</template>

<style>
.gol {
  color: green;
}

.amarilla {
  color: rgb(221, 221, 48);
}

.roja {
  color: red;     
}

</style>
        
    