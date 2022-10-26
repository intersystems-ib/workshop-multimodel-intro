Intro to basic concepts about multi-model database using InterSystems IRIS. You can find more information in [InterSystems Developer Hub](https://developer.intersystems.com)

<img src="img/multimodel.png" width="500px">

# What do you need to install? 
* [Git](https://git-scm.com/downloads) 
* [Docker](https://www.docker.com/products/docker-desktop) (if you are using Windows, make sure you set your Docker installation to use "Linux containers").
* [Docker Compose](https://docs.docker.com/compose/install/)
* [Visual Studio Code](https://code.visualstudio.com/download) + [InterSystems ObjectScript VSCode Extension](https://marketplace.visualstudio.com/items?itemName=daimor.vscode-objectscript)

# Setup
Build the container
```
docker-compose build
```

Run the container we will use as our IRIS instance:
```
docker-compose up -d
```

# Examples

## (a). Create a table / persistent class

Let's create a new persistent class using VS Code:

```objectscript
Class try.Point Extends %Persistent [DDLAllowed]
{
    Property X;
    Property Y;
}
```

This persistent class in InterSystems IRIS is also a table.

You could also create the same class using DDL / SQL:
```sql
CREATE Table try.Point (
    X VARCHAR(50),
    Y VARCHAR(50)
)
```


## (b). Storage

After compilation, the class would have generated a storage structure, as a persistent class in InterSystems IRIS is also a table.

Pay attention to:
* Type: generated storage type, in our case the default storage for persistent objects
* StreamLocation - global where we store streams
* IndexLocation - global for indices
* IdLocation - global where we store ID autoincremental counter
* **DefaultData** - storage XML element which maps global value to columns/properties
* **DataLocation** - global in which to store data

```objectscript
Class try.Point Extends %Persistent [ DdlAllowed ]
{

Property X;

Property Y;

Storage Default
{
<Data name="PointDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>X</Value>
</Value>
<Value name="3">
<Value>Y</Value>
</Value>
</Data>
<DataLocation>^try.PointD</DataLocation>
<DefaultData>PointDefaultData</DefaultData>
<IdLocation>^try.PointD</IdLocation>
<IndexLocation>^try.PointI</IndexLocation>
<StreamLocation>^try.PointS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
```

*DefaultData* is `PointDefaultData`, it means that the global node has this structure:
* 1 - %%CLASSNAME
* 2 - X
* 3 - Y


So, the global should look like this:
```objectscript
^try.PointD(id) = %%CLASSNAME, X, Y
```

## (c). Have a look at the data

We still have no data. 

Open a [WebTerminal](http://localhost:52773/terminal/) session.

Let's add one object:
```objectscript
set p = ##class(try.Point).%New()
set p.X = 1
set p.Y = 2
write p.%Save()
```

You can have a look at the data using SQL in [SQL Explorer](http://localhost:52773/csp/sys/exp/%25CSP.UI.Portal.SQL.Home.zen?$NAMESPACE=USER) or even using an external client through JDBC like *SQLTools* for VS Code.

```
select * from try.point
```

Now, you can display the global in [WebTerminal](http://localhost:52773/terminal/) or even [Global Explorer](http://localhost:52773/csp/sys/exp/UtilExpGlobalView.csp?$ID2=try.PointD&$NAMESPACE=USER&$NAMESPACE=USER)

```objectscript
zwrite ^try.PointD
try.PointD(1)=$lb("",1,2)
```

The expected structure %%CLASSNAME, X, Y is set with `$lb("",1,2)` which corresponds to X and Y properties of our object (%%CLASSNAME is system property, ignore it).

Of course, you can also add a row via SQL:

```sql
INSERT INTO try.Point (X, Y) VALUES (3,4)
```

The global will look like this:

```objectscript
zw ^try.PointD
^try.PointD=2
^try.PointD(1)=$lb("",1,2)
^try.PointD(2)=$lb("",3,4
```

Let's delete all the data from the table:

```sql
DELETE FROM try.Point
```

Our global will look like this:
```
zw ^try.PointD
^try.PointD=2
```

Only ID counter is left, so a new object/row would have an ID=3. Also our class and table continue to exist.

But, what happens when we run:

```sql
DROP TABLE try.Point
```

It will destroy the table, the class and delete the global:

```objectscript
zw ^try.PointD
```

