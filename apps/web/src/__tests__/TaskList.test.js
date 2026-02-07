import { render, screen } from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import App from "../App";

test("adds a todo", async () => {
  render(<App />);
  const input = screen.getByPlaceholderText(/Add a Task/i);

  await userEvent.type(input, "Learn React by testing");
  await userEvent.keyboard("{Enter}");

  expect(await screen.findByText("Learn React by testing")).toBeInTheDocument();
});
