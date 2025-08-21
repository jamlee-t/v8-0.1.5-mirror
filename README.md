# v8-0.1.5-mirror

## 编译步骤

```bash
# 禁止 warn 当做 error
sed -i 's/-Werror//g' src/SConscript 

# 镜像已替换好 old-release 镜像源
docker pull navit/ubuntu:8.04
docker run --name ubuntu-804 --restart=always -tid -v `pwd`:/app navit/ubuntu:8.04

# 进入容器安装必备软件
# scons: v0.97.0d20071203.r2509。
# g++: 4.2
apt-get install build-essential scons
# 编译
scons
# 或者编译 debug 版本 scons mode=debug
# 编译 shell
g++ -I. -L./release -o shell shell.cc -lv8 -lpthread -lrt

# 一句话编译
docker exec -t -w /app ubuntu-804 bash -c "scons mode=debug; g++ -I. -L./debug -o debug/shell shell.cc -lv8 -lpthread -lrt"
```

## 打印机器码

```diff
iff --git a/src/api.cc b/src/api.cc
index f346cc19778..f5e6b1ea30d 100644
--- a/src/api.cc
+++ b/src/api.cc
@@ -1054,6 +1054,9 @@ Local<Value> Script::Run() {
   {
     HandleScope scope;
     i::Handle<i::JSFunction> fun = Utils::OpenHandle(this);
+
+    fun->code()->PrintLn();
+
     EXCEPTION_PREAMBLE();
     i::Handle<i::Object> global(i::Top::context()->global());
     i::Handle<i::Object> result =
```

则会输出机器码：
```
0xf7c12211: [Code]
kind = FUNCTION
Instructions (size = 86)
0xf7c12228     0  55             push ebp                    ;; debug: statement 0
0xf7c12229     1  8bec           mov ebp,esp
0xf7c1222b     3  56             push esi
0xf7c1222c     4  57             push edi
0xf7c1222d     5  c7c05d01c0f7   mov eax,0xf7c0015d          ;; object: 0xf7c0015d <undefined>
0xf7c12233    11  50             push eax
0xf7c12234    12  688dcc8df7     push 0xf78dcc8d             ;; object: 0xf78dcc8d <FixedArray[2]>
0xf7c12239    17  fff6           push esi
0xf7c1223b    19  6a00           push 0x0
0xf7c1223d    21  c7c002000000   mov eax,0x2
0xf7c12243    27  e8a808ffff     call 0xf7c02af0             ;; code target (STUB, Runtime, DeclareGlobals)
0xf7c12248    32  3b2508992008   cmp esp,[0x8209908]         ;; external reference (StackGuard::address_of_limit())
0xf7c1224e    38  0f8223000000   jc 79  (0xf7c12277)
0xf7c12254    44  680122c1f7     push 0xf7c12201             ;; debug: statement 58
                                                             ;; object: 0xf7c12201 <String[5]: hello>
0xf7c12259    49  ff7617         push [esi+0x17]
0xf7c1225c    52  e8f76effff     call 0xf7c09158             ;; code target (context) (CALL_IC)
0xf7c12261    57  8b75fc         mov esi,[ebp+0xfc]
0xf7c12264    60  890424         mov [esp],eax
0xf7c12267    63  8b0424         mov eax,[esp]
0xf7c1226a    66  8945f4         mov [ebp+0xf4],eax
0xf7c1226d    69  58             pop eax
0xf7c1226e    70  8b45f4         mov eax,[ebp+0xf4]
0xf7c12271    73  8be5           mov esp,ebp                 ;; js return
0xf7c12273    75  5d             pop ebp
0xf7c12274    76  c20400         ret 0x4
0xf7c12277    79  e81409ffff     call 0xf7c02b90             ;; debug: statement 0
                                                             ;; code target (STUB, StackCheck, minor: 0)
0xf7c1227c    84  ebd6           jmp 44  (0xf7c12254)

RelocInfo (size = 17)
0xf7c12228  position  (0)
0xf7c1222f  embedded object  (0xf7c0015d <undefined>)
0xf7c12235  embedded object  (0xf78dcc8d <FixedArray[2]>)
0xf7c12244  code target (STUB)  (0xf7c02af0)
0xf7c1224a  external reference (StackGuard::address_of_limit())  (0x8209908)
0xf7c12254  statement position  (58)
0xf7c12255  embedded object  (0xf7c12201 <String[5]: hello>)
0xf7c1225d  code target (context) (CALL_IC)  (0xf7c09158)
0xf7c12271  js return
0xf7c12277  position  (0)
0xf7c12278  code target (STUB)  (0xf7c02b90)
```

## wsl 设置 root 为默认用户
```
ubuntu.exe config --default-user root
# 或者不同版本
ubuntu2404.exe config --default-user root
```

## 打印 Object

```
object->Println()
```