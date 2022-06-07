class EdamamApi
  def initialize(ingredient)
    @food_id = get_food_id(ingredient)
  end

  def nutrients
    response = faraday_client.post("nutrients") do |req|
      req.body = {
        "ingredients": [
          {
            "quantity": 1,
            "measureURI": "http://www.edamam.com/ontologies/edamam.owl#Measure_gram",
            "foodId": @food_id,
          },
        ],
      }.to_json
    end
    JSON.parse(response.body)
  end

  private

  def get_food_id(ingredient)
    response = faraday_client.get("parser") do |req|
      req.params["ingr"] = ingredient
    end
    data = JSON.parse(response.body)
    data.dig("parsed", 0, "food", "foodId")
  end

  def faraday_client
    Faraday.new(
      url: "https://api.edamam.com/api/food-database/v2",
      params: {
        app_id: "924c4181",
        app_key: "b3e8d0641e29ea71eabdd2a5e89991aa",

      },
      headers: { "Content-Type" => "application/json" },
    )
  end
end
