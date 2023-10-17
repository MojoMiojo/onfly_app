class OnflyApiRoutes {
  final String login;

  OnflyApiRoutes(this.login);

  static get authenticate => '/collections/users/auth-with-password';
  get listExpenses => '/collections/expense_$login/records';
}
