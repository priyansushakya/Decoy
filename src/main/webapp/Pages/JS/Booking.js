function calculateCheckoutDate() {
  const checkinInput = document.getElementById("checkin").value;
  const daysInput = document.getElementById("daysStay").value;
  const checkout = document.getElementById("checkout");

  if (checkinInput && daysInput && !isNaN(daysInput) && Number(daysInput) > 0) {
    const checkinDate = new Date(checkinInput);
    const daysToAdd = parseInt(daysInput, 10);

    checkinDate.setDate(checkinDate.getDate() + daysToAdd);

    const yyyy = checkinDate.getFullYear();
    const mm = String(checkinDate.getMonth() + 1).padStart(2, '0');
    const dd = String(checkinDate.getDate()).padStart(2, '0');

    checkout.value = `${yyyy}-${mm}-${dd}`;
  } else {
    checkout.value = "";
  }
}

document.addEventListener("DOMContentLoaded", function () {
  document.getElementById("checkin").addEventListener("change", calculateCheckoutDate);
  document.getElementById("daysStay").addEventListener("input", calculateCheckoutDate);
});



document.addEventListener('click', function(event) {
  var roomPicker = document.getElementById('roomPicker');
  var roomInput = document.getElementById('roomNumber');
  
  // Check if the click is outside of the room picker and room input field
  if (!roomPicker.contains(event.target) && event.target !== roomInput) {
    roomPicker.style.display = 'none';
  }
});

function selectRoom(roomNumber) {
  const roomId = "room" + roomNumber;
  const selectedRoom = document.getElementById('roomNumber');
  const clickedRoom = document.getElementById(roomId) || document.querySelector(`li:contains("Room ${roomNumber}")`);

  if (clickedRoom && clickedRoom.classList.contains("booked")) {
    alert("This room is already booked. Please choose another one.");
    return;
  }

  selectedRoom.value = "Room " + roomNumber;

  // Remove previous 'selected' state
  const allRooms = document.querySelectorAll('.room-picker li');
  allRooms.forEach(room => room.classList.remove("selected"));

  // Mark clicked one
  if (clickedRoom) {
    clickedRoom.classList.add("selected");
  }

  document.getElementById("roomPicker").style.display = "none";
}
