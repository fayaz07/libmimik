package platforms

import "mimik/types/core"

func GetSupportedPlatforms() []core.Platform {
	return append(androidPlatforms, iosPlatforms...)
}
