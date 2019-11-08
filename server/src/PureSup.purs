module PureSup where

import Effect
import Erl.Data.List
import Prelude

import Pinto as Pinto
import Pinto.Sup (startLink) as Sup
import Pinto.Sup 
import PureWeb as PureWeb
import PureConfig as PureConfig
import PureLibrary as PureLibrary

startLink :: Effect Pinto.StartLinkResult
startLink = Sup.startLink "pure_sup" init

init :: Effect SupervisorSpec
init = do
  webPort <- PureConfig.webPort
  pure $ buildSupervisor
                # supervisorStrategy OneForOne
                # supervisorChildren ( ( buildChild
                                       # childType Worker
                                       # childId "pure_web"
                                       # childStart PureWeb.startLink  { webPort } )
                                       : 
                                       ( buildChild
                                       # childType Worker
                                       # childId "pure_library"
                                       # childStart PureLibrary.startLink {} )
                                        : nil)


