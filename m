Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4921342CAE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187477; cv=none; b=Xw922VUJV5mkpxnqdSexg8KH5wwLbN2CZN5hEkie+E+D1Iy1aYwgvhwxEIq5UkiJkvb37+IHngAOumSxSXEmwLaIsiDX2Z8lseej+CUQyUcLoEqCntQ3CrxT5ldp9DZNJehZPzwn1TCr/HxV05buO3H0XTFKl61W3ReLsic12VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187477; c=relaxed/simple;
	bh=gRVbFpxn5kG8aCnSm5vf7ltvO3Q5lHYy12p0O96RkME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJyoTf2PRfjhCf/JH6zIYlJ5RcDfDr/6uffLgNBgB9bFySA1TdsqIZStqIDFa8Bb2n23R7rhMHrt9oJ9qsZaF3+hgsi7KiRkO6iTlviXBzBynwIv9n/34QCP+nX8GoWJ2gnYAUQ/lFhSxf4nERwkNPaYbBN0papSkVk2XkjJhjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Od+dhuU5; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Od+dhuU5"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848d21bbaffso3278693b3a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187474; x=1785792274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gBTzrcmdmtkEpiXXJ0sz+z/YX24zqKRtOQsTmMKXrM8=;
        b=Od+dhuU564vbnO3QNU6uIGWUPMGvbtn5ZI5aDrln1FwVYF43kPRNgGz0fRbPzSYPaA
         PN72Cnh7435CguPY/IwwKE/xMhIlSHhotP6H6m98oDzBFi9iZXCBlbWqfLZdOCus+cjm
         PSllfoxWgtUo6Rn+PDxkkwfKrNsrGGdK+I28GtLclnCYSKUlanFYFx0OTyG3JOxu622c
         DxOUDywHJwUszL0ZHWd8mCEE+HtX5JH7aUmzOizSE0NPdZWs7cjVIeDOVgXqgu5MP3Sd
         6t3J3EDYyCdJ69o0jISxmWXdZ4quVjDP7pTuuUhxfFWRoP4S4zpHs+sRNDZb80wD0QkQ
         XIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187474; x=1785792274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBTzrcmdmtkEpiXXJ0sz+z/YX24zqKRtOQsTmMKXrM8=;
        b=sHZ6L4jFXyLhcaBbvILTrjX6efo2Xs+kDW77b3z6PHLTaEmggglN2OQ55wWBtD1faj
         XWeCvh+od2dbAsFKX5NlPEJ8/qIu2pGNARAYZ2prqce8syNDdboFiAcGo+Rz/DfRVHe7
         UJYBpG/164PgT4k0Bh5rSgvytEDsj8QVUS0yhBUiyOMUQ69Xk5uGj1dqUK2x+81qvg2P
         kTjAR8sZDPMv/kM/uY8H+st94DkKmpsMj99JtgU55oFWJH4441tvFffv/gBZ8KPKgjpD
         ZcOnjwChoL0TqOM0CVm+fwgy5bmb0z6VISKU29e1ORP7XZr4zpRqeXFldx9Ai+U/IBu8
         M73A==
X-Forwarded-Encrypted: i=1; AHgh+Ro2zpJsHiKj7fgcWJgSVYNqyFeNSVaI8x98TfTdU/o+v+whgjt7HI7jpabX6UpHBq7yD+mvgOjigdDIFjHT@vger.kernel.org
X-Gm-Message-State: AOJu0YyxlmhDc/uzkbSXarLiX3j8x1kJPnjTZhYCkkglYw1MnEr85/sZ
	izoO37VEvO3F+H+kH2kne+00BER0CWiNXQqVymmOuOjh9DcVZQMHqecL
