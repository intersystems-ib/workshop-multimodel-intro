Class game.Player Extends %Persistent [ DdlAllowed ]
{

Property Name As %String(MAXLEN = 255);

Property Alias As %String(MAXLEN = 50);

Property Score As %Numeric;

Storage Default
{
<Data name="PlayerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Alias</Value>
</Value>
<Value name="4">
<Value>Score</Value>
</Value>
</Data>
<DataLocation>^game.PlayerD</DataLocation>
<DefaultData>PlayerDefaultData</DefaultData>
<IdLocation>^game.PlayerD</IdLocation>
<IndexLocation>^game.PlayerI</IndexLocation>
<StreamLocation>^game.PlayerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
