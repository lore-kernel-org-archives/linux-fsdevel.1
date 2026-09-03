Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153C246781
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399229; cv=none; b=ZUM06hAIXTesS+t5m6aydof7AjEJ/Eon5Iu5Q2S8oEJxhgSFRyIf+HjyQf7y++OnGNuUPhcWBhgwDl8dtF8kX7GSc/qqeUl+eKSwXLFXui+rsvDdxnEulGl/gjxASAcjceqg25/XbW1SkiDSHUhq34TQuyU9/oUpLit0iyKha0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399229; c=relaxed/simple;
	bh=BSQQzVNIuupTKWHkDHInQ5UQ2OhS26ABbsbDxBswT/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pAMG08YZHy2vicsjSE1qd6L3n9QK8mmPU0a82AwNrHJVNLIEqG5TNGYUrQuStMpTUT991pPdQo0q++MWjrxbrXz18ZrroyDGxynfxiGwt5BBiduh//Ttv9owRIInjweXbLYw8utf0cOvXrpiFCNrKboXEP0h7wKdac4nDoYvBCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+u6506U; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+u6506U"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48444ec4fe2so937891f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 18:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788399226; x=1789004026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EVU2xXIwX74fn3t2r/Vw9dgcDAmgQOJ1XEy2yGBRzGw=;
        b=n+u6506UUZxMIUyB1HWGzkgal3KkYaeRENWHfRqBPMs40eQcTF+IGyg9fkP1LnvAaI
         oAhP7la/IWVzl80GaoApzFYdhYRJywaPb9yQ3RpF42xhUuHrfZwFdpCB8u70fPMbItKS
         sjAuH0u9N0K3wg9KDT5CBLQhZ98CLqWkbGY0rnYWCS5B8Q4ujzbbRfZZVQma3d2PCnnn
         Mu51sPOgYsr1/6/xkJC6R2zTghyOKqscGFn3HwDofLqhpWc3J1RcbpNrXEkL3FUzs2MG
         VW4z9ZpzVmaxXAHftpXKoukyn8Jyky9465DNAjyWm2xC3ih6rjKMN0PtypeICZtBNmYT
         PtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788399226; x=1789004026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EVU2xXIwX74fn3t2r/Vw9dgcDAmgQOJ1XEy2yGBRzGw=;
        b=tDTtszAjle55hkQT6Ayd+MBZQaymDstLPeWVFmgyu1VjJft+qF6ae0oR45X/C0JwW4
         ouLOYWIq6Sd8Jsr8836IpZ5NySs+p8khRgDoCsqtA3PCFVttO58c+QVfdBeHzPTPoBAG
         ru4Im+IGlHn2VHN+SbI/xj85lM9PxDndYfkNBviCY+TknAcz+NBQkMZb1PpSYUFCSGyX
         CO5s1bLS7CkMJBhuj17d/4s1wZXhrmafUAHMZne8ckMQ2s8UENEh69JqZM/vJFSIl4Cy
         xxcadIp7bGMVMZIu26Npr5o/XCRyn5hb0WdmGdLPFgL9pZ+umTaYGM0ufUU5K6PsJK6R
         bWnA==
X-Forwarded-Encrypted: i=1; AKwUvBx0sDcSaG1KN8Q24howQAXUg8/vCUdxVgQH24FWEyZ8hBhprSUaKvC6uYqMuD8wRQaV76av924qQYJOV9l/@vger.kernel.org
X-Gm-Message-State: AFuF++k+IxX4tfB/ZYiBN7A0ba5X3tY1PxIvDIH+jZ0wL9WbO+NXXDIC
	AfF52LG+SBrA4RMeiWQn1gWrGNB56F8miSq+MmjN2PYjoXaXYPLloLAb
X-Gm-Gg: AYBFou03+ucQa/1D70p/VPI17I7VNYZtbMg3G3PCdZhbDv7hBICIeGjUCvlUtdzoHJk
	b4f+j+58zDLPeH8fVjGsizMiD9PVPyWMzShJNgWC5gY3ezGdbkdjlkrNvWQKaR9nXOFKbgEd5k3
	WADatUCsJeeFfKyykFpHM7JS1ouEl7z9/aHhKQ2cOGB3PgvHfK0Ao2ayuGM9fDRB0AxVQdLQBc9
	iD/xIFlSJbIahMsO/CCvvw7VLh0vtvkcMtnUBXskS2B6kJL9OSRWoFGm0plzGhH8wAJWhrj0883
	5dwN+7e4+IzSIvze8ihnFpJyiCS0ZlaIjr7TiFFSAAOiVGbOn+zrYJWUAEyNPg4Wla6x45u/2H/
	ld00YKpK4Vx2KOqfdrGqkFXzVth1xJSDJjetxCL9U8h3Zp1SqfOhG3rSjhAnk/Qrauk966+2Ony
	p45IRhCEMxSEzAY9RxQJXwMBLZnVjLdnusWWy8io5rV9YwcgVZLncvefXKC2daL2PmCZl5NbLuR
	HFhmYexJOsQNOuwIk69k+nMV3hT2JAZBgrHx1Rc5zb6z+6ZyOXJ+KQfe4piIFlyDTq9ZGXvbtUI
	5w0OCdDgjG/KOA34Bdq1EEXrePs47X6B6oG+yi8KOWMrKKRhQpPc/f1kAnZX1DXEhytFims=
