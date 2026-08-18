Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C42472534
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787057759; cv=none; b=OEVsWJLpIgWXOCE1JUfaXl072fPNYOrB6CExWgsbCXSUIKZiStb1I33ek78q8gYVQR/D6aU/QHni+3Nyw91+oDzUjZVFN2AydQwWYGdLQNKCCDoCdqmKfjQycG9Pe784xoK/RRjiJo1M2VsANCJVktXJDlFhDEVkbUcgWu8XIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787057759; c=relaxed/simple;
	bh=OncDvHA7fSD4sCCfJbvOmg+3sbzoB4UIo5rG4JSCl7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YifVKX4tPKT/sWBCjV4ampx0yeLCsVaPseLX6HtOKrO811Tl1ZSo8Y6iVRJp71ZOPLqMAVg48CBdJ91/A4UmZKOd9EvV29Y03qPXxq0HqF1g4/jiLuT5a/zRO6mbAiVU+muET6c7CZdOJbXm0EH5CHlV0dN3PzK4O8HYKuCL/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GR07lZYy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GR07lZYy"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso58255455e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787057755; x=1787662555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wz/tt3OEeoJ4p1KZkv+Y5zlNQ0BTeshZ8PYQprR5SJg=;
        b=GR07lZYyxX9JpDPV2SJbUonUA4TgK6eJdAT9blcwoO03UlsTCjiG/GmBSPlRU9yCu7
         hHqfTP0xJdy2SY4hlO1DCFVgnEyekz35oWluogtIdjw0Yc1FJVjzUfokZyKez64+B5fq
         V7LE8r4/4eI+Bnp2rExRKQbeJhsGr1pN5jMHP5XRLkuDg15SKryduDs6L1F3WA4uou0W
         FdOTUyDxfjo/N/tUCNMyNaINVLumutW9lBmKZCvIstIgChxWvHXzrsFwam8Cbc57rRLG
         Jx+zpUCz66/AYuA+O+JctT/qyR+dXuDCpNigXPkSNooL/k+NSnz/2YmMppB+lKIAN6yE
         +suw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787057755; x=1787662555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wz/tt3OEeoJ4p1KZkv+Y5zlNQ0BTeshZ8PYQprR5SJg=;
        b=HxFA2ohHWCSGT+piW+tTOwXNYd27NkVoHO/fcHfkyQEtPBnG8MsqJL3jmshggNDDeq
         MNGiin9u8D8RuOyk++PPNOb7aa6GOr1KSfVxx5m0Ad2MFdcrJE5aRrjoA7u90PYGRixP
         Q3WfmfjM3mRf8r09hzkjrhwMrtKM1MbGbEFLuYMonz902z8fnttakBMncooOHJGT22wd
         2m4JTDacLctJdLxqHiC+2k088VvYDODCttsquVuW4HrRfesJHxGtlgySbFTtPlyLp+Xz
         oEQ3EpD4T5Ctk1dx2MUtfrhznQtPoDdOVqdW3kEcrnzCfPpAqfPQdiARSq/wGXoiYvQu
         5qPQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0OYeOQa6DeEaB7DYyAJZGV8vmhIwGjh23nITY11PbB+lFW09R9zj1YNeN20P63u3BMZP3VW1njJGx5KI5@vger.kernel.org
X-Gm-Message-State: AOJu0YzJEpjXZE2KfdugoHqVh4l3d/Al3t/5DL/8eRTdM/0tcWfsiaA9
	Rsn3hqKivI0mAYpiy3F885GdzVRKf89gmyrCsWioUkzPVtOO0NL2Mg5IgpX/Iaqm01U=
