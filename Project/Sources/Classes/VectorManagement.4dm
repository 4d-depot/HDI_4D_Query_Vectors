//****************************************************************
// Search for the recipe that best corresponds to the prompt
Function calculate($prompt : Text; $apiKey : Text; $threshold : Real) : cs:C1710.EntitySelection
	
	//If no key is found, alert the user
	If ($apiKey="")
		ALERT:C41("Please provide your OpenAI API key.")
		return {}
	End if 
	
	//If trace mode is on, start 4D's TRACE debugger
	If (Form:C1466.trace)
		TRACE:C157
	End if 
	
	// Proceed only if both prompt and API key are available
	If ($prompt#"")
		
		// Generate a vector from the custom prompt using the AIManagement class
		var $promptVector:=cs:C1710.AIManagement.new($apiKey).generateVector($prompt)
		
		// Use the Query function to find all recipes with a cosine similarity of 0.4 or higher compared to $promptVector
		var $recipeList:=ds:C1482.Recipes.query("Vector>=:1"; {vector: $promptVector; threshold: $threshold})
		
		// Return the recipes ordered by cosine similarity (most similar first)
		return $recipeList.orderByFormula(Formula:C1597(This:C1470.Vector.dotSimilarity($promptVector)); dk descending:K85:32)
		
	Else 
		// If no prompt, returns empty result
		return {}
		
	End if 
	
	
	//****************************************************************
	// Search for the recipe that best corresponds to the prompt
Function calculateWithSelectedPrompt($prompt : cs:C1710.PromptsEntity; $threshold : Real) : cs:C1710.EntitySelection
	
	//If trace mode is on, start 4D's TRACE debugger
	If (Form:C1466.trace)
		TRACE:C157
	End if 
	
	// Use the Query function to find all recipes with a cosine similarity of 0.4 or higher compared to $promptVector
	var $recipeList:=ds:C1482.Recipes.query("Vector>=:1"; {vector: $prompt.Vector; threshold: $threshold})
	
	// Return the recipes ordered by cosine similarity (most similar first)
	return $recipeList.orderByFormula(Formula:C1597(This:C1470.Vector.cosineSimilarity($prompt.Vector)); dk descending:K85:32)
	