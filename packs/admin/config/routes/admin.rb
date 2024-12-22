# TODO: Admin auth
mount Avo::Engine, at: Avo.configuration.root_path
mount Flipper::UI.app(Flipper) => "/flipper"
mount MissionControl::Jobs::Engine, at: "/jobs"
