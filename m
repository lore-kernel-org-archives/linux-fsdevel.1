Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4790B55C316
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882161; cv=none; b=lo2kr2sMy1tQI/CAmMtDgBojNVJ8W10rA8QcrvDvmvz3COPKI1G/Zogwz5/w/iq4WBvYZV/nCjdFtWzDE4L9/bPW+RuLLJyb8Wym3FL0dA8MiQX2+MKpv6bPkjqEnYTW7fWxpyirt1T4Dn53J3H6VoaiukbzpR5ahbNndMvMTZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882161; c=relaxed/simple;
	bh=9cN5SOSL99rpEAu0RQYG6alc4Zm9Rs4xgcJVI1mRwys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoZc15nVrJcxHhA7TgTMDXpeQcDv/A4wRc/zwobg6mC3rtRm4eE22Vhr2cUSTCpvOwZrd/DrwwDupVic51JckA/gsQROWFUh0SI9pe0fvEvdIGv1mxdU5LhAzFktIqgy3QtRIlNqHycKo9hGIiYB1S+oDgeRpz5Dbzx5ktaJ/vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B481C1F00A3A;
	Tue,  8 Sep 2026 15:42:38 +0000 (UTC)
From: hubcap@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	devel@lists.orangefs.org,
	farhad.alemi@berkeley.edu,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org
Subject: [PATCH] orangefs: don't continue on to gpf if client dies on write.
Date: Tue,  8 Sep 2026 11:41:50 -0400
Message-ID: <20260908154152.230936-1-hubcap@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CA+0ovChOY+cRnRkfRWr5X9gcdXsz_L6BkBpXvL6=zdFBWFfUwg@mail.gmail.com>
References: <CA+0ovChOY+cRnRkfRWr5X9gcdXsz_L6BkBpXvL6=zdFBWFfUwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

I got a message from Farhad Alemi (farhad.alemi@berkeley.edu)
showing that this can happen:

Oops: general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:orangefs_writepages_callback fs/orangefs/inode.c:144 [inline]
  RIP: 0010:orangefs_writepages+0x642/0xc60 fs/orangefs/inode.c:205
  Call Trace:
   orangefs_writepages+0x642/0xc60 fs/orangefs/inode.c:205
   do_writepages+0x328/0x550 mm/page-writeback.c:2571
   filemap_write_and_wait_range+0x332/0x3f0 mm/filemap.c:685
   orangefs_flush+0x44/0x60 fs/orangefs/file.c:566
   filp_flush+0xbd/0x190 fs/open.c:1467
   filp_close+0x1d/0x40 fs/open.c:1480
   close_files fs/file.c:494 [inline]
   put_files_struct+0x1b6/0x340 fs/file.c:509
   do_exit+0x6a8/0x2360 kernel/exit.c:971

With the help of Grok I created a reproducer program that
causes a gpf on the same line: "ow->folios[ow->nfolios++] = folio;"
in orangefs_writepages_callback. The reproducer program flows into
this new code after this patch.

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index cd3273c88e03..c088a02e8215 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -181,8 +181,27 @@ static int orangefs_writepages(struct address_space *mapping,
 {
 	struct orangefs_writepages *ow;
 	struct blk_plug plug;
-	int error;
+	int error = 0;
 	struct folio *folio = NULL;
+	int maxpages;
+
+	maxpages = orangefs_bufmap_size_query() / PAGE_SIZE;
+	if (maxpages < 1) {
+		/*
+		 * Probably the client is dead and there's no bufmap.
+		 * Walk writeback_iter anyway so each dirty folio is unlocked
+		 * and writeback is ended. wait_for_direct_io will fail; the
+		 * data is not written.
+		 */
+		gossip_err("%s: maxpages < 1. \n", __func__);
+		while ((folio = writeback_iter(mapping, wbc, folio, &error))) {
+			error = orangefs_writepage_locked(folio, wbc);
+			mapping_set_error(mapping, error);
+			folio_unlock(folio);
+			folio_end_writeback(folio);
+		}
+		return error;
+	}
 
 	ow = kzalloc_obj(struct orangefs_writepages);
 	if (!ow)
-- 
2.55.0

