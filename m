Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3744C4E4
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035583; cv=none; b=qjcpa5/MlhNv9oXc2jTvXZA3kQOT4MXJxx8FhWmdXGZEm+6IkmDVFqTlqtQGaVdqRsIfGjX0LICJjQ2Qes+QIuDOUyk6Rso40FOGsFke1NpTQBRNLlrpWyBr9MgxiLzV15HRc9Z3ybDMNVdmWIFi5MFzgg+iT+cS3NKhaQomyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035583; c=relaxed/simple;
	bh=tpriWxWOl+J6JwWfTTr6TdF9jz0JsOXJvxWyKOuU9Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8yBAaXFe4gqwKkcJPzlQhxhLT65q1EKbEHAnWNb/4/FNYC/YPTGDQxNbttjg09wG6NF2abk98Dye5hWU3VUJDgRUJqZ4F3C3ilYeKal8SfjZx8fCCenNlZQwvfLoAjKkhddjJ0fUmOpr1m5BJDAoqdCsyZdQHz5e7+01Ds+CeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bo0d+42b; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bo0d+42b"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c276bfce7eso1726591e0c.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786035579; x=1786640379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=duwKRHlWbKUb/BOL4rfzAJNO2P4dXrVaNM+8BQLZ4gY=;
        b=bo0d+42bvRuWcxvl9oRfa245IM6mXsp/UqtsZ81UG6HCbTeG1P+89qWhMg8tJj/TtC
         I2TEUZCbYsLqS/GjLCMj92lPj2KygZ+5Y5YGbsLsKmEqHGMQxRL8vkOYyPOronlXlGkk
         l3ZKvlAgM8OuXeMl3nxvjLosaZ00O6z7tkbSRPMkr7t0jhMVXfot1TXvK9W3RujchWgN
         i13gt9oN58lUIbPpUI2yLkX5chiNtH6AQOHtXPXSmw3KaGjNy5S3ICbPlSC731OCsTwb
         DGGIWgjIHseapbdUvrjtrpH5Gu9gNUSmiI9YqVOlazDSLSF8anKVNDTHLkKgu8hBZUnt
         WUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035579; x=1786640379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=duwKRHlWbKUb/BOL4rfzAJNO2P4dXrVaNM+8BQLZ4gY=;
        b=HHILOAMjMHfxUF5ywdvmvjHSED7zrv4H0OuXmZcnxzbLj/HNhgpkab/quRl5X8fHL3
         1Bxgrwt0moVhR/BDqSzH0Xx6GBM4zGC3TjZ7AuOz2eY/T62F8V02fX8hKjkUrAKqNnhW
         6W1vL9kFtyzazjsHNep9H7Ipk+q7rxc0EXjmukmra1CxbdY/MKa8BNEULYUOOF7rCpXv
         1K6jbEvfy5f3MgmhDJ3rE7AzhgrVoQTJcR2izrYvXJhfR4b1silSyy9cxcoSCuHLkJa7
         SwfFwcLipeWoWxtE7wLz5o+0cv876wEgorBEnftjdnUel5qdVZZvdjAoU+pGuvBpboFN
         uLGg==
X-Forwarded-Encrypted: i=1; AHgh+Rr03R0PY4Nptj5ida27ypyn5ohufMydBKcMTh+QY72zuEUCO/cdVPtZ2U101gcc444ZzAC+J7pz8Q5ZJKYA@vger.kernel.org
X-Gm-Message-State: AOJu0YwUDgsU0SpfukEvabJduX0rCvgA6R33BxdMB3Hv5jhqfJaYJhCI
	AjxflE2l9EItTWDBPLlv95irInf0T36u+i52I82moW3cRadQyehvr8+E
X-Gm-Gg: AR+sD10F4PixQhmHkdghI1G7F5Rlzr3pm03F2C2LrAOT26fwwFiifolStK6/rUITzG+
	Nb5icexbkm8qUiDefg1Z4rUev6k/0Hr00peWTCmmz9xlPnlXOci9GJ7CLzrEsLKcK3twcM6zqYb
	+3x9FVSFgea+MJfiPA7hxDxtRD3+6I+tmEVGVbQ09K959+UstBhv82FO5nEQyPePoPkpG2DrSim
	fjrPcTU34PSY5ctpYO96aHoNdzQ5p3Nd34QUYmXVD1bVUs/bglQ47lGO46adY0cVF+ZTLSz9G8e
	wAnNj7p7vJYxsRxMUJbkI8hDXRvsu2Fq+Ey2N/D8wTIPnHCuUryXNdPbxwyfjeHkjnTHHMtRGia
	ROr8KFWiDr1hEXmSoqWj71sudGviUoE+99Ft7/0i1t6jPbPNJfWaB9TeCcfKhU274ENgAPEAee0
	o2RX59Q0h4pyN8KirwRkBtjEwjqmIXmL2044VNO40eObuyop2JAKM9LxwIVjqwMPuDwmUMmZqPC
	FQk1C/bA3h816WaWw==
X-Received: by 2002:a05:6122:3d0e:b0:5bd:b27c:bace with SMTP id 71dfb90a1353d-5c3d926476emr2526056e0c.14.1786035579340;
        Thu, 06 Aug 2026 09:59:39 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3d05c594fsm3706321e0c.8.2026.08.06.09.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 09:59:38 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Matthew Wilcox <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Bob Copeland <me@bobcopeland.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-ext4@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2 09/21] ext2: check for an xattr block write error with buffer_write_io_error()
Date: Thu,  6 Aug 2026 12:58:32 -0400
Message-ID: <fcc530fffd0f1e18e8cd1a3974bc0ccc5b4c4b66.1785951556.git.coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
References: <cover.1785951556.git.coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext2_xattr_set2() spots a failed synchronous write by testing BH_Req
together with !BH_Uptodate.  That relies on the write completion handler
clearing BH_Uptodate on error, which this series removes: a buffer whose
write failed still holds the data the filesystem asked to be written, so
declaring it not up to date is wrong and makes callers re-read it.

BH_Write_EIO says exactly what this code wants to know, and it implies
BH_Req, so the pair collapses into one test.

No behaviour change today - a failed write sets BH_Write_EIO and clears
BH_Uptodate together.  It stops being a no-op at the end of the series,
where the new test is the one that still works.

Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index be63f89402a3..39005ec23fe5 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -769,7 +769,7 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 		if (IS_SYNC(inode)) {
 			sync_dirty_buffer(new_bh);
 			error = -EIO;
-			if (buffer_req(new_bh) && !buffer_uptodate(new_bh))
+			if (buffer_write_io_error(new_bh))
 				goto cleanup;
 		}
 	}
-- 
2.43.0

