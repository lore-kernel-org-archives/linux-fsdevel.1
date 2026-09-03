Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5213C988D
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415748; cv=none; b=E6VydtzaV/F4ElrsV6T7bd0kGsmVjgRK5TICw1D2khwEYO1fpKFffBhsX/cdMBr8UY6ja62H6O7kA/MT/DKL1zyJ5YQ1hQYA+XNw0vvMRAFMQYd24iEytdDpadAQHU1S4FgcDzWK1qKmK9zIdqap8CQIUKTzGoSt6uBcD6A0NKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415748; c=relaxed/simple;
	bh=13NOwt05YCvYR1FRhsDAGks5KtX2KOGzQ5RGIkhtnSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aJyd3RXLNU6wX50Jb8rBYBJbgSxHOVQG3qXeN+6TTmLqhVkInKF7JzO0pcBs4XFUz0j0Ya4dAvUdpJjyyM++Nm65OzppfVL8hna5cZEekk0kQeWGbK+2lUlzMwYGdO54cG4r+r4J/PFEVSQKjnrdaxKUZbOFFZ5u9rYKqtA/eNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjxM8la8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjxM8la8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-499ae1c6471so11912585e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788415744; x=1789020544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sL5uuPI2u6y1wwAOJx74lQZI6Tu0UXUv5TUqcTMXlIs=;
        b=jjxM8la8Yv6MeH4q+vxxAyC6/5NRPyAZPcf121TLW8NezhF7eVlt+T1oJeyV0rrd00
         chVN5J6eDOGauP7t8bFNgCCKZM1YGYIhLC4m3tbyrNq2/0glUd53v6R2EftxvspqJWkM
         nqDMVu2uCAYZywj8sWRETYqOnhxhm5/DhBBOfHkl97ri98R04uJAgnAaKE6GmM880Tju
         TXVk0L9B03T8kF86K0MZY++CMXPpzIJuDtbK9FicGP0VhcH4u7ml5EB+IpDE0dSsW67e
         Ogj+e3dxz8bM159oddv5yZ/wol4IMWG3PYeCzqMlBSML37Qq1X3Yzv/3KUUSriXSfTKJ
         67TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788415744; x=1789020544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sL5uuPI2u6y1wwAOJx74lQZI6Tu0UXUv5TUqcTMXlIs=;
        b=piT5nja7avs2DZ87tf/CVdmLLU17DFZsez5Zxf96TtsW9cDK1d0zW/hVIRRzu/HhYl
         HbVBAEMSt6F/BFNqZtoPCeU0e40Jfp9EtEE9gkQBUSOOPb6ZUDcdolonflEgif7eveTa
         GHoRhP43HxBYK+As62EOATNVwcZzknvq2wBlFN2ko1Wfh/vGyChKEnwMcGMmSRRH+NyI
         7X1n28s2/NwGt2uyInkADGhZrOaleExHemx98UC9jIGCIGIL4+nqE0Hir5BWJXX+mms1
         ru6D8OYsOJr2vDGWuxlMb3Nh6ZLniC4BHlxWgBDZ3LrIR0by1jYkHeQCycaHVKOrp6cd
         J1tQ==
X-Forwarded-Encrypted: i=1; AKwUvBxu2maid8UjgZglRtNWEBHv35BMS+DwXHtQrnI4MzE99OCHa4HQwMtMYbDgp/HpG+uF+LtmoaUy5BuKgkbY@vger.kernel.org
X-Gm-Message-State: AFuF++nyRKSE95BLN//OqTNVL2Ab3QarPjMD0R5E1a1VbGyyv7JMkzVA
	lIN/tdUjZwC9+tC16osGHjcPpnDKqZL48XYtnD/sz73iIXhTxHjk21Q+
