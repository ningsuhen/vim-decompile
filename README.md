# vim-decompile

Need a Java .class file YOU need decompiling?
We've got your back!

vim-decompile is a vim plugin for automatically decompiling a Java classfile when you open it.
By default, it uses the Java decompiler `javap`, but you can configure it for other decompilers if needed.

`javap` is included with all new installs of the Java development kit (JDK).


# How to Use

0. Download Java [here][java].
1. Install the plugin using your favorite plugin manager.
2. Open a compiled Java .class file.
3. ???
4. Profit!


# Configuration

## g:decomp\_jar

Uses the given custom jar for decompilation, rather than javap.
It is empty by default.

```vim
 let g:decomp_jar = '/my/jar/directory/cfr.jar'
```



[java]: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
