add_bank_account = function(e) {
  var bankAcctNumberField = $(".acct-number");
  var bankAcctRoutingNumberField = $(".acct-routing-number");
  var bankAcctTypeField = $(".acct-type");
  var bankAcctNameField = $(".acct-name");
  var bankAcctBalancedUriField = $(".acct-balanced-uri");
  var $bankAcctForm = $(".acct-info-form");
  var bankAcctSubmitButton = $(".submit-bank-acct-info");

  bankAcctCallbackHandler = function(response) {
    console.log(response.status);
    console.log(response);

    switch (response.status) {
      case 201:
        bankAcctBalancedUriField.val(response.data.uri);
        bankAcctNumberField.val(response.data.account_number);
        bankAcctRoutingNumberField.val(null);
        $bankAcctForm.submit();
        break;
      default:
        alert("There was an error with the bank account information you supplied. Please verify that all fields are correct and try again.");
        break;
    }
  }

  if ($bankAcctForm.length > 0 && bankAcctBalancedUriField.val() == "") {
    e.preventDefault();

    var acctData = {
      name: bankAcctNameField.val(),
      routing_number: bankAcctRoutingNumberField.val(),
      account_number: bankAcctNumberField.val(),
      type: bankAcctTypeField.val()
    }
    
    console.log(acctData);
    balanced.bankAccount.create(acctData, bankAcctCallbackHandler);
  }
}

$(document).ready(function() {
  $("body").on('click', ".submit-bank-acct-info", add_bank_account);
});