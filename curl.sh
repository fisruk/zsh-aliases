function curlAlgoliaRecipes() {
  curl -X GET \
    -H "X-Algolia-API-Key: ${ALGOLIA_API_KEY}" \
    -H "X-Algolia-Application-Id: ${ALGOLIA_APPLICATION_ID}" \
    "https://${ALGOLIA_APPLICATION_ID}-dsn.algolia.net/1/indexes/recipes?" | jq
}

function curlSearchApiRecipesForRsel() {
  curl -X GET \
    -H "Ck-Search-Api-Key: ${SEARCH_API_TOKEN}" \
    "https://api.chefkoch.de/v2/search/recipe-for-rsel?" | jq
}

function curlSearchApiRecipes() {
  curl -X GET \
    -H "X-Chefkoch-Service-Token: ${SEARCH_API_TOKEN}" \
    "https://api.chefkoch.de/v2/recipes/list?status=99&limit=0&isPlus=1" | jq
}