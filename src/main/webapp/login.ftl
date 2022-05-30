<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="semantic/semantic.css" rel="stylesheet">
    <script src="js/vue.js"></script>
    <script src="js/axios.js"></script>
    <!-- <script src="js/semantic.js"></script> -->
</head>
<style>
    *{
        margin: 0;
        padding: 0;
    }

    html, body {height:100%;overflow:hidden;margin: 0;}


    #container{
        position: absolute;
        background-color: blue;
        height: 100%;
        width: 100%;
        background-image: url("images/super3.gif");
        background-size: 100% 100%;
        background-repeat: no-repeat;
    }
    #login{
        /* overflow: hidden; */
        position: relative;
        top: 20%;
        left: 10px;
        height: 450px;
    }

    #login_form{
        background-color: teal;
    }
    #login_form input{
        margin-top: 12px;
    }
    #login_form label{
        margin-top: 12px;
    }
    #register_form{
        background-color: teal;
    }

</style>
<body>
<div id="app">
    <div id = "container" >
        <div id="content" class="ui three column grid">
            <div class="centered column">
                <div id="login">
                    <button class="ui blue huge animated button" @click="login">
                        <div class="visible content">
                            登录
                        </div>
                        <div class="hidden content">
                            <img src="images/spongebob.webp" alt="" class="ui  avatar image">
                        </div>
                    </button>
                    <button class="ui blue huge animated button" @click ="register">
                        <div class="visible content">
                            注册
                        </div>
                        <div class="hidden content">
                            <img src="images/spongebob1.webp" alt="" class="ui avatar image">
                        </div>
                    </button>

                    <div id ="form">

                        <!-- 登录框 -->
                        <#if errLogMsg??>
                            <div class="ui top attached error message">账号或密码错误</div>
                            <#else>
                        </#if>

                        <form id ="login_form" class="ui form attached fluid segment" v-show="islogin" ref="login_form" method="post" action="/login">
                            <div class="centered colunm">
                                <div class="fourteen wide field">
                                    <div class="ui right icon left labeled input">
                                        <label for="account" class="ui label"><img src="images/spongebob.webp" alt="" class="ui right avatar image">账号</label>
                                        <input type="text" id="account" name="userName" placeholder="account" required v-model="loginfo.userName">
                                        <i class="ui user icon"></i>
                                    </div>
                                </div>

                                <div class="fourteen wide field" >
                                    <div class="ui right icon left labeled input">
                                        <label for="password" class="ui label"><img src="images/spongebob1.webp" alt="" class="ui right mini avatar image">密码</label>
                                        <input type="password" id="password" name="userPassword" placeholder="password" required v-model="loginfo.userPassword">
                                        <i class="ui lock icon"></i>
                                    </div>
                                </div>

                                <div class="fourteen wide field">
                                    <div class="ui checkbox" @click.stop="change">
                                        <input type="checkbox" tabindex="0" class="hidden" v-model="check" >
                                        <label>I agree to the Terms and Conditions</label>
                                    </div>
                                </div>
                                <button class="ui button" type="button" @click="doLogin">Submit</button>
                            </div>
                        </form>


                        <!--注册框  -->
                        <form id = "register_form" class="ui form attached segment" v-show="!islogin" @submit.prevent="doRegister">
                            <div class="centered colunm">
                                <div class="fourteen wide field">
                                    <div class="ui right icon left labeled input">
                                        <label for="username" class="ui label"><img src="images/spongebob.webp" alt="" class="ui right avatar image">用户名</label>
                                        <input type="text" id="username" name="username" required placeholder="username" @blur="checkName()" v-model="reginfo.userName">
                                        <i class="ui user icon"></i>
                                    </div>
                                </div>

                                <div class="fourteen wide field">
                                    <div class="ui right icon left labeled input">
                                        <label for="email" class="ui label"><img src="images/spongebob1.webp" alt="" class="ui right mini avatar image">邮箱</label>
                                        <input type="text" id="email" name="email" placeholder="email" @blur="checkEmail()" required v-model="reginfo.userEmail">

                                        <i class="ui envelope icon"></i>
                                    </div>
                                </div>

                                <div class="fourteen wide field">
                                    <div class="ui right icon left labeled input">
                                        <label for="phone" class="ui label"><img src="images/spongebob1.webp" alt="" class="ui right mini avatar image">电话</label>
                                        <input type="text" id="phone" name="phone" placeholder="phone"  required v-model="reginfo.userPhone">
                                        <i class="ui phone icon"></i>
                                    </div>
                                </div>

                                <div class="fourteen wide field">
                                    <div class="ui right icon left labeled input">
                                        <label for="password1" class="ui label"><img src="images/spongebob1.webp" alt="" class="ui right mini avatar image">密码</label>
                                        <input type="password" id="password1" name="password1" placeholder="password" required v-model="reginfo.userPassword">
                                        <i class="ui lock icon"></i>
                                    </div>
                                </div>

                                <div class="fourteen wide field">
                                    <div class="ui right icon left labeled input">
                                        <label for="password2" class="ui label"><img src="images/spongebob1.webp" alt="" class="ui right mini avatar image">确认密码</label>
                                        <input type="password" id="password2" name="password2" placeholder="confirm password" required v-model="confirmed">
                                        <i class="ui lock icon"></i>
                                    </div>
                                </div>

                                <div class="fourteen wide field">
                                    <div class="ui checkbox" @click.stop="change">
                                        <input type="checkbox" tabindex="0" class="hidden" v-model="check" >
                                        <label>I agree to the Terms and Conditions</label>
                                    </div>
                                </div>

                                <button class="ui button" type="submit">Submit</button>
                            </div>
                        </form>
                        <div class="ui  bottom attached error message" v-show="!islogin && checkName()">用户名已经存在</div>
                        <div class="ui  bottom attached error message" v-show="!islogin && checkEmail()">邮箱已经被注册</div>
                        <div class="ui  bottom attached error message" v-show="!islogin && !confirmPwd">两次密码输入不一致</div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


<script>
    new Vue({
        el:"#app",
        data(){
            return{
                islogin:true,
                check:false,
                errRegMsg:{
                    errUsername:false,
                    errUserEmail:false
                },
                loginfo:{
                    userName:"",
                    userPassword:"",
                },

                reginfo:{
                    userName:null,
                    userPassword:null,
                    userPhone:null,
                    userEmail:null
                },

                confirmed:null
            }
        },
        methods: {
            login(){
                this.islogin = true;
            },
            register(){
                this.islogin = false;
            },
            checkName(){
                if(this.reginfo.userName === null) return false
                let userName = this.reginfo.userName
                axios.get('http://localhost:8080/login/checkUserName',{
                    params:{userName}
                }).then(response=>{
                    this.errRegMsg.errUsername = response.data
                    console.log(response.data)
                })

                return this.errRegMsg.errUsername
            },
            checkEmail(){
                if(this.reginfo.userEmail === null) return false
                let userEmail = this.reginfo.userEmail
                axios.get('http://localhost:8080/login/checkUserEmail',{
                    params:{userEmail}
                }).then(response=>{
                    this.errRegMsg.errUserEmail = response.data

                })
                return this.errRegMsg.errUserEmail
            },
            doLogin(){
                if(this.check === true)
                    this.$refs.login_form.submit()
                else
                    alert("请勾选确认协议")

            },
            doRegister(){
                if(this.check)
                {
                    if(this.confirmed && !this.errRegMsg.errUserEmail && !this.errRegMsg.errUsername){
                         let userName = this.reginfo.userName
                         let userPassword = this.reginfo.userPassword
                         let userPhone = this.reginfo.userPhone
                         let userEmail = this.reginfo.userEmail

                        axios.get('http://localhost:8080/login/userRegister',
                            {params:{
                                userName,
                                userPassword,
                                userPhone,
                                userEmail
                            }}
                        ).then(
                            response=>{
                               if(response.data.success === true){
                                   alert('注册成功!')
                                   window.location.reload()
                               }
                             }
                        )
                    }
                }
                else {
                    alert("请勾选确认协议")
                    return false
                }
            },
            change(){
                this.check = this.check === true? false:true
            }
        },
        computed: {
            confirmPwd(){
                if((this.reginfo.userPassword === this.confirmed) && this.confirmed !== null)
                    return true
                else if(this.confirmed === null) return true
                else return false
            }
        }
    })

</script>


</body>
</html>