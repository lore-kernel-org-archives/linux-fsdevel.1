Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235692D94BA;
	Wed, 18 Feb 2026 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771376847; cv=none; b=WsDHNTvMQJdakaHvQag7FVXi50nAtcoP+EvXWDMJz4pw/XKDnlnlsfrJppEjuzzyZQwwE+azrzTIEMLWOosMPZcyp5ZjA7UQWuKTksyVq9M1EKZMxtfxJwUXEIi9eg6D9qAMlC1HizlkA0jfJmh7317IPbfnW878n2EBsRXtjFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771376847; c=relaxed/simple;
	bh=O3dLk96HCqOP4bm+/UDISNUGuTY/kvHS6P5aQSKjx4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5Bpw9CYR+VMEJP9DLQ5c3LHUyGx8oKbda7LrBqzaAwSnCJNQiPlZ5z8fYF/3201fWP3i8oHi7OwlCrZDsfjS1+/mF391lRkgxaVfaOHNuzo3RNlchxUkOxSoZqpzrT2qd/AmwHj0y1bPyURncRwJXsw1LXHvjCnppkhXnPH6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pooA/22O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pooA/22O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CB0C4CEF7;
	Wed, 18 Feb 2026 01:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771376846;
	bh=O3dLk96HCqOP4bm+/UDISNUGuTY/kvHS6P5aQSKjx4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pooA/22OZ652zP3398OFf3SBzvc/c/IZCczNVV1m4nv627hVgkyiDDvAaTmCOKuWG
	 ooYfTy/B/24rpuWhNynwE3Sxs6nGdQ+qTmBF3+ASssVhKdRdefv+7PxD7LEGJFtaiY
	 Ozx/3UeBCS4X34viDZ+/UFhzfqM86A7G3+C/ZAbDEfnPeAWFaBMkV9qRCYglR2R+ZO
	 LXjtGH4r5rF/V1sBhEjGVHns02OyqLYQsEKpbYGKC3JAwBmtfzILt/vycSEHKtcTJX
	 kiYqM34iVvgeWR92JjYpmPtKh9/oT+vldkSqmKP1rJfGfKpZeHCJ5qvid5Bzk1hx5p
	 23a9yF38TKO2A==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v4 2/3] f2fs: make f2fs_verify_cluster() partially large-folio-aware
Date: Tue, 17 Feb 2026 17:06:29 -0800
Message-ID: <20260218010630.7407-3-ebiggers@kernel.org>
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

f2fs_verify_cluster() is the only remaining caller of the
non-large-folio-aware function fsverity_verify_page().   To unblock the
removal of that function, change f2fs_verify_cluster() to verify the
entire folio of each page and mark it up-to-date.

Note that this doesn't actually make f2fs_verify_cluster()
large-folio-aware, as it is still passed an array of pages.  Currently,
it's never called with large folios.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 fs/f2fs/compress.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 355762d11e25..8c76400ba631 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1811,17 +1811,18 @@ static void f2fs_verify_cluster(struct work_struct *work)
 	int i;
 
 	/* Verify, update, and unlock the decompressed pages. */
 	for (i = 0; i < dic->cluster_size; i++) {
 		struct page *rpage = dic->rpages[i];
+		struct folio *rfolio;
 
 		if (!rpage)
 			continue;
-
-		if (fsverity_verify_page(dic->vi, rpage))
-			SetPageUptodate(rpage);
-		unlock_page(rpage);
+		rfolio = page_folio(rpage);
+		if (fsverity_verify_folio(dic->vi, rfolio))
+			folio_mark_uptodate(rfolio);
+		folio_unlock(rfolio);
 	}
 
 	f2fs_put_dic(dic, true);
 }
 
-- 
2.53.0

