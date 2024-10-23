{pkgs-unstable, ...}: {
  home.packages = [pkgs-unstable.yazi];

  programs.yazi = {
    enable = true;
    package = pkgs-unstable.yazi;
    settings.manager = {
      show_hidden = true;
      show_symlink = false;
    };
    catppuccin.enable = true;
  };

  home.file.".config/yazi/init.lua".text = ''
    function Status:name()
      local h = self._tab.current.hovered
      if not h then
        return ui.Line {}
      end

      local linked = ""
      if h.link_to ~= nil then
        linked = " -> " .. tostring(h.link_to)
      end

      return ui.Line(" " .. h.name .. linked)
    end

    Status:children_add(function()
      local h = cx.active.current.hovered
      if h == nil or ya.target_family() ~= "unix" then
        return ui.Line {}
      end

      return ui.Line {
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
        ui.Span(":"),
        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
        ui.Span(" "),
      }
    end, 500, Status.RIGHT)

    Header:children_add(function()
      if ya.target_family() ~= "unix" then
        return ui.Line {}
      end
      return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
    end, 500, Header.LEFT)
  '';
}
