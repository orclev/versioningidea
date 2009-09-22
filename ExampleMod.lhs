This would need the features of ghc 6.12 to work properly because it uses the new annotation system, and would likewise need a
ghc plugin to function properly.

first declare the module, and annotate it's version and compatability

> module ExampleMod (foo, bar, baz, narf) where
> {-# ANN module Version 2.4.2 #-}
> {-# ANN module Compat $ Full 2.4.0 && Partial 2.1.0 #-}

next we do imports and annotate those with target versions, same as any other program.

> {-# ANN module ImportTarget Data.List 4.1.0.0 #-}
> import Data.List as L

lastly we have out functions and/or types annotated as appropriate with compatability info

> {-# ANN foo Compat Full 2.1.0 #-}
> foo :: String -> String
> foo = flip (++) "Foo! "
>
> {-# ANN bar Compat Full 2.2.0 #-}
> bar :: String -> String
> bar = flip (++) "Bar! "
>
> {-# ANN baz Compat Full 2.4.0 #-}
> baz :: String -> String
> baz = flip (++) "Baz! "
>
> {-# ANN narf Compat 2.4.2 #-}
> narf :: String -> String
> narf = flip (++) "Narf! "
