
// LN 2021 

#ifndef CARLSIM_API_H
#define CARLSIM_API_H

#include <carlsim_conf_api.h>

#ifndef CARLSIM_INTERFACE_API
#  ifdef carlsim_interface_EXPORTS
#    define CARLSIM_INTERFACE_API CARLSIM_EXPORT
#    define CARLSIM_INTERFACE_EXTERN CARLSIM_EXPORT_EXTERN
#  else
#    define CARLSIM_INTERFACE_API CARLSIM_IMPORT
#    define CARLSIM_INTERFACE_EXTERN CARLSIM_EXPORT_EXTERN
#  endif
#endif


#endif // CARLSIM_API_H