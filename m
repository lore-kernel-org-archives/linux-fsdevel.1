Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116195;
	b=uVbkD/i5ew3OBauOFvXhBimaCA50sgaDwmf4KGy9/M4LuuqPMG69vYwu0mGjiV+K66t/
	 1bU+0d0ekKGk+Fu5AXPCZdg0Qc1ri6dZrsc4FPa9lJrNr+1VHCKeC6feaExXBGlCj7QKi
	 u3K56iG7wy2pplBR8gxRd3YCt/JSKeOxaw/2JMvyvzzeWTDUq4aXPGp/KIrTexrgsz5bo
	 bzE1rXhyV/F1MyfhE8HvKr3uaOaYH76fPihLuXkmgBcc/FQEC++4K+Kdv3as8oWhs7aXl
	 9TSRbvZKje/VmI4BbcTFwF39NPliCUXK9R7gqNyAM/WbkHVUor1D3UAy5bNk+uTg9vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=sfFGrUaw7Fqr5/HV4cxJvsPhjYosSvwq1pdNIkXnzLs=;
	b=Zo0/lolTYihL8Essu/Y/xuQheFhg1DWUn8EThARAZdbHO3C1nPcPenvz0nHP9hb+YJ7p
	 SKVODEQXEmc70Y11fMPNqcRiQjQuLKCeuh1Q42sdhCm5DHerxKSrWu+hkwCl0tptVebYx
	 tZqYnEzmwDK8iWxi9srxSepEWixiOW6o7CNAi14l5ni6Aa+wALHM4QYU+wyDirUJBodzE
	 WiZD+IMIFPxlmzAezfKwWobEzSy1Q90y8xM9dFf6Y9lz2iDAz5vVbte4Pd1RBKBwDiANJ
	 dCcJjqirFB7Fz7W50esiokTKI5QUigK5TLAStlfMSeKsozLBBCei3sCKtQMj2C0bElQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RoDD9snv;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E45606A331
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02E45606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RoDD9snv
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e0389d6f9so22936f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795116193; x=1795720993; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfFGrUaw7Fqr5/HV4cxJvsPhjYosSvwq1pdNIkXnzLs=;
        b=RoDD9snvR81IV2Ac91gE8vBF6shjd0+G/GstOxhrAM3SU+vnUWav7pdLTYj2zpW1ae
         n0Bw5QMqboFfQibqVW5DVvHhfnDNMM1bLnZJhgAckNtr3yUmAixu7c/zjC2QiGwUCYAR
         xAzcJanpU9j1ZN4wZa04592Gm1gNrIyH7AvAVZYBFC3diNVX9v937HdIIdlsXjsNUPyj
         orOAinpXq3RWqJtvSWFbFK3EiGctAOxAgEwoS46l5q2rHBqFPTZKnqkGdZOStIyZM8uw
         peeEGD6cYufG62reehGHYWkMo8EF3PqyLkLROupBtdKbawNz6OqI6yTugB8Lh9PX0ixk
         jLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116193; x=1795720993;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sfFGrUaw7Fqr5/HV4cxJvsPhjYosSvwq1pdNIkXnzLs=;
        b=xoTusvuiLwUpbDXPDzc5gYASJjxr1lZutivqw5Ya1cOPlHLG/qtXaw3SpE4OATYVZ4
         o5IAQNOXxWopjNvZ13zeLMqWelsWneSv2jnJDj99sXdWBI6SuYebkhM/7G6lpaQA2X2p
         p9mam2oSHtmvn9FJWoXBSW6Vxm7JFeLx1dNi7FP7rfDJ1OmM+bCmJZcB5aH2kDx+LdaG
         r8rMKSvPdD/V7U7+T7wSxmF0BW8BejXYD0FSBIlyCAvaLyC9YMOeYmPrxWclqxPx/JVL
         EEIHrMpT5yMR7YZoaE96BPG2FZVy4Ub/4jEgRM13gA57B5FusE2Bi6lBoXBYA+/pr02+
         heyw==
X-Forwarded-Encrypted: i=1; AL+hErHwMjyJgINHA/Iu4onU4vyc9iN7zNf8eL5iuXWj1Z3W3lq+e0MmseQzTIneXsbJkrx0luwvSGFFC7MO4A2f@vger.kernel.org
X-Gm-Message-State: APuU4Z8T9U8cX7Pwbn4m92oaTyh7dSddY20X8d5U2i4B+9z9r3TzLCE6
	S26zdz6c22FVqi1a/z9OqiDvzQbjOC5k/UhrMvVeUoMfuFCN2zijS6Ffsu8CWCAHjSceXA65hA=
	=
X-Received: from wrpz6.prod.google.com ([2002:adf:f746:0:b0:4a6:7c3d:a12f])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:848d:b0:4a5:1cf1:b7bd
 with SMTP id 5b1f17b1804b1-4bb88810b2dmr11129215e9.16.1795116193152; Thu, 19
 Nov 2026 11:23:13 -0800 (PST)
Date: Thu, 19 Nov 2026 20:23:10 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119192311.2684978-1-dmnk@google.com>
Subject: [PATCH 1/2] fs: export may_linkat() for nfsd
From: Dominik Maier <dmnk@google.com>
To: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	dmnk+artist@google.com, Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

vfs_link() expects its callers to enforce protected hardlink policy via
may_linkat() prior to creating a hardlink. Move the declaration of
may_linkat() from fs/internal.h to include/linux/fs.h and export it with
EXPORT_SYMBOL_GPL() so modular in-kernel file servers such as NFSD can
invoke it before calling vfs_link().

This prepares for fixing missing hardlink restrictions in nfsd_link(),
which was discovered by an AI-assisted code review tool (ARTIST),
validated in QEMU without kernel modifications or error injection, and
verified with kernel builds and checkpatch.pl.

Fixes: 800179c9b8a1 ("fs: add link restrictions")
Cc: stable@vger.kernel.org
Signed-off-by: Dominik Maier <dmnk@google.com>
---
 fs/internal.h      | 1 -
 fs/namei.c         | 1 +
 include/linux/fs.h | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/internal.h b/fs/internal.h
index 3f2fbac..7c30669 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -54,7 +54,6 @@ extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, const struct path *root);
 int filename_rmdir(int dfd, struct filename *name);
 int filename_unlinkat(int dfd, struct filename *name);
-int may_linkat(const struct mnt_idmap *idmap, const struct path *link);
 int filename_renameat2(int olddfd, struct filename *oldname, int newdfd,
 		 struct filename *newname, unsigned int flags);
 int filename_mkdirat(int dfd, struct filename *name, umode_t mode);
diff --git a/fs/namei.c b/fs/namei.c
index 925aeb6..8f7c2dc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1385,6 +1385,7 @@ int may_linkat(const struct mnt_idmap *idmap, const struct path *link)
 	audit_log_path_denied(AUDIT_ANOM_LINK, "linkat");
 	return -EPERM;
 }
+EXPORT_SYMBOL_GPL(may_linkat);
 
 /**
  * may_create_in_sticky - Check whether an O_CREAT open in a sticky directory
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100..c165f27 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2740,6 +2740,7 @@ int may_delete_dentry(const struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *victim, bool isdir);
 int may_create_dentry(const struct mnt_idmap *idmap,
 		      struct inode *dir, struct dentry *child);
+int may_linkat(const struct mnt_idmap *idmap, const struct path *link);
 
 static inline bool execute_ok(struct inode *inode)
 {
-- 
2.56.1.750.gf70dc682cf-goog

