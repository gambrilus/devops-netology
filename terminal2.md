1   cd is a shell builtin. Она является встроенной команда шелла, потому что необходима для базовых действий внутри шелла

2   grep -c <some_string> <some_file>

3   systemd

4   ls 2>/dev/pts/1

5   cat <exaple.md>oufile.md

6   Через команду перенаправления ввести получится, но наблюдать не получится

7   После выполнения все что отправляется в 5 поток будет выходить в stdout. При вводе команды мы увидим вывод netology в нашем stdout (т.е. на экране).

8   Да через использование дополнительного потока из предыдущего вопроса. 
    Например:
    strace ls -lha / 5>&2 2>&1 1>&5 | grep openat
    
9   Можно, командой env.

10  /proc/[pid]/cmdline строка 120
    This read-only file holds the complete command line for the process, unless the process is a zombie.  In the latter case, there is nothing in this file: that is, a read on this file will
    
    /proc/[pid]/exe строка 146
    Under  Linux  2.2  and later, this file is a symbolic link containing the actual pathname of the executed command.  This symbolic link can be dereferenced normally; attempting to open it will open the executable.  You can even type /proc/[pid]/exe to run another copy of the same executable that is being run by process [pid].  If the pathname has been unlinked,  the  symbolic link will contain the string '(deleted)' appended to the original pathname.  In a multithreaded process, the contents of this symbolic link are not available if the main thread has already terminated (typically by calling pthread_exit(3)).
    Permission to dereference or read (readlink(2)) this symbolic link is governed by a ptrace access mode PTRACE_MODE_READ_FSCREDS check; see ptrace(2).
    Under Linux 2.0 and earlier, /proc/[pid]/exe is a pointer to the binary which was executed, and appears as a symbolic link.  A readlink(2) call on this file under  Linux  2.0  returns a string in the format:
        [device]:inode

    For example, [0301]:1502 would be inode 1502 on device major 03 (IDE, MFM, etc. drives) minor 01 (first partition on the first drive).

        find(1) with the -inum option can be used to locate the file.

11  grep sse /proc/cpuinfo 
    sse2

12  ssh -t localhost 'tty' принудительно создаст pty. 


14  Команда будет работать потому что tee берет данные из stdin и передает их в файл
