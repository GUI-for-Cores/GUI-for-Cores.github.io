import { h, defineComponent } from "vue";

export default defineComponent(
  (porps) => {
    return () =>
      h("input", {
        checked: porps.checked,
        type: "checkbox",
        style: { "pointer-events": "none" },
      });
  },
  {
    props: {
      checked: {
        type: Boolean,
        default: false,
      },
    },
  }
);
