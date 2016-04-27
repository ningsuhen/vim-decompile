# vim-cfr 

Need a Java .class file YOU need decompiling?
CFR it!

vim-cfr is a vim plugin for automatically decompiling a Java classfile when you open it.
It uses the CFR Java decompiler to work.


# How to Use

0. Download the CFR compiler [here][cfr] and Java [here][java].
1. Install the plugin using your favorite plugin manager.
2. Open a compiled Java .class file.
3. ???
4. Profit!


# Configuration

 - g:cfr\_jar\_location - Used to find where cfr is. Empty by default.
 - g:cfr\_jar\_filename - Used if cfr is a different filename for some reason. Set to the latest release by default.


# CFR

CFR is Copyright (c) 2011-2104 Lee Benfield.
I am not Lee Benfield, and do not own CFR.


[cfr]: http://www.benf.org/other/cfr/
[java]: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
