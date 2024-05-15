local t = Def.ActorFrame{};

local set;

local RDGtext = THEME:GetString("MusicWheel","CustomItemRDGText");

local t = Def.ActorFrame {
	LoadActor(THEME:GetPathG("","_shared/MusicWheel/_section inner"))..{
		SetMessageCommand=function(self, params)
			if params.Label == RDGtext then
				self:diffuse(color("#ff266d"));
			end;
		end;
	};
	LoadActor(THEME:GetPathG("","_shared/MusicWheel/_section outer"));
	LoadActor(THEME:GetPathS("","_RDC pre (loop)"))..{
		InitCommand=cmd(stop);
		SetMessageCommand=function(self, params)
			if params.Label == RDGtext then
				if params.HasFocus then
					setenv("RDGSEL",1)
					self:play();
				else
					setenv("RDGSEL",0)
					self:stop();
				end;
			end;
		end;
	};
};

t[#t+1] = Def.ActorFrame {
	Def.Sprite{
		InitCommand=cmd(halign,0;x,-140;);
		SetMessageCommand=function(self,params)
			self:visible(true);
			if params.Label == RDGtext then
				self:Load(THEME:GetPathG("","MusicWheelItem Custom OverPart/_MusicRCD (doubleres).png"))
			end;
		end;
	};
};

return t;
