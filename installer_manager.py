from simple_term_menu import TerminalMenu

class TerminalMenuCustom:
    def menu(self, options: list, menu_type:str = "simple"):
        if menu_type.upper() == "SIMPLE":
            terminal_menu = TerminalMenu(options)
            menu_entry_index = terminal_menu.show()

            return options[menu_entry_index]

        raise Exception("Invalid option")

def main():
    TerminalMenuCustom().menu(["val1", "val2"], "simple")

if __name__ == "__main__":
    main()

