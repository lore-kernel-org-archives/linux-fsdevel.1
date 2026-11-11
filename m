Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379641;
	b=DmuHpN3/7CQ05C2aRSvQSTCntdvc8kLJWY8x3G9iIhAAOHFjC2Ity5knfm8Xhrl/F2+D
	 ULMTYvEcGBdboL8B9qqciNSMHYLR7TJvjTO/RI2xKJ7lp3KcNxaZBsz+f/E14C5M/JYnm
	 URVsDpXPrKn8ZTxuAX/huyY2VBbiUYiNjb1M9raS7MTLKytzEqqMDu/P9A+lbVBZ0DEHM
	 42r80lTbvyJZGZO4YRhETUoLB4FAtGIo/oAiC/oNpKZmAMzjf2z4vCP0wE2RZVuCgBauD
	 jMAcXvUzz/beTqnnZ3tsYwHu14rGzAGkLcleEL9Q6VULeIliwY75A5Tu5Xyn7IdeuYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379641;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/3b05ApE7UziTlREebkT1yH2k0t+ooDMznf9ZVFrj2M=;
	b=FyxAa/yBgZc749Kqp2u74G979rM7PJrw6pfaPxrhVGsTJqsbMity8Cyi3JHnu2L9R2QK
	 Dp7+g8TJitEdt3BVya2YOUUtVDTIUYV8Pt9XSrnhVwJHTEpzfHB/8lSBdZT4NyqjlBMot
	 myxAJgdFyOGTVjQoSkNjI9amfV5WGrtqciZNTrVTgZ5foJMb1PElNqwwwPgUAjCpH4Mtt
	 /OZaJCkfEsk2M7q5FMUAD+6zq/JW7/2GzGcEX8ffYMh2AyUC6GM4cm/nTF+mv0K0rsYWi
	 lklpw4AX2McCLHRo5i1eYDjlGZdKGQ50YLmznKjrNGWx843vZVqNLkHdwVmkJUWLe/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=q+2Y+ix+;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0414760A2605;
	Wed, 11 Nov 2026 06:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0414760A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=q+2Y+ix+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=q+2Y+ix+wKEohMDCondptIOYO59miP3IljwZrCn08wUBp67gkT+9aBlT7sE6/FZL5Yf2EG/JOFkr6
	 P39YWmqF79ZWFJIh5oa1ZrGkwCyCs7GAe6ZthsIVcl+TB30XVZFzQIxQmerpT6toBA7LKMI6iYqeXE
	 izqnPRr5V86p6hgk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af40f745cc-d2bbd;
	Wed, 11 Nov 2026 14:47:18 +0800 (CST)
X-RM-TRANSID:2ee56af40f745cc-d2bbd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af40f75d9c-d1e6c;
	Wed, 11 Nov 2026 14:47:18 +0800 (CST)
X-RM-TRANSID:2ee46af40f75d9c-d1e6c
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c4a4cf7debda88305d2b@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] pipe: annotate lockless checks of the file count
Date: Wed, 11 Nov 2026 14:47:17 +0800
Message-ID: <20261111064717.17165-1-zhujun2@cmss.chinamobile.com>
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

pipe_lock() and pipe_unlock() inspect pipe->files without inode->i_lock,
while opening or closing a pipe changes the count under that lock. KCSAN
reports these checks racing with put_pipe_info().

Only the zero/nonzero distinction matters here: a caller's file reference
keeps the count nonzero for a regular pipe or FIFO, and an internal splice
pipe has no files. Use data_race(READ_ONCE()) to document that distinction
and take a single snapshot without changing the file-count writers.

Fixes: 6447a3cf19da ("get rid of pipe->inode")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 fs/pipe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 4fa69192e6fb..cdca0df67f90 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -87,14 +87,16 @@ static int pipe_lock_cmp_fn(const struct lockdep_map *a,
 
 void pipe_lock(struct pipe_inode_info *pipe)
 {
-	if (pipe->files)
+	/* A file reference keeps this nonzero; internal splice pipes stay zero. */
+	if (data_race(READ_ONCE(pipe->files)))
 		mutex_lock(&pipe->mutex);
 }
 EXPORT_SYMBOL(pipe_lock);
 
 void pipe_unlock(struct pipe_inode_info *pipe)
 {
-	if (pipe->files)
+	/* As in pipe_lock(), only the stable zero/nonzero distinction matters. */
+	if (data_race(READ_ONCE(pipe->files)))
 		mutex_unlock(&pipe->mutex);
 }
 EXPORT_SYMBOL(pipe_unlock);
-- 
2.51.0


