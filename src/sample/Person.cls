Class sample.Person Extends (%Persistent, %XML.Adaptor, %JSON.Adaptor)
{

/// Name
Property Name As %String;

/// Last name
Property LastName As %String(%JSONFIELDNAME = "last");

/// Birth date
Property BirthDate As %Date;

/// Sex
Property AdministrativeSex As %String(VALUELIST = ",M,F");

/// Address
Property Company As Company(%JSONREFERENCE = "ID");

ForeignKey FKCompany(Company) References Company();

/// Sample method that exports as JSON and XML an object
/// call it using: do ##class(sample.Person).RunSample()
ClassMethod RunSample()
{
    // company
    set company = ##class(sample.Company).CodeIdxOpen("ACME")
    if '$isobject(company) {
        set company = ##class(sample.Company).%New()
        set company.Code = "ACME"
        set company.Name = "A.C.M.E. Corp."
        set company.Description = "A cool company called ACME"
    }
    
    // create new object
    set person = ##class(sample.Person).%New()
    
    // set object properties
    set person.Name = "Joe"
    set person.LastName = "Burrow"
    set person.BirthDate = $zdateh("1996-12-10", 3)
    set person.Company = company

    // save object
    do person.%Save()

    // export object to JSON
    do person.%JSONExportToString(.jsonString)
    write !,"JSON: "
    write !,jsonString

    // export object to XML
    set writer=##class(%XML.Writer).%New()
    set sc=writer.OutputToString()
    do writer.RootObject(person)
    
    set xmlString = writer.GetXMLString()
    write !,"XML: "
    write !,xmlString
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>LastName</Value>
</Value>
<Value name="4">
<Value>BirthDate</Value>
</Value>
<Value name="5">
<Value>AdministrativeSex</Value>
</Value>
<Value name="6">
<Value>Address</Value>
</Value>
<Value name="7">
<Value>Company</Value>
</Value>
</Data>
<DataLocation>^sample.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^sample.PersonD</IdLocation>
<IndexLocation>^sample.PersonI</IndexLocation>
<StreamLocation>^sample.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
