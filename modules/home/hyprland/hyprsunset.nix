{...}: {
  services.hyprsunset = {
    enable = true;

    settings = {
      max-gamma = 150;

      profile = [
        # Morning/daytime: normal colors
        {
          time = "07:00";
          identity = true;
        }

        # Evening: mildly warm
        {
          time = "19:00";
          temperature = 4500;
        }

        # Night: properly warm
        {
          time = "21:30";
          temperature = 3500;
          gamma = 0.9;
        }

        # Late night: very warm + slightly dimmer
        {
          time = "23:30";
          temperature = 3000;
          gamma = 0.8;
        }
      ];
    };
  };
}
