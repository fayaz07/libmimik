package main

import (
	"encoding/json"

	"mimik/core/platforms"
	"mimik/types/core"

	"google.golang.org/protobuf/proto"
)

func GetSupportedPlatformsJSON() ([]byte, error) {
	platformsRaw := platforms.GetSupportedPlatforms()
	return json.Marshal(platformsRaw)
}

func GetSupportedPlatformsProto() ([]byte, error) {
	platformsRaw := platforms.GetSupportedPlatforms()
	platformPtrs := make([]*core.Platform, len(platformsRaw))
	for i := range platformsRaw {
		platformPtrs[i] = &platformsRaw[i]
	}
	platformList := &core.PlatformList{
		Platforms: platformPtrs,
	}
	return proto.Marshal(platformList)
}
