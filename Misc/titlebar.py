import tkinter as tk

class BorderlessApp(tk.Tk):
    def __init__(self):
        super().__init__()
        self.title("Borderless App")
        self.geometry("600x400")
        self.configure(bg="lightblue")

        self.bind("<FocusIn>", self.hide_title_bar)
        self.bind("<FocusOut>", self.show_title_bar)

        label = tk.Label(self, text="Focus on this window to hide title bar", bg="lightblue", font=("Arial", 14))
        label.pack(expand=True)

    def hide_title_bar(self, event=None):
        self.overrideredirect(True)

    def show_title_bar(self, event=None):
        self.overrideredirect(False)

if __name__ == "__main__":
    app = BorderlessApp()
    app.mainloop()
