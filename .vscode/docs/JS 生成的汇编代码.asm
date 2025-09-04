; 源码文件
; var obj = {name: 'hello'}
; function sayHello() {
;     print("sayHello")
; }
; print("hello")


--- Code ---
0xf7c12221: [Code]
kind = FUNCTION
Instructions (size = 165)

;; 常规调用约定
0xf7c12238     0  55             push ebp                    ;; debug: statement 0
0xf7c12239     1  8bec           mov ebp,esp
0xf7c1223b     3  56             push esi
0xf7c1223c     4  57             push edi                    ;;  callee-saved 包括 EBX, ESI, EDI, EBP, ESP。caller-saved 包括 EAX, ECX, EDX

;; 调用 DeclareGlobals 声明变量。__ CallRuntime(Runtime::kDeclareGlobals, 3)，它有3个参数
0xf7c1223d     5  c7c05d01c0f7   mov eax,0xf7c0015d          ;; object: 0xf7c0015d <undefined>
0xf7c12243    11  50             push eax                    ;; 压栈 eax，也就是 undefined。这个 undefined 对象实际上是作为 receiver 压栈
0xf7c12244    12  689dcc91f7     push 0xf791cc9d             ;; object: 0xf791cc9d <FixedArray[4]> ，压栈固定数组大小 4。
0xf7c12249    17  fff6           push esi                    ;; V8 的调用契约保证 进入 JSFunction 时，esi 已经由调用方设置好指向当前 context。第 1 个参数
0xf7c1224b    19  6a00           push 0x0                    ;; push 0 是 runtime 调用所需要的一个参数，意义是”flags = 0“。第 2 个参数
0xf7c1224d    21  c7c002000000   mov eax,0x2                 ;; 这次调用从栈上取 2 参数。
0xf7c12253    27  e89808ffff     call 0xf7c02af0             ;; code target (STUB, Runtime, DeclareGlobals)，调用Runtime函数Stub

0xf7c12258    32  3b2508992008   cmp esp,[0x8209908]         ;; external reference (StackGuard::address_of_limit())
0xf7c1225e    38  0f8272000000   jc 158  (0xf7c122d6)
0xf7c12264    44  684ddec0f7     push 0xf7c0de4d             ;; object: 0xf7c0de4d <String[3]: obj>
0xf7c12269    49  8b4df8         mov ecx,[ebp+0xf8]
0xf7c1226c    52  8b4917         mov ecx,[ecx+0x17]
0xf7c1226f    55  8b5907         mov ebx,[ecx+0x7]
0xf7c12272    58  81fb5d01c0f7   cmp ebx,0xf7c0015d          ;; object: 0xf7c0015d <undefined>
0xf7c12278    64  0f8440000000   jz 134  (0xf7c122be)
0xf7c1227e    70  53             push ebx
0xf7c1227f    71  c7c000000000   mov eax,0x0
0xf7c12285    77  e84251ffff     call 0xf7c073cc             ;; code target (STUB, Runtime, CloneObjectLiteralBoilerplate)
0xf7c1228a    82  50             push eax
0xf7c1228b    83  c7c001000000   mov eax,0x1
0xf7c12291    89  e89a6effff     call 0xf7c09130             ;; code target (STUB, Runtime, InitializeVarGlobal)
0xf7c12296    94  688d21c1f7     push 0xf7c1218d             ;; debug: statement 74
                                                             ;; object: 0xf7c1218d <String[5]: print>
0xf7c1229b    99  ff7617         push [esi+0x17]
0xf7c1229e   102  680122c1f7     push 0xf7c12201             ;; object: 0xf7c12201 <String[5]: hello>
0xf7c122a3   107  e8a00bffff     call 0xf7c02e48             ;; code target (context) (CALL_IC)
0xf7c122a8   112  8b75fc         mov esi,[ebp+0xfc]
0xf7c122ab   115  890424         mov [esp],eax
0xf7c122ae   118  8b0424         mov eax,[esp]
0xf7c122b1   121  8945f4         mov [ebp+0xf4],eax
0xf7c122b4   124  58             pop eax
0xf7c122b5   125  8b45f4         mov eax,[ebp+0xf4]
0xf7c122b8   128  8be5           mov esp,ebp                 ;; js return
0xf7c122ba   130  5d             pop ebp
0xf7c122bb   131  c20400         ret 0x4
0xf7c122be   134  fff1           push ecx                    ;; debug: statement 0
0xf7c122c0   136  6a00           push 0x0
0xf7c122c2   138  688dcc91f7     push 0xf791cc8d             ;; object: 0xf791cc8d <FixedArray[2]>
0xf7c122c7   143  c7c002000000   mov eax,0x2
0xf7c122cd   149  e82251ffff     call 0xf7c073f4             ;; code target (STUB, Runtime, CreateObjectLiteralBoilerplate)
0xf7c122d2   154  8bd8           mov ebx,eax
0xf7c122d4   156  eba8           jmp 70  (0xf7c1227e)
0xf7c122d6   158  e8b508ffff     call 0xf7c02b90             ;; code target (STUB, StackCheck, minor: 0)
0xf7c122db   163  eb87           jmp 44  (0xf7c12264)

RelocInfo (size = 34)
0xf7c12238  position  (0)
0xf7c1223f  embedded object  (0xf7c0015d <undefined>)
0xf7c12245  embedded object  (0xf791cc9d <FixedArray[4]>)
0xf7c12254  code target (STUB)  (0xf7c02af0)
0xf7c1225a  external reference (StackGuard::address_of_limit())  (0x8209908)
0xf7c12265  embedded object  (0xf7c0de4d <String[3]: obj>)
0xf7c12274  embedded object  (0xf7c0015d <undefined>)
0xf7c12286  code target (STUB)  (0xf7c073cc)
0xf7c12292  code target (STUB)  (0xf7c09130)
0xf7c12296  statement position  (74)
0xf7c12297  embedded object  (0xf7c1218d <String[5]: print>)
0xf7c1229f  embedded object  (0xf7c12201 <String[5]: hello>)
0xf7c122a4  code target (context) (CALL_IC)  (0xf7c02e48)
0xf7c122b8  js return
0xf7c122be  position  (0)
0xf7c122c3  embedded object  (0xf791cc8d <FixedArray[2]>)
0xf7c122ce  code target (STUB)  (0xf7c073f4)
0xf7c122d7  code target (STUB)  (0xf7c02b90)