X-Gm-Gg: AR+sD1223Rt7VFM4kER4YdcWdad6jIa71aJVzgt0m5q7mozTmYDSf2dtdh4rYfoEXj3
	JKjDbZyKCXDeIAcmtB5HrJPEdswelhwSRK5uCYuRnSRmSxeITHoHNB0NyJAmvx92/bVIWmJv0Um
	l87kZgd2yHKyTPQWeOl43cWWLszusOUIn9DBYsOyAnAIeqncV2+yF2SzpKWrg9Dct4aD/sM3Yln
	Mkk2P7cxKbm7aF0OZfMFr2nxNCe6OllRuqB9tmwYoCNKSY0mqWcZM5Fw53gJyRVdmh2G/1Oejp4
	eIDdEkGkWW+2xyQG30GG9l28J+QjfwXsz/eW5J/IUDlbg8ke7JcBvmW0jEShOuR8n/BXhO38pYa
	D/hctasVDESEKtRYnbFMLi4IYjXdR76qSvoxAPii5n06pTYSyLJpywfOTjG4L2DNj+LaRsEhexp
	2R+IwNZ38qkeELwrnkRC8OYdOAK+niaXkOUgYJqJs3W6v/
X-Received: by 2002:a05:600c:3398:b0:499:52dd:c1f0 with SMTP id 5b1f17b1804b1-499879298c4mr346231175e9.1.1787057754333;
        Tue, 18 Aug 2026 05:55:54 -0700 (PDT)
Received: from c.. ([213.165.253.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499877d5548sm277680845e9.1.2026.08.18.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 05:55:53 -0700 (PDT)
From: Narek Jilavyan <njilav@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Narek Jilavyan <njilav@gmail.com>
Subject: [PATCH] fs: refuse to drop a dentry reference d_make_persistent() never took
Date: Tue, 18 Aug 2026 12:55:49 +0000
Message-ID: <20260818125549.2315538-1-njilav@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DCACHE_PERSISTENT records that d_make_persistent() took a reference on
the dentry with dget_dlock(). d_make_discardable() announces that
precondition but does not act on it:

	spin_lock(&dentry->d_lock);
	WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT));
	dentry->d_flags &= ~DCACHE_PERSISTENT;
	dentry->d_lockref.count--;
	finish_dput(dentry);

so a caller that never made the dentry persistent still has a reference
taken from it.  finish_dput() runs dentry_kill(), so the result is not a
stale flag but a d_lockref underflow that can free a dentry another
holder still references.

The same file already enforces the invariant rather than announcing it,
in select_collect_umount():

	if (dentry->d_flags & DCACHE_PERSISTENT) {
		dentry->d_flags &= ~DCACHE_PERSISTENT;
		dentry->d_lockref.count--;
	}

All seven in-tree callers are correctly paired (fs/libfs.c, fs/devpts,
fs/autofs, fs/tracefs).  Both d_make_persistent() and
d_make_discardable() are EXPORT_SYMBOL, so the contract is module-facing
and currently unenforced.

Make the check act.  On a mismatch the failure mode becomes a leaked
pinned dentry with a warning naming the caller, instead of a freed live
one.  The early return unlocks explicitly, since finish_dput() - which
normally releases d_lock - is no longer reached on that path.

Demonstrated with a late_initcall calling d_make_discardable() on a
d_alloc_name() dentry, which by construction lacks DCACHE_PERSISTENT.
Same kernel, only fs/dcache.c differs:

	unpatched:  count before=2 after=1	(reference dropped)
	patched:    count before=2 after=2	(refcount untouched)

Both kernels emit the warning; only the patched one declines to act on
it.

Fixes: bacdf1d70bbe ("primitives for maintaining persisitency")
Signed-off-by: Narek Jilavyan <njilav@gmail.com>
---
 fs/dcache.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3e9af9de7..897a100e7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1046,7 +1046,16 @@ EXPORT_SYMBOL(dput);
 void d_make_discardable(struct dentry *dentry)
 {
 	spin_lock(&dentry->d_lock);
-	WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT));
+	/*
+	 * DCACHE_PERSISTENT records that d_make_persistent() took a reference.
+	 * If it is clear there is no such reference to return, and dropping one
+	 * anyway underflows d_lockref and frees a dentry someone else still
+	 * holds. Refuse instead, as select_collect_umount() already does.
+	 */
+	if (WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT))) {
+		spin_unlock(&dentry->d_lock);
+		return;
+	}
 	dentry->d_flags &= ~DCACHE_PERSISTENT;
 	dentry->d_lockref.count--;
 	finish_dput(dentry);
-- 
2.43.0

