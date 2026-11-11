Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379655;
	b=cOvNmWNickAGyf7QsdZ+pYcZE9TL8M2lSF0VJxqYJKGWu+zQQedArpBrRvifz95FrCWI
	 +cmd5+HD5/+2WAKOo7U3HvrrGyEbyuMjYYpCyYYMin6XK4DnM++zwLclwNx2LtduE29Oh
	 UzN+Gkc30AEOFy7GX6O2ZfLEerbYDa1V5HgUqgMnDoGvBzC5S6uUcRzKCQ3Aaa6XRn7XK
	 Loe6uoxgajHVEmdvGPPlD5n3f+LILTL7k5g1iK1dtUTXPiFEz4O1XlhnFzfAtB/SnYlxz
	 txEqnZVrgCXSEPLARIbidjYaGJwTuWgL/6GaxzCxGCaNBITYQ1jusR0doRDO5WwXIdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379655;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=T5i3Oi7BJr9v77Dog3Y0vN/1EvTrivH4ao/wIPN6ylk=;
	b=RjxLO+8eE56f+xkGeEv9ByN1NnXFW0N8jPEp7WDNnnoJTuL2d58QoucWQbVwBDYchJ7+
	 NEFOVBNz2NPD+TSyWfAmi3Y4lXl3saJoGZsKTIyIV5Fxx31SriVMhvmOKzk96rJvBfy54
	 LJpJLcj717gS0r2KteGECNhpNx5H4kg33fYOxQK5ijRmXgJ2aHUqMh/ps8snBP7cqLOwO
	 Bl1JAvhUQXHVupFTW1OAvoSSjSZ2yavOB5t7bi1Oyv47Rb4/d/5+8VOragK6lo6zoDTZc
	 Ic/8FnhK34p6qaOGLrEa3QqsZ4APVg8Ea5GkDPWKs9jxaQWbuRBqaC7UHcjNnssSjdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=TcRqFdLf;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552E960A6F66;
	Wed, 11 Nov 2026 06:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 552E960A6F66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=TcRqFdLf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=TcRqFdLfFLakPtRJOlX8uGiBNsNhYX8CioCeBJ1+7xvaI3561M/wZpF5Er4MxNnGRXWg/LG/fimTq
	 2jw/tg5fdVdeKRfzY0onxcqmrprDQD5nmAW9nMpWSNaiGiqGF4FyshOR1wL8zLJXqhm3bIib4Zfm1N
	 sPSY6EB2oAdA0dLA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af40f82198-a1dc0;
	Wed, 11 Nov 2026 14:47:32 +0800 (CST)
X-RM-TRANSID:2ee66af40f82198-a1dc0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36af40f81f56-d10f0;
	Wed, 11 Nov 2026 14:47:32 +0800 (CST)
X-RM-TRANSID:2ee36af40f81f56-d10f0
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a088f9d6bf95dc66a923@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] stat: annotate the lockless inode block count snapshot
Date: Wed, 11 Nov 2026 14:47:30 +0800
Message-ID: <20261111064731.17214-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_fillattr() reads i_blocks without inode->i_lock, while concurrent
space accounting updates it under that lock. KCSAN reports the read
racing with inode_add_bytes(), for example during a tmpfs write.

The block count returned by stat is a snapshot taken while file contents
may change. Annotate this intentional lockless read with data_race(),
without marking or weakening the locked space-accounting updates.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 fs/stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index a2e63c6c45b7..6e6f99aaa628 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -103,7 +103,8 @@ void generic_fillattr(const struct mnt_idmap *idmap, u32 request_mask,
 	}
 
 	stat->blksize = i_blocksize(inode);
-	stat->blocks = inode->i_blocks;
+	/* The block count is a snapshot and may race with space accounting. */
+	stat->blocks = data_race(inode->i_blocks);
 
 	if ((request_mask & STATX_CHANGE_COOKIE) && IS_I_VERSION(inode)) {
 		stat->result_mask |= STATX_CHANGE_COOKIE;
-- 
2.51.0


