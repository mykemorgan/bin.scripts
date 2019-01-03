#!/usr/bin/awk -f
# Tries to colorize log lines for console readability.
# 

BEGIN {
  in_warning = 0;
  in_alert = 0;
}

{
  in_warning = 0;
  in_alert = 0;
  in_service_response = 0;
}

# warning lines
/ warning / {
  in_warning = 1;
}

# error lines
/ alert / {
  in_alert = 1;
}

/ Service returned HTTP / {
  in_service_response = 1;
}

{
  if (in_warning)
    printf("[31m");
  if (in_alert)
    printf("[31;1m");
  if (in_service_response)
    printf("[32m");

  print $0;

  if(in_warning || in_alert || in_service_response)
    printf("[0m");
  fflush();
}

END {
  printf("[0m");
}
