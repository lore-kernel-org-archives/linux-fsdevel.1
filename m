Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB791DED63
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782032929; cv=none; b=oF/6DeVQU7PkcwIa37CB7h25HoVUS5oinLS9W1CWdAViBlkG4p4o9qoAjgBQXcjLK3We2z3FhV/3cPZ5O0uQQ79kffh5MNtTu/gsqOdL8lCNfLnZjituxHDSXQF5+v1xCBX7Kjfl6rtOc7LSRIeyJDnKeIVCPCG6YbnowdlRbIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782032929; c=relaxed/simple;
	bh=D8EWIrYF4rIXIYGHAgKszsKKj22NQDodwP8iPittV24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NKWBhwxcU455jp83yKszRDeyIHvPYXEG+S5yfZFh202EnEdy/FTf5IBXDR/Zi0qL6LVAWkohHdIBVmpJo9CeNdJ8Yvr/m3jV6mtS6nP42ahm/2Bc5ODIc9SFJmOLeRIf+SMT0Kd8P+J0fQ2vDXNHBCxsoHnl3XATnco84b5cY88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEXD/Hlu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEXD/Hlu"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c8ce8f2e235so347415a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 02:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782032927; x=1782637727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8cB+3aTUJcGslDy+LtIPcuzpD/+janxw7ACEaFGEINk=;
        b=QEXD/Hlu7JWRmkQLc1jxkoQgEHxKqa52mJf2XXJJdfX6XEimhCLNLzy2L2I/qUWibr
         ujbXctIlJ1EII/t8D4lYsVWWZHySC1n2N8+m25NQd0iycbIwtdYebNF14hjrWPqwNrKy
         8Dw4Pq++eCfKJL/4CGliQ8HCEKlXgobFAilc5MbrqRKtY+7uSZrSZh88Z7gTfiA/FtOm
         Vl6H6/CBPIwoMOLNR36iBtYF7M9IDvlUUwIjZrMGHzeomyLDIAsNyDMIq1GNQHju6OnS
         M7Pa1QLVe7h8f60A+f745x9BG9DLYdbCV7/VYwdGT86y4YtT5JK0V1+eObkgajevg7ff
         wTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782032927; x=1782637727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cB+3aTUJcGslDy+LtIPcuzpD/+janxw7ACEaFGEINk=;
        b=DLmBicO+LCCFh8842UXUEVf8QvjCE7ORIqihlGXEvlbVfth+Lbxd+Ld6utdjQJus1w
         AonWyuB+TsokfoSK3WRreQXKmadTrTdVrh38ax0C/UlVUWYXrRXEzf/Di5mQrZbKdcZw
         zY4n/IvjiMm0t5b2rD35fZ5jkZjjhrEjEIzuaGI9YjeVmrkDqn+9Z5Rq+tg3VblM/zUQ
         19DIOkiSajBe9odBRxMG7QPGn/hw245WiCPcan0ah9YxLEKaH8N4VgMoOjj0431xxdwi
         YOXxJT9FaMTqD12M5Y9mvCq2rEmf3uT1xVJswT65nTlIkaeqk4s0MzXGpcsVxyHgBf4W
         QGmQ==
X-Gm-Message-State: AOJu0YxRHjb6TXbluR8NkaPg6Yvrx3ATMa9nPly2a+qzsK07iHALGhat
	4TBEXoLJnPDvq2SbJPOY92rGFAuGUfvCSMD6F+RrDDg3Kulj0hCJ7tOt
X-Gm-Gg: AfdE7clTWqFL3swB5wxJf3fRnWSpqj+E8AeBIvZ8hK16CN9iordrAGuOc0MIRvZhAHw
	iafb0BLWJVPZuVzA7s+uzrFpa21YfkduuEmQi7TX0q3fe9HrCLgwTvwQFXlRE3VYhOwy7CKmXZO
	YijhNYzuLVJGol2hxCkBRB38iqw99BPdVn15hKCERBAcTSA/FxFfenNSFJKCeTu+I6kX1OauJOt
	CElpmMddvJDWVLSV/oJ/ngd7I4izxQYTqsXInhCu9FaH8ph2qa2JwuXot0sFMCHgC23U/H8kDfY
	e0mk2d7Fm7U7rYg1Z1ElQgJcRSEn67neHmMzCCo4lrEQRIyzhVchVsgm9KQjuYAWpXYhWYDMJdJ
	9QCEXhqStnNjUna6kGxRdI8b0wftIfPo8TCEpIEfQyrw5YvnZGtjDBb2ZBM5OjFEzTfriknXwFf
	0HDepDaAAMN2QeUJNgMqpFAtl5P6hWUV4t1mQ7CsXAGmSjA3K5O/92qA==
X-Received: by 2002:a05:6a00:94f3:b0:82a:6461:6d15 with SMTP id d2e1a72fcca58-845508eba43mr11499481b3a.46.1782032927379;
        Sun, 21 Jun 2026 02:08:47 -0700 (PDT)
Received: from DESKTOP-P6LTFAM.localdomain ([152.57.224.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564da67a1sm4624633b3a.27.2026.06.21.02.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 02:08:46 -0700 (PDT)
From: Sainath Manda <sainathmanda777@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sainath Manda <sainathmanda777@gmail.com>,
	syzbot+f83fa2cf571bd7650422@syzkaller.appspotmail.com
Subject: [PATCH] hfsplus: fix duplicate bnode creation in hfs_bnode_create
Date: Sun, 21 Jun 2026 14:34:48 +0530
Message-Id: <20260621090448.13108-1-sainathmanda777@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a WARNING in hfsplus_bnode_create. A maliciously crafted
HFS+ image can request the creation of a duplicate bnode (e.g., bnode 0)
that is mathematically within the tree->node_count bounds, but has
already been hashed in memory. This bypasses initial boundary checks and
triggers a WARN_ON(1) upon a duplicate hash collision.

This patch adds a clean state check in hfs_bnode_create. If a requested
node is already hashed, the driver now safely rejects the operation
with -EEXIST instead of tripping the kernel warning.

Reported-by: syzbot+f83fa2cf571bd7650422@syzkaller.appspotmail.com
Signed-off-by: Sainath Manda sainathmanda777@gmail.com
---
 fs/hfsplus/bnode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae5..5946baad2 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -626,12 +626,18 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *tree, u32 num)
 	struct page **pagep;
 	int i;
 
+	if (num >= tree->node_count) {
+		pr_err("hfsplus: attempted to create invalid bnode %u (max %u)\n",
+		       num, tree->node_count);
+		return ERR_PTR(-EINVAL);
+	}
+
 	spin_lock(&tree->hash_lock);
 	node = hfs_bnode_findhash(tree, num);
 	spin_unlock(&tree->hash_lock);
 	if (node) {
-		pr_crit("new node %u already hashed?\n", num);
-		WARN_ON(1);
+		pr_err("hfsplus: attempted to create already hashed bnode %u\n",
+		       num);
 		return ERR_PTR(-EEXIST);
 	}
 	node = __hfs_bnode_create(tree, num);
-- 
2.34.1

