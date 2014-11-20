

# Lack of Generics in Go

One of my frustrations in Java 1.3 (pre-generics) was the difficulty of
creating algorithms to operate on a range of types.  

- If the algorithm operates on Object, the algorithm is limited to operations on Object.  The user must explicitly unbox/cast the results of the algorithm back to the input type, e.g. String.
- If the algorithm operates on an interface, then the input type must explicitly implement the interface (not a big deal in my experience) and the results of the algorithm must be explicitly cast back to the input type.

Generics provide a way to avoid casting and hence runtime type errors.

The interfaces of Go decouple algorithm design from explicit declaring that a type implements an interface.  Hence the "duck-typing" description.
You still are stuck with explicitly casting the output of the algorithm back to the input type (assuming that is the type you want to use), I think.

http://stackoverflow.com/questions/6255720/making-generic-algorithms-in-go
https://golang.org/doc/faq#generics


# Embedded Types

http://www.goinggo.net/2014/05/methods-interfaces-and-embedded-types.html


