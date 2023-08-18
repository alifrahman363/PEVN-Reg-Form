<template>
   <v-container>
    <v-alert v-model="alert.show" :type="alert.type" dismissible>{{ alert.message }}</v-alert>
    <v-row justify="center">
      
      <v-col class="text-center" md="2" sm="2" @click="suForm=true">
        <v-btn class="primary">Sign Up</v-btn>
      </v-col>

      <v-col class="text-center" md="2" sm="2" @click="suForm=false">
        <v-btn class="success">Sign In</v-btn>
      </v-col>

    </v-row>

    <v-row justify="center">
      <v-col md="6" sm="6">
        <!-- Sign Up -->
        <v-card v-if="suForm"> 
          <v-card-title> Sign Up</v-card-title>
          <v-card-text>
            
            <v-form class="ma-3" @submit.prevent="signup()" ref="signupForm">
              <v-text-field label="Name" prepend-icon="mdi-account" :rules="nameRules" v-model="user.name">  </v-text-field>
              <v-text-field label="E-mail" prepend-icon="mdi-email" :rules="emailRules" v-model="user.email">  </v-text-field>
              <v-text-field label="Password" prepend-icon="mdi-lock" type="password" :rules="passwordRules" v-model="user.password">  </v-text-field> 
            
              <v-radio-group row :rules="[(v)=> !!v || 'Please choose one']" v-model="user.role">
                <v-radio label="Professor" value="Professor"></v-radio>
                <v-radio label="Student" value="Student"></v-radio>
              </v-radio-group>  

              <v-btn block class="primary mt-3" type="submit">Sign Up </v-btn>

            </v-form> 

            
 
          </v-card-text>
        </v-card>

        <!-- Sign In -->
        <v-card v-else> 
          <v-card-title> Sign In</v-card-title>
          <v-card-text>
            
            <v-form class="ma-3" @submit.prevent="signin()" ref="signinForm">
               
              <v-text-field label="E-mail" prepend-icon="mdi-email" :rules="emailRules" v-model="user.email">  </v-text-field>
              <v-text-field label="Password" prepend-icon="mdi-lock" type="password" :rules="passwordRules" v-model="user.password">  </v-text-field> 
            
              <v-radio-group row :rules="[(v)=> !!v || 'Please choose one']" v-model="user.role">
                <v-radio label="Professor" value="Professor"></v-radio>
                <v-radio label="Student" value="Student"></v-radio>
              </v-radio-group>  

              <v-btn block class="success mt-3" type="submit">Sign In </v-btn>

            </v-form> 

            
 
          </v-card-text>
        </v-card>

      </v-col>
    </v-row>


   </v-container>
</template>

<script>  

  export default { 
    data: () =>({
      alert:{
        show: false , 
        message: '' 
      },

      nameRules: [
        value => !!value || 'Name is Required',
        value => (value && value.length> 5 || 'Name must have more than 5 characters') 
      ],
      emailRules: [
        value => !!value || 'E-mail is required',
        value => (/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(value) || "E-mail must be valid")
      ],
      passwordRules: [
        value => !!value || 'E-mail is required',
        value => (value && value.length> 4 || 'Password must have more than 4 characters')
      ],
      user: {name:'', email:'', password:'', role:''},
      
      suForm: true
    }),
    methods:{
      async signup(){
        let valid = this.$refs.signupForm.validate()
        console.log(this.user)
        
        if (valid) {
          try {
            const res = await this.axios.post('/signup', this.user)
            this.$refs.signupForm.reset()
            console.log(res)

            this.alert = {
              show: true, 
              type:"success",
              message: res.data.message
            } 
          } catch (error) {
            this.alert ={
              show: true, 
              type: 'error',
              message: error.response.data.message
            }
          }
        }  
      }, 
      async signin() {
        let valid = this.$refs.signinForm.validate()
        
        if(valid){
          try {
            const res = await this.axios.post('/signin', this.user)
            if(res.data.NotFound){
              this.alert= {
                show: true, 
                type: 'error', 
                message: res.data.message
              }
            }else{
              sessionStorage.setItem('session', JSON.stringify(res.data))
              this.alert = {
                show: true, 
                type: 'success', 
                message: 'Welcome'
              }
            }
          } catch (error) {
            this.alert ={
              show: true, 
              type: 'error',
              message: error.response.data.message
            }
          }
        }
      }
    }
  }
</script>
