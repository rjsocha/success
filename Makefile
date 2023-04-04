REGISTRY = wyga/success
TAG = latest
PLATFORM = linux/amd64,linux/386,linux/arm64/v8,linux/arm/v6,linux/arm/v7,linux/s390x,linux/ppc64le
BUILDX = docker buildx build --provenance false --platform $(PLATFORM)
OUTPUT = --output type=image,name=$(REGISTRY):$(TAG),push=true,compression=gzip,compression-level=9,force-compression=true,oci-mediatypes=true
all:
	$(BUILDX) $(OUTPUT) --pull -f Dockerfile .
