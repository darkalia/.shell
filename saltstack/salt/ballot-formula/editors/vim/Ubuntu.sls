#
# Set specific stuff for Ubuntu
#

include:
  - ballot-formula.editors.vim

#configure ppa for vim 8.0:
#  pkgrepo.managed:
#    - ppa: jonathonf/vim
#    - keyserver: keyserver.ubuntu.com
#    - keyid: F06FC659
#    - require_in:
#      - pkg: install vim

add ctags package:
  pkg.installed:
    - names:
      - exuberant-ctags
      - pandoc
