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

4. **云服务与AI能力适配**
	- 配置云服务、AI、推送、定位等接口为国行/中国大陆专用，提升体验和可用性。
	- 适配部分 ColorOS/国行专属功能，如智能侧边栏、AI记忆、云存储、会员服务等。

5. **适用范围与注意事项**
	- 仅适用于一加13（OxygenOS 16），不适用于修复硬件差异或驱动问题。
	- 需解锁Bootloader并具备Root权限。
	- 适合Magisk/KernelSU等模块化Root环境。

- 使用支持模块系统的root方案，如Magisk或KernelSU