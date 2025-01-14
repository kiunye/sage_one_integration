// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import { createConsumer } from "@rails/actioncable";

const consumer = createConsumer();
const subscription = consumer.subscriptions.create("FileUpdatesChannel", {
  received(data) {
    console.log("Received update:", data);
  },
});