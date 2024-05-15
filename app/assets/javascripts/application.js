  document.addEventListener("DOMContentLoaded", function() {
    // Get the user type from the server-side variable or wherever it's stored
    var userType = "<%= current_user.type %>"; // Replace this with your actual code to get the user's type

    // Check if the user type is "Customer"
    if (userType === "Customer") {
      // Hide the "Create Restaurants" and "Create Category" links
      var createRestaurantLink = document.querySelector(".create-link[href='<%= new_restaurant_path %>']");
      var createCategoryLink = document.querySelector(".create-link[href='<%= new_category_path %>']");

      if (createRestaurantLink) {
        createRestaurantLink.style.display = "none";
      }

      if (createCategoryLink) {
        createCategoryLink.style.display = "none";
      }
    }
  });
