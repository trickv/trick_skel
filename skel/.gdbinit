# trick_skel gdbinit

handle SIGXCPU SIG35 SIG33 SIGPWR nostop noprint
handle SIGSEGV pass noprint

define mono_backtrace
 select-frame 0
 set $i = 0
 while ($i < $arg0)
   set $foo = mono_pmip ($pc)
   if ($foo == 0x00)
     frame
   else
     printf "#%d %p in %s\n", $i, $pc, $foo
   end
   up-silently
   set $i = $i + 1
 end
end

define mono_stack
 set $mono_thread = mono_thread_current ()
 if ($mono_thread == 0x00)
   printf "No mono thread associated with this thread\n"
 else
   set $ucp = malloc (sizeof (ucontext_t))
   call (void) getcontext ($ucp)
   call (void) mono_print_thread_dump ($ucp)
   call (void) free ($ucp)
 end
end
