Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E212D9798;
	Wed, 18 Feb 2026 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771376847; cv=none; b=jFM/IJs5WYvnCqGfGj50U1uh6a5KJsBalR3XYzY15DZ2Th7xrxj9vz+4mhaZKNW5juP/UhxTwKAH0rXx3UQOA+VkLXuE7/9hycYUH9h3pIBKhjiQI+I1zqAEI0kd1LvbxFvTezYxGD6CdmQbimkHW5CMRfyccVt6dzn24/cMZ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771376847; c=relaxed/simple;
	bh=J7ZTZq4X/3Y2QVbeFUP412jblzsMRFo21pG26WCfQTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=of5AXqklP0GPfC2DgKZOSumYQfshhs5+a5SF2VEJd+W1GknpQdykdKqsvjCZicbJZo8NwznVMGS0Y+r1BSAd7B3/ptsjpHpFJ+CUqcI+vpo064GXg0mQlmyFtxFbrLjZpD0fOGltIAVXGzP3Emhg3DeoVs+zvCXrhN6G944Razo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Srd+C08v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Srd+C08v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4E6C19423;
	Wed, 18 Feb 2026 01:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771376847;
	bh=J7ZTZq4X/3Y2QVbeFUP412jblzsMRFo21pG26WCfQTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Srd+C08vslHfUG9Tw6b9RpfoD8kuvADMCGD9LgpLl4y8mGX/pOFAu3ZGA6SgxTvu9
	 dHVt4Dc2MEm1svIi/8k1sRp1CgiQSkxrahw3glADDWMylDGUF0t0Sbk9087myC+yyh
	 ZpTlwWDmmonBJuxCAQb4NACAKFz/aai1cxMcp7Xo7phkTV5bSigWidaaIN1qkIP/rU
	 uvJP5Fb8NhSn971Fj3HlHbH7+VUX2OB6SM/KAuRXmqa+KkZgkRMUpGo8U1zy+cTlx0
	 fuCiNbRb0IyitVwK733pAgdvf9kuDH3oA9R5D5g2cSUtrje97rDbQO4Ow/Cf0erZFK
	 kSGVPXobOtdjQ==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 3/3] fsverity: remove fsverity_verify_page()
Date: Tue, 17 Feb 2026 17:06:30 -0800
Message-ID: <20260218010630.7407-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218010630.7407-1-ebiggers@kernel.org>
References: <20260218010630.7407-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that fsverity_verify_page() has no callers, remove it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/verity/verify.c       | 4 ++--
 include/linux/fsverity.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index 31797f9b24d0..3e38749fbc82 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -431,12 +431,12 @@ EXPORT_SYMBOL_GPL(fsverity_verify_blocks);
  * verification, then bio->bi_status is set to an error status.
  *
  * This is a helper function for use by the ->readahead() method of filesystems
  * that issue bios to read data directly into the page cache.  Filesystems that
  * populate the page cache without issuing bios (e.g. non block-based
- * filesystems) must instead call fsverity_verify_page() directly on each page.
- * All filesystems must also call fsverity_verify_page() on holes.
+ * filesystems) must instead call fsverity_verify_blocks() directly.  All
+ * filesystems must also call fsverity_verify_blocks() on holes.
  */
 void fsverity_verify_bio(struct fsverity_info *vi, struct bio *bio)
 {
 	struct fsverity_verification_context ctx;
 	struct folio_iter fi;
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index fed91023bea9..6de3ddf0b148 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -280,16 +280,10 @@ static inline bool fsverity_verify_folio(struct fsverity_info *vi,
 					 struct folio *folio)
 {
 	return fsverity_verify_blocks(vi, folio, folio_size(folio), 0);
 }
 
-static inline bool fsverity_verify_page(struct fsverity_info *vi,
-					struct page *page)
-{
-	return fsverity_verify_blocks(vi, page_folio(page), PAGE_SIZE, 0);
-}
-
 /**
  * fsverity_file_open() - prepare to open a verity file
  * @inode: the inode being opened
  * @filp: the struct file being set up
  *
-- 
2.53.0

