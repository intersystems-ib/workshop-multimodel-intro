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
