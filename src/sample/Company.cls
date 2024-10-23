Class sample.Company Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor)
{

Property Code As %String;

Property Name As %String;

Property Description As %String;

Index CodeIdx On Code [ Unique ];

Storage Default
{
<Data name="CompanyDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Code</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>Description</Value>
</Value>
</Data>
<DataLocation>^sample.CompanyD</DataLocation>
<DefaultData>CompanyDefaultData</DefaultData>
<IdLocation>^sample.CompanyD</IdLocation>
<IndexLocation>^sample.CompanyI</IndexLocation>
<StreamLocation>^sample.CompanyS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
