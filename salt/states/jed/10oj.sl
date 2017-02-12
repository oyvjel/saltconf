#ifdef IBMPC_SYSTEM
  LINENUMBERS   = 2;    % A value of zero means do NOT display line number on
#else                   % status line line.  A value of 1, means to display
  LINENUMBERS   = 1;    % the linenumber. A value greater than 1 will also
#endif                  % display column number information.  I recommend a
                        % value of 2 only at high baud rates

add_mode_for_extension("php","php3");
add_mode_for_extension("php","php4");
add_mode_for_extension("php","php5");
add_mode_for_extension("php","inc");
add_mode_for_extension("sh","sls");
