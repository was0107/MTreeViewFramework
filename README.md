# MTreeViewFramework
[树型结构的列表](https://github.com/was0107/treeTableView)

##需求
*  模仿QQ联系人页面，实现展开折叠效果；

##分析
*	很明显QQ的联系人界面，使用的是二层树型结构进行展示，另加上展开与折叠来进行当前节点及子节点是否展示；
*	由于是列表类型，使用`UITableView`来进行列表展示再好不过，
*	在分类折叠过程中，具有折叠效果，且具有吸附效果，可以使用`UITableView`的Section Header进行实现；
*	由于是树型结构，故需要定义一个根节点，由根节点延伸出各子孙节点

##实现
* 1、定义树型结构的节点，目前根节点和叶子节点共用同一个数据模型
```objective-c		
@interface MTreeNode : NSObject
@property (nonatomic, readwrite, assign) BOOL expand;  // 返回当前节点是否已经展开，默认为NO
@property (nonatomic, readonly, assign) NSInteger depth; // 返回当前节点深度,默认为0，根节点为-1
@property (nonatomic, readonly, weak) MTreeNode *parentNode; // 返回当前节点的爷节点
@property (nonatomic, readwrite, strong) id content;    // 存储当前节点的数据模型
@property (nonatomic, readwrite, strong) NSMutableArray *subNodes; // 存储当前节点的子节点集合

- (instancetype)initWithParent:(MTreeNode *) parent expand:(BOOL) expand;
+ (instancetype)initWithParent:(MTreeNode *) parent expand:(BOOL) expand;
- (void) toggle;
@end
```
* 2、由以上的数据结构可知，当前节点的subNodes仅保存了当前节点的信息，对于其子孙节点信息均未能呈现，需要另外定义一个数据来进行管理，为不混淆当前节点的子节点与子孙节点，另使用`Category`来声明子孙节点
```objective-c		
@interface MTreeNode (ExpandNode)
@property (nonatomic, strong) NSMutableArray *expandNodes;      //存储当前节点之下展开的节点

- (NSArray *) getSubExpandNodes;
@end
```

* 3、`MTreeView`继承`UITableView`，声明一个根节点，及相应的方法
```objective-c		
@interface MTreeView : UITableView

@property (nonatomic, readwrite, strong) MTreeNode *rootNode;           //根节点

@property (nonatomic, readwrite, weak) IBOutlet id<MTreeViewDelegate> treeViewDelegate;


/**
 *  返回根节点的子节点数，即深度为0的节点数
 *
 *  @parames
 *  @param  treeView
 *
 *  @return 根节点的子节点数
 *
 */
- (NSInteger) numberOfSectionsInTreeView:(MTreeView *)treeView;

/**
 *  返回深度为0的所有子孙节点数
 *
 *  @parames
 *  @param  treeView
 *  @param  section
 *
 *  @return 深度为0的所有子孙节点数
 *
 */
- (NSInteger) treeView:(MTreeView *)treeView numberOfRowsInSection:(NSInteger)section;

/**
 *  展开或者折叠当前节点
 *
 *  @parames
 *  @param  indexPath   当row为负数时，则表示展开一级节点，即对应的Section点击事件处理
 *
 *  @return
 *
 */
- (void) expandNodeAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  获取指定path对应的节点
 *
 *  @parames
 *  @param  indexPath   当row为负数时，则表示获取一级节点
 *
 *  @return 对应的节点
 *
 */
- (MTreeNode *) nodeAtIndexPath:(NSIndexPath *)indexPath;
	
@end
```
	首先需要弄清楚，树型结构上的各节点，在UITableView是如何进行布局的，
	根节点（深度为-1）管理所有数据，在界面上不呈现；
	0级节点（深度为0）管理一级数据，对应的是Section数据；
	一..N级节点（深度为1..n），对应的是`UITableViewCell`，进行呈现；`UITableViewCell`根据深度，进行UI及逻辑的控制；

* 4、在构造树的数据时，为满足叶子节点可动态增加，及动画处理，故在此设计一个回调，供业务方进行使用；
```objective-c	
@protocol MTreeViewDelegate <NSObject>

@optional

/**
 *  即将展开/关闭子节点，此代理可以动态加载子节点
 *
 *  @parames
 *  @param  treeView
 *  @param  indexPath
 *
 */
- (void) treeView:(MTreeView *)treeView willexpandNodeAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  已经展开/关闭子节点，此代理可以于此进行动画效果的设置
 *
 *  @parames
 *  @param  treeView
 *  @param  indexPath
 *
 */
- (void) treeView:(MTreeView *)treeView didexpandNodeAtIndexPath:(NSIndexPath *)indexPath;

@end
```

##测试
提供三种测试情况，一为随机组织数据，二为QQ联系人界面，三为沙盒文件查看，其中前两者数据为静态数据，沙盒数据由点击查看进行数据的动态生成，且仅生成一次。效果请参照下图

<img src="https://raw.githubusercontent.com/was0107/treeTableView/master/images/qq.gif" width="50%" >
<img src="https://raw.githubusercontent.com/was0107/treeTableView/master/images/file.gif" width="50%">

##使用

*	1、此项目依赖SDK最低版本为7.0；
*	2、在工程中引入MTreeViewFramework.framework即可使用；





