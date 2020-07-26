// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

window.setAsPurchased = function (id) {
  var album = document.getElementById(`album-${id}`);
  var unpurchasedButton = album.getElementsByClassName("purchase")[0];
  album.classList.add("purchased");
  album.classList.remove("unpurchased");
  unpurchasedButton.classList.remove("clicked");
  void unpurchasedButton.offsetWidth;
  unpurchasedButton.classList.add("clicked");
  album.setAttribute("data-method", "delete");
};

window.setAsUnpurchased = function (id) {
  var album = document.getElementById(`album-${id}`);
  var purchasedButton = album.getElementsByClassName("unpurchase")[0];
  album.classList.remove("purchased");
  album.classList.add("unpurchased");
  purchasedButton.classList.remove("clicked");
  void purchasedButton.offsetWidth;
  purchasedButton.classList.add("clicked");
  album.setAttribute("data-method", "post");
};
