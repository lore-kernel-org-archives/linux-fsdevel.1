Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC1A2F1FEA
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780726335; cv=none; b=QzdG68uBB6N/6kX8Jf6olUH++CoCQD2AR8b52rrq5hmgn+wr0wkOsPXrJjhs44luW9T24g++55C+BK74K7ad26z0UG+/TJsNHooUaTdwZc29uTd6QIjsSW/rn2yVdnGu2HBSmuo/IK6ghoajnwAECPzCEjy/NtlgUgc4hCkzQJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780726335; c=relaxed/simple;
	bh=cFehA3I9prjpPS9MpvxHw5vuJaTELUrjhx5IPWyT2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMKkPZOFPblZs84pOTwndT4W07P7UHS4pOwxZ94lIaHyYm98Mlkm/UZ9nwNMhhH2qJL4+UQwhgOtMwIxwErRWqhyB/en+w35tYKBVyCr1tdZ9JqDu7geql5cwulAsb5mdB9mP7ec1GUorC7IuUGOJrJPFfIrHMjUCettXPu3G/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQQv21UN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQQv21UN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4905529b933so26560825e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 23:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780726333; x=1781331133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
        b=jQQv21UNBBN5dIlIwwGKVgNBTYweSwG9zYIldvHz3X4vjHXFs7Cq11mcHlzjXhav3k
         k4QfhbCNYy9oOF9FRn1V5pXLvm9WR0peXOsRlnOnuxYD48rXLuq0ts+YKGohwzIion8t
         9suv7ugADQ2muBnXEWf93lBrTP8adPhGduIhWs/13fRjOxuAlXcCgtLgX4lj7oqYH5Ih
         DLAtbIZEBJCp7uEglv9Cm6U0VTIWwRjXDHypMmVm9HwpkbbJNqTC9QfklgUz/fuTBKe5
         1Tj5tYsEGrg1I+tQSiltcZI5nKx8y7JAR4cvt+MTaTNIDr2aql4tgx2nbD1UJnbbvLdh
         UYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780726333; x=1781331133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
        b=IuzUaR8CZzwAImRHv6N5n6cAstW7KdeysjIWKuNNsOW2SoWC062Nh+QPwgX10LjNfu
         wdTskTv4K30KM3/4SinBDdxgIGdEJQ03GqpotH9Fq2R0d++gvVyVHkl/4QCZHceeERR/
         cVwa8FpqRnp2xrc3Os0O5vGYACB+hbmi8sHlU0DlqA3XVJiV6Rcxr5oN7QZA1UT7nVId
         M/axxP16gaL0weo6r3BR0S7Z2CsSiNa+RdBf3F0hQV/+iUs9CHK+t9IJc8A0xoWo4q3A
         KCUmwt+8Ydyv+Ip4DGewrjaoLnQiw3VV0stAAywGpLFgdmfuRpupavgfuzmKWIuj4Ug9
         3KsA==
X-Gm-Message-State: AOJu0YwMkf9uLveudGtcNKIDLYkBilzTkVyxpIfAV8qgMNoX4Q1jrXSv
	1L4yAl7Xdh1bH7Dv66uwb2F/l10RRMclxxkOxsQZvQI2zJh1rDWM1Cv6FqgstQ==
X-Gm-Gg: Acq92OHwzKQ+IDFxifGY8bbjOTv8Cs/vRUUin8gQsmWj2uatTYscKn+4rV5QlEOxhbf
	MVmC8PlUbrarOveENBB6hE/QpsOmaccU1jT2ISHyVcMQvqSgtH3Q2EJWZDGN2s/PnttUHpMXg27
	pyBkuuuVr93k+dt87K2HRwV2wMJxPAKXuz0XLXAshxLPDE4bYuh3aHmAGGwmPbvtHn9NwK+/Jrn
	KgVP3fUyMQTnrfLLUsxE9hx5DB+tU3D0lfXa9NktAv2zMJNR0eppU9xojmkaw5TQ5I5O10cODWA
	y4aFq9V6gSvpBwxRV9RM02tjmtjltSgFsivsBXJzGKHKpcTSdko+9gzz5NvgY85wsx0qkr5OcWy
	K6gCBjSkIvwIie3uTasqg6pVt88yQzF1Zr8k6Sik7LfhEYNWJX8oAtLDredwfm8NsGh9IOSxVXP
	uJr8d+NMh2E1QLjgtk9PsCPOLDiDCbZr2ggKa3IzCb
X-Received: by 2002:a05:600c:8b0c:b0:490:ba61:7981 with SMTP id 5b1f17b1804b1-490c25c1e4amr103918225e9.23.1780726332629;
        Fri, 05 Jun 2026 23:12:12 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490c2c9ea37sm178712255e9.0.2026.06.05.23.12.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 23:12:12 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	ltp@lists.linux.it,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH 3/5] splice: turn wait_for_space flags argument into bool
Date: Sat,  6 Jun 2026 06:10:29 +0000
Message-ID: <20260606061031.3744880-4-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I want to do this, because I will move this function to fs/pipe.c.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/splice.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6ddf7dd72..707db2c2c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,7 +1239,7 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(splice_file_range);
 
-static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
+static int wait_for_space(struct pipe_inode_info *pipe, bool non_block)
 {
 	for (;;) {
 		if (unlikely(!pipe->readers)) {
@@ -1248,7 +1248,7 @@ static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 		}
 		if (!pipe_is_full(pipe))
 			return 0;
-		if (flags & SPLICE_F_NONBLOCK)
+		if (non_block)
 			return -EAGAIN;
 		if (signal_pending(current))
 			return -ERESTARTSYS;
@@ -1268,7 +1268,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 	ssize_t ret;
 
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags);
+	ret = wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
 	if (!ret)
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
-- 
2.47.3

