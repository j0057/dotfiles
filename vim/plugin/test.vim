function! TestPython()

if has('python')

python << EOF
print 'hello world'
import vim

for objname in ['vim', 'vim.buffer', 'vim.current']:
    obj = eval(objname)
    print objname, obj
    for item in dir(vim):
        v = getattr(vim, item)
        print
        print item, ':', v
        print 
        print '#' * 80
        if hasattr(v, '__doc__'):
            print v.__doc__
        print
        print '-' * 80
        print
    print
    print '#' * 80
    print 

EOF

else

    echo "test.vim: no +python"

endif

endfunction

:map <F9> :call TestPython()<CR>

