Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA832E72F
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785047122; cv=none; b=Icrf3UIYVLX0rom2MkhsgOdtKu5mT6JSjeI2/8Igr52wCcLfiOebVV4HdQZsMLHm4WOOPQje62/9v9UTPm0BsdpmZhGm1Gvz7TXs86e/IkGn+BFNGR9q7ds9W5M7fJih/t2Y8abEnbRqz+/Sk9si/yBD6W/xHFtMq/p0Y/a1Kl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785047122; c=relaxed/simple;
	bh=Hszg99Fhnt/WRuDbGMmPk8WSIMvY26tREE486XMnpmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FaJdJ+vWeevYeVp1yWNBIrKHi+4WrrFkdvuS0OTOnQQQcNStvxd4W6P4hjYqYqxAH8fTv+ioJIeJZLyotoGn9xzM9AoavIdCd/kWpfc8XFTru7+43uW0q5oadK35G2TKyaQ0AAePMxgIvTUy8QA8KklfImMNwK/ww7zWNQESwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=QZ1kpC72; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="QZ1kpC72"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1738330b3a.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 23:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785047120; x=1785651920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8eyy01gUZcTypOwXF2vr3vGTrQtX1X17k4pOsofiCGY=;
        b=QZ1kpC722EVZFG0/AWQbNnb9tbfSYtiZ8Il1avooyCNydGPXn45jo9i+HSiljCOeK9
         FihD6kRr68xLC+lyxW9h+wr5q1k3otBdjvEDXVUpXnerF/BAJjOlJMFP0V40NTIhui7y
         zrKXrO99Koh+CRr86sya4+hY41yfto3IsgaLbeMklZIMKEuWScRInsyIkNCL86264s18
         zwDxBJ8/mLxZhNQ29xUfDadxc241+pItcHZYw5Qlf8UDvAOWXA3ATQu177Xt+YB1y68o
         zjY4EygESmlep36ISa99Xthi5Jg67ZkndQ+QBprIbQi7R3M8Z3BS6u7NRMuWuFAbtmkm
         NUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785047120; x=1785651920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8eyy01gUZcTypOwXF2vr3vGTrQtX1X17k4pOsofiCGY=;
        b=PYN99g8XzyIF0EfISzTCz9cv46eOQkj57gX5DSp0ZFvSjGMcf5JCR3JVp3K0r9s8s2
         XATJ+sdVgPKzLnXKAPjHyc4hZJw0R8JP4jtdRnruAuEaTLy1YZjoK5ou1XSG2o5ToQrv
         U48KtM9EXgwNjxd8pa3/ZotTXhq2MMpKfxQbdGGOPUw//9vfPIsyGHmUS4aT1R/g+dSy
         ZAeyJwg7gJrehiUo2SSKf7p4qUoq9EZFi6SYxYtALu7/XBvXGA+RXE9x6gDaG/V95GAG
         KBm/DDCWd4hYBmPFuFwRLZx4IqEHuaLMARZejBckeO3SC5IeoUlU2wuVUc3PiWn2qxqr
         NLzw==
X-Gm-Message-State: AOJu0Yy3hcuDUpaWW3oHDgRo/PoKbrIUIYDM/bGuSHE+t09Y2J9cEfSb
	VRpwVg0dBtG3bLuX68/bcq4+FKtFScyMI2zSf8LyCIBeVinUAu+AzWgea34+4vHQNvhKLusHbcc
	AMQ1miIk=
X-Gm-Gg: AR+sD13uqpGp6FEmVVgDpTE6tSXW1w1JopEcPlPUoP41TxKhhFA1gLXJmE7t5WZe8vM
	PVrLW8AshOcqBBjK4/2FytgxzOix50qmuUYXGYHOWiEzUf5VI0gXkjcgzp12a9UGEtyyfiTJUrc
	dQNIY30cqozM1lHGP6FggG4GXe2mifvQQzetEeu/HC6CbGWdqbDhVJ+mXY8VEUxi7V6LnAFWcLZ
	GKzl28GED/SNfv6hiVvGVOwotBCR/3QOYk2AgBCwJyvas+3Mo8WLc8/MUDtOpc5nwCM+wLhVITp
	cYl0rBHk25IVGzpAS/rnsLkxtjlQl39PIzjs7VPem81V/5acMxjdHdtRFj1YlkyqontOJF/eSmz
	IDKRUS7Pa10N1FWz+Zx/EmdagnVhku+YjyaJMsWKTUy6GnWYYRjcf1eUmHd+PRuuoUDW5D9qSjy
	nZso0IAW6rCEaxnbEMwAjAcfGChTUricZjFciwPVcXIow8ckVNVe+/33pjAoNR
X-Received: by 2002:a05:6a00:4c9a:b0:845:dbdc:8652 with SMTP id d2e1a72fcca58-84e5942bcacmr3501122b3a.2.1785047120125;
        Sat, 25 Jul 2026 23:25:20 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66dcd38sm1841236a12.29.2026.07.25.23.25.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:25:19 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH] freevxfs: fix off-page read on a crafted dirblock
Date: Sun, 26 Jul 2026 15:25:14 +0900
Message-ID: <20260726062514.43756-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxfs_readdir() and vxfs_find_entry() both advance the intra-page offset
pg_ofs by VXFS_DIRBLKOV(sbi, dbp) at each dirblock boundary and then
dereference

	de = (struct vxfs_direct *)(kaddr + pg_ofs);

without re-checking pg_ofs against PAGE_SIZE in between.  The enclosing
while (pg_ofs < PAGE_SIZE && pos < limit) test only gates loop
re-entry, not the deref that follows the addition in the same
iteration.

VXFS_DIRBLKOV() is 2 * d_nhash + 4, and d_nhash is an unvalidated
on-disk __fs16, so the overhead is attacker arithmetic of up to roughly
32 pages.  kaddr is page_address() of the single order-0 page-cache
page returned by vxfs_get_page(), so nothing else bounds the addition
and the de->d_reclen load lands off the mapped page.  Directory pages
are consumed unvalidated: vxfs_check_page() was never implemented, only
a commented-out call survives.

Both sites are reachable on any mounted crafted freevxfs image, the
vxfs_readdir() one from an unprivileged getdents64(2) and the
vxfs_find_entry() one from any path walk into the directory.  When
d_ino is non-zero vxfs_readdir() also feeds the off-page bytes to
dir_emit(), so they reach userspace.  KASAN reports a 2-byte
out-of-bounds read in vxfs_readdir().

Re-check pg_ofs against PAGE_SIZE right after the addition and before
the deref in both loops, restoring the invariant they already assume.
The added break leaves the page the same way the existing zero-d_reclen
break does.  Well-formed directories, whose overhead never pushes
pg_ofs past a single dirblock, are unaffected.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 12495ea3ac47 ("freevxfs: refactor readdir and lookup code")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Reported-by: Baul Lee <baul.lee@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 fs/freevxfs/vxfs_lookup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index 138e08de976e..b068f93359fb 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -87,6 +87,8 @@ vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
 
 				pos += overhead;
 				pg_ofs += overhead;
+				if (pg_ofs >= PAGE_SIZE)
+					break;
 			}
 			de = (struct vxfs_direct *)(kaddr + pg_ofs);
 
@@ -237,6 +239,8 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 
 				pos += overhead;
 				pg_ofs += overhead;
+				if (pg_ofs >= PAGE_SIZE)
+					break;
 			}
 			de = (struct vxfs_direct *)(kaddr + pg_ofs);
 
-- 
2.50.1 (Apple Git-155)

