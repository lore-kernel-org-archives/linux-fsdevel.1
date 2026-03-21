Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C4175A76
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774074264; cv=none; b=PYTasZGLNntzutPwtUxX3ivbmRavTg1XjXHsE6b9QYqTMgerupnsQdl4T9Slj2sFO/5g++auyh46+tn3rxCJ7KgfMbIwcIsic/eB0ZFNNSMh0s1s9BoD61r46wX5iiYozHgjscYC+1CD2V7Sg4JGArMZM2c1VZ03ePg/rabC5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774074264; c=relaxed/simple;
	bh=nTO2Gx3WmvdiBOjCFsXe13z/HKMaS7yzJD5EwSY0wSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JlrSxsKl7ZdQ1GltLN9kzn2XA04VOmtvBLPXTt+iYAnHHiBFnObfyBQTHi+d0SjiGjwJy7F0jgZqlSdXDlC8cak6lyx0UcpX+xneW//swwZYJMC3xpZmvvN4LfwmR4E0kLvVVY3a+SrFZysu23LzDAnjg0SX+hfbfi9Dx3e/jFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoofpU0Z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoofpU0Z"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82be8702db6so513236b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 23:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774074261; x=1774679061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OaQRGRXsvJkENa/hzfE98pz3839YGIUuM6KjI5vU0xQ=;
        b=RoofpU0ZHoTqd5WCgDFNPsLF53p7H6PlKtbfTRwwmmF8t6qwwpIEmZPg2Ye67c7CX1
         wiqdd7miwhhYtVGSM5J9fw2oDiZtCEsSvYE8u/FCRfMmiY9xv5t5CU4zod1y7z8qT9U2
         062olCAErMCj69E5aKQJBk0pg2McS2UYmk1dXn+ATzQe5l1mJAG14dcA6l0tF9hR0WfP
         GqieCNuK7HWPxiX+WxxSDvrA9CXeyIkob5KfwhWwp5upYlbe4yrXvyRJl0GW5Yb6o06k
         yAr4suSPh1TfnvM7NtfBxLn5vBGgRIdUOWJanejEd7Z7QdP3FlLH32rXR5rB0daqSOKd
         I3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774074261; x=1774679061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaQRGRXsvJkENa/hzfE98pz3839YGIUuM6KjI5vU0xQ=;
        b=fo9ETMK0o/GlfeF/Ww2sIZACppmz0xEW2yWd/v/DRVp0Tole6DDQFWWvA9mBZZ1ocE
         Ndx4PgGEixb9r+RbtGhEBls7SPTyvoTHo2xDhnTF/RX37A7HQhCRG2hx71xqUFY9Cmek
         vVmEA6UWXkohhgBuWzXmFaMjRIBcmnX+BUG2xLhzZHmYXBa2cnzk7pIQg+m3ciO27U2f
         w4UQ0qger7BbpIOkDO4p2COt6J/QgyDMZp0n/8BhYt4ZG8Qq2SKWArDv5fZhVvL1ujiG
         EwC9VyK28mOOXM+51efnB+YfDnQq5Gb2uQXu0zRAHlT0x/MLcTOK8YJowS0stvIaWx+O
         TTJA==
X-Forwarded-Encrypted: i=1; AJvYcCXlbAKWVFggakMV4UxO2BqxWdqkm5T4roJmEw8fjQ8/6wxtgN2gISFTxjsnQaN8stf3X1PPQ5Y45Rjp4zIk@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaRENHodoXV8CwaAjup5eNFi/eSFGU6wLNx5NlcMX3YRnNJdT
	mspzhTG6qk7R6SuWqpO78qFslymUahmS9j4xz0gb/L4dlr9IboemcgsShDxLOw==
X-Gm-Gg: ATEYQzwgGM9QunlT/nvVPYUOgk3FyezqOT87igU9TPbREqfbr+WmVvSdC6flTQkFJ7p
	nHZGQT7i6xnZIRSMyZuPmXUQVvF5lRkAyD3vryCe/MWFzIChwBJRxwT9qWySVsyDTgEXVB+Yfej
	Yy/gCrA2m7bvoi9sZZuCZN/1Oa7yyPDp8ll3Bmxtgabj6Cd+UYPLYBfC+cuxp1nSxe7Dj6KWzFk
	vO5LKticUdB1vRmmCIUpxzojpUugpUukwW+EGwF3LatCAVROmGJj5qDw1ij+lkfIbWhw1TgUNbq
	wwESE7GCxA1O4k1sCm6htsA6mAOAoQcob00jheNaSwrvptfI31eLRxf1px2ZWrVPad9Dou2CVwq
	J/mdZekDD5hf4LaBPHES+Rxn6Dufh3CljIDLFOzmbQMUZ5PIvGRFG7A1Jswtf0aX79zBpAZAKT9
	4pQqTml6Y7wK+n5akYXU3NpJyCiPL/K8Upp/edMQho7m2bTmL1YGBRulJqsgpzjBKfo1Vkmk5tC
	CLPLKKaB1qQXPi3Qw==
X-Received: by 2002:a05:6a00:9510:b0:82a:609f:d49c with SMTP id d2e1a72fcca58-82a8c35de95mr4326831b3a.47.1774074260765;
        Fri, 20 Mar 2026 23:24:20 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:5c27:b800:7775:1147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409bf65sm3676997b3a.34.2026.03.20.23.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 23:24:20 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: mszeredi@redhat.com,
	raven@themaw.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com,
	Deepanshu kartikey <Kartikey406@gmail.com>
Subject: [PATCH] fs/namespace: fix double hlist_del_init of mnt_mp_list in get_detached_copy()
Date: Sat, 21 Mar 2026 11:54:12 +0530
Message-ID: <20260321062412.1120693-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_detached_copy() builds a new anonymous mount namespace for
open_tree(OPEN_TREE_CLONE) by iterating all mounts in the cloned tree
and calling mnt_add_to_ns() for each. However, child mounts in the
cloned tree have their mnt_mp_list linked into the original mountpoint's
m_list via mnt_set_mountpoint(). mnt_add_to_ns() only updates the
namespace RB tree and never removes mnt_mp_list from that list.

When both the original and new anonymous namespaces are torn down on
process exit, put_mnt_ns() -> umount_tree() -> __umount_mnt() calls
hlist_del_init() on mnt_mp_list for each mount. Since the same mount
belongs to two namespaces, hlist_del_init() is called twice on the same
node, corrupting the list and causing a general protection fault.

Fix this by calling hlist_del_init() on mnt_mp_list and clearing mnt_mp
for each mount inside the loop in get_detached_copy(). This detaches
them from the original mountpoint's m_list. Clearing mnt_mp also
prevents __umount_mnt() from passing a stale pointer to
maybe_free_mountpoint() during teardown.

Reported-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e4470cc28308f2081ec8
Tested-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com
Fixes: 2eea9ce4310d ("mounts: keep list of mounts in an rbtree")
Signed-off-by: Deepanshu kartikey <Kartikey406@gmail.com>
---
 fs/namespace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 854f4fc66469..04e7ffd7fcf5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3063,6 +3063,10 @@ static struct mnt_namespace *get_detached_copy(const struct path *path, unsigned
 
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
 		mnt_add_to_ns(ns, p);
+		if (p->mnt_mp) {
+			hlist_del_init(&p->mnt_mp_list);
+			p->mnt_mp = NULL;
+		}
 		ns->nr_mounts++;
 	}
 	ns->root = mnt;
-- 
2.43.0

