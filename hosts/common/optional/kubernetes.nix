{ pkgs, ... }:
{
  # Some kubernetes-related packages
  home.packages = with pkgs; [
    kubernetes-helm
    kubelogin-oidc
    kubectl
    linkerd
    step-cli
    kubeseal
    argocd
    starboard
    vcluster
    krew
  ];
}