X-Gm-Gg: AR+sD12TIHpAMVVbZmbaBk8tqeKr4c/Z+kjCd0QQy/lYwBeKdXBcZ00+POrezLF2BFU
	4EYl1+xIZOSIGiXLAh3mqDZtWE3cAGbJ1gsRzdUsAH+5PWOcr1RW6LCQyyCWR+UDzI4dWoWdAy/
	Bt0NxC0XV6yP5RxVxHHg/fdeEdLfteVrO7BmcHvZmQ44XPonh/8EmOtWMcagod4cc+fQc2oPPGl
	NHyPmAf8OV1taFWur1P+DFNsPviqBW+z8NyDNFDdtMWiHFkf+whmlmso5I1uwEaZniHRbM6GLd0
	2BVE1V2XeeQCC5kfwDM6DgSyChtNB0phL9FO9plbcMc5Pb6aaDkVYzGPLC2WtzNBK25KfFvSPq8
	3w/BaN5kMHBNU0Az9P918tAKhDmFQZMfWd+G2UeCh2tA0Q1pcs4N2FRwvR7qisLQb4+mvN+WEV7
	CsAcOIlGNZHVS14DQPHy8cZTiD7tHabET7bo2D5KizzVSihPLsaYLZVzGQ0cjzGQd9
X-Received: by 2002:a05:6a00:99e:b0:848:2f84:736 with SMTP id d2e1a72fcca58-84e8d1234cfmr929145b3a.73.1785187474644;
        Mon, 27 Jul 2026 14:24:34 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5327f116sm3537052b3a.16.2026.07.27.14.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:24:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	hch@lst.de,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	tytso@mit.edu,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH v4 04/21] iomap: add ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:41 -0700
Message-ID: <20260727211758.1116539-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260727211758.1116539-1-joannelkoong@gmail.com>
References: <20260727211758.1116539-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have one ->iomap_next() callback instead of ->iomap_begin() and
->iomap_end(). ->iomap_next() finishes the previous mapping if needed,
and produces the next mapping.

Collapsing to a single callback lets a performance-critical caller
inline its iteration loop and pass its ->iomap_next() function as a
compile-time constant, so the compiler can devirtualize that callback
into a direct call instead of an indirect call through a function
pointer.

iomap_iter() uses ->iomap_next() when the filesystem provides that
callback and otherwise falls back to the ->iomap_begin()/->iomap_end()
path, so filesystems can be converted one at a time.

Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/iter.c       | 8 ++++++--
 include/linux/iomap.h | 9 +++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 66ccb87441ab..e05574602946 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -107,8 +107,12 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 
 	trace_iomap_iter(iter, ops, _RET_IP_);
 
-	ret = iomap_iter_next(iter, &iter->iomap, &iter->srcmap,
-			ops->iomap_begin, ops->iomap_end);
+	if (ops->iomap_next)
+		ret = ops->iomap_next(iter, &iter->iomap, &iter->srcmap);
+	else
+		ret = iomap_iter_next(iter, &iter->iomap, &iter->srcmap,
+				ops->iomap_begin, ops->iomap_end);
+
 	iter->status = 0;
 	if (ret > 0)
 		iomap_iter_done(iter);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 80832edc7ec2..d203d9fe0f89 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -231,9 +231,18 @@ typedef int (*iomap_iter_begin_fn)(struct inode *inode, loff_t pos,
 typedef int (*iomap_iter_end_fn)(struct inode *inode, loff_t pos, loff_t length,
 		ssize_t written, unsigned flags, struct iomap *iomap);
 
+/*
+ * Produce the next mapping (finishing the previous one if needed).
+ * Return 1 to continue iterating, 0 if the range is fully consumed, or a
+ * negative error on failure.
+ */
+typedef int (*iomap_iter_next_fn)(const struct iomap_iter *iter,
+		struct iomap *iomap, struct iomap *srcmap);
+
 struct iomap_ops {
 	iomap_iter_begin_fn iomap_begin;
 	iomap_iter_end_fn iomap_end;
+	iomap_iter_next_fn iomap_next;
 };
 
 /**
-- 
2.52.0

