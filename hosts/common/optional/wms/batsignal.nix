{ config, ... }:
{
  services.batsignal.enable = config.laptop.enable;
}
