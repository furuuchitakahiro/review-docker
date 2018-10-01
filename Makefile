DOCKER_IMAGE = vvakame/review:2.5
DOCKER_WORKDIR = /tmp
DOCKER_CMD = docker run --rm -v "$$(pwd):$(DOCKER_WORKDIR)" --workdir "$(DOCKER_WORKDIR)" -it $(DOCKER_IMAGE)

FMT = ""
ifeq ($(FMT),text)
	OUTPUT_FMT := txt
else ifeq ($(FMT),latex)
	OUTPUT_FMT := tex
else ifeq ($(FMT),idgxml)
	OUTPUT_FMT := xml
else ifeq ($(FMT),markdown)
	OUTPUT_FMT := md
else
	OUTPUT_FMT := $(FMT)
endif

REVIEW_FILE := $(DOCKER_WORKDIR)/$(PJ)/$(PJ).re
OUTPUT_FILE_PATH := $(DOCKER_WORKDIR)/$(PJ)/$(PJ).$(OUTPUT_FMT)

install:
	docker pull $(DOCKER_IMAGE)

bash:
	$(DOCKER_CMD) bash

review-init:
	$(DOCKER_CMD) review-init $(PJ)

review-compile:
	$(DOCKER_CMD) sh -c "review-compile --target $(FMT) $(REVIEW_FILE) > $(OUTPUT_FILE_PATH)"