X-Received: by 2002:a05:6000:4813:b0:485:81b9:4e79 with SMTP id ffacd0b85a97d-48581b9523dmr1775697f8f.7.1788399225660;
        Wed, 02 Sep 2026 18:33:45 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a1c2-c401-11b2-c123-0d12-6c0f.310.pool.telefonica.de. [2a02:3100:a1c2:c401:11b2:c123:d12:6c0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea5b4sm10241187f8f.27.2026.09.02.18.33.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 02 Sep 2026 18:33:44 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Paulo Alcantara <pc@manguebit.org>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] super: make iterate_supers_type() deletion-safe
Date: Thu,  3 Sep 2026 03:33:36 +0200
Message-Id: <20260903013336.92081-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iterate_supers_type() drops sb_lock while invoking the callback and keeps
only a passive reference to the current superblock. That reference keeps
the object allocated, but does not keep its s_instances node linked.

After the callback releases s_umount, final teardown can unlink the current
s_instances node. The iterator then advances through a reinitialized node.
With the current hlist it stops without visiting the remaining superblocks.
The unlink moved from generic_shutdown_super() to kill_super_notify(), but
the cursor lifetime has been unsafe since the helper was introduced.

The CIFS DFS lookup can consequently miss a matching superblock and return
-EINVAL.

Walk the global superblock list in reverse and filter it by filesystem
type. A passive reference keeps its s_list node linked, and reverse
traversal preserves newest-first visitation. Superblocks removed from
fs_supers remain on the global list, but teardown marks them SB_DYING
before unlinking them, so the existing filter excludes them.

This broadens the scan from superblocks of one type to all superblocks.
The only in-tree caller is the CIFS DFS lookup, so the broader scan is
limited to that path.

Fixes: 43e15cdbefea ("new helper: iterate_supers_type()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Testing: x86_64 QEMU deterministic KUnit A/B using the actual CIFS lookup
callback over temporary VFS superblocks. Baseline skipped the surviving
match after teardown of the preceding nonmatch and returned -EINVAL. With
only this patch applied, the same test passed.

A real Samba DFS server and the kernel CIFS client were then run in the
same QEMU guest over loopback. Baseline and patch-only kernels both followed
the referrals and completed 20 reconnects while two workers repeatedly
mounted and unmounted independent CIFS superblocks. The patch-only run
successfully mounted, read from, and unmounted CIFS shares 95 times. Kprobes
recorded 110 DFS lookup calls and 60 iterate_supers_type() calls. There were
no unmount failures, kernel warnings, oopses, or sanitizer reports. The
natural network stress did not hit the narrow race on baseline.

Stable is requested because concurrent DFS automount teardown can make a
reconnect lookup miss a live matching superblock.

Backport note: before dc3216b14160 ("super: ensure valid info"), the
s_instances unlink is in generic_shutdown_super(). Before 3ec9800c2d33
("super: convert s_count to refcount_t s_passive"), the passive reference is
named s_count.

 fs/super.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 05e4431730387..c8accd144bad2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1026,11 +1026,18 @@ void iterate_supers_type(struct file_system_type *type,
 	struct super_block *sb, *p = NULL;
 
 	spin_lock(&sb_lock);
-	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
+	/*
+	 * The passive reference keeps the s_list cursor valid while sb_lock
+	 * is dropped. Entries are added at the tail. Walk backwards to retain
+	 * newest-first visitation.
+	 */
+	list_for_each_entry_reverse(sb, &super_blocks, s_list) {
 		bool locked;
 
 		if (super_flags(sb, SB_DYING))
 			continue;
+		if (sb->s_type != type)
+			continue;
 
 		if (!refcount_inc_not_zero(&sb->s_passive))
 			continue;
-- 
2.53.0
