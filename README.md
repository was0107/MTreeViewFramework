# MTreeViewFramework
树型结构的列表
=

前言
-

*  模仿QQ联系人页面，实现树型结构数据的展示；


一、概述
-

* 1、封装树型结构的节点，目前根节点和叶子节点共用同一个数据模型
* 2、基于UITableView进行功能实现，所有数据由根节点(-1级)进行管理，section为0级数据，row为1...n级节点
* 3、提供Aggregate模块库，对外以Framework进行功能使用；
* 4、提供三种测试情况，一为随机组织数据，二为QQ联系人界面，三为沙盒文件查看，其中前两者数据为静态数据，沙盒数据
     由点击查看进行数据生成，且仅生成一次


二、发布
- 

* 1、MTreeViewFramework 最低支持版本为7.0;


三、效果
-
<img src="https://raw.githubusercontent.com/was0107/treeTableView/master/images/qq.gif" width="80%">
<img src="https://raw.githubusercontent.com/was0107/treeTableView/master/images/file.gif" width="80%" >
<img src="https://raw.githubusercontent.com/was0107/treeTableView/master/images/1.jpg" width="80%">
<img src="https://raw.githubusercontent.com/was0107/treeTableView/master/images/2.jpg" width="80%">
<img src="https://raw.githubusercontent.com/was0107/treeTableView/master/images/3.jpg" width="80%">
<img src="https://raw.githubusercontent.com/was0107/treeTableView/master/images/4.jpg" width="80%">