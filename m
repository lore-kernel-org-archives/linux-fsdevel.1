Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF6A2F25F0
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780359981; cv=none; b=jnsZmZN9Z2HB3+0evKjabocH9D2ECVkQD5v8nvLQAECrfRQBP8YqFrXmimCMT04QutW+AKPBcTa05Z9pH39gaj0O9SBdLEXe5DskEIfkG5WcDMwfkzOKjNIl3BXbR4wY3Ewa7AgUixGtBzMtcP2uAeBEBRn+utu2jLGa6pOfoKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780359981; c=relaxed/simple;
	bh=+Noov5hc3CKOChyUBI5LBTPPkRxfbl8Xb8rJdBUuyF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=emVsEuOtQATnZwx99bZh6RH+999Hz6pSjjXt65AJtm9nBBQ/ZViXPApqlQbZfBlkPcuJu40Oqh/mBtZGkvm0BCcV89pyw10s6LC/nKn6A6aXddjDMy3xkUvCoY9D5h2QegrskwvsoBpipvmpBfG7WXHE+//rA2MKo7gRV4zzaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVrVRu2w; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVrVRu2w"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8423f52af13so1246141b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 17:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780359975; x=1780964775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LOY92BXaD5vIhUlApxku9SLm44StQ5oPQUpOHpXHWq0=;
        b=bVrVRu2wW7s0dKyGfgzv1sgQ2OndsOIGqAQwgEmiNtUTEY8YTwlNVvA85kyj/mYBKf
         H0TfjLLwWKpJltZTkoPfrblWfJZko2VoYBJvY2iKrW68WGvFQzojXve23o05KOIsj8co
         +ZxS57kO1TXsSPPNdfu1vrKWaUYGOKPLoNcE/Wtf1H0MsS9gTm3vgXl+Ex1hTCjcGiva
         VzR+6AxoFi4kzSewvp6KlF3XflwtY4+e7XMtUppEcSVRDOjhh5cR3NoyNXGS7NCkC1HY
         W+o3EMTZhKpOISSE8Bz7DPo2RY7KdYkbmUm8JLdSCbD8mm5na/5LWXKcVuZZlJm5hrqg
         mgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780359975; x=1780964775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOY92BXaD5vIhUlApxku9SLm44StQ5oPQUpOHpXHWq0=;
        b=KFEA0/ECCRIe4+7AQQ1sTVfx+szcIgIxXfPM5920yQ5NfYuNp+H/uoq0Z78ldxmT+4
         M5DYqOEP8NMvhOkVa4lbMD/hEBeN7TRSkfdI49SBd2GQM4XPVV8fmUv2bR6M/uHfrp/P
         MpxMMaHGXof/qoaqDDMSZ33Mzp6o4+UMNMMiI1W4Lqk81oeZwf51/iowO3n4STwUjMjL
         cxqK1Rv8LpM+edd+RawWR8kG0h2fUpFCCE/uPMzJdf7bR2O69qW8C5qRn9OK96Qyi53t
         8CtENVLIvFcQGeWT/rHmHomx8Wdtkls3xIh0WQ8yyLv7IrK1dQxdLG+BpwMmtW14Lcn5
         H05w==
X-Forwarded-Encrypted: i=1; AFNElJ+0MK3Gmu+eG6Pe5m2nRqljcjEuR6YXG0VbFrHx1TalfvR0qRbDzAWE/AbKA0TtzGtXgRmnKLu6+3WnfkNt@vger.kernel.org
X-Gm-Message-State: AOJu0YzVE3z4fGxsvtRfD03Br4ocj+iLU1mwQ8596ZsgjSDbbW8nbg1f
	+4hmIMMkGl7eWiaGDfF/nHpwqDl/0TsTML15lex5NSF7YUFs41cyFu9XbktSSw==
