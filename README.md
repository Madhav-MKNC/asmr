Assemble the Program:

```(bash)
nasm -f elf hello.asm
```

Link the Object File:

```(bash)
ld -m elf_i386 -s -o hello hello.o
```

Run
  
```(bash)
./hello
```
