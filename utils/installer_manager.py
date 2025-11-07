from simple_term_menu import TerminalMenu
import os
import subprocess

actual_path = os.getcwd()

file_paths ={
             "Nvim": f"{actual_path}/nvim/installers/nvim_installation.sh",
             "Nvim Plugins": f"{actual_path}/nvim/installers/nvim_plugins.sh",
             "Tmux": f"{actual_path}/tmux/installation/tmux_installation.sh",
             "Tmux Plugin": f"{actual_path}/tmux/installation/tmux_plugins.sh",
             "Vial Configuration": f"{actual_path}/split-keyboard/config_vial.sh",
            }

class TerminalMenuCustom:
    def menu(self, options: list, menu_type:str = "simple"):
        os.system("clear")
        if menu_type.upper() == "SIMPLE":
            terminal_menu = TerminalMenu(options)
            menu_entry_index = terminal_menu.show()

            return list(options)[menu_entry_index]

        raise Exception("Invalid option")

def main():
    selected_option = TerminalMenuCustom().menu(file_paths.keys())
    subprocess.run(file_paths[selected_option])

if __name__ == "__main__":
    main()

