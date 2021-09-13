<template>
  <div id="main">

    <div class="headline">
      <div class="container hello">
        <h1>{{ msg }}</h1>
      </div>
    </div>

    <div class="add-secret">
      <div class="container">
        <h2>Add secret</h2>
        <div>Expire After Views</div>
        <div>
          <input v-model="addSecretData.expireAfterViews" type="number"/>
        </div>
        <div>TTL in min</div>
        <div>
          <input v-model="addSecretData.expireAfter" type="number"/>
        </div>
        <div>Secret text</div>
        <div>
          <textarea v-model="addSecretData.secretText" placeholder="Secret text"></textarea>
        </div>
        <div>
          <button v-on:click="addSecret">Add secret</button>
        </div>
      </div>
      <div v-if="addSecretData.response.code > 0" class="add-secret-response">
        <div v-if="addSecretData.response.code !== 200" class="warning">
          <div class="container">
            <div>Unsuccessful request</div>
          </div>
        </div>
        <div v-if="addSecretData.response.code === 200" class="success">
          <div class="container">
            <div>secret hash:</div>
            <div><b>{{ addSecretData.response.hash }}</b></div>
          </div>
        </div>
      </div>
    </div>

    <div class="get-secret">
      <div class="container">
        <h2>Get secret</h2>
        <div>Hash</div>
        <div><input v-model="getSecretData.hash"/></div>
        <div>
          <button v-on:click="getSecret">Get secret</button>
        </div>
      </div>
      <div v-if="getSecretData.response.code > 0" class="add-secret-response">
        <div v-if="getSecretData.response.code !== 200" class="warning">
          <div class="container">
            <div>Unsuccessful request</div>
          </div>
        </div>
        <div v-if="getSecretData.response.code === 200" class="success">
          <div class="container">
            <div>secret data:</div>
            <div>
              <textarea v-model="getSecretData.response.secret" class="secret-data-response"></textarea>
            </div>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>
export default {
    name: 'SecretManager',
    data: function () {
        return {
            addSecretData: {
                secretText: '',
                expireAfterViews: 100,
                expireAfter: 60,
                response: {
                    code: 0,
                    hash: ''
                }
            },
            getSecretData: {
                hash: '',
                response: {
                    code: 0,
                    secret: ''
                }
            }
        }
    },
    props: {
        msg: String,
        serverUrl: String
    },
    methods: {
        addSecret: function() {
            const secretData = {
                "secret": this.addSecretData.secretText,
                "expireAfterViews": this.addSecretData.expireAfterViews,
                "expireAfter": this.addSecretData.expireAfter
            };
            this.axios.post(this.serverUrl + "/api/secret", secretData)
                .then((response) => {
                    this.clearResponseData();
                    this.addSecretData.response.code = response.status;
                    this.addSecretData.response.hash = response.data.hash;
                    this.getSecretData.hash = response.data.hash;
                })
                .catch((error) => {
                    this.addSecretData.response.code = 500;
                    console.error("There was an error!", error);
                });
        },
        getSecret: function () {
            const url = this.serverUrl + "/api/secret/" + this.getSecretData.hash;
            this.axios.get(url)
                .then((response) => {
                    this.clearResponseData();
                    this.getSecretData.response.code = response.status;
                    const secret = JSON.stringify(response.data, null, '\t');
                    this.getSecretData.response.secret = secret;
                })
                .catch((error) => {
                    this.getSecretData.response.code = 500;
                    console.error("There was an error!", error);
                });
        },
        clearResponseData: function () {
            this.addSecretData.response.code = 0;
            this.addSecretData.response.hash = '';
            this.getSecretData.response.code = 0;
            this.getSecretData.response.secret = '';
        }
    }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  ul {
    list-style-type: none;
    padding: 0;
  }
  li {
    display: inline-block;
    margin: 0 10px;
  }
  a {
    color: #42b983;
  }
  div {
    margin: 0;
    padding: 5px;
  }
  div.container {
    max-width: 700px;
    text-align: left;
    margin: auto;
    /*background-color: white;*/
  }
  #main {
    /*background-color: white;*/
  }
  .headline {
    background-color: #ed5a29;
    padding: 10px;
    color: white;
  }
  .warning {
    background-color: #ffd0c7;
    color: darkred;
  }
  .success {
    background-color: #e6ffc0;
    color: darkgreen;
  }
  .secret-data-response {
    width: 600px;
    height: 100px;
  }
  button {
    padding: 10px 20px;
    font-size: 1em;
  }
  input {
    padding: 5px 10px;
    width: 300px;
  }
  textarea {
    padding: 5px 10px;
    width: 500px;
    height: 100px;
  }
</style>
