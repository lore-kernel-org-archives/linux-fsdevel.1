Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B023093B5
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780726383; cv=none; b=mjUJErm41/Lcj3DsIEy7q4LoGZsxjIfoF2afHK86q2MGNlwyt56ZucnuuxFU+5Pe3W0KuIIU+yNVx0VM2cpIF4To7Vx3yjs2NgBNYdfaSzwygX/d3KApoQMWOBWXo6jnD+c0Z8EFCgTHPO7lMZewksWx98YFCbQb1YJgYOhAYso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780726383; c=relaxed/simple;
	bh=YVkMCLt5FJ+bDbSrJETzwIU6LK60EPUbwXQNXghAHuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrdxfFWfoXwbOQ7UotFmmkPGclxQqqH0OLt+EZslPD4M50ekj/rAnHvjS2RKip0YJ5/cYqeYwITh/KqKIugcEdFeaWsVjhrgUGiOfuIOAyEBbiy3UvmPRJPHbKoY4aIUIYl/EoGmiyvW5QMlIKJ5PqLO2wWAQ8GcfVAS6XTcQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3xZMcf8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3xZMcf8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b09e4cccso18949295e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 23:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780726380; x=1781331180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y22J8nzR3UW0cMYCUVJWDcFSFo/6kHGVqnn/SzRaSz8=;
        b=a3xZMcf8qDs8ViQFPPN8nYKAL1Op8FOTL/SEYz+j1qU9fOehiv6gerL8Z0EuCjr4jv
         HzRypJdpqmObxKso9mHsn0g15GTjR0XBAXyZOHh55yoB6XxDYd59DipPJSNqDxEaU/4Q
         BMZB8INnMZ8T2et5vzOaY/Ox69qyHqWVIlFmtUZvFSypmvFetmxSsORTT45UGHl3FIaS
         VGInaZScHjTqHPwDX9yC2gAVV9Ze7OQmsjKVlAHASkvxpN9gLrP4jRy2teo2R13z4Qj6
         HVDS/mFAmPPxrQVADHYbsjFn6nbs3Sb2c2X0GaCNQDspHIGHhAFhtODEvC8n631oljsK
         GarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780726380; x=1781331180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y22J8nzR3UW0cMYCUVJWDcFSFo/6kHGVqnn/SzRaSz8=;
        b=msYOrfqqt3GLFsDVmMzJAHouQD/X5KS4usVKyt/bgn3XEfBeI+MQkcoaqYD1B4S/Dj
         AnyI4c9Qh2Gt/AIONLWybvWW8PwvupDWIBv+XAbPy/Yy2ne41ny/a5GEEvU92VrCJ33R
         Yl1q0isgaptqEzbPow4q9xKyuO//7rMTaiCcSL/zWBUQ2UDZxP2eZ5a+te8HJZsFQ84e
         fpscNAFSlwU8eUavssoV88B2MtKi3Hm6dKxVt+Z+wnPneRYuTzIto1+rJfp8vuWhgBB+
         VGhos8qT6DkHp5aOv+aeD/R2pmHZwiPbQmoxOPN2cjSpQndfS9RuPTyuYXQb2CM1r5wQ
         HJFg==
X-Gm-Message-State: AOJu0YzTDVXlsuTvbvEyFQykEvDSQ44IFklicjhOiZwJQAFOMQ7BzkRb
	55Uv5xXLdf32epwTUt9g8kWHGP3KDBrzIvEynmpfoBWISmU73dHZ232y8rztqw==
X-Gm-Gg: Acq92OEhcgjSNPm45CzjWegSxyCTpw00Gmx82lYSvtl7ghA1NgjbvaXXLDCuIl8GdxN
	RIrVHw5uq8PIzJCHUJnKINyG/scwi54APUPq+7Rmh17/bqFsjD2fUaisWwndRAzYgSc0jdCAh+L
	fvAgyAOidy/PO2208ccYsmch3xhuBSu0YEgW3dr4P2zD5dbv2IaEoi/BoeawXjZkny1Y8Wx5twD
	t07ZojmeeLlbB+e2T18y80RSmyLiup2jVPmtqsywpBJIGIxKqqBASj6Hye7gy7xHjhr7b2QKanr
	4XX6SYI8cl+yssbp7KKzQ69JTZOr4FYUeZMYWb5GQ3qVIJPwSTyJZLfmF9wkOejSkss0vXEDF6A
	RUSrfxOpkEVpgYV1oK0f0MioRnUtkZmZgXwGQ700/QZALaVP3G4V/YfStxv0ejOzKrfHY1ja59b
	OgV9S/9E5At8O7FGLpwK5k8wPlnlLbZA==
X-Received: by 2002:a05:600c:c0d3:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-490c265c148mr78044605e9.33.1780726380490;
        Fri, 05 Jun 2026 23:13:00 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2eadefsm32281391f8f.11.2026.06.05.23.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 23:13:00 -0700 (PDT)
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
Subject: [PATCH 5/5] vmsplice: make sure we don't wait after writing some data
Date: Sat,  6 Jun 2026 06:10:31 +0000
Message-ID: <20260606061031.3744880-6-safinaskar@gmail.com>
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

Make sure we don't wait for space in pipe after writing some data.
This is needed for compatibility with previous version of vmsplice.
Found by LTP vmsplice01.
See comments in the code and links below for details.

Link: https://lore.kernel.org/all/20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner/
Link: https://lore.kernel.org/all/CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com/
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 77487b307..dbd0debc2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1221,6 +1221,8 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		unsigned long, vlen, unsigned int, flags)
 {
+	struct pipe_inode_info *pipe;
+
 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
 
@@ -1229,11 +1231,44 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		return -EBADF;
 
 	/* We do vfs_writev/vfs_readv, so it is okay to pass "false" here */
-	if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
+	pipe = get_pipe_info(fd_file(f), /* for_splice = */ false);
+
+	if (!pipe)
 		return -EBADF;
 
 	if (fd_file(f)->f_mode & FMODE_WRITE) {
-		ssize_t ret = vfs_writev(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+		/*
+		 * When writing to the pipe, previous implementation of vmsplice
+		 * first waited for space in the pipe to appear
+		 * (depending on whether SPLICE_F_NONBLOCK was passed),
+		 * then did unconditional non-blocking write to the pipe.
+		 *
+		 * This differs from what pwritev2 does.
+		 *
+		 * For compatibility we do the same thing previous
+		 * implementation did.
+		 *
+		 * We lock the pipe, do pipe_wait_for_space, then unlock
+		 * the pipe, and then do vfs_writev. vfs_writev internally
+		 * locks the pipe again. This may cause TOCTOU: when we
+		 * do vfs_writev, the pipe may become full again. So we
+		 * do a loop.
+		 */
+
+		bool non_block = (flags & SPLICE_F_NONBLOCK) || (fd_file(f)->f_flags & O_NONBLOCK);
+		ssize_t ret;
+
+		do {
+			pipe_lock(pipe);
+			ret = pipe_wait_for_space(pipe, non_block);
+			pipe_unlock(pipe);
+
+			if (ret < 0)
+				break;
+
+			ret = vfs_writev(fd_file(f), vec, vlen, NULL, RWF_NOWAIT);
+		} while (!non_block && ret == -EAGAIN);
+
 		if (ret > 0)
 			add_wchar(current, ret);
 		inc_syscw(current);
-- 
2.47.3

