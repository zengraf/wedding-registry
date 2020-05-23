RED='\033[1;31m'
BLUE='\033[1;34m'
BOLD='\033[1m'
NC='\033[0m'

print_command() {
    echo "\n\n${BLUE}*** Running '$1' ***${NC}\n\n"
}

print_command_failed() {
    echo "\n\n${RED}*** Command '$1' failed ***${NC}"
}

print_command 'bundle install'
bundle install || { print_command_failed 'bundle install'; exit 1; }
print_command 'yarn install --check-files'
yarn install --check-files || { print_command_failed 'yarn install --check-files'; exit 1; }
print_command 'rails db:migrate'
rails db:migrate || { print_command_failed 'rails db:migrate'; exit 1; }
print_command 'rails db:fixtures:load'
rails db:fixtures:load || { print_command_failed 'rails db:fixtures:load'; exit 1; }

echo "\n\n* That's it!\n* ${BOLD}bin/rails t${NC} - run tests\n* ${BOLD}bin/rails s${NC} - start server in development mode"
echo "\n* Login credentials:"
echo "\n* user:\n* email: ${BOLD}pawabarta@gmail.com${NC}\n* password: ${BOLD}bartoszKool1357${NC}"
echo "\n* admin:\n* email: ${BOLD}d.nowak228@gmail.com${NC}\n* password: ${BOLD}qwertyasdf1234${NC}"