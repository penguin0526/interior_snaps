// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "@popperjs/core";
import "bootstrap";
import "../stylesheets/application.scss";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// 小さな画像をクリックした際の処理
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.small-image').forEach(function(img) {
        img.addEventListener('click', function() {
            var smallImagePath = img.getAttribute('src');
            var largeImage = document.getElementById('largeImage');
            largeImage.setAttribute('src', smallImagePath);

            // 大きな画像を表示する処理（例えばモーダルウィンドウなど）
            document.getElementById('largeImageContainer').style.display = 'block';
        });
    });
});;

