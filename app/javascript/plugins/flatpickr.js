import flatpickr from "flatpickr";

const toggleDateInputs = () => {
  console.log("entering flatpickr");
  flatpickr(".datepicker", {
    minDate: "today",
  });
};

export { toggleDateInputs }



