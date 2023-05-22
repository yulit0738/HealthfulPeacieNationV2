	const button = document.querySelector(".btn-login");
	const dialog = document.querySelector('dialog#login_dialog')

	button.addEventListener("click", function() {
		dialog.showModal();
		dialog.classList.add("open");
	});

	dialog.addEventListener("click", function(event) {
		  if (event.target === dialog) {
		    dialog.classList.add("closing");
		    setTimeout(() => {
		      dialog.close();
		      dialog.classList.remove("closing");
		    }, 290);
		  }
		});