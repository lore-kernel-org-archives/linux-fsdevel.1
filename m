Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDA3F1056
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 22:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771333; cv=none; b=Qefx2UF5Gs5H8PopmpxyJ6M6yyTucQJtmDW4kD7AiqunTbJfVa2GGaGM7DoVgzJ2a5eECVlC4SSslf+BKx0eMZltxy6aHvErRFy05m8ZFZP49NtAqtwXXOjBztT+FR0anXBYkuwWjX8iA8IV5vn1DkRS4TarOb+QYaIZYKf46AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771333; c=relaxed/simple;
	bh=MDJCbyT1cZKehkQnaZ+gHgHSuZG6wMy9EnrQdAHKmyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqcHEW0BiuM6KjA7oIcCDfVxs6/qxRR6FvxV60KrQeVQrG9dXoVf6Rrs4vyJJxpaQY9tpSilTTWoJDnjboepdjeQNtXKfP/DW1e/HUNu+S/lVd/5Ur6xeFat2ZRHB7vgCmMMRs7ZU5EFnUhUX35y1eByvQw+dmmsr0rymhN9Xag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kdog0l9G; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kdog0l9G"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843cedd129so774401f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 15:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789771329; x=1790376129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QQ881rFR4Wp25hA4A3PpgsR4qeoeCRIW/99haQ5+2Ks=;
        b=Kdog0l9Gs/Xi50rhgcwgQjCLXO9AiCs5F7/EXOdT99b+GHQ4+QmfEB0i8dy5U7bt7E
         sTyYDt3i2zZTakZAKX592tGbyXiRw9PM2tlpI+rBIZl3Mr/bF8bziluEXGqLNlD6Y3Fb
         t2lWolLKr2G/PdqUpDeAiP7JJzMg9jplGbKStrNNLn1Vk/btAT+QGGuX+uj/rvEIVKcD
         gyxlgzIOvhmbdEfLmcDq86nKrR2LDbKXOZTbClOhu0QffNAcM5GmtOwS3wz1t0VUc8Ob
         LKeZq7fDjQxRsZ18qgocou8tdrnt3j61gYKQpLBt/x+P6H2/bA/Vjik4QBtpK3B7TeNm
         zU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789771329; x=1790376129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QQ881rFR4Wp25hA4A3PpgsR4qeoeCRIW/99haQ5+2Ks=;
        b=MafoojFzGMYeZ6UeC6LvLZ4aW4Ny1qFPPAunphPwyEq6K7MAVfSKaHrsX9Tw3Jic8E
         Frwx0MHO4ABqGQ7Npy8C4KzBeyD9GoR0xNOJGFozyfXgwYCuHQ/BiVrxwTYZSCLfPCSY
         RJMooajdEXwbT/zAVpHENfdcExae7Fj3hvEjgg34Clo1zI54xfIuaciIcD1F2TgALFcA
         /Hv2Mdl6u/Sy1mSfyP5sy3vGebrvMohZpbUsuDwlvqTPP/zgmh6itWXbwgGuNz1ZjTMe
         kkz5aj2IJxZF+sfWzpmTXYn1GnXDYe2SQiX5Nlh9jP9w0AzuE1A17Vd3bn80XniXIo0D
         uejw==
X-Forwarded-Encrypted: i=1; AKwUvBwce0UsKW95WqIOQ4mfI9hmpK5cTM3Lw6E3NOXRWLkfMAZ+1xaaIe6ilFxRKjvUfynrQWsi23g8YqWPnv9e@vger.kernel.org
X-Gm-Message-State: AFuF++kRsd2OKhdptaZF1Bf8vDGsOgfMyJDKEToJxVwKTsC4mdC3nMq0
	8XmD7YbvVihChbg3XemXBDVAvVvGrS0bUcv+zmlHTtWVWzGWrrmyx/7V
