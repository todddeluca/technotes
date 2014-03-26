

http://julialang.org/


## Language Features

The introduction (http://docs.julialang.org/en/release-0.2/manual/introduction/) describes some of the features of Julia.  Here are several ways it differs from typical (e.g. python) dynamically typed languages:

- The core language imposes very little; the standard library is written in Julia itself, including primitive operations like integer arithmetic
- A rich language of types for constructing and describing objects, that can also optionally be used to make type declarations
- The ability to define function behavior across many combinations of argument types via multiple dispatch
- Automatic generation of efficient, specialized code for different argument types
- Good performance, approaching that of statically-compiled languages like C

Some other features:

- Free and open source (MIT licensed)
- User-defined types are as fast and compact as built-ins
- No need to vectorize code for performance; devectorized code is fast
- Designed for parallelism and distributed computation
- Lightweight “green” threading (coroutines)
- Unobtrusive yet powerful type system
- Elegant and extensible conversions and promotions for numeric and other types
- Efficient support for Unicode, including but not limited to UTF-8
- Call C functions directly (no wrappers or special APIs needed)
- Powerful shell-like capabilities for managing other processes
- Lisp-like macros and other metaprogramming facilities

I've very excited to try a language with the speed of static typing and a JIT (like Julia or Go) combined with the type inference needed to make the type syntax lightweight (and even optional!).  Julia seems to have the syntactic lightness for prototyping and the typing and speed needed for production systems.

The object model (types + multiple dispatch functions) appeals to me.  It seems simple and powerful.  Other features, like unicode support, shell capabilities, C function calls, and metaprogramming make me feel like the language designers really get what people need in a well-designed language.  I think Julia has the potential to become powerful and widespread!
