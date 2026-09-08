Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2AA26158B
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834979; cv=none; b=q2BRW223DET0kwaEMRIRcCuzzifO8+jHcGNt+PTMN52UJGfvr1IsZZaEtzK4S6rPz3GXl2Hvw0BAeK/FXLagP2uVOXJrPA9YRU2h0Ox8vDuUWpoLa7QSx6DOwi7osFhH7b7YZJ/SZcS9XVnG73e3zYHdq20pMSRUG+tBa93olLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834979; c=relaxed/simple;
	bh=m6XqoUodv8NsilFjwXb7ElswNYC4z6Ylt8/xBRm4O48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XWi9BoMvGTU6IT4ktrZqXYflqEYTKs4yhRbOEImjIM3p8D0J/6robNw6V/hYLxUH2NLwQkGsJdAtEto+kaV99kqCDUteTE/Qa0ZXVwlR/AbO69Py3TWC1dw789hdCuacy5eVP3ZOl70LD5J+SNiHTAA1y/gbNFtbv1y9Hh2geb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S8r9XEGU; arc=none smtp.client-ip=95.215.58.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S8r9XEGU"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=m6XqoUodv8NsilFjwXb7ElswNYC4z6Ylt8/xBRm4O48=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788834975; v=1; x=1789439775;
 b=S8r9XEGUQ1kF5s8otbZzIOMqWDhE8NdNCsKbUfk0c88GFm02KDhiuWvzP8/IfCDn4w2QYBQ+
 gXotAnsFkoH0K9PfVmLbx7XYfzZ3OimkrtSfy1BxRdbMXHvT3rM9zm2YtLovSulacVm3Prwn/Qm
 df+Z6Und3mA1ZRiLMx3KkyIA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id cf50a8224a729a78;
	Tue, 08 Sep 2026 02:36:15 +0000
X-Mizu-Trace-ID: cf50a8224a729a78
X-Migadu-Flow: FLOW_OUT
From: Ridong Chen <ridong.chen@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org,
	Ridong Chen <ridong.chen@linux.dev>,
	Ridong Chen <chenridong@xiaomi.com>
Subject: [PATCH next] buffer: guard folio_test_dropbehind() against a NULL b_folio in __bh_submit()
Date: Tue,  8 Sep 2026 10:36:00 +0800
Message-Id: <20260908023600.788219-1-ridong.chen@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ridong Chen <chenridong@xiaomi.com>

Commit 8deae2284976 ("buffer: allow a buffer_head to point at memory
outside the page cache") made bh->b_folio optional: jbd2 submits a shadow
buffer_head whose data lives in slab (the frozen/escaped copy of a metadata
block), and such a buffer carries no folio at all - b_folio stays NULL from
alloc_buffer_head() onwards (see the comment in
jbd2_journal_write_metadata_buffer()).  That commit audited __bh_submit()
and taught bio_add_folio_nofail() and wbc_account_cgroup_owner() to check
for a NULL folio, but it missed an earlier dereference:

	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);

That test was added by commit a2c924c240e7 ("buffer: set
BIO_COMPLETE_IN_TASK for dropbehind writeback"), which predates the
NULL-b_folio semantics and so dereferenced b_folio unconditionally.  Once
b_folio may be NULL, folio_test_dropbehind() reads NULL->flags and the
kernel takes a NULL pointer dereference.

This is reached from the jbd2 commit path (bh_submit() -> __bh_submit())
whenever a shadow buffer is submitted, i.e. when a metadata block has to be
escaped or was copied out, so it is data/timing dependent rather than seen
on every commit.  When it does hit, it is deterministic and independent of
the dropbehind bit, since the flag test dereferences the folio before
examining it.

Reproduced on x86_64 with KASAN under filesystem write pressure:

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:__bh_submit+0x21b/0x9d0
  Call Trace:
   bh_submit+0x15/0x30
   jbd2_journal_commit_transaction+0x1c19/0x5ac0
   kjournald2+0x1cf/0x760

Guard the flag test with a b_folio check, matching the other folio
accesses in the same function.

Fixes: 8deae2284976 ("buffer: allow a buffer_head to point at memory outside the page cache")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
---
 fs/buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 427d8a817cd5..f46fa6413032 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1106,7 +1106,8 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
 
-	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
+	if (bh->b_folio && folio_test_dropbehind(bh->b_folio) &&
+	    op_is_write(opf))
 		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 
 	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
-- 
2.34.1