X-Gm-Gg: AYBFou2g8CovbFFBvlcvWNJ4IMQeyD7qP0Ba4xYSDzXlITs0VhKggjfDv22f5+yRho+
	kWzr4EWDvvPQJcvC4UAW2Dvu2YXRqNxAuRzuYoL1wnAhcfb0hd5yUKMqXiLUu3soxdFsmtNp3nC
	dbJTt93TXY5souS6j0jLtd5SZ/wu4gaEWaNjrSgr1TdyYUhjdZLjZlXyPHED5os8TWpPPuDsX9K
	UAeHsLFp5uvymGVqXgk6/qLVBFIWE1NRYxLe5GvXBBCV0O4a+XfS1kIgoCBLxP1UnChaZW2PHUD
	FjpHIdke7l1FvnNTE23MjlX+EyR2V3CyX7bZeOLe7GCXxGP3AlXcJ5HSVwmcUcR5A3KIpQ5la2o
	Ia9JkDNbiL8RF0CnBDt99n1lj8MBrlDZzVGkERx3TE/UT7arFtLnuJg3hy4ve1emTuP5WRsOSHO
	0hghE6gog+d+qRhPCPDhOK7Yh/QNDfv0lDMHKDlHBDUIdA0R39+Vd/ASub2P43O0ruUIJ5UOi1U
	EXXLNc3QkAijn47nxW1rdNeMHlzaAAZ9u4uRTJwUqvN+v7et5E26xt3PM7gk6zmw2dZPmReYzE6
	iMD2V1IhRnq0LMPkw9rrRGDmUbBOeVXc/pnZ5MTWeP62iPg6smtqlm7trXwoEm6MaasFT8Erx/P
	/bwOIJQ==
X-Received: by 2002:a05:600c:4715:b0:49b:9161:db26 with SMTP id 5b1f17b1804b1-49ce5843bc0mr159730355e9.14.1788415743941;
        Wed, 02 Sep 2026 23:09:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce46696e8sm72551085e9.0.2026.09.02.23.09.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 23:09:03 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Oleg Nesterov <oleg@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] super: remember whether freeze holds writer rwsems
Date: Thu,  3 Sep 2026 08:08:55 +0200
Message-Id: <20260903060855.4610-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

freeze_super() does not acquire the writer rwsems when the superblock is
read-only. thaw_super_locked() currently decides whether to release them
from the current SB_RDONLY flag. Filesystem error paths can change that
flag between freeze and thaw without s_umount serialization.

If a writable freeze is followed by a forced read-only transition, thaw
reports success but skips ->unfreeze_fs() and sb_freeze_unlock(). The
superblock is marked unfrozen while all writer rwsems remain write-locked.
Conversely, if a filesystem is read-only when frozen and SB_RDONLY is
cleared before thaw, thaw can release rwsems that were never acquired.

Record whether a successful freeze acquired the writer rwsems and use that
state during thaw instead of re-sampling SB_RDONLY.

Fixes: 8129ed29644b ("change sb_writers to use percpu_rw_semaphore")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested with a test-only KUnit case in x86_64 QEMU on linux-next
32b6ef9a5d0e (next-20260902). It freezes a writable ramfs, sets SB_RDONLY,
thaws it, and calls sb_start_write_trylock(). The call fails without this
patch and succeeds with it.

Backport note: before e0b62a4dee24 ("fs: add fs/super_types.h header"),
struct sb_writers is in include/linux/fs.h.

 fs/super.c                     | 4 +++-
 include/linux/fs/super_types.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 9d40252135212..e8d75cef74677 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2329,6 +2329,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
 	 */
 	WARN_ON_ONCE(freeze_inc(sb, who) > 1);
 	sb->s_writers.freeze_owner = freeze_owner;
+	sb->s_writers.freeze_rwsems_locked = true;
 	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
 	wake_up_var(&sb->s_writers.frozen);
 	lockdep_sb_freeze_release(sb);
@@ -2364,7 +2365,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 		goto out_unlock;
 	}
 
-	if (sb_rdonly(sb)) {
+	if (!sb->s_writers.freeze_rwsems_locked) {
 		sb->s_writers.frozen = SB_UNFROZEN;
 		sb->s_writers.freeze_owner = NULL;
 		wake_up_var(&sb->s_writers.frozen);
@@ -2387,6 +2388,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 	sb->s_writers.freeze_owner = NULL;
 	wake_up_var(&sb->s_writers.frozen);
 	sb_freeze_unlock(sb, SB_FREEZE_FS);
+	sb->s_writers.freeze_rwsems_locked = false;
 out_deactivate:
 	deactivate_locked_super(sb);
 	return 0;
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ecd96aeb1cee7..3e15efab65329 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -53,6 +53,7 @@ enum {
 
 struct sb_writers {
 	unsigned short			frozen;		/* Is sb frozen? */
+	bool				freeze_rwsems_locked; /* Freeze holds writer rwsems */
 	int				freeze_kcount;	/* How many kernel freeze requests? */
 	int				freeze_ucount;	/* How many userspace freeze requests? */
 	const void			*freeze_owner;	/* Owner of the freeze */
-- 
2.53.0
