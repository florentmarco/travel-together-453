import flatpickr from "flatpickr";

const toggleDateInputs = () => {
  console.log("entering flatpickr");
  flatpickr(".datepicker", {
    minDate: "today",
    enableTime: true,
    dateFormat: "d/m/Y"
  });
};

export { toggleDateInputs }



