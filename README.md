# Oneplus13Locational
适用于一加13 OxygenOS16 的本地化模块

**提示：本模块未必可以满足每个人的需求，请谅解。**

一个用于给 OxygenOS 补齐 ColorOS 本地化功能的模块，支持一加13。

注意：本模块并不适用于修复一加国行机型与外版机型的硬件差异带来的驱动问题

## 功能(包括正在做的)
1. **区域与运营商本地化**
	- 通过 `my_region/build.prop`、`my_carrier/build.prop`、`my_product/build.prop` 等文件，模拟国行（中国大陆）区域和运营商环境，解锁部分仅限国行的功能。
	- 设置区域标记、运营商标记、IMS注册、5G/VoLTE等相关参数，提升兼容性。

2. **系统属性与权限增强**
	- `system.prop` 配置允许模拟定位、关闭签名校验（开发阶段可用）、增强调试能力（默认关闭）。
	- 增加 `com.oplus.android-features.xml`、`com.oplus.app-features.xml` 等权限和特性声明，补齐ColorOS/国行特有API能力。

3. **应用启用/禁用与配置**
	- 通过 `my_stock/etc/config/app_v2.xml`，批量禁用/启用部分系统应用，精简系统、提升兼容性。
	- 恢复/增强电话、短信、录音、推送、天气等核心功能。 

5. **适用范围与注意事项**
	- 仅适用于一加13（OxygenOS 16），不适用于修复硬件差异或驱动问题。
	- 需解锁Bootloader并具备Root权限。
	- 适合Magisk/KernelSU等模块化Root环境。


## OxygenOS16本地化总结

1. 恢复国内消息推送服务，O16的`my_carrier`运营商配置文件分区是空的占位文件，所以要替换成C16的`my_carrier`全网通配置文件，其中`/my_carrier/etc/extension/com.oplus.app-features.xml`跟pin码有关这个是O16没有的不清楚有什么影响，O16的`my_region/build.prop`包含有国内运营商网络与通信配置以及云服务，这个也要替换成C16的文件，最后把O16的`com.heytap.mcs`这个推送组件替换成C16的就恢复OPPO的推送服务了
2. 恢复电话和短信服务以及通话录音禁止 提示,删除O16自带的Google电话本和消息，安装在`/my_stock/priv-app/Contacts`(`com.android.contacts`)和`/my_stock/priv-app/InCallUI`(`com.android.incallui`)这两个组件，安装国行或者印度版的信息组件(`com.android.mms`)，如果是国际版O16会提示`InCallUI`安装包无效，这是因在为在`/my_stock/etc/config/app_v2.xml`中被系统禁用了，要把和`com.android.incallui`有关的删除，O16国际版通话录音开启时会提示当前通话正在被录音，在`my_region/etc/extension/com.oplus.app-features.xml`中添加

```xml
#电话模块中国区域标识

<app_feature name="com.android.phone.region_cn"/>
```

这行代码就不会出现提示音了

信息安装完成后能收短信但是无法发出，需要爱玩机助手给信息相关权限，MT管理器终端给root权限执行

`pm grant com.android.mms android.permission.READ_PRIVILEGED_PHONE_STATE`

3.   恢复国行一加互传，直接替换`/my_stock/priv-app/OShare/`这个目录下的组件，C16为(`com.coloros.oshare`)O16为(`com.oneplus.oshare`)，目前最大的问题是能收不能发，因为发送位置被Google快速分享占用了，如果用C16相册在相册里分享会多出一个位置这时就可以使用一加互传

4.   恢复C16钱包使用门禁卡交通卡，安装系统卡包组件(`com.heytap.tas`)和钱包(`com.finshell.wallet`)以及账号服务(`com.heytap.vip`)账号中心(`com.oplus.account`)登录国内账号即可使用，也可以直接刷别人做好的模块，不过我本人是没有门禁卡和交通卡的需求的，所以只测试能正常办理交通卡没有试过门禁卡

5.   恢复Car+车联，安装数字车钥匙服务(`com.oplus.cardigitalkey`)，CarLink(`com.heytap.opluscarlink`),

Car+ 车联(`com.oplus.ocar`)安装完成后在设备互联中会出现Car+车联相关界面，因为我本人没有车也不需要所以不确定是否完全恢复

6.   恢复与iPhone互联，只知道在`my_region`里面替换整个`my_region`出现，不确定和`my_region`里面哪个文件有关因为我不需要所以不研究了

7.   恢复速览负一屏，

先禁用Google负一屏在`my_region/etc/extension/com.oplus.app-features.xml`中添加

```xml
#启动器区域设置为中国

<app_feature name="com.android.launcher.REGION_NAME" args="String:CN"/>

#启动器中国版本标识

<app_feature name="com.android.launcher.CN_VERSION"/>
```

这两行代码

不想看广告的不用替换速览(`com.coloros.assistantscreen`)这个组件，但是会缺少一点本地化功能，如快捷服务，速览第三方小组件依赖快应用服务框架(`com.nearme.instant.platform`)和OpenCapabilityService(`com.coloros.ocs.opencapabilityservice`)这两个组件，像快递查询物流服务等会需要国内账号，我本人不需要负一屏所以直接整个删除了，需要的可以安装恢复

8.   恢复云服务和查找手机服务，这些都需要国内账号就是上面提到过的两个组件，安装就可以使用

9.   恢复小布ai全家桶，小布记忆和账号绑定，O16小布助手不能使用C16的账号服务，把O16的小布记忆换成C16的小布记忆使用AI总结时提示生成失败，但是记账功能等正常推测AI总结需要上传到云端服务器如中国区AI服务地址(`aitool-infer-cn.heytapmobi.com`)海外区(`aitool-oversea-nl.heytapmobile.com`)记账功能通过本地识别屏幕所以不受影响，小布助手不绑定账号海外国内都可以使用，小布建议跟智慧能力服务(`com.oplus.deepthinker`)智慧决策服务(`com.oplus.metis`)等有关，安装组件后会多出很多服务

10.   恢复流体云，恢复系统流体云和服务治理框架(`com.oplus.pantanal.ums`)智慧出行(`com.oplus.travelengine`)智慧数据增强服务(`com.coloros.sceneservice`)有关，安装这三个组件可以恢复系统流体云，第三方流体云配置在my_region里，目前不清楚是里面哪个文件有关我会继续研究

11.   天气定位问题，替换O16的定位服务(`com.oplus.location`)和`com.android.location.fused`

天气服务(`com.coloros.weather.service`)

以及运营商特定GPS辅助服务`my_region/extension/oplus_carrier_config.xml`

OxygenOS16天气无法定位问题，只需要把`/odm/etc/gps/`这个目录下的文件补全ColorOS的就可以解决，Oxygen缺少相应文件，优先使用北斗定位在`my_region/etc/extension/oplus_carrier_config.xml`这个文件里