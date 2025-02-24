// Smooth scroll for navigation links
$(document).ready(function(){
  $("a[href^='#']").on("click", function(e){
    e.preventDefault();

    var target = this.hash;
    $('html, body').animate({
      scrollTop: $(target).offset().top
    }, 800);
  });

  // Form submission (basic validation)
  $("#contact-form").on("submit", function(e){
    e.preventDefault();
    const name = $("#name").val();
    const email = $("#email").val();
    const message = $("#message").val();

    if(name && email && message) {
      alert("Thank you for reaching out! We will get back to you shortly.");
      // You can also send the form data to a server via AJAX or other methods here.
    } else {
      alert("Please fill in all fields.");
    }
  });
});

// JavaScript to toggle the navigation links when the hamburger is clicked
document.getElementById("hamburger").addEventListener("click", function() {
  const navLinks = document.querySelector(".nav-links");
  navLinks.classList.toggle("active");
});

// Countdown Timer
function countdownTimer() {
  const saleStartDate = new Date("March 1, 2025 00:00:00").getTime();
  const saleEndDate = new Date("March 31, 2025 23:59:59").getTime();
  
  let x = setInterval(function() {
    let now = new Date().getTime();
    let distance = saleStartDate - now;

    // Calculate time left
    let days = Math.floor(distance / (1000 * 60 * 60 * 24));
    let hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    let minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
    let seconds = Math.floor((distance % (1000 * 60)) / 1000);

    // Display the result
    document.getElementById("countdown").innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";

    // If the countdown is over, display a message
    if (distance < 0) {
      clearInterval(x);
      document.getElementById("countdown").innerHTML = "Sale Started!";
    }
  }, 1000);
}

countdownTimer();
