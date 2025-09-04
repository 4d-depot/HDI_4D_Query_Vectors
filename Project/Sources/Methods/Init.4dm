//%attributes = {}

Form:C1466.trace:=False:C215
Form:C1466.threshold:=4

var $prompts:=ds:C1482.Prompts.all().toCollection()
Form:C1466.prompts:={values: $prompts.extract("Description"); index: 1}

Form:C1466.recipes:=cs:C1710.VectorManagement.new().calculateWithSelectedPrompt($prompts[1])