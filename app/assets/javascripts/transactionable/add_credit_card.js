$(document).ready(function() {
  var ccNumberField = $(".cc-number");
  var ccSecurityCodeField = $(".cc-csc");
  var ccExpirationDateField = $(".cc-exp-date");
  var ccExpirationYearField = $(".cc-exp-year");
  var ccExpirationMonthField = $(".cc-exp-month");
  var ccNameField = $(".cc-name");
  var ccPostalCodeField = $(".cc-postal-code");
  var balancedUriField = $(".cc-balanced-uri");
  var submitButton = $(".submit-cc-info");
  var ccAddressFields = $(".cc-address");
  var $form = $(".cc-info-form");

  Array.prototype.clean = function(deleteValue) {
    for (var i = 0; i < this.length; i++) {
      if (this[i] == deleteValue) {         
        this.splice(i, 1);
        i--;
      }
    }
    return this;
  };

  callbackHandler = function(response) {
    console.log(response.status);
    console.log(response);
    window.resp = response;

    switch (response.status) {
      case 201:
        balancedUriField.val(response.data.uri);
        ccNumberField.val(response.data.brand + ' (' + response.data.last_four + ')');
        ccSecurityCodeField.val(null);
        submitButton.unbind('click');
        submitButton.click();
        break;
      default:
        alert("There was an error with the credit card information you supplied. Please verify that all fields are correct and try again.");
        break;
    }
  }

  function composeCCData() {
    var ccName = ccNameField.val();
    var ccNumber = ccNumberField.val();
    var ccCSC = ccSecurityCodeField.val();
    var ccZip = ccPostalCodeField.val();
    var ccAddress;
    var ccExpYear;
    var ccExpMo;

    var ccAddressVals = ccAddressFields.map(function() { return this.value.trim() });
    ccAddress = ccAddressVals.toArray().clean("").join(", ");

    if (ccExpirationDateField.length > 0) {
      ccExpMo = ccExpirationDateField.val().split("/")[0];
      ccExpYear = ccExpirationDateField.val().split("/")[1];
    } else {
      ccExpMo = ccExpirationMonthField.val();
      ccExpYear = ccExpirationYearField.val();
    }

    data = {
        card_number: ccNumber,
        expiration_month: ccExpMo,
        expiration_year: ccExpYear,
        security_code: ccCSC,
        name: ccName,
        address: ccAddress,
        postal_code: ccZip
      }

    return data;
  }

  if ($form.length > 0 && balancedUriField.val() == "") {
    submitButton.click(function(e) {
      e.preventDefault();

      var ccData = composeCCData();
      console.log(ccData);

      balanced.card.create(ccData, callbackHandler);
    });
  }

});