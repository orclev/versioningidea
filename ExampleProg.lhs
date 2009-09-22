This would need the features of ghc 6.12 to work properly because it uses the new annotation system, and would likewise need a
ghc plugin to function properly. It compiles and runs just fine in current versions of ghc, but generates a bunch of warnings
about unrecognized pragmas.

Declare the main module and give it a version. No compat info provided for the module as it's not intended to be used elsewhere.

> module Main where
> {-# ANN module Version 1.0.0 #-}

Do the imports annotating them with target info. The versions would be the version numbers the developer is using and which he
knows the code compiles cleanly against.

> {-# ANN module ImportTarget ExampleMod 2.2.0 #-}
> import ExampleMod

Now, just use the module as normal.

> main :: IO ()
> main = do
>     putStrLn "Example Program using ExampleMod 2.2.0."
>     putStrLn "In practice this is being linked against ExampleMod 2.4.2, which is partially compatible."
>     putStrLn $ foo "For example, foo is compatible: "
>     putStrLn $ bar "So is bar: "
>     putStrLn "It would be an error to use baz or narf though as their not compatible."
>     putStrLn "If you did use them it may or may not compile depending on whether the behavior, or the type signature changed from the target version."

This would compile cleanly using the provided version of ExampleMod even though it's only partially compatible.
For the purposes of checking compatability call graphs would be built starting from all top level functions and the compatability info
for each function would be checked against the target version of the module it came from.

E.G. For this simple program it would look like:
    main
        foo <- Member of ExampleMod, Target is 2.2.0
        bar <- Member of ExampleMod, Target is 2.2.0
        ... <- Whatever other functions, basically all the stuff from Prelude, ignore because no version info given
