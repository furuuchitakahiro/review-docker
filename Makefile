# ===== Re:VIEW 設定 =====

REVIEW_VERIOSN = 2.5

# =======================


# ===== 以下編集する際は注意 =====

DOCKER_IMAGE = vvakame/review:$(REVIEW_VERIOSN)
DOCKER_WORKDIR = /tmp
DOCKER_CMD = docker run --rm -v "$$(pwd):$(DOCKER_WORKDIR)" --workdir "$(DOCKER_WORKDIR)" -it $(DOCKER_IMAGE)

# Re:VIEW のドキュメントの設定ファイル名
REVIEW_CONFIG_FILE = config.yml

# Re:VIEW のドキュメント名 ( make command の引数で上書きされる前提 )
DOC = ""

# Re:VIEW のドキュメントの書き出しフォーマット ( make command の引数で上書きされる前提 )
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

REVIEW_FILE := $(DOCKER_WORKDIR)/$(DOC)/$(DOC).re
OUTPUT_FILE_PATH := $(DOCKER_WORKDIR)/$(DOC)/$(DOC).$(OUTPUT_FMT)

install:
	docker pull $(DOCKER_IMAGE)

bash:
	$(DOCKER_CMD) bash

review-init:
	$(DOCKER_CMD) review-init $(DOC)

review-pdfmaker:
	$(DOCKER_CMD) sh -c "cd $(DOC) && review-pdfmaker $(REVIEW_CONFIG_FILE)"

review-epubmaker:
	$(DOCKER_CMD) sh -c "cd $(DOC) && review-epubmaker $(REVIEW_CONFIG_FILE)"

review-textmaker:
	$(DOCKER_CMD) sh -c "cd $(DOC) && review-textmaker $(REVIEW_CONFIG_FILE)"

review-compile:
	$(DOCKER_CMD) sh -c "cd $(DOC) && review-compile --target $(FMT) --yaml $(REVIEW_CONFIG_FILE)"
