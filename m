Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA232FE0F
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864697; cv=none; b=vEeG+eWeJT+wDL52uoHYp6+wU/ZjAt/TS+BtmikRyAbROtyEJ3ihLwEngAx/y4DToAXHZUPZnD+oXYtraCEaOc4//SgaB/K74mZEOjaAo3RzPkMxc/Iy4MUsY5qX2zeodtbe7881/YvPU/IL4ESpJljw2rvgr5qChkxilLg0y+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864697; c=relaxed/simple;
	bh=Iv4GCJaO/34mDYJOmxkE3wt9pN6X7diuAH2PZb21ThY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL2QOHrGgPk5nvo9DW3+/9qQuDmejU/5o0nNxI25OlTuOVJeZMFIWGACTrnn41dSgmkYMYBkR8wAWY/H/ueoDeiWbU6fEOfK/YHyXzTLZbFJVG9A69EL6RVL+VPDipF+06dR4DDD7UxxpSrpI+0QQAqZIMrkB5xBFEsddEXI/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHIDGtbA; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHIDGtbA"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9fa42f08cso92140a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864695; x=1783469495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1putNs7Ll9/eGF0kN7bKSNzhAECn09yq2yevPfUrcc=;
        b=WHIDGtbArVdNZMw24xOhOcFhjwxafvzCNa1p4dcwSzUHP3gvV3NHVfHSGcoNHOiLJj
         CAP6OVPbW5jkZC4u7GdhdTolOnoKiLSIEGg6mf9uBUoMvh6ei57nEdJd2czfruNnNlxd
         gE5TQlMcpqxFigPcPIJ+/UauapJF2SnU3XQobaIcuvMWihcDnM3fqIndTGS4InFCnyIv
         zRpjeX9VwN13cLSWLC2KmYD9jNPMqU1GKTQQRZ/9j+vxvsAGViTtOgAFrmXNoxIG8Qgt
         Q0apAmxJDfDDBy7bo+i7d1C/yyK/YhW9QS/doeEltVdFDgztfm7Se5qfAMrxaeQd2Xf4
         tQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864695; x=1783469495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1putNs7Ll9/eGF0kN7bKSNzhAECn09yq2yevPfUrcc=;
        b=a/EAYXIQ8z7rXBCyl0kGD5Iub5lMr/H7pVu/uhFZPaHsUNElqmelvy6wmZt7Q7zA+s
         KWCPSVUno+PL9A8V8IliHXBBBmYFhEnXlUpL5SqEW5gMEqmGHzIl5qizwvjQ13Ks4h68
         3GFUeTsbvQGo5dWU9VxIimFraAQ6qjJxbDN43c3N4bsoRjl61vC1c2Hkb3fA6em2RDp9
         /PjUz7PdKScgiHpWGqk65U1WdmRgqcLo7o1zaET9jNWCwkL62k75aasAeb0aHXN8H5LW
         2QbPldn/eU65ytw0/KMyAcnvIdIJMHbYPWiW0g+U+PxNWsPnYEkAXx7isppmZLcIbGol
         Vucw==
X-Forwarded-Encrypted: i=1; AFNElJ/n3uB8r7GSiHP946+WwsxW2blxjZnopnlOB+sQ/ny1FC+vVfqIogiGmBTiuEGyBTG+dP9Uddc++1tTLomf@vger.kernel.org
X-Gm-Message-State: AOJu0YxplYn7Gya9ZS7hcQSTyDan0u+CUZ6Wing2Yex/Kxxu1IK0aQVO
	xDTTXF6vcDilAsHafNBMX1IWyvBBwfC5djr/ZdljRc919yQZcl0tYw+O
X-Gm-Gg: AfdE7cmFo/aggJiMNny3bxHc6Nbr1dIW2Ib5PMLj+l4DzjQ5Z9osnBC7kTUR8ML4NDE
	ROxLkEfWA+uzJdzSzoAXjgBttLHXJ8LbSQam2+wRzuUFykMYrMRdzXhiH3r8V1SZzgX+ifCHrDe
	SNyfjs6EX5XyxaE0sPEr6yBhnwNOxIZ7FCgYUfZ3BcTkPrVomtClM6x5NSLVVjkp+ddByD1ANe1
	2sor6//PWzUyN0sXVWXs9OZrby6E+ze6AjTSC2PPOMAcDeq/hOBVk1rON9osPnQ0XRakq307qkO
	W70f9K4Mw2omueNyWMDbV+52lVVqVHtmgirjldzcuGE2mH88TyNmrPRZVJNIX9ONv5MoTmtSPd0
	U0nCt/uvw0BJFbVAe8YZY4ogGMwVUhCVxo2oFXEClGOlN8NBQleqHYpNC2GNX7p4r6jBWYa5nZL
	b4yqc0aPd9d4Yiuf++3NrV149S+iulDEUJBvlWZhi5yUcWKn6hKflaiHwjHWt0Zz0=
X-Received: by 2002:a05:6830:6f19:b0:7e9:f8e8:d905 with SMTP id 46e09a7af769-7e9f8e8e4e8mr2078716a34.16.1782864695410;
        Tue, 30 Jun 2026 17:11:35 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebfec7easm3576842a34.12.2026.06.30.17.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	linux-ext4@vger.kernel.org (open list:EXT4 FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 06/18] ext4: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:21 -0700
Message-ID: <20260701000949.1666714-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260701000949.1666714-1-joannelkoong@gmail.com>
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ext4 iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ext4/extents.c |  8 +++++++-
 fs/ext4/inode.c   | 17 +++++++++++++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 91c97af64b31..431298eca7e8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5171,8 +5171,14 @@ static int ext4_iomap_xattr_begin(struct inode *inode, loff_t offset,
 	return error;
 }
 
+static int ext4_iomap_xattr_next(const struct iomap_iter *iter,
+				 struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ext4_iomap_xattr_begin, NULL);
+}
+
 static const struct iomap_ops ext4_iomap_xattr_ops = {
-	.iomap_begin		= ext4_iomap_xattr_begin,
+	.iomap_next		= ext4_iomap_xattr_next,
 };
 
 static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ce99807c5f5b..cf7aa8275651 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3850,8 +3850,14 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int ext4_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			   struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ext4_iomap_begin, NULL);
+}
+
 const struct iomap_ops ext4_iomap_ops = {
-	.iomap_begin		= ext4_iomap_begin,
+	.iomap_next		= ext4_iomap_next,
 };
 
 static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
@@ -3905,8 +3911,15 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static int ext4_iomap_next_report(const struct iomap_iter *iter,
+				  struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, ext4_iomap_begin_report,
+			     NULL);
+}
+
 const struct iomap_ops ext4_iomap_report_ops = {
-	.iomap_begin = ext4_iomap_begin_report,
+	.iomap_next = ext4_iomap_next_report,
 };
 
 /*
-- 
2.52.0

