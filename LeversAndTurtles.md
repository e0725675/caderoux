Viewable online here: http://www.slideshare.net/caderoux/get-a-lever-and-pick-any-turtle-lifting-with-metadata

# Introduction #

My Goal is to demonstrate concrete metadata techniques for SQL Server, simplified from actual production code that: Make for maintainable systems, Are flexible for a variety of problems and Extend your productivity for more leverage – taking simple building blocks and concepts to build larger structures.

The presentation and code is available for download http://code.google.com/p/caderoux/downloads/detail?name=leversandturtles-SQLSaturday64-BatonRouge-20110806.zip&can=2&q=#makechanges

# Details #

Archimedes is often associated with work with simple machines and this quote about the lever is attributed to him.  With an appropriate tool, you can magnify your strengths and free up time to concentrate on less tractable problems.  The analogy with the lever does break down – with a lever, you use a smaller force through a larger distance – with the techniques in this talk, you should use less effort and less time!

As you can imagine, this talk is going to be a bit recursive.  Metadata is data about data.  In this talk I’ll be showing tactics that use metadata to manage metadata…  We normally build software in layers.  I’m going to be talking about using metadata from one layer to support the next layer.

Although using metadata and code generation can be faster and more efficient than manual coding, using the proper lifting technique can also be safer as well by eliminating defects through consistently generated and re-generated code, exception reports and self-maintaining subsystems.