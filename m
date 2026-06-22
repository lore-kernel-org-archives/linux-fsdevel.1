Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63408126BF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148674; cv=none; b=ivCgdhv1a3o0lrgrbukSW3jaurhf7RdLcb/UJUPS0vMGSMZVOqf8Az+UEPQgg/grLWf6rBGf7QYos3uMgTqgxFO1RG0IKfFD295tF9Td7Pii9ej/wOq+y+j4t/IfZpE0PpDDKgg/7Yh2EFmCmMqRAJqdbUPqFczOYzQZqV174+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148674; c=relaxed/simple;
	bh=1gRikTyfrr8CN5N/ZieSqpn+yNlhuR4u+SEoJtI42Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dVlDN9kCM/EzNtr5VM8PWPJinoC7Pex42z1U907BwBQJYesKGak6bIHfyknd3vhwaMVxvOttXi9JAtAaqZLi/YVf51l4JZhsDt3/adP/6PKA63y86k4DmmJnwuJ5guvpcqO/zt/Vbgejha3x7v96Yi73NoSQ/CfSBE85XElK9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxwHY7ee; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxwHY7ee"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so3238159a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782148673; x=1782753473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gz4kyuB3SVM7/juytwVobIKlwq0XBJAvHtbzqrR5YVE=;
        b=BxwHY7eeR9p6KynyXWE6BQJfdjKnbBCEfyJyFk2ULd42FoGPMjVJJ4FlPdgnHSyuj5
         xo+uNiVesDBTYg+LawHXiAkj2rOAQKqvKSMF/53O9JfnV4dSOy0jEIs1gqcx2Io8atm4
         Q/tKywKouPKGFrjw9emYaPmS330iGBdhPxGHMyINs04t+vkn7CQ+1SFVE0m5z/nMED/3
         mdyUBCTJAQh9M4PkuUG/kxxKgPMpmTKaI2zpDM8CTOK2nRWl6Xadx1vUgD8WJmsXSK+w
         FAIl6uN/pIQCcyE9vuCRIeLUo/vRUpQU6fNL82c2rNcg47MVFyOSKBdwGErEs80/0CJP
         xIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782148673; x=1782753473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz4kyuB3SVM7/juytwVobIKlwq0XBJAvHtbzqrR5YVE=;
        b=q7AL57qoLXbCThZQgAsrCXNYcnyPztl9FJR7FhHL3JtvaKQLPsba8yPbgr+HyR7AJA
         rcTJrngC2WCtDCugjAj7IIIKBiMlRVap6bZ7GzqzNp5tWc0vaF1bjRzyEffspxpioOQc
         563s8oLw1+rY86d7hJpPhBNcfdIQaFJjEjzUWu9NllRBR9UkH7G4vuzkj/NSgHBgEz21
         mNJM4pxU2qJyQYsOfHnsN5ZPt1LMwyBIIdIoZRWAZUBVurxbzLpkbVlj7ZGjv4zJE3WR
         LtTzZ2BI4Z1zaz+0Xzf/eg0UjPDmBjudBTmKfk+TAuVibzxiDwGQwV6/NBou8LSwrhBk
         h16Q==
X-Gm-Message-State: AOJu0YxvpE/aL9ZgRgtArzjR02x9ISdGQTQQofKc5w0dCfOCGUSJRls5
	92NjLWgPv1/+7lvsY6f1Qs8Kx1mG9iBVwK32beOgJZGjvf20w8NNsHlZ
X-Gm-Gg: AfdE7cn3QeuQLtTbOGmwQg2LJrTBWrHMiK37voqXYm/w/I8EEd7xBHiX5FFTelqGOHX
	+t9ZKOD+wIA+EnImy5i7HXw6UQQSAkdUjEYam/LGGpY7kSp1MQIdxRBPpDZ9ZX6em+JjPo4eSud
	5ZT88NV+jERXY+TDnGhjnIUE9AmmUJ+jA9vSPVpQsZMqJ2FC2GQoNi47Juc6XMuqlxv9MQCWVAc
	4re7i5SrmnEOoXBVGdZ3ug8zJwWbmtce5+ZupBEhCj6esaYvzloFKVec5xPH2ybhZvfaa36W2Ge
	urAQmk5fHnzSeDHRaGIdkBcAqE9PgTfyOTPGwCwT39e3vRF8rJBrR29emjug9C/OB7VzOS1v0HV
	0nOTLz4bMuXSR0xwbYPbEPlXVeTeyb0sF6jDKOk2KNw+DILqs1y28A5htPV0y3C2UNq4Q2g/lkC
	l28PoKwN3hh2wloSK8agFLsa24UsmzffWL7IVryU5SzSuhzZPU5wyJ5VUSia8WZN6sS98bCGzPb
	PNHjwFKjzWapH+9Vw2mWT41Q+dodaVvWwAD+axN86meswuJImkIWBD/LIkOStBBC/pzXh+3o0eN
	G/urbz0nu17+4qHqGsykHkwsDQ==
X-Received: by 2002:a17:90b:388e:b0:368:3d3e:efa6 with SMTP id 98e67ed59e1d1-37d4e64ce30mr10920377a91.20.1782148672677;
        Mon, 22 Jun 2026 10:17:52 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.d33bddc1d573818c7-tp.internal (64.192.142.34.bc.googleusercontent.com. [34.142.192.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d155804acsm10458958a91.6.2026.06.22.10.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 10:17:52 -0700 (PDT)
From: Aditya Srivastava <aditya.ansh182@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>,
	syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com
Subject: [PATCH] hfs, hfsplus: remove WARN_ON when new bnode already hashed
Date: Mon, 22 Jun 2026 17:17:14 +0000
Message-ID: <20260622171715.1697-1-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>

Syzbot reported a warning in hfsplus_bnode_create() when mounting and
traversing a fuzzed/corrupted disk image.

The warning is triggered because the node index is found to be already
active and hashed in the btree hash table, which indicates on-disk
metadata corruption.

Filesystem corruption should be handled gracefully by returning an error
and logging a message, rather than triggering kernel-level warnings
(which can panic the system under panic_on_warn=1 configurations).
The code already prints a critical message and returns -EEXIST (or the
node in hfs), so the WARN_ON() is completely redundant and dangerous.

Remove the WARN_ON(1) from both hfs_bnode_create() and
hfsplus_bnode_create().

Reported-by: syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2bf21610eea63cb2ce93
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 fs/hfs/bnode.c     | 1 -
 fs/hfsplus/bnode.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 13d58c51fc46..335834961741 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -517,7 +517,6 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	spin_unlock(&tree->hash_lock);
 	if (node) {
 		pr_crit("new node %u already hashed?\n", num);
-		WARN_ON(1);
 		return node;
 	}
 	node = __hfs_bnode_create(tree, num);
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff..bfc2a7f53edd 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -631,7 +631,6 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	spin_unlock(&tree->hash_lock);
 	if (node) {
 		pr_crit("new node %u already hashed?\n", num);
-		WARN_ON(1);
 		return ERR_PTR(-EEXIST);
 	}
 	node = __hfs_bnode_create(tree, num);
-- 
2.47.3

