Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB844780F
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789414174; cv=none; b=oa7szGfb/mHU1HpQz3iQxptp2yw9ooV8jMcLum9xHmATUr23vFP/mkVI0eDUWQUKFhcaxtyZF3xd3DyqQMSIL1uhOoqsD7G3y00u35ih338nq2KwwmBpOoHd1VAvjPoVifhO4LnBl9Lcf9FPgy0EeF3CxG4Rns/MSpiJ1rtC8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789414174; c=relaxed/simple;
	bh=7BfBo4bSrQKPySmGfB8WjDBoz0v+gox7MbGpfymR+zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvf5rb0rtPs5ppJ5dIsxS9xJnbUW6ypOXX2r3iTPt7DZ95zbhk4WuMxzjvdfrwXkYkY0mcD2/UbrSw9EuDIHs2vzWhFjfUwnPCh0b+VK3mVzaSxnocQe5qLRqDHM0Tu8EvFTbo4Gl+45+N9cBzkRmQt76Qa4Ktxacdir1IDT6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syGmAkW6; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syGmAkW6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so16022135e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789414171; x=1790018971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZxJ4bLJ7cXBKPY/voOIJSEHogHuTv+PG+lQi8LKJRVc=;
        b=syGmAkW6xxdg5UmFnnErn0Qiba7fOvpanWJPB3QgrRa9xm30n0TPWC4lTRtMEYbk0R
         uKvIPWLtrKDu3BBbc4qzOqieJEJMyRra/XGnudMZUWEN8zgqQU5MwplSlFpJHKoqCK9a
         B7c8Xe6qsgtWh4WAhYBaYW5J4LqJPwnbCiiPZoJ7auyYyCH+F6mxeDcNPDApdDE1IPDM
         vp5plOBaipUqKrNBFAvOyt1bAdl8tmi27KZ87asSlF3CEmJwoYEwS2Lmtm/Ob0nEqND9
         MeEMUYSDAz8jQnoQrhtvpAAGfLilkRkNSfvlkBBxnOmzBPhjLaQiy0b42SfslBo8Uk+T
         e6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789414171; x=1790018971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZxJ4bLJ7cXBKPY/voOIJSEHogHuTv+PG+lQi8LKJRVc=;
        b=jYPG3v7NC4LkaJplByiJw5KWY4hTpyUzb9OLooooHIfDxThTsE2xPRpZ/gZ/rRh1Bs
         /jGYggddY8LJFXO5+bdkaonpJmc/KjkXCXQXF+6UtXWcETUtuSnkHvzlLSrGnl50OZM5
         qCNko/3rCiHsF/HMBxC1SqAJ3u/mRRGNQive1aPtIC91B4ejqyDRZyqtetx7W3GoDohF
         ExC70hj02hFQlvH534OQn7hkWLXnNxgRF7t4gF8SlAo0kXeYvxDu+A8G8mQc5iSvIXqH
         mcMvBuoiNDrRmgur1Z8dR4PXtCLAp4hWKn0sMVViRii/9Pu6kFvxquGOXxa1dy3tlPMN
         SA/g==
X-Forwarded-Encrypted: i=1; AKwUvBxZ0aggPobC0Il6uNfVZjGh9AmU+yGQYR2OgqOkwKk+omDDEGXP69T8T1fOZ0Fj4mBu1GvXg1UPT0dIGKIL@vger.kernel.org
X-Gm-Message-State: AFuF++m0plbPgdZZigjfeW8yDYxyD3ei6MoV/UKGBD9UX6aJgULKgAtc
	Cft5qFh8LN7fC2Li6LN/cFLEx9haxolxgqz/pd38yJTAJ36uKHQMATtJ
X-Gm-Gg: AYBFou2ljgcRaE8vevbObYXYrzcZkpxAyHW92Rlu03gNXljZtIcQKtKjMKC5XtH+UHH
	uMQTrC9DIu7zdSX/UNnYwlqpb7/hPvC0kQLL5B2jxIf44OjdNlOBtnXgPIjlZr5fYC0/iSop7KZ
	8IhTWY00cbtCTtWC3L6X12IofGyeeqGZC2N04RPwsYFau6larZsACNCIaTt110VFdSE7+91Q3gD
	F/2ORp4e0VpMORPdAxO3CRuafDzJZ+GfFWKqNzUxd7jU/NkPp8TdMG+xV9hD7sdw1X7envxjxg/
	k9fosVhpprwgZngazfxm+DqIAzrgHFdhSdzkEyRo/y3Tq7bTBz/9qWgk2bGqDZu12DYNvU0sFhc
	Lw+0U/cbLsJeCOeRb4Bn8Nw5hQ0pz6q6YtzvsrbbxiS97kkAFjIU4x6MankLqffrJV9tJG+xhKO
	RXtpVg8wHKidzXis+vzeg5QJ4hxIyNeSu31bG19ZYglemzledCnnWF+30GmHsWw1WTU2OfYefEA
	gu9uMfKFKMw67QuCIc9uXZGacvGwwWFMD7PDQstc5jspqLUfA==
X-Received: by 2002:a05:600c:34c1:b0:49c:e3c3:5efd with SMTP id 5b1f17b1804b1-49e7a67e4d5mr105035245e9.9.1789414171099;
        Mon, 14 Sep 2026 12:29:31 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.102.196.87])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d66e77csm14496205e9.5.2026.09.14.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:29:30 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com,
	glider@google.com,
	dvyukov@google.com,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH v2] dcache: fully initialize the inline name in __d_alloc()
Date: Mon, 14 Sep 2026 20:29:26 +0100
Message-ID: <20260914192926.1591-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913152802.13413-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20260913152802.13413-1-drifabdelmalekmohamedsaid@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported:

    BUG: KMSAN: uninit-value in dentry_string_cmp fs/dcache.c:291 [inline]
    BUG: KMSAN: uninit-value in dentry_cmp fs/dcache.c:322 [inline]
    BUG: KMSAN: uninit-value in __d_lookup_rcu+0x37d/0x5e0 fs/dcache.c:2522

     dentry_string_cmp fs/dcache.c:291 [inline]
     dentry_cmp fs/dcache.c:322 [inline]
     __d_lookup_rcu+0x37d/0x5e0 fs/dcache.c:2522
     lookup_fast+0x194/0xa40 fs/namei.c:1854
     lookup_fast_for_open fs/namei.c:4545 [inline]
     open_last_lookups fs/namei.c:4579 [inline]
     path_openat+0x9ef/0x6540 fs/namei.c:4856
     do_file_open+0x2aa/0x680 fs/namei.c:4888
     do_sys_openat2+0x17c/0x390 fs/open.c:1395
     do_sys_open fs/open.c:1401 [inline]
     __do_sys_openat fs/open.c:1417 [inline]
     __se_sys_openat fs/open.c:1412 [inline]
     __x64_sys_openat+0x240/0x300 fs/open.c:1412
     x64_sys_call+0x2445/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:258
     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
     do_syscall_64+0x15d/0x3c0 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was stored to memory at:
     copy_name fs/dcache.c:3031 [inline]
     __d_move+0xd29/0x21f0 fs/dcache.c:3099
     d_move+0x71/0xf0 fs/dcache.c:3147
     vfs_rename+0x2619/0x2770 fs/namei.c:6085
     filename_renameat2+0xa59/0x1230 fs/namei.c:6188
     __do_sys_rename fs/namei.c:6232 [inline]
     __se_sys_rename+0xc5/0x5c0 fs/namei.c:6228
     __x64_sys_rename+0x78/0xb0 fs/namei.c:6228
     x64_sys_call+0x329/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:83
     do_syscall_x64 arch/x86/entry/syscall_64.c:63
     do_syscall_64+0x15d/0x3c0 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
     slab_post_alloc_hook mm/slub.c:4617 [inline]
     slab_alloc_node mm/slub.c:4939 [inline]
     kmem_cache_alloc_lru_noprof+0x376/0x1230 mm/s
     __d_alloc+0x52/0x9f0 fs/dcache.c:1902
     d_alloc+0x57/0x300 fs/dcache.c:1981
     lookup_one_qstr_excl+0x19d/0x7a0 fs/namei.c:1806
     __start_renaming+0x341/0x850 fs/namei.c:3888
     filename_renameat2+0x625/0x1230 fs/namei.c:6163
     __do_sys_rename fs/namei.c:6232 [inline]
     __se_sys_rename+0xc5/0x5c0 fs/namei.c:6228
     __x64_sys_rename+0x78/0xb0 fs/namei.c:6228
     x64_sys_call+0x329/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:83
     do_syscall_x64 arch/x86/entry/syscall_64.c:63
     do_syscall_64+0x15d/0x3c0 arch/x86/entry/syscall_64.c:94
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

The race happens between a concurrent open() and rename() of the same
path.  __d_alloc() initializes only the name itsel
of the inline buffer; the tail in between is left uninitialized.
copy_name(), called from rename(), copies the enti
including that uninitialized tail - into the moved dentry.  Meanwhile
__d_lookup_rcu(), called from open(), is an optimi
it checks d_name.hash_len first and leaves the seqcount retry to its
caller, so a lookup of the old (longer) name racin
compares with a stale length.  While copy_name() is rewriting the name
in place, the walker can transiently step past the
terminating NUL and read bytes from the uninitialized tail, which KMSAN
reports.

The race is benign by design - the read stays in bounds and the lookup
result is discarded by the seqcount retry - but th
is real.  Fix it by zeroing the entire inline buffer in __d_alloc(),
so every byte a racy walker can touch is defined;
past a mid-rewrite name now simply stops at a NUL.

Reported-by: syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ff3adde89dd795ad4c4
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
v2:
  - Screwed up by using memcpy in v1, fixed it here by using memset, only change
 fs/dcache.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da6..730571e92af8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1910,12 +1910,17 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 		return NULL;
 
 	/*
-	 * We guarantee that the inline name is always NUL-terminated.
-	 * This way the memcpy() done by the name switching in rename
-	 * will still always have a NUL at the end, even if we might
-	 * be overwriting an internal NUL character
+	 * Fully initialize the inline name buffer.  copy_name() and
+	 * swap_names() copy d_shortname in its entirety, so any
+	 * uninitialized tail would propagate to the other dentry, and
+	 * __d_lookup_rcu() may transiently read any byte of the inline
+	 * name while rename() rewrites it in place.
+	 *
+	 * This also keeps the inline name NUL-terminated: the name
+	 * switching in rename will still always have a NUL at the end,
+	 * even if we might be overwriting an internal NUL character.
 	 */
-	dentry->d_shortname.string[DNAME_INLINE_LEN-1] = 0;
+	memset(dentry->d_shortname.string, 0, DNAME_INLINE_LEN);
 	if (unlikely(!name)) {
 		name = &slash_name;
 		dname = dentry->d_shortname.string;
-- 
2.43.0

