% Intake24 API reference

## Introduction

Intake24 API uses several data encoding conventions that are slightly different from what is usually encountered in
other JSON-based APIs. These conventions are explained below and are used throughout the system.

### Optional type
      
Optional values are encoded as JSON arrays with either zero elements (when the value is not present):

~~~ {.json}
{
  "value": []
}
~~~

or exactly one element (when the value is present):

~~~ {.json}
{
  "value": ["hello"]
}
~~~

as opposed to the more popular convention of omitting the optional fields altogether in case the value is missing.
      
The reasoning behind such encoding is that optional types in Intake24 can form a part of a more complex type. For
instance, a type which is either an optional string, or a number (see also the explanation of the Either type below) is
encoded as follows:

~~~ {.json} 
{
  "optionalLeftOrRight": [
    0,
    []
  ]
}
~~~

the missing left value could potentially be encoded as @b{null}, but that would be inconsistent with the case where the
optional value is a field and it would also make it impossible to tell which values are intended to be optional. Having
an explicit optional value encoding allows to assume that no value can ever be @b{null} and avoid unnecessary nullness
checking and null pointer exceptions.
      
Another less practical reason for this encoding is that it would otherwise be impossible to encode a nested optional
value as a field. In this example, "value" is an optional value that is present that wraps another optional value that
is missing:

~~~ {.json}
{
  "value": [
    []
  ]
}
~~~

It would be impossible to encode the presence of the outer value using field omission if the inner value was missing.

Of course such types are unlikely to be used in practice, however they must still be possible to encode to ensure the
robustness of the server-side automated JSON mapping system. 

### Either type

The Either type represents values with two possibilities, traditionally called left and right. The Either type is
encoded as a JSON array of exactly 2 elements, where the first element is either 0 or 1. If the first element is 0, then
the second element must be parsed as a value of the left type. If it is 1, then the second element must be parsed as the
right type.
      
For instance, **foodOrCategory** could be either a food header or a category header. These types are incompatible and
must be handled differently. If it is a food header (left type), it will be encoded as follows:

~~~ {.json}
{
  "foodOrCategory": [
    0,
    {
      "code": "FOOD001",
      "englishDescription": "Example food",
      "localDescription": [
        "Пример продукта"
      ],
      "doNotUse": false
    }
  ]
}
~~~
   
and if it is a category header (right type) it will be encoded like this:

~~~ {.json}
{
  "foodOrCategory": [
    1,
    {
      "code": "CAT001",
      "englishDescription": "Example category",
      "localDescription": [],
      "isHidden": false
    }
  ]
}
~~~
