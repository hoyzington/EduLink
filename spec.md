# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project  <!-- '>= 6.0.3.1' -->
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)  <!-- Teacher has_many Klasses -->
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)  <!-- QuizGrade belongs_to StudentStatus -->
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)  <!-- Teacher has_many StudentStatuses through Klasses, Teacher has_many Homeworks through Klasses -->
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)  <!-- Klass has_many Students through Homeworks, Student has_many Klasses through Homeworks -->
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)  <!-- homework.done -->
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)  <!-- Teacher, Klass, StudentStatus, Student, Homework -->
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)  <!-- StudentStatus.non_edulink_students, /classes/:id/non_edulink_students -->
- [x] Include signup  <!-- students/new.html.erb -->
- [x] Include login  <!-- sessions/new.html.erb -->
- [x] Include logout  <!-- In layouts/_navbar.html.erb -->
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)  <!-- Facebook OAuth -->
- [x] Include nested resource show or index (URL e.g. users/2/recipes)  <!-- teachers/:id/classes (plus others) -->
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)  <!-- teachers/:id/classes/new (many others) -->
- [x] Include form display of validation errors (form URL e.g. /recipes/new)  <!-- layouts/_errors.html.erb -->

Confirm:
- [x] The application is pretty DRY  <!-- Lots of private and instance methods -->
- [x] Limited logic in controllers  <!-- Lots of private and instance methods -->
- [x] Views use helper methods if appropriate  <!-- 29 of them -->
- [x] Views use partials if appropriate  <!-- 15 of them -->