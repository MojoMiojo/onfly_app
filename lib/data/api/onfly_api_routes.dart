class OnflyApiRoutes {
  final String identity;
  final String? pathVariables;
  OnflyApiRoutes(this.identity, {this.pathVariables});

  static get authenticate => '/collections/users/auth-with-password';
  get createOrlistExpenses => '/collections/expense_$identity/records'; 
  get updateExpense => '/collections/expense_$identity/records/$pathVariables';
}