X-Gm-Gg: Acq92OHCn2++WuSesevQ0LHU/cygyy5o3faJEWKDJ1/AREfBRCNj1qPcLVmL9TcWXMP
	IUPMgtpndwxnkcAp2h18Y2ozouM0TXbCkxX2HAAvy0EcTt4hxIzKaeoK5syrKwj5PW/+U3HMZd1
	9NX1qnWp8TEIa8vLK18/dbSRN0EO6lvL6awbUSEg17co/bWV9uddn0C3KOmMOiceR3WlLCGO0Gj
	XOJHTL1P+v3UpcXfPcM7YHoOWgPPQFHmq2IF/LsUy/1ix35n9yflYNn5fpafUJF292U+qfuiJAS
	NuyN/Pp8s9wdtG07x+ezgmtsWTa88kFb2Sp6vdu7la0c+5lkCmDbaj60gBjvQ+fhC3fzwhLpvoo
	OohLuBeA4+cgIlbt/aasoGlvX9yopZPiEXynFxZVdD+FPMpuyCGMTxJ2ZXK/hRlWUMZoTQkGc7D
	754lTC5jSYhWJidYuluI2Tz/4cORQDXv5QBR3jpfiMnMVFCy2u8djfdIS1BT98kH8xztH1hH2A3
	nDUAZIHOJ2Z5Ndtqg==
X-Received: by 2002:a05:6a00:1ad0:b0:842:54e8:bdd with SMTP id d2e1a72fcca58-84254e80ed5mr5731304b3a.40.1780359975442;
        Mon, 01 Jun 2026 17:26:15 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:9be2:13da:1be0:a11a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84246844780sm5603702b3a.30.2026.06.01.17.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 17:26:14 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: mjguzik@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
Subject: [PATCH] fs/namei: fix UAF in pick_link() by unlazying before atime check
Date: Tue,  2 Jun 2026 05:56:07 +0530
Message-ID: <20260602002607.110866-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In pick_link(), atime_needs_update() is called while the path walk
may still be in RCU mode (LOOKUP_RCU set), meaning no reference is
held on the inode. A concurrent iput() from another task can free
the inode while atime_needs_update() reads inode->i_opflags (offset
+2) inside current_time() -> is_mgtime(), causing a use-after-free.

KASAN reports:
  BUG: KASAN: slab-use-after-free in is_mgtime include/linux/fs.h:2313
  Read of size 2 at addr ffff8880407e4282 (offset +2 = i_opflags)

The race:
  Task A (pick_link)             Task B (unlinkat)
  ------------------             -----------------
  atime_needs_update(inode)      iput(inode)
    current_time(inode)            evict()
      is_mgtime(inode)               destroy_inode()
        inode->i_opflags  UAF          inode FREED

Fix: call try_to_unlazy() before atime_needs_update() so that
a proper inode reference is held before any inode fields are read.
If try_to_unlazy() detects the inode is already gone, it returns
false and we exit safely with -ECHILD without touching freed memory.

Fixes: e45960c279b098ebc0c2 ("fs: unconditionally use atime_needs_update() in pick_link()")
Reported-by: syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=36e50496c8ac4bcde3f9
Tested-by: syzbot+36e50496c8ac4bcde3f9@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..eac0ec35be37 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2037,11 +2037,11 @@ static noinline const char *pick_link(struct nameidata *nd, struct path *link,
 			unlikely(link->mnt->mnt_flags & MNT_NOSYMFOLLOW))
 		return ERR_PTR(-ELOOP);
 
+	if (nd->flags & LOOKUP_RCU) {
+		if (!try_to_unlazy(nd))
+			return ERR_PTR(-ECHILD);
+	}
 	if (unlikely(atime_needs_update(&last->link, inode))) {
-		if (nd->flags & LOOKUP_RCU) {
-			if (!try_to_unlazy(nd))
-				return ERR_PTR(-ECHILD);
-		}
 		touch_atime(&last->link);
 		cond_resched();
 	}
-- 
2.43.0

