Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F33C9EED
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776452364; cv=none; b=EBykpdzishhqIcxznf8G068KNezjJG4znciMIkL2AnivC57VfYGu8vOaUt8Jb9XmyWqArv8LDnkczfK6cVcb3FTfXGoPXCkkX7GldgxFbouqBzb4oh9/J+i89vVFAVOQfA1SyWQWDoxyTe51GpYPhLzA5+yIRfgiBtU4DEOAm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776452364; c=relaxed/simple;
	bh=5Y0n6CZoHP4DcntwMAYBkIPzcR5/+vcjyEFl4iue5i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtZOucKQ2nWcZa3ChE5FqEjBypCMCZUeXJ7PF1VAGjvzup7pJhXgbLvogyt9AHWr1kXkRhPypheaoyex8Rc7bMzCyAsftW+Yi1o5oJ1AFRsnFz3V64VYQT5NNa+KDlkXCE7WsZwttA5u32OhQyADep3UDPx/bhESQN7FOV6hkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b65z4OkG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b65z4OkG"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488c2690057so10219245e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776452362; x=1777057162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eiaP9ibW1qoN3pZwr4QXm4whiKQGYd/qsAGcYb+48R8=;
        b=b65z4OkGPH4n6j841yr9PWuDgkXWFwKyZHUMgkJ80Sg5wY/Jo2fr297icQmohC3OoX
         9htCNh+aaOdiiVqhIw1ajXL1KDXkjDdUAwcipNeoHrGu1QE1LnbzS/fGsHcjoXTUmJrN
         vpkctgTS7aXGzPTBt4BE2lfG+k0aZoBCy85Pn5XWgCJJNYmUH9G630iUhrJQA2BaV/1u
         2HMkAdY1zyGqZSYrLsJYFr86OqKN8RxpzJ3vo4MHLGQ45fStGXXd7RpNh2b93N03ekQG
         xtutufZ4ic93lMnMCj2gXjrUIQUdkZXB9ZLbCQPk63gvNWVDu8+Bxo1vjkKpWRmgGiFr
         P3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776452362; x=1777057162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiaP9ibW1qoN3pZwr4QXm4whiKQGYd/qsAGcYb+48R8=;
        b=NQjDQk/2fY4AyKGpBLmdcfQtEa7drH0R2j/s6wc1SxSANLpc9sft4DuCI3XbMfO7hj
         2qsOPFCHmfECXh9YTLF5ASZII9GLWz8rFRBDs0phXt7r52STdfAjN8tFstiTvEnYUz2e
         L9OzrzMIT7D79jBEbjlKFKbiTBp5s7CgMHz+yyF+mmOSmp0eJbPkKCszYBc5//s+fm82
         9PzBQM0DC/Hn1//CCr9WfFdTpgNk+0AZDZ6skYCMXmam61U28i+J0x//GIAN/frdrGWr
         rVAwm3loZZCrLyvlTm8BoglFs433Iwndwzb/przndvSX6/IpbAtB5X0Rsuo0qVjz/sCq
         4yJw==
X-Gm-Message-State: AOJu0YxZ7rtoSyKO+Nr8TIILO2J88Zbhr/ZVEwh3V06aPWAgBg9LLbPH
	NA2wB0bc+eMKnNr8MgRTyJ8GHJJF/yNe484jZXQTPdmTg4MneJhHU80=
X-Gm-Gg: AeBDievXHNloR1twMRuDbP48ujO1YOewsqFWh0Aw0Aa+P3Yo37w+l+CHPUvoazcwsEB
	eyp7px99RVE32/cvtEV6xnYey2ztgXktTPvGHFcYA96gpORtCctb5XMWuFevPL5xOjsayiYblqA
	gPN+wjQMpCqWvPzCKhGC2lAzkhxiU2pXVLrV8eOwksn7Yc8kQA0WYM0QrpE7sHrRDGwXzpDBWre
	iHOtskMJSBkK9H0CV4bP3LMreiSv/sFJmQKlBCx0YdhJX7raje25Fy1cpLcmmAMRvkok6RJRyS/
	LWlYow0erf9uv3RMaXJQSuMz1DfXmqQD48H5rDcljpzKsCTekkzsPbIpHNW7OItCvgrklM+F17/
	BZP7Fao3UlqQ2NBJomPvI0ExoaFGghfLOIfJlB1svTsohis4Syel2pPdmPPBD9OO+6r7kuU/qnt
	HOFD1DfCZNTNDfKmIu
X-Received: by 2002:a05:600c:c0c8:b0:488:ab1d:dcc5 with SMTP id 5b1f17b1804b1-488fb787ba3mr47388625e9.27.1776452361489;
        Fri, 17 Apr 2026 11:59:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75c695sm22806255e9.14.2026.04.17.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 11:59:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] hfs: return error when bnode already hashed in hfs_bnode_create
Date: Fri, 17 Apr 2026 18:59:19 +0000
Message-ID: <20260417185920.182595-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_bnode_create() checks if the requested node number is already
present in the B-tree hash table.  If it is, the function emits a
WARN_ON(1) and returns the existing node:

    if (node) {
        pr_crit("new node %u already hashed?\n", num);
        WARN_ON(1);
        return node;
    }

On crafted HFS images with inconsistent B-tree bitmap data, the
allocator can repeatedly request creation of node 0 which is
already hashed, triggering this WARNING reliably on every mkdir.

Replace the WARN_ON with an error return.  The node being already
hashed when creation is requested indicates filesystem corruption
-- returning ERR_PTR(-EIO) allows the caller to handle this
gracefully rather than generating a kernel stack trace.

Reported-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
Tested-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfs/bnode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index e8cd1a31f247..69895ccf81ef 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -517,8 +517,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	spin_unlock(&tree->hash_lock);
 	if (node) {
 		pr_crit("new node %u already hashed?\n", num);
-		WARN_ON(1);
-		return node;
+		return ERR_PTR(-EIO);
 	}
 	node = __hfs_bnode_create(tree, num);
 	if (!node)
-- 
2.47.3

