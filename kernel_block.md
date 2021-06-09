## About kernel block
Some kernels are blocking most of known optimizers including some apps by preventing their instalaltion/execution.<br>
Why do kernel devs do this? For various reasons. Some are sick of false user reports in conflicting situations, some just hate optimizers and/or think they're doing better, some just blindly copy commits from others not even knowing why.<br>
Whatever. This file is created NOT in order to ashame or abuse anyone, but for answering all that "will this kernel work with FDE.AI" questions.<br>

This is the list of kernels which I found and are blocking optimizers. If you want to use FDE.AI - don't use any of this kernels and switch to a better one.<br><br>

_Mi A1:_
 - WuuzKernul
 - DerpFest prebuilt
 - RevengeOS prebuilt
 - PixelDust prebuilt
 - Pixel Experience prebuilt
 - Descendant prebuilt
 - CarbonROM prebuilt
 - Raven-Kernel
 - MSM Xtended prebuilt<br><br>

_Mi A2 lite:_
 - MSM Xtended prebuilt
 - Cardinal_Kramul
 - Thor kernel<br><br>

_Mi 5X:_
 - PixelDust prebuilt
 - Descendant prebuilt
 - CarbonROM prebuilt
 - DerpFest prebuilt<br><br>

_Mi 9T Pro/Redmi K20Pro:_
 - AICP prebuilt
 - Pixel Experience prebuilt
 - Corvus prebuilt
 - OmniROM prebuilt
 - F1xy kernel
 - OmniF1xy kernel
 - TitaniumOS prebuilt
 - EvolutionX prebuilt
 - Marisa kernel<br><br>

_Redmi K20/Mi 9T:_
 - VantomKernel
 - F1xy kernel
 - Project Fluid prebuilt
 - PixysOS prebuilt
 - Marisa kernel
 - StatiXOS prebuilt
 - ArrowOS prebuilt<br><br>

_Redmi 4A/5A:_
 - GoGreen kernel
 - Cygnus prebuilt
 - GreenForce kernel<br><br>

_Redmi Note 4/4x:_
 - Corvus prebuilt
 - DerpFest prebuilt
 - PixelDust prebuilt
 - Descendant prebuilt
 - CarbonROM prebuilt
 - PureCAFx kernel<br><br>

_Lenovo a6000/a6010:_
 - LayeardTeam kernel
 - Acroreiser kernels
 - Prototype kernel
 - Projectneesan kernel
 - Requiem kernel
 - ARAGOTO kernel
 - Eclipse kernel<br><br>

_Poco X3:_
 - StormBreaker kernel (non-MIUI)
 - Silont Project kernel
 - F1xy kernel<br><br>

_Samsung:_
 - ThunderStormS kernel (Galaxy S10 & Note10 & S7)
 - White Wolf kernel (Galaxy S9 & S9)<br><br>

_Misc:_
 - All TogoFire's (Togo 77) kernel builds 
 - All Yaroslav Furman's kernel builds (all F1xy kernels)
 - DerpFest prebuilt - MiA2, Mi6X, Mi9
 - White Wolf Kernel - Mi10 5G
 - StagOS prebuilt - Asus Zenfone Max Pro M1
 - NeonKernel - Redmi 9S
 - BloodMoon kernel - Realme XT
 - Forest kernel - Mi Note 3
 - EvolutionX prebuilt - Redmi Note 8 Pro
 - SiLonT Project prebuilt - Redmi Note 8<br><br>
 
 I am not going to update this list frequently. You can find out if kernel has blocker or not by your own this way:
 - Find a source code repo of your kernel. If dev doesn't provided source code for it's kernel - change your kernel to a better one straight away.
 - Once you found kernel source, search for "com.feravolt" keyword in that repo, also check your defconfig file for "CONFIG_BLOCK_UNWANTED_FILES=Y".
 
 If any of theese from above matches for you - "congratulations", kernel dev decided to block "unwanted" apps for you. In such case, consider avoiding such kernel if you wish to have freedom of what to do with your system and be able to use FDE.AI inclusive. OR you may try to use FDE.AI-as-system-app Magisk module from releases page.
 
 
 
 
