<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../../semantic/semantic.css" rel="stylesheet">
    <script src="../../js/jquery.min.js"></script>
    <script src="../../semantic/semantic.js"></script>
    <script src="../../js/vue.js"></script>
    <script src="../../js/axios.js"></script>
    <title>main</title>
</head>
<style>

    #ts_table{ 
        font-weight: 800;
        text-align: center;
    }

    #ts_table thead{
        font-size: medium;
    }
    

    #ts_table tbody{
        color: aquamarine;
    }

    #ts_table td{
        height: 59px;
    }

</style>
<body>
    <div id="app">
        <div class="ui attached stackable menu" style="background-color: rgb(18, 151, 151);">
            <div class="ui container">
                <div class="image item" style="font-size: x-large;color: rgb(7, 244, 252);">
                <img src="../../images/spongebob.webp">
                云借阅-图书管理系统
                
                </div>

                <div class=" right icon item" >
                    <i class="large circular teal inverted user icon"></i>
                    <span style="margin-left: 25px;">
                        <font style="display: inline-block; height: 30px; font-size: x-large;">
                        ${user.userName}
                        </font>
                    </span>
                    
                    <div id="logout" class="ui animated image meddium button" style="margin-left: 25px;" @click="logout()">
                        <div class="visible content"><font style="font-size: x-large;">登出</font></div>
                        <div class="hidden content"><img src="../../images/spongebob.webp" class="ui avatar image"></div>
                    </div>

                    <a class="ui hidden" href="/logout" ref="logout"></a>
                </div>

            </div>
        </div>
            

        <div class="ui grid" >
            <div class="three wide column" style="padding-right: 0;" >
                <div class="ui vertical inverted fluid tabular  menu"  style="height: 100%;background-color:rgb(18, 151, 151);">
    
                    <a v-for="menu in menus" :class="menu.class" style="height: 72px;border: 2px solid skyblue;text-align: center;" @click="changeMenu(menu.id)">
                        <font style="font-size: x-large; font-weight: 800;color: aquamarine;">{{menu.title}}</font>
                        <i class="large book icon"></i>
                    </a>

                </div>
            </div>



            <div class="thirteen wide stretched column" style="padding-left: 0;">
                <div class="ui  segment" style="background-color: aquamarine;">

                        <div v-if="menus[1].active || menus[2].active">
                            <div class="ui grid" style="text-align: center;margin-right: 5px;">
                                <div class="one wide column">
                                    <h2 class="ui blue header" style="width: 50px;height: 50px;" v-if="menus[1].active">
                                       {{menus[1].title}}
                                    </h2>
                                    <h2 class="ui blue header" style="width: 50px;height: 50px;" v-else-if="menus[2].active">
                                        {{menus[2].title}}
                                    </h2>
                                </div>


                                <div class="four wide column">
                                    <div class="ui  right icon left labeled input">
                                        <label for="bname" class="ui label">图书名称</label>
                                        <input type="text" id = "bname"  style="width: 160px;" v-model="book_search.bookName">
                                        <i class="ui book icon"></i>
                                    </div>
                                </div>

                                <div class="four wide column">
                                    <div class="ui  right icon left labeled  input">
                                        <label for="author" class="ui label">图书作者</label>
                                        <input type="text" id = "author" style="width: 160px;" v-model="book_search.bookAuthor">
                                        <i class="ui user icon"></i>
                                    </div>
                                </div>

                                <div class="four wide column">
                                    <div class="ui  right icon left labeled  input">
                                        <label for="publisher" class="ui label">出版社</label>
                                        <input type="text" id = "publisher" style="width: 160px;" v-model="book_search.bookPress">
                                        <i class="ui user icon"></i>
                                    </div>
                                </div>

                                <div class="three wide column">
                                    <div id="btn_search" class="ui teal animated button" v-if="menus[1].active" @click="doSearch('search_bor',1)">
                                        <div class="visible content">查询</div>
                                        <div class="hidden content"><img src="../../images/spongebob.webp" class="ui avatar image"></div>
                                    </div>

                                    <div id="btn_search" class="ui teal animated button" v-if="menus[2].active" @click="doSearch('search_bored',1)">
                                        <div class="visible content">查询</div>
                                        <div class="hidden content"><img src="../../images/spongebob.webp" class="ui avatar image"></div>
                                    </div>

                                    <#if user.userRole==0>
                                        <div id="btn_add" class="ui blue animated button" @click="showModal('add')">
                                            <div class="visible content">新增</div>
                                            <div class="hidden content"><img src="../../images/spongebob1.webp" class="ui avatar image"></div>
                                        </div>
                                    </#if>
                                </div>
                            </div>
                        </div>

                        <div v-else-if="menus[0].active">
                            <div class="ui grid" style="padding-bottom: 0">
                                <div class="eight wide column">
                                    <h2 class="ui blue header" style="height: 50px;" v-if="menus[0].active">
                                        {{menus[0].title}}
                                    </h2>
                                </div>
                                <div class="eight wide column">
                                    <h2 class="ui blue header" style="height: 50px;text-align: right" v-if="menus[0].active">
                                        欢迎使用云借阅图书管理系统
                                    </h2>
                                </div>
                            </div>
                        </div>

                        <div v-else-if="menus[3].active">
                            <div class="ui four column grid">

                                <div class="column">
                                    <h2 class="ui blue header">
                                        {{menus[3].title}}
                                    </h2>
                                </div>
                                <#if user.userRole == 0>
                                    <div class="column" style="padding-left: 0">
                                        <div class="ui left labeled right icon input" style="padding-left: 0">
                                            <label class="ui label">借阅人</label>
                                            <input name="recordBorrower" placeholder="借阅人姓名" style="padding: 0" v-model="record_search.recordBorrower">
                                            <i class="ui user icon"></i>
                                        </div>
                                    </div>
                                </#if>
                                <div class="column" style="padding-left: 0">
                                    <div class="ui left labeled right icon input" style="padding-left: 0">
                                        <label class="ui label">图书名称</label>
                                        <input name="recordBookName" placeholder="图书名称" style="padding: 0" v-model="record_search.recordBookName">
                                        <i class="ui book icon"></i>
                                    </div>
                                </div>

                                <div class="column">
                                    <div id="btn_search" class="ui teal animated button" @click="doSearch('bor_reco',1)">
                                        <div class="visible content">查询</div>
                                        <div class="hidden content"><img src="../../images/spongebob.webp" class="ui avatar image"></div>
                                    </div>
                                </div>

                            </div>
                        </div>


                        <div v-else-if="menus[4].active">
                        <div class="ui four column grid">

                            <div class="column">
                                <h2 class="ui blue header">
                                    {{menus[4].title}}
                                </h2>
                            </div>
                            <#if user.userRole == 0>
                                <div class="column" style="padding-left: 0">
                                    <div class="ui left labeled right icon input" style="padding-left: 0">
                                        <label class="ui label">员工工号</label>
                                        <input name="userId" placeholder="员工工号" style="padding: 0" v-model.number="user_search.userId">
                                        <i class="ui user icon"></i>
                                    </div>
                                </div>
                            </#if>
                            <div class="column" style="padding-left: 0">
                                <div class="ui left labeled right icon input" style="padding-left: 0">
                                    <label class="ui label">员工姓名</label>
                                    <input name="userName" placeholder="员工姓名" style="padding: 0" v-model="user_search.userName">
                                    <i class="ui book icon"></i>
                                </div>
                            </div>

                            <div class="column">
                                <div id="btn_search" class="ui teal animated button" @click="doSearch('search_emp',1)">
                                    <div class="visible content">查询</div>
                                    <div class="hidden content"><img src="../../images/spongebob.webp" class="ui avatar image"></div>
                                </div>

                                <#if user.userRole==0>
                                    <div id="btn_add" class="ui blue animated button" @click="showModal('addEmp')">
                                        <div class="visible content">新增</div>
                                        <div class="hidden content"><img src="../../images/spongebob1.webp" class="ui avatar image"></div>
                                    </div>
                                </#if>

                            </div>

                        </div>
                    </div>

                    




                    
                    <!-- 图书推荐，图书借阅和当前借阅的表格展示 -->
                    <table id="ts_table" class="ui inverted teal celled structured table" >
                        <thead v-if="!forms[4].active">
                            <tr>
                            <th>图书名称</th>
                            <th v-if="!forms[3].active">图书作者</th>
                            <th v-if="!forms[3].active">出版社</th>
                            <th>标准ISBN</th>
                            <th v-if="!forms[3].active">书籍状态</th>
                            <th>借阅人</th>
                            <th>借阅时间</th>
                            <th v-if="!forms[3].active">应归还时间</th>
                            <th v-else>归还时间</th>
                            <th v-if="!forms[3].active">操作</th>
                            </tr>
                        </thead>

                        <thead v-else>
                        <tr>
                            <th>员工工号</th>
                            <th>员工姓名</th>
                            <th>员工电话</th>
                            <th>员工邮箱</th>
                            <th>入职时间</th>
                            <th>离职时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>

                        <tbody v-if="forms[0].active || forms[1].active || forms[2].active">
                                <tr v-for="nbook in new_books.rows" :key="nbook.bookId">
                                    <td >{{nbook.bookName}}</td>
                                    <td v-if="!forms[3].active">{{nbook.bookAuthor}}</td>
                                    <td v-if="!forms[3].active">{{nbook.bookPress}}</td>
                                    <td >
                                        {{nbook.bookIsbn}}
                                    </td>
                                    <td v-if="!forms[3].active && !forms[2].active">{{nbook.bookStatus === 0? '可借阅':'已借阅'}}</td>
                                    <td v-else-if="forms[2].active">{{nbook.bookStatus === 2? '归还中':'已借阅'}}</td>
                                    <td>{{nbook.bookBorrower}}</td>
                                    <td>{{nbook.bookBorrowTime}}</td>
                                    <td>{{nbook.bookReturnTime}}</td>
                                    <td v-if="forms[0].active ">
                                        <#--     新书推荐界面操作按钮   -->
                                        <div class="ui blue animated button" v-if="nbook.bookStatus === 0" @click="showModal('borrow',nbook.bookId)">
                                            <div class="visible content">borrow</div>
                                            <div class="hidden content">借阅图书</div>
                                        </div>

                                        <div class="ui blue disabled animated button" v-else>
                                            <div class="visible content">borrow</div>
                                            <div class="hidden content">借阅图书</div>
                                        </div>

                                    </td>

                                    <td v-else-if="forms[1].active">

                                        <#--     图书借阅页面操作按钮   -->
                                        <div class="ui blue animated button" v-if="nbook.bookStatus === 0" @click="showModal('borrow',nbook.bookId)">
                                            <div class="visible content">borrow</div>
                                            <div class="hidden content">借阅图书</div>
                                        </div>

                                        <div class="ui blue disabled animated button" v-else>
                                            <div class="visible content">borrow</div>
                                            <div class="hidden content">借阅图书</div>
                                        </div>

                                        <div class="ui animated button" style="background-color: rgb(17, 233, 233)" v-if="nbook.bookStatus === 0"  @click="showModal('edit',nbook.bookId)">
                                            <div class="visible content">edit</div>
                                            <div class="hidden content">编辑图书</div>
                                        </div>
                                    </td>


                                    <td v-else-if="forms[2].active">

                                        <#--     当前借阅界面操作按钮   -->
                                        <div class="ui blue animated small button" v-if="nbook.bookStatus === 1" @click="returnBook(nbook.bookId)">
                                            <div class="visible content">remand</div>
                                            <div class="hidden content">归还</div>
                                        </div>

                                        <div class="ui animated disabled tiny button"  style="background-color: rgb(17, 233, 233)" v-if="(nbook.bookStatus === 2)" >
                                            <div class="visible content">Backing</div>
                                            <div class="hidden content">归还中</div>
                                        </div>

                                        <#if user.userRole == 0>
                                            <div class="ui animated tiny button"  style="background-color: rgb(17, 233, 233)" v-if="nbook.bookStatus === 2" @click="returnConfirm(nbook.bookId)">
                                                <div class="visible content">confirm</div>
                                                <div class="hidden content">确认归还</div>
                                            </div>
                                        </#if>
                                    </td>
                                </tr>
                        </tbody>


                        <tbody v-else-if="forms[3].active">
                            <tr v-for="record in records.rows">
                                <td >{{record.recordBookName}}</td>

                                <td >
                                    {{record.recordBookIsbn}}
                                </td>
                                <td>{{record.recordBorrower}}</td>
                                <td>{{record.recordBorrowTime}}</td>
                                <td>{{record.recordRemandTime}}</td>

                            </tr>
                        </tbody>


                        <tbody v-else-if="forms[4].active">
                            <tr v-for="user in users.rows">
                                <td>{{user.userId}}</td>
                                <td>{{user.userName}}</td>
                                <td>{{user.userPhone}}</td>
                                <td>{{user.userEmail}}</td>
                                <td>{{user.userHiredate}}</td>
                                <td>{{user.userDeparturedate}}</td>
                                <td>
                                    <#--     员工管理界面操作按钮   -->
                                    <div class="ui blue animated button" @click="showModal('editEmp',user.userId)">
                                        <div class="visible content">edit</div>
                                        <div class="hidden content">编辑信息</div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>



                    <div v-if="forms[1].active">
                        <button class="ui blue button" :disabled="book_search.pageNum===1" @click="doSearch('search_bor',book_search.pageNum -1)">上一页</button>
                        <span>当前第{{book_search.pageNum}}页</span>
                        <button class="ui blue button" :disabled="new_books.total < book_search.pageNum * book_search.pageSize" @click="doSearch('search_bor',book_search.pageNum +1)">下一页</button>
                    </div>

                    <div v-else-if="forms[2].active">
                        <button class="ui blue button" :disabled="book_search.pageNum===1" @click="doSearch('search_bored',book_search.pageNum -1)">上一页</button>
                        <span>当前第{{book_search.pageNum}}页</span>
                        <button class="ui blue button" :disabled="new_books.total < book_search.pageNum * book_search.pageSize" @click="doSearch('search_bored',book_search.pageNum +1)">下一页</button>
                    </div>

                    <div v-else-if="forms[3].active">
                        <button class="ui blue button" :disabled="record_search.pageNum ===1" @click="doSearch('bor_reco',record_search.pageNum -1)">上一页</button>
                        <span>当前第{{record_search.pageNum}}页</span>
                        <button class="ui blue button" :disabled="records.total < record_search.pageNum * record_search.pageSize" @click="doSearch('bor_reco',record_search.pageNum +1)">下一页</button>
                    </div>

                    <div v-if="forms[4].active">
                        <button class="ui blue button" :disabled="user_search.pageNum===1" @click="doSearch('search_emp',user_search.pageNum -1)">上一页</button>
                        <span>当前第{{user_search.pageNum}}页</span>
                        <button class="ui blue button" :disabled="users.total < user_search.pageNum * user_search.pageSize" @click="doSearch('search_emp',user_search.pageNum +1)">下一页</button>
                    </div>
                </div>
            </div>




            <!-- 借阅书籍,显示书籍信息模态框 -->
            <div id = "savmodal" class="ui modal ">
                <div class="ui icon header" style="background-color: rgb(127, 241, 241);">
                    <i class="book icon"></i><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">
                    欢迎借阅书籍
                </font></font></div>
                <div class="content" style="background-color: rgb(127, 241, 241);" >
                    <div class="ui two column grid" style="text-align: center;">
                    <!-- <p>Your inbox is getting full, would you like us to enable automatic archiving of old messages?</p> -->

                    <div class="row">

                        <div class="column">
                            <div class="ui large right icon left labeled transparent input">
                                <label for="bookname1" class="ui label">图书名称</label>
                                <input id = "bookname1" type="text" style="font-size: large;font-weight: 800;color: blue;" disabled :value="book_info.data.bookName">
                                <i class="book icon"></i>
                            </div>
                        </div>

                        <div class="column">
                            <div class="ui large right icon left labeled transparent input">
                                <label for="bookisbn1" class="ui label">标准ISBN</label>
                                <input id = "bookisbn1" type="text" style="font-size: large;font-weight: 800;color: blue;" disabled :value="book_info.data.bookIsbn">
                                <i class="book icon"></i>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="column" >
                            <div class="ui large right icon left labeled transparent input">
                                <label for="publisher1" class="ui label">出版社名</label>
                                <input id = "publisher1" type="text" style="font-size: large;font-weight: 800;color: blue;" disabled :value = "book_info.data.bookPress">
                                <i class="book icon"></i>
                            </div>
                        </div>

                        <div class="column" >
                            <div class="ui large right icon left labeled transparent input">
                                <label for="author1" class="ui label">作者姓名</label>
                                <input id = "author1" type="text" style="font-size: large;font-weight: 800;color: blue;" disabled :value="book_info.data.bookAuthor">
                                <i class="book icon"></i>
                            </div>
                        </div>

                    </div>


                    <div class="row">
                        <div class="column">
                            <div class="ui large right icon left labeled transparent input">
                                <label for="bookpage1" class="ui label">书籍页数</label>
                                <input id = "bookpage1" type="text" style="font-size: large;font-weight: 800;color: blue;" disabled :value="book_info.data.bookPagination">
                                <i class="book icon"></i>
                            </div>
                        </div>


                        <div class="column">
                            <div class="ui large right icon left labeled transparent input">
                                <label for="remandtime" class="ui label" >归还时间</label>
                                <input id = "remandtime" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="modata.bookRemandTime" placeholder="日期格式:年-月-日">
                                <i class="book icon"></i>
                            </div>
                        </div>
                    </div>

                    </div>
                </div>


                <div class="actions" style="background-color:rgb(127, 241, 241);">
                    <div class="ui  blue inverted animated button" @click="doSubmit('borrow',book_info.data.bookId)">
                        <div class="visible content"><i class="checkmark icon"></i>确定</div>
                        <div class="hidden content">保存信息</div>
                    </div>

                    <div class="ui blue cancel inverted animated button">
                        <div class="visible content"><i class="remove icon"></i>取消</div>
                        <div class="hidden content">取消操作</div>
                    </div>
                </div>

            </div>



            <!-- 添加书籍和编辑书籍的模态框 -->
            <div id="edimodal" class="ui modal">
                <div class="ui icon header" style="background-color: rgb(1, 160, 160);text-align: center;">
                    <i class="book icon"></i>
                    <font style="vertical-align: inherit;"><font style="vertical-align: inherit;"></font></font>
                    {{modata.bookId === null? '添加图书信息':'编辑图书信息'}}
                </div>
                <div class="content" style="background-color: rgb(1, 160, 160);text-align: center;">
                    <div class="ui two column grid">
                        <div class="row">
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="bookname2" class="ui label">图书名称</label>
                                    <input id = "bookname2" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="modata.bookName">
                                    <i class="book icon"></i>
                                </div>
                            </div>
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="bookisbn2" class="ui label">标准ISBN</label>
                                    <input id = "bookisbn2" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="modata.bookIsbn">
                                    <i class="book icon"></i>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="publisher2" class="ui label">出版社名</label>
                                    <input id = "publisher2" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="modata.bookPress">
                                    <i class="book icon"></i>
                                </div>
                            </div>
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="author2" class="ui label">作者姓名</label>
                                    <input id = "author2" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="modata.bookAuthor">
                                    <i class="book icon"></i>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="bookpage2" class="ui label">书籍页数</label>
                                    <input id = "bookpage2" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="modata.bookPagination">
                                    <i class="book icon"></i>
                                </div>
                            </div>
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="bookprice" class="ui label">书籍价格</label>
                                    <input id = "bookprice" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="modata.bookPrice">
                                    <i class="book icon"></i>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="column">
                                <div class="ui left labeled right icon large input" style="width:422px;">
                                    <label for="bookstatus" class="ui label" >书籍状态</label>
                                    <!-- <input id = "bookstatus" type="" style="font-size: large;font-weight: 800;color: blue;"> -->
                                    <select style="width: 331.08px;height: 48.25px;" v-model="modata.bookStatus" >
                                        <option disabled></option>
                                        <option value="0">可借阅</option>
                                        <option value="1">借阅中</option>
                                        <option value="2">归还中</option>
                                        <option value="3">已下架</option>
                                    </select>
                                    <i class="time icon" ></i>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="actions" style="background-color: rgb(1, 160, 160);">
                    <div class="ui  blue inverted animated button" v-if="modata.bookId !== null" @click="doSubmit('edit',modata.bookId)">
                        <div class="visible content"><i class="checkmark icon"></i>确定</div>
                        <div class="hidden content">保存信息</div>
                    </div>

                    <div class="ui  blue inverted animated button" v-else  @click="doSubmit('add',0)">
                        <div class="visible content"><i class="checkmark icon"></i>确定</div>
                        <div class="hidden content">保存信息</div>
                    </div>

                    <div class="ui teal cancel inverted animated button">
                        <div class="visible content"><i class="remove icon"></i>取消</div>
                        <div class="hidden content">取消操作</div>
                    </div>
                </div>
            </div>



            <!-- 添加员工和编辑员工信息的模态框 -->
            <div id="usermodal" class="ui modal">
                <div class="ui icon header" style="background-color: rgb(10, 155, 252);text-align: center;">
                    <i class="user icon"></i>
                    <font style="vertical-align: inherit;"><font style="vertical-align: inherit;"></font></font>
                    {{umodata.userId === null? '添加员工信息':'编辑员工信息'}}
                </div>
                <div class="content" style="background-color: rgb(10, 155, 252);text-align: center;">
                    <div class="ui two column grid">
                        <div class="row">
                            <div class="column" v-if="umodata.userId !== null">
                                <div class="ui left labeled right icon large input">
                                    <label for="userid" class="ui label">员工工号</label>
                                    <input id = "userid" placeholder="员工工号" disabled type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="umodata.userId">
                                    <i class="user icon"></i>
                                </div>
                            </div>
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="username" class="ui label">员工姓名</label>
                                    <input id = "username" placeholder="员工姓名" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="umodata.userName" >
                                    <i class="user icon"></i>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="userphone" class="ui label">员工电话</label>
                                    <input id = "userphone" placeholder="员工电话" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="umodata.userPhone">
                                    <i class="phone icon"></i>
                                </div>
                            </div>
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="useremail" class="ui label">员工邮箱</label>
                                    <input id="useremail" placeholder="员工邮箱"  type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="umodata.userEmail">
                                    <i class="envelope icon"></i>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="column">
                                <div class="ui left labeled right icon large input">
                                    <label for="time" class="ui label">入职时间</label>
                                    <input id="time" placeholder="入职时间" type="text" style="font-size: large;font-weight: 800;color: blue;" v-model="umodata.userHiredate">
                                    <i class="time icon"></i>
                                </div>
                            </div>
                            <div class="column" v-if="umodata.userId !== null">
                                <div class="ui left labeled right icon large input">
                                    <label  class="ui label">离职时间</label>
                                    <input type="text" placeholder="离职时间:年-月-日" style="font-size: large;font-weight: 800;color: blue;" v-model="umodata.userDeparturedate">
                                    <i class="time icon"></i>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>

                <div class="actions" style="background-color: rgb(10, 155, 252);">

                    <div v-if="umodata.userId === null" class="ui  blue inverted animated button"  @click="doSubmit('addEmp',0)">
                        <div class="visible content"><i class="checkmark icon"></i>确定</div>
                        <div class="hidden content">保存信息</div>
                    </div>

                    <div v-else class="ui  blue inverted animated button"  @click="doSubmit('editEmp',umodata.userId)">
                        <div class="visible content"><i class="checkmark icon"></i>确定</div>
                        <div class="hidden content">保存信息</div>
                    </div>

                    <div class="ui teal cancel inverted animated button">
                        <div class="visible content"><i class="remove icon"></i>取消</div>
                        <div class="hidden content">取消操作</div>
                    </div>
                </div>
            </div>


        </div>
    </div>


<script>
        Date.prototype.format = function format(date){
           let year = date.getFullYear()
           let month = date.getMonth()+1
           let dt = date.getDate()
           return year+"-"+month+"-"+dt
        }
    </script>



    <script>
    axios.defaults.withcredentials = true
    new Vue({
      el:"#app",
      data () {
          return {
              menus:[
                  {
                      id:0,
                      active:true,
                      title:'新书推荐',
                      class:['teal','item','active']
                  },
                  {
                      id:1,
                      active:false,
                      title:'图书借阅',
                      class:['teal','item']
                  },
                  {
                      id:2,
                      active:false,
                      title: '当前借阅',
                      class:['teal','item']
                  },
                  {
                      id:3,
                      active:false,
                      title: '借阅记录',
                      class:['teal','item']
                  },
                  {
                      id:4,
                      active:false,
                      title: '人员管理',
                      class:['teal','item']
                  }
              ],

              forms:[
                  {
                      id:0,
                      titl:'新书推荐',
                      active:true,
                  },

                  {
                      id:1,
                      titl:'图书借阅',
                      active:false,
                  },

                  {
                      id:2,
                      titl:'当前借阅',
                      active:false,
                  },

                  {
                      id:3,
                      titl:'借阅记录',
                      active:false,
                  },
                  {
                      id:4,
                      titl:'人员管理',
                      active:false,
                  }
              ],
              new_books:{
                  total:null,
                  rows:[]
              },
              book_info:{
                  data:{}
              },
              book_search:{
                  bookName:null,
                  bookAuthor:null,
                  bookPress:null,
                  pageNum:0,
                  pageSize:10
              },
              modata:{
                  bookId:null,
                  bookName:null,
                  bookIsbn:null,
                  bookPress:null,
                  bookAuthor:null,
                  bookPagination:null,
                  bookPrice:null,
                  bookStatus:null,
                  bookRemandTime:null
              },
              record_search:{
                  recordBorrower:null,
                  recordBookName:null,
                  pageNum:0,
                  pageSize:10
              },
              records:{
                  total:null,
                  rows:[]
              },
              user_search:{
                  userId:null,
                  userName:null,
                  pageNum:0,
                  pageSize:10,
              },
              users:{
                  total:null,
                  rows:[]
              },
              umodata:{
                  userId:null,
                  userName:null,
                  userPhone:null,
                  userEmail:null,
                  userHiredate:null,
                  userDeparturedate:null
              }
          }
      },
      methods: {
          changeMenu(id){
              this.$set(this.book_search,'pageNum',1)
              this.$set(this.record_search,'pageNum',1)
              if(id === 0){
                  axios.get('http://localhost:8080/book/selectNewBooks').then(
                      response=>{
                          this.new_books = JSON.stringify(response.data)
                          this.new_books = JSON.parse(this.new_books)
                      },
                      error=>{
                          alert("数据错误",error.message)
                      }
                  )
              }
              else if(id === 1){
                  let bookName = this.book_search.bookName
                  let bookAuthor = this.book_search.bookAuthor
                  let bookPress = this.book_search.bookPress
                  this.$set(this.book_search,'bookName',null)
                  this.$set(this.book_search,'bookAuthor',null)
                  this.$set(this.book_search,'bookPress',null)
                  let pageSize = 10
                  axios.get('http://localhost:8080/book/search',{
                      params:{
                          bookName,
                          bookAuthor,
                          bookPress,
                          pageNum:1,
                          pageSize
                      }
                  }).then(
                      response=>{
                          this.new_books = JSON.stringify(response.data)
                          this.new_books = JSON.parse(this.new_books)
                      },
                      error=>{
                          alert("查询失败！")
                      }
                  )
                  this.$forceUpdate()
              }
              else if(id === 2){
                  let bookName = this.book_search.bookName
                  let bookAuthor = this.book_search.bookAuthor
                  let bookPress = this.book_search.bookPress
                  this.$set(this.book_search,'bookName',null)
                  this.$set(this.book_search,'bookAuthor',null)
                  this.$set(this.book_search,'bookPress',null)

                  let pageSize = 10
                  axios.get('http://localhost:8080/book/searchBorrowed',{
                      params:{
                          bookName,
                          bookAuthor,
                          bookPress,
                          pageNum:1,
                          pageSize
                      }
                  }).then(
                      response=>{
                          this.new_books = JSON.stringify(response.data)
                          this.new_books = JSON.parse(this.new_books)

                      },
                      error=>{
                          alert("查询失败！")
                      }
                  )
                  this.$forceUpdate()
              }
              else if(id === 3){
                  this.$set(this.record_search,'pageNum',1)
                  let recordBookName = this.record_search.recordBookName
                  let recordBorrower = this.record_search.recordBorrower
                  this.$set(this.record_search,'recordBookName',null)
                  this.$set(this.record_search,'recordBorrower',null)
                  let pageSize = 10

                  axios.get('http://localhost:8080/record/searchRecords',{
                      params:{
                          recordBookName,
                          recordBorrower,
                          pageNum:1,
                          pageSize
                      }}).then(
                      response=>{
                          this.records = JSON.stringify(response.data)
                          this.records = JSON.parse(this.records)
                      },
                      error=>{
                          alert("查询失败！")
                      }
                  )
              }
              else if(id === 4){
                  this.$set(this.user_search,'pageNum',1)
                  let uid = this.user_search.userId
                  let userName = this.user_search.userName
                  let pageSize = 10

                  axios.get('http://localhost:8080/searchEmployee',{
                      params:{
                          uid:uid,
                          userName,
                          pageSize
                      }
                  }).then(
                      response=>{
                          this.users = JSON.stringify(response.data)
                          this.users = JSON.parse(this.users)
                      },
                      error=>{
                          alert("查询失败")
                      }
                  )
                  this.$set(this.user_search,'userId',null)
                  this.$set(this.user_search,'userName',null)
              }

              this.menus.forEach(menu=>{
                  if(menu.id !== id) {
                      menu.active = false
                      menu.class = ['teal','item']
                  }
                  else{
                      menu.class = ['teal','item','active']
                      menu.active = true
                  }
              })
              this.forms.forEach(form=>{
                  if (form.id === id) form.active = true
                  else form.active = false
              })

          },
          showModal(type,id){

              if(type === 'borrow'){
                  axios.get('http://localhost:8080/book/findById',{params:{
                      bookId:id
                      }
                    }).then(
                      response=>{
                          this.book_info = JSON.stringify(response.data)
                          this.book_info = JSON.parse(this.book_info)
                      },
                      error=>{
                          alert("查询失败！")
                      }
                  )
                  $(function(){
                      $('#savmodal').modal('show');
                  })
              }
              else if(type === 'edit'){

                  axios.get('http://localhost:8080/book/findById',{  //此处用post导致后台session再次失效
                      params:{
                          bookId:id,
                      }
                  }).then(response=>{
                      let data = JSON.stringify(response.data.data)
                      data = JSON.parse(data)
                      this.$set(this.modata,'bookId',data.bookId)
                      this.$set(this.modata,'bookName',data.bookName)
                      this.$set(this.modata,'bookIsbn',data.bookIsbn)
                      this.$set(this.modata,'bookPress',data.bookPress)
                      this.$set(this.modata,'bookAuthor',data.bookAuthor)
                      this.$set(this.modata,'bookPagination',data.bookPagination)
                      this.$set(this.modata,'bookPrice',data.bookPrice)
                      this.$set(this.modata,'bookStatus',data.bookStatus)
                  })

                  $(function(){
                      $('#edimodal').modal('show')
                  })
              }
              else if (type === 'add'){
                  this.$set(this.modata,'bookId',null)
                  this.$set(this.modata,'bookName',null)
                  this.$set(this.modata,'bookIsbn',null)
                  this.$set(this.modata,'bookPress',null)
                  this.$set(this.modata,'bookAuthor',null)
                  this.$set(this.modata,'bookPagination',null)
                  this.$set(this.modata,'bookPrice',null)
                  this.$set(this.modata,'bookStatus',null)
                  $(function(){
                      $('#edimodal').modal('show')
                  })
              }
              else if(type === 'addEmp'){
                  this.$set(this.umodata,'userId',null)
                  this.$set(this.umodata,'userName',null)
                  this.$set(this.umodata,'userPhone',null)
                  this.$set(this.umodata,'userEmail',null)
                  this.$set(this.umodata,'userHiredate',null)
                  this.$set(this.umodata,'userDeparturedate',null)
                  $(function(){
                      $('#usermodal').modal('show')
                  })
              }
              else if(type === 'editEmp'){
                  axios.get('http://localhost:8080/findEmpById',{  //此处用post导致后台session再次失效
                      params:{
                          userId:id,
                      }
                  }).then(response=>{
                      let data = JSON.stringify(response.data.data)
                      data = JSON.parse(data)
                      this.$set(this.umodata,'userId',data.userId)
                      this.$set(this.umodata,'userName',data.userName)
                      this.$set(this.umodata,'userPhone',data.userPhone)
                      this.$set(this.umodata,'userEmail',data.userEmail)
                      this.$set(this.umodata,'userHiredate',data.userHiredate)
                      this.$set(this.umodata,'userDeparturedate',data.userDeparturedate)
                  })


                  $(function(){
                      $('#usermodal').modal('show')
                  })
              }
          },

          doSubmit(type,id){
              if(type==='borrow'){
                  if(this.modata.bookRemandTime != null){
                      let remandTime = new Date(this.modata.bookRemandTime)
                      let now = new Date()

                      if(remandTime > now){
                          remandTime = Date.prototype.format(remandTime)
                          axios.get('http://localhost:8080/book/borrowBook',{  //此处用post导致后台session再次失效
                              params:{
                                  bookId:id,
                                  bookReturnTime:remandTime
                              }
                          }).then(response=>{
                              alert(response.data.message)
                              console.log(response.data)
                              if(response.data.success === true){
                                  window.location.reload()
                              }
                          })
                      }
                  else alert("请输入有效的日期")
                  }
                  else{
                      alert("请填写归还日期")
                  }
                  this.$set(this.modata,'bookRemandTime',null)
              }
              else if (type === 'add'){
                  let bookName =  this.modata.bookName
                  let bookIsbn = this.modata.bookIsbn
                  let bookPress = this.modata.bookPress
                  let bookAuthor = this.modata.bookAuthor
                  let bookPagination = this.modata.bookPagination
                  let bookPrice = this.modata.bookPrice
                  let bookStatus = this.modata.bookStatus
                  axios.get('http://localhost:8080/book/addBook',{
                      params:{
                          bookName,
                          bookIsbn,
                          bookPress,
                          bookAuthor,
                          bookPagination,
                          bookPrice,
                          bookStatus
                      } }).then(
                          response=>{
                              alert(response.data.message)
                              if (response.data.success === true) {
                                  window.location.reload()
                              }
                          }
                  )
                  this.$set(this.modata,'bookName',null)
                  this.$set(this.modata,'bookIsbn',null)
                  this.$set(this.modata,'bookPress',null)
                  this.$set(this.modata,'bookAuthor',null)
                  this.$set(this.modata,'bookPagination',null)
                  this.$set(this.modata,'bookPrice',null)
                  this.$set(this.modata,'bookStatus',null)
              }
              else if (type === 'edit'){
                  let bookName =  this.modata.bookName
                  let bookIsbn = this.modata.bookIsbn
                  let bookPress = this.modata.bookPress
                  let bookAuthor = this.modata.bookAuthor
                  let bookPagination = this.modata.bookPagination
                  let bookPrice = this.modata.bookPrice
                  let bookStatus = this.modata.bookStatus

                  axios.get('http://localhost:8080/book/editBook',{
                      params:{
                          bookId:id,
                          bookName,
                          bookIsbn,
                          bookPress,
                          bookAuthor,
                          bookPagination,
                          bookPrice,
                          bookStatus
                      } }).then(
                      response=>{
                          alert(response.data.message)
                          if (response.data.success == true) {
                              window.location.reload()
                          }
                      }
                  )
                  this.$set(this.modata,'bookId',null)
                  this.$set(this.modata,'bookName',null)
                  this.$set(this.modata,'bookIsbn',null)
                  this.$set(this.modata,'bookPress',null)
                  this.$set(this.modata,'bookAuthor',null)
                  this.$set(this.modata,'bookPagination',null)
                  this.$set(this.modata,'bookPrice',null)
                  this.$set(this.modata,'bookStatus',null)
              }
              else if (type === 'addEmp'){
                  let userName = this.umodata.userName
                  let userPhone = this.umodata.userPhone
                  let userEmail = this.umodata.userEmail
                  let userHiredate = this.umodata.userHiredate
                  let userDeparturedate = this.umodata.userDeparturedate
                  axios.get('http://localhost:8080/addEmployee',{
                      params:{
                          userName,
                          userPhone,
                          userEmail,
                          userHiredate,
                          userDeparturedate
                      }
                  }).then(
                      response=>{
                          alert(response.data.message)
                          if(response.data.success === true)
                              window.location.reload()
                      }
                  )
                  this.$set(this.modata,'userName',null)
                  this.$set(this.modata,'userPhone',null)
                  this.$set(this.modata,'userEmail',null)
                  this.$set(this.modata,'userHireDate',null)
                  this.$set(this.modata,'userDeparturedate',null)
              }
              else if (type === 'editEmp'){

                  let userId = this.umodata.userId
                  let userName = this.umodata.userName
                  let userPhone = this.umodata.userPhone
                  let userEmail = this.umodata.userEmail
                  let userHiretime = this.umodata.userHiredate
                  let userDeparturetime = this.umodata.userDeparturedate
                  axios.get('http://localhost:8080/editEmployee',{
                      params:{
                          userId,
                          userName,
                          userPhone,
                          userEmail,
                          userHiretime,
                          userDeparturetime
                      }
                  }).then(
                      response=>{
                          alert(response.data.message)
                          if(response.data.success === true)
                              window.location.reload()
                      }
                  )
                  this.$set(this.modata,'userId',null)
                  this.$set(this.modata,'userName',null)
                  this.$set(this.modata,'userPhone',null)
                  this.$set(this.modata,'userEmail',null)
                  this.$set(this.modata,'userHiredate',null)
                  this.$set(this.modata,'userDeparturedate',null)
              }
          },

          doSearch(type,pageNum){

              this.$set(this.book_search,'pageNum',pageNum)
              if(type === 'search_bor'){
                  let bookName = this.book_search.bookName
                  let bookAuthor = this.book_search.bookAuthor
                  let bookPress = this.book_search.bookPress
                  let pageSize = 10
                  axios.get('http://localhost:8080/book/search',{
                      params:{
                          bookName,
                          bookAuthor,
                          bookPress,
                          pageNum,
                          pageSize
                      }
                  }).then(
                      response=>{
                          this.new_books = JSON.stringify(response.data)
                          this.new_books = JSON.parse(this.new_books)
                      },
                      error=>{
                          alert("查询失败！")
                      }
                  )
              }

              else if(type === 'search_bored'){
                  let bookName = this.book_search.bookName
                  let bookAuthor = this.book_search.bookAuthor
                  let bookPress = this.book_search.bookPress
                  let pageSize = 10
                  axios.get('http://localhost:8080/book/searchBorrowed',{
                      params:{
                          bookName,
                          bookAuthor,
                          bookPress,
                          pageNum,
                          pageSize
                      }
                  }).then(
                      response=>{
                          this.new_books = JSON.stringify(response.data)
                          this.new_books = JSON.parse(this.new_books)
                      },
                      error=>{
                          alert("查询失败！")
                      }
                  )
              }
              else if(type === 'bor_reco'){
                  this.$set(this.record_search,'pageNum',pageNum)
                  let recordBookName = this.record_search.recordBookName
                  let recordBorrower = this.record_search.recordBorrower
                  let pageSize = 10

                  axios.get('http://localhost:8080/record/searchRecords',{
                      params:{
                          recordBookName,
                          recordBorrower,
                          pageNum:pageNum,
                          pageSize
                      }}).then(
                          response=>{
                              this.records = JSON.stringify(response.data)
                              this.records = JSON.parse(this.records)
                          },
                      error=>{
                          alert("查询失败！")
                      }
                  )
              }
              else if(type === 'search_emp'){
                  this.$set(this.user_search,'pageNum',pageNum)
                  let userId = this.user_search.userId
                  let userName = this.user_search.userName
                  let pageSize = 10

                  axios.get('http://localhost:8080/searchEmployee',{
                      params:{
                          userId,
                          userName,
                          pageNum,
                          pageSize
                      }
                  }).then(
                      response=>{
                          this.users = JSON.stringify(response.data)
                          this.users = JSON.parse(this.users)
                      },
                      error=>{
                          alert("查询失败")
                      }
                  )
                  console.log(userId)
                  this.$set(this.user_search,'userId',null)
                  this.$set(this.user_search,'userName',null)
              }
          },

          returnBook(bookId){
              if(confirm("确定归还图书?")){
                  axios.get('http://localhost:8080/book/returnBook',{
                      params:{bookId}
                  }).then(
                      response=>{
                         alert(response.data.message)
                         if(response.data.success === true)
                             window.location.reload()
                      }
                  )
              }
          },

          returnConfirm(bookId){
              if(confirm('确认图书已经归还吗?')){
                  axios.get('http://localhost:8080/book/returnConfirm',{
                      params:{bookId}
                  }).then(
                      response=>{
                          alert(response.data.message)
                          if(response.data.success === true)
                              window.location.reload()
                      }
                  )
              }
          },

          logout(){
              if (confirm('确定退出吗?')){
                  this.$refs.logout.click()
              }

          }

      },
     mounted(){
          axios.get('http://localhost:8080/book/selectNewBooks').then(
              response=>{
                  this.new_books = JSON.stringify(response.data)
                  this.new_books = JSON.parse(this.new_books)
              },
              error=>{
                  alert("数据错误",error.message)
              }
          )
     }

    })
    </script>

</body>
</html>