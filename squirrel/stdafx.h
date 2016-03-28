
#pragma once

#ifdef _DEBUG
#include <crtdbg.h>
#endif
#include <new>
#include <limits.h>
#include <assert.h>
#include <setjmp.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <ctype.h>
#include <wchar.h>
#include <wctype.h>
#include <windows.h>

#ifdef Yield
#undef Yield
#endif
