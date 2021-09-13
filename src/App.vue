<template>
  <div id="app">
    <div id="logo"><img src="./assets/logo.png"></div>
    <SecretManager
            msg="Welcome to SecretManager"
            serverUrl="http://localhost:3000"
    />
  </div>
</template>

<script>
import SecretManager from './components/SecretManager.vue'

export default {
  name: 'App',
  components: {
      SecretManager
  }
}
</script>

<style>
  body, #app {
    margin: 0;
    padding: 0;
    border: 0;
  }
  #app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: black;
    margin-top: 20px;
  }
  #logo {
    text-align: left;
    margin-left: 10px;
  }
</style>
