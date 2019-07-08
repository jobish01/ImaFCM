class Menu {
  bool schemeApprovals;
  bool showMemberShip;
  Menu(
      {
      this.schemeApprovals,
      this.showMemberShip,
      });

  Menu.fromJson(dynamic obj) {
    this.schemeApprovals = obj['ShowSchemes'];
    this.showMemberShip = obj['ShowMembership'];
  }
}
