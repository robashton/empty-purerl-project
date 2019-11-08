module PureApp where

import Prelude
import PureSup as PureSup

import Pinto.App as App

start = App.simpleStart PureSup.startLink
