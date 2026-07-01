Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317CB42050
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864700; cv=none; b=OFFY71P7lA61UYgEwwlNI2m28dnJK49EQ5sTXJZiP81jveICbxaPveAyR9d/kqnQ+HJIHQrWoV+5LYJK8/aRX+woeW4NaBUUhm68aBeIfeki7YGI6ISmoU17QDSWMwARJTfbbjbmyl5doMenHeG714PAOhdbcVfyxIlYN/FOn04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864700; c=relaxed/simple;
	bh=UAK5oUiWMIcbyMwKSX2yaW8g3zJEjKE8bwxijrAtnjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCNPV32l/QcC7HJ4rci9cQ2jgugVx3QuA1lrOJJdzPsFGAxnn2hc2kXyklNdW0twFkzdHeXgIUSe0HPwKz2fuN0E8+e+lyV7xGUX86Nqn4woG62Sd9C3T3y8hZG0AlrNYjQmQj2gvzYluiebIMf6UbrGjxRd6X3PY1VpmwzZSIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgtrOeVB; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgtrOeVB"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso47279a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 17:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864698; x=1783469498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7+CcIiDetDTiagtbVpMn37s8DwFl6V2j0Jf9vPEZaw=;
        b=SgtrOeVBMyf8aTBkOw+Yu0WBLRlfFqsf+8Niaoab/o6tzS59mJ/XK1imUjCuethZGN
         fQVpqpo+K0M+WRfC6hMRjcO7Ii4hAPAMpMSAWlcz7yzxXOeq3j/0TWh0YvtulVuc/kVU
         sLupNzQ+wnCYejMH23zsmihA8bzmQTYA50BA5fDS8QCLt+74Ngrci3zsSAGJmjKbxntA
         enRXaDLwKDwn4HMz3kQSq08qcyunZHoUOdFRlxWe+r1QSHidSzMPL9/uQdG9QwDY2ruE
         XuiW2+nZL3gOQ9CVZGS3l7oi55Fqf6ndE9uBizP0vvMr7Hd3DH4eE8emTchIA8lw0WIj
         5bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864698; x=1783469498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7+CcIiDetDTiagtbVpMn37s8DwFl6V2j0Jf9vPEZaw=;
        b=C3alStMpPZBH9Ko/LIYxib4SmWEZWWALZKz4phydVxq4KSZ3CdMCJg9v+z+8kPyNY7
         xwQiPo6N33Gn2+EBgF8vdccXdUfbYzkffCgZQsKmjyjsiXA/6MPp83qPYbaMkbs4N0CW
         dApyyk3uFSRfjFFIVikNOrFsPNjc2dD48epPSk+1N/oBdr8+xZj+XArjz7iyqJrIPSWl
         Yt8C1uyhnAXLBiKwGs100u/n7XJmZTvPa4LhWzmm0n3JoWyO4qIyY98UUvLf8hEi2wzv
         ofDkKa2QB03+RdDgCql326XosArPh0fOXQkxnQfFKUPAuiaw/sv4UPbzsyxbegAGlPB3
         Yt0g==
X-Forwarded-Encrypted: i=1; AFNElJ+tR7x4K2Zm1C/Qt+0uldhyaJZOa84cy+sZOA9oRcxLRRzrP5ERKHdshfWZV2ddYCNbUlqw0IppnyV98d6T@vger.kernel.org
X-Gm-Message-State: AOJu0YwY62H0tCWenTWpLyieIM1MyqaoGoH5whKaQAjSl3CkrHMSqGJq
	CGA4eToxWkOuMwShLKpSbx6Mi2BQSknX2zH7xL7D4JO5AbVp0yrZcu9/
X-Gm-Gg: AfdE7cmrinl/zh5IrDRe6umInVOkAUMRWTMNpK91dEwkaG3U0o9g/NNymI+1TOECrUK
	frXeYZq7zn79CE1p7FlUmtM1OOFgv4lRuOy3Hh0sByFRFkIFu4taRvw6d8lcW1X4Oh6iJD6NVdD
	K5VsmRGudLK9hJOpuTqsq0wn+iha47LJsHYh3bCyroGD1F8Xuo31hzgsG3vgW8qmgDlQLRElU/7
	Whz3B2djuVzrVdxWijQ4SygxgHYqJOjTshH1G2/moBoi33vKek3GEyZ6uJlq6G1fwm4ZpHQfqNS
	U9EzlGJW8hPLQGtf4rpCywwmI9sfXGQ16G+DHaUqSfvgztZr2fWoySYRs81tjKoR6x5m61yVdA7
	PqQ9BruM0myDoEIaPeuCVdDNAz32erl1+UOErTk5cv5inHZZU5d799q7bZUhejUTpGtc/ud9PWH
	BOSc/ifVnyBrulZezDWmFEtsUNM9keJgyfntduIB5seSulEu3HSe5aOvOiFma+Nrm/
X-Received: by 2002:a05:6830:3808:b0:7dc:cdea:7d9 with SMTP id 46e09a7af769-7e9fc15ad0cmr1772936a34.22.1782864698251;
        Tue, 30 Jun 2026 17:11:38 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ec2b96c0sm3558136a34.14.2026.06.30.17.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:11:37 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	hch@lst.de
Cc: djwong@kernel.org,
	willy@infradead.org,
	hsiangkao@linux.alibaba.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	linux-erofs@lists.ozlabs.org (open list:EROFS FILE SYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 07/18] erofs: convert iomap ops to ->iomap_next()
Date: Tue, 30 Jun 2026 17:09:22 -0700
Message-ID: <20260701000949.1666714-8-joannelkoong@gmail.com>
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

Convert erofs iomap_ops to the new ->iomap_next() callback. This uses the
iomap_process() helper, which finishes the previous mapping if needed
and produces the next one. No functional changes are intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/erofs/data.c | 10 ++++++++--
 fs/erofs/zmap.c |  9 ++++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 9aa48c8d67d1..47dba61ec576 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -380,9 +380,15 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
+static int erofs_iomap_next(const struct iomap_iter *iter, struct iomap *iomap,
+			    struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, erofs_iomap_begin,
+			     erofs_iomap_end);
+}
+
 static const struct iomap_ops erofs_iomap_ops = {
-	.iomap_begin = erofs_iomap_begin,
-	.iomap_end = erofs_iomap_end,
+	.iomap_next = erofs_iomap_next,
 };
 
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index bab521613552..dd058413a0b6 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -821,6 +821,13 @@ static int z_erofs_iomap_begin_report(struct inode *inode, loff_t offset,
 	return 0;
 }
 
+static int z_erofs_iomap_next_report(const struct iomap_iter *iter,
+				     struct iomap *iomap, struct iomap *srcmap)
+{
+	return iomap_process(iter, iomap, srcmap, z_erofs_iomap_begin_report,
+			     NULL);
+}
+
 const struct iomap_ops z_erofs_iomap_report_ops = {
-	.iomap_begin = z_erofs_iomap_begin_report,
+	.iomap_next = z_erofs_iomap_next_report,
 };
-- 
2.52.0

