// ============
// COUNTDOWN
// ============

// it should count down from 140 characters

// Variables
// =========

var charsMax = 140;
var charsTyped = "";
var fieldValue = "";
var fieldId = "post_id";
var divId = "counter";

// Count the characters
// ====================

function getChars() {
   fieldValue = document.getElementById(fieldId).value;
   charsTyped = fieldValue.length;
   charsLeft = charsMax - charsTyped;
   return charsLeft;
}

// +++++++++++++++
// Start
// ++++++++++++++++

$(function() {
   $('#' + divId).html('<p>Maximum: ' +  charsMax + ' characters.</p>');
   $('#' + fieldId).keypress(function() {
      $('#' + divId).html('<p>' + getChars() + '/' + charsMax + ' left.</p>');
   });
    
});