X-Gm-Gg: AYBFou1iYrWzgei/isyqiYRfJDIPj3/VbqpwA1n5f0T5BC3bOacxT/8p3km9xqj6LEc
	afsm0NNeuvj9HGV581v8SDnQo5/BOEiHHjOceV5fyja7OiR/r0ROKRR+AeBbxsap5i2KUdl9+eu
	7qultPTCjqGRa/q5jFRgDYbogoo9OktykCo16WiaF3f/cwNzzpZ2F3eZaLa5Vm4y4RRgUDFGShA
	7LFrWjST4k9PpvA2eOgvMt3KMpuMcM4sZYTzRSDV3ZHvF11HaNgFpEOSkpo01y2dp6Ya/nrx6VT
	9a12TEIT+7G8n2uZ3/EnuE636D1FC+kvigpl6RwyJIlvdM31LVEuqQ2n768WKRyP+V2wHVxmTJ2
	scbwxG/WKmoMFfR3AL1KBLQmjkh2xq6tEx0Vp8u7bl6gtfSNDPrvOdaWZqaWweCLgQQ6PnTVirU
	V6IgAsN/BhhQMdjLV9AOl76aiBOehIfefJmeeVvFg7OpzLsSh6WdZP0iNSGx9i8oazC009R7hPX
	IUtjGpTi9hy3Aqmlp5jedaYZ2EF4Z9T7XoAXi1xe/C4vO1oWk/K1gTklRchpg==
X-Received: by 2002:a05:6000:2304:b0:484:3200:b7a1 with SMTP id ffacd0b85a97d-4871e25d894mr9927251f8f.13.1789771329034;
        Fri, 18 Sep 2026 15:42:09 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.102.245.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872459d72esm2052930f8f.34.2026.09.18.15.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 15:42:08 -0700 (PDT)
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
Subject: [PATCH v3] dcache: unpoison the inline name buffer in __d_alloc()
Date: Fri, 18 Sep 2026 23:42:04 +0100
Message-ID: <20260918224204.3056-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914192926.1591-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20260914192926.1591-1-drifabdelmalekmohamedsaid@gmail.com>
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

The race is between a concurrent open() and rename() of the same path.

__d_alloc() only stores the name itself and its terminating NUL, so the
rest of the inline buffer (d_shortname, DNAME_INLINE_LEN bytes) is left
uninitialized.  copy_name(), called from rename(), copies that buffer as a
whole, so the uninitialized tail is propagated into the dentry that is
being moved.  Meanwhile __d_lookup_rcu(), called from open(), is an
optimistic lockless lookup: it checks d_name.hash_len first and leaves the
seqcount retry to its caller, so it can end up comparing against a dentry
whose name a rename is rewriting in place, using a stale (longer) length.
The comparison then runs past the terminating NUL and reads bytes of the
uninitialized tail, which KMSAN reports.

The read is harmless by design: it stays inside the buffer, the name is
still NUL-terminated, and the result is thrown away by the seqcount retry.
It is not specific to KMSAN either - with CONFIG_DCACHE_WORD_ACCESS
enabled the very same bytes are read by read_word_at_a_time(), which is
__no_sanitize_or_inline and therefore invisible to KMSAN.  KMSAN builds
only see the instrumented byte-at-a-time dentry_string_cmp() because
CONFIG_DCACHE_WORD_ACCESS is disabled when KMSAN is enabled on x86:

commit 7cf8f44a5a1c ("x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS")

Zeroing the inline buffer would hide the report, but it would add a
memset() to a hot allocation path just to initialize bytes that are never
used as part of a name.  Instead, tell KMSAN the inline buffer is
initialized: kmsan_unpoison_memory() compiles to nothing unless
CONFIG_KMSAN is set, and doing it at allocation time is enough for every
dentry, because copy_name() and swap_names() copy the whole buffer and
thus propagate its shadow.

Reported-by: syzbot+7ff3adde89dd795ad4c4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7ff3adde89dd795ad4c4
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>

Changes in v3:
- Annotate for KMSAN instead of zeroing, as suggested in review: the read
  is harmless, so unpoison the inline buffer in __d_alloc() with
  kmsan_unpoison_memory() (a no-op unless CONFIG_KMSAN) rather than adding
  a memset() to the dentry allocation path.
- Document why only KMSAN builds report this at all: with
  CONFIG_DCACHE_WORD_ACCESS the same read goes through
  read_word_at_a_time(), which KMSAN does not instrument.
- Rewrite the commit message; the previous one had several truncated
  lines.
---
 fs/dcache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da6..a66be85f9d01 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1916,6 +1916,10 @@ static struct dentry *__d_alloc(struct super_block *sb, const struct qstr *name)
 	 * be overwriting an internal NUL character
 	 */
 	dentry->d_shortname.string[DNAME_INLINE_LEN-1] = 0;
+
+	/* Racy __d_lookup_rcu() walk may read past the NUL; harmless */
+	kmsan_unpoison_memory(dentry->d_shortname.string, DNAME_INLINE_LEN);
+
 	if (unlikely(!name)) {
 		name = &slash_name;
 		dname = dentry->d_shortname.string;
-- 
2.43.0

