Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324A13783C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310248; cv=none; b=lxybQCG03pPo/kZr8N6NoFnp1B1haBGfatu2bQ5Lnc3LhrcZXxG7ftTtlXombk+CSkXMMfQshLHj+ci6VPcmRCN1RXTfIApc9LLmHh+Af8wa74HpfDrX5N2mPsfic2xkARJvCasDXyiKbQNr0yRyTSkTR7HfaomPeAX2Bw5y0U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310248; c=relaxed/simple;
	bh=sWXCb2voUNh/5RgXFZA32Pq1QXHhhJuRnYDZVKm8gu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ak9Rh5xZwl4n+iIzQMCdEOj3y4RUkb7Ir18ojVfafLbP+1cUTz11FgEfn0v5cb+2dkhYkfS+/LOqN8AAMtkVSDS3g14mmLHs6f0asbYg0VWZXvC4h+VXvDLJ6fpWlL4ivwPmdEz3TrN2SYoKmDb2ylM/RupN8y2lIb28r12d3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=RaMC69iL; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="RaMC69iL"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKOSoq1271419
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=NuYZ
	UEpkdlDPA/MoPFg1KYmaCTdNZxzaMhmmXnS7n5Y=; b=RaMC69iL96yzOK/lRDf+
	5JstGQzPJTY3tGXJTW72lq1IMm7QXNtfTzTcW2dJzro8iQN+IyGFfOMigEK5kXJC
	TkrRPLlM6LLPe9Qif+6bs3GDBj8mFTAx3sj1CYxGfo0lwJ12gOLSKkDssy69M3pY
	kO3SoZGr2BJkk0iYM1n0FLY1CbFqNx1ykfaoWTx5Gb/OxbWLZcWDyIt9kLP3mzNJ
	cSuJlBH9j4SixMkwpaTYSSyeuOORn178xTCgNO7LWnmh8yB6rbXufNbbbx689Wdj
	/ONqFgUH4ENnnf762oQfQfPGjfmIXn9BhZXTOIt21neOwtoYd6cH77WqV6mIabu4
	Rg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e98j6wc8x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:43 -0400 (EDT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8aca29dcd69so154103336d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310243; x=1779915043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NuYZUEpkdlDPA/MoPFg1KYmaCTdNZxzaMhmmXnS7n5Y=;
        b=smqidtxvBZhuuxHgSPVjsww/Fn2kqXGYIxbwqeQ1rl/SbWAQEs9r775hB+M/V+ZNnj
         itx8FhAy5Xau4aMG830Z/LKY3DQMdvyjWcxSvrfUk9Q42pjZ/Tmd1H2rzyyZF5a7jgxu
         BVyhMIqlkTfAy/CGs7cnyU4rK4bMFDQV3CX+YQLKJBoeZz+KWKUuVj3c6tO4aHXuq2CV
         VCP0wP6Ukg/HNke7oKEoyKz5Z1eAbqp4gEN/B8E0+N2A4G4+4c8lH0hXJsW+9IMQP/B/
         8idSu9/JVDYX2793pHTNAbxZ7bCuIk9Dw85xsE6D0TSJPhVr/tleEHAWoYM6TM/Gz0V4
         /8Yg==
X-Gm-Message-State: AOJu0YwGTU+cz2GbIOHVPFX5fyGM6t+OpjgAZ0XJP9h2Gy5e6cn77LZx
	yJSpYXrLy1AC1TYd1H73NTskpGlDaBSEfFvbtQWIE8S6Jn6jxrQ3n3aXTrAfmgqw2y1nocHaa1t
	2bkBmFOYWxCVVhNnzGh807CjQWK6MGnxKJZAweOYIQk3CaubCVMdrxJLonRsNOtw=
X-Gm-Gg: Acq92OGorIybXyNj7k6UfFKhWDQd9JbjtEm2JB1x3ZI1uhMtvpuKg3Kpt5LgFXj1ro+
	VhpsFlOJYPY1DEu0+FJWmMsnOWzvNGS7muY6f+UCgga8Yc9Gnh1Jwz60NRPQDMSHX2xy9+YRPL4
	KBTyri1+BJToIZ45nOuhzGktoeansKXcO7BVqnrzPg2DRQp+OjohOQfN0edguML/t70YYhhnLGZ
	At6rogeX3vlWW6lekBChJSoCwUl9OXH+3d5BHJVOudvUlXpbnuK/8eIarrn7qW6faqhEwU5JmR1
	gACiSxTswLUkrOAUuIcu4sNIDGcu1YE4I1HzVtSAO35MLaH4Xm9MCs1dW3DGpkIrctRaN+jqAN6
	mZjejqv2I6v+Eih/CzNoaFBfdq3cT4jiipiS21FAXZNj1Av7xxYeDecf2insJYz20aUUudB3Z5x
	CDrw==
X-Received: by 2002:a05:620a:258f:b0:8ed:dc5a:f668 with SMTP id af79cd13be357-911d00b7d27mr3703469185a.58.1779310242793;
        Wed, 20 May 2026 13:50:42 -0700 (PDT)
X-Received: by 2002:a05:620a:258f:b0:8ed:dc5a:f668 with SMTP id af79cd13be357-911d00b7d27mr3703462585a.58.1779310242221;
        Wed, 20 May 2026 13:50:42 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm2232692085a.37.2026.05.20.13.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:41 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 20 May 2026 16:49:01 -0400
Subject: [PATCH RFC 10/11] fs: move generic_file_read_iter() to
 fs/read_write.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-filemap-split-v1-10-c36ddc2b6cf2@columbia.edu>
References: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
In-Reply-To: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779310229; l=8508;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=sWXCb2voUNh/5RgXFZA32Pq1QXHhhJuRnYDZVKm8gu0=;
 b=c4SVT0/EKyeLALT++GoCtxlOHEW6EtdwGs6LfnqVwX3PEcOVGXnxyAlvuksJ5kGk//rUF733e
 +mKRneLOBHUCwxRiU2NqVzX9ZiVWHPnX8ZDbFnwJYl64fBDuIVt5eIF
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMyBTYWx0ZWRfX/P1KHoUN0mKA
 +vmmfUCkcxMu+jxMsmKLafoJeacnQo30wIglYfzg7zkPwXz1X12jH3iMyYr5eQuhNTgoOcoE6jo
 JDHFqHZNchgC7XSgRBAIQPDVBD6mTUP7HcGjggRJNFMGR6cX4Jz5ZJHmEefsNrLMc04U1WlN9e/
 SzS/ZU2Q6dIbxIWcftJwwGrpU2lV1bYZ0gRWo4HROe3rYhUvBOmG5a7rIMYtyl/O0e9FpkTK5Eh
 WuLOgfYjzo5jx3XWhskMq6uXRtu2upTGsAc46jTa3Kgk4tHzNMcrkHyYcsA2RGlYNanSPsQ2q+b
 5Il/S5ZT7lEGpI0OFTxu2LFv/Rs0kpFQhIqFfscAxXpL2NlnDtyCW4oXLBk4f0l4OugZ1EX3h60
 0IZGdnY8WeIOh+W9LzfCdexNeVQXVgOu+JwuXQN5Y2Uv1ckFs8SjvUaZoSzNsNg2PefOqed+EjB
 DtzLzTaMWo2SOKqtYZg==
X-Authority-Analysis: v=2.4 cv=TsDWQjXh c=1 sm=1 tr=0 ts=6a0e1ea3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=gH0tmTfNonLjgA-2hfQA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: GjMEMOXJ2gYcXH1iOyA65Dis0meH3YbL
X-Proofpoint-ORIG-GUID: GjMEMOXJ2gYcXH1iOyA65Dis0meH3YbL
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 suspectscore=0 phishscore=0 lowpriorityscore=10 adultscore=0
 spamscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200203

generic_file_read_iter() and its kiocb_write_and_wait() helper are
VFS-level read functions: Their callers are filesystems, and their job
is to glue direct I/O or the page cache (filemap_read) to a struct kiocb
and iov_iter caller.

Move both to fs/read_write.c, alongside vfs_iter_read. Drop the extern
from generic_file_read_iter()'s declaration and reflow the
generic_file_read_iter() definition to fit on one line too.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/read_write.c         | 82 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h      |  3 +-
 include/linux/pagemap.h |  1 -
 mm/filemap.c            | 82 -------------------------------------------------
 4 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 50bff7edc91f..59ceea85c163 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -989,6 +989,88 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 }
 EXPORT_SYMBOL(vfs_iter_write);
 
+int kiocb_write_and_wait(struct kiocb *iocb, size_t count)
+{
+	struct address_space *mapping = iocb->ki_filp->f_mapping;
+	loff_t pos = iocb->ki_pos;
+	loff_t end = pos + count - 1;
+
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (filemap_range_needs_writeback(mapping, pos, end))
+			return -EAGAIN;
+		return 0;
+	}
+
+	return filemap_write_and_wait_range(mapping, pos, end);
+}
+EXPORT_SYMBOL_GPL(kiocb_write_and_wait);
+
+/**
+ * generic_file_read_iter - generic filesystem read routine
+ * @iocb:	kernel I/O control block
+ * @iter:	destination for the data read
+ *
+ * This is the "read_iter()" routine for all filesystems
+ * that can use the page cache directly.
+ *
+ * The IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN shall
+ * be returned when no data can be read without waiting for I/O requests
+ * to complete; it doesn't prevent readahead.
+ *
+ * The IOCB_NOIO flag in iocb->ki_flags indicates that no new I/O
+ * requests shall be made for the read or for readahead.  When no data
+ * can be read, -EAGAIN shall be returned.  When readahead would be
+ * triggered, a partial, possibly empty read shall be returned.
+ *
+ * Return:
+ * * number of bytes copied, even for partial reads
+ * * negative error code (or 0 if IOCB_NOIO) if nothing was read
+ */
+ssize_t generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	size_t count = iov_iter_count(iter);
+	ssize_t retval = 0;
+
+	if (!count)
+		return 0; /* skip atime */
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		struct file *file = iocb->ki_filp;
+		struct address_space *mapping = file->f_mapping;
+		struct inode *inode = mapping->host;
+
+		retval = kiocb_write_and_wait(iocb, count);
+		if (retval < 0)
+			return retval;
+		file_accessed(file);
+
+		retval = mapping->a_ops->direct_IO(iocb, iter);
+		if (retval >= 0) {
+			iocb->ki_pos += retval;
+			count -= retval;
+		}
+		if (retval != -EIOCBQUEUED)
+			iov_iter_revert(iter, count - iov_iter_count(iter));
+
+		/*
+		 * Btrfs can have a short DIO read if we encounter
+		 * compressed extents, so if there was an error, or if
+		 * we've already read everything we wanted to, or if
+		 * there was a short read because we hit EOF, go ahead
+		 * and return.  Otherwise fallthrough to buffered io for
+		 * the rest of the read.  Buffered reads will not work for
+		 * DAX files, so don't bother trying.
+		 */
+		if (retval < 0 || !count || IS_DAX(inode))
+			return retval;
+		if (iocb->ki_pos >= i_size_read(inode))
+			return retval;
+	}
+
+	return filemap_read(iocb, iter, retval);
+}
+EXPORT_SYMBOL(generic_file_read_iter);
+
 static ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 			 unsigned long vlen, loff_t *pos, rwf_t flags)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 776cc82932a7..c0151ced8e7a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3055,7 +3055,8 @@ extern int generic_write_check_limits(struct file *file, loff_t pos,
 extern int generic_file_rw_checks(struct file *file_in, struct file *file_out);
 ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *to,
 		ssize_t already_read);
-extern ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
+ssize_t generic_file_read_iter(struct kiocb *, struct iov_iter *);
+int kiocb_write_and_wait(struct kiocb *iocb, size_t count);
 extern ssize_t __generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_write_iter(struct kiocb *, struct iov_iter *);
 extern ssize_t generic_file_direct_write(struct kiocb *, struct iov_iter *);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index f86a550ad516..46cefd552a51 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -59,7 +59,6 @@ int filemap_fdatawrite_range(struct address_space *mapping,
 		loff_t start, loff_t end);
 int filemap_check_errors(struct address_space *mapping);
 void __filemap_set_wb_err(struct address_space *mapping, int err);
-int kiocb_write_and_wait(struct kiocb *iocb, size_t count);
 
 static inline int filemap_write_and_wait(struct address_space *mapping)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index 079f9c3ac8a2..db7c53cd681b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2251,22 +2251,6 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 }
 EXPORT_SYMBOL_GPL(filemap_read);
 
-int kiocb_write_and_wait(struct kiocb *iocb, size_t count)
-{
-	struct address_space *mapping = iocb->ki_filp->f_mapping;
-	loff_t pos = iocb->ki_pos;
-	loff_t end = pos + count - 1;
-
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (filemap_range_needs_writeback(mapping, pos, end))
-			return -EAGAIN;
-		return 0;
-	}
-
-	return filemap_write_and_wait_range(mapping, pos, end);
-}
-EXPORT_SYMBOL_GPL(kiocb_write_and_wait);
-
 int filemap_invalidate_pages(struct address_space *mapping,
 			     loff_t pos, loff_t end, bool nowait)
 {
@@ -2302,72 +2286,6 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
 }
 EXPORT_SYMBOL_GPL(kiocb_invalidate_pages);
 
-/**
- * generic_file_read_iter - generic filesystem read routine
- * @iocb:	kernel I/O control block
- * @iter:	destination for the data read
- *
- * This is the "read_iter()" routine for all filesystems
- * that can use the page cache directly.
- *
- * The IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN shall
- * be returned when no data can be read without waiting for I/O requests
- * to complete; it doesn't prevent readahead.
- *
- * The IOCB_NOIO flag in iocb->ki_flags indicates that no new I/O
- * requests shall be made for the read or for readahead.  When no data
- * can be read, -EAGAIN shall be returned.  When readahead would be
- * triggered, a partial, possibly empty read shall be returned.
- *
- * Return:
- * * number of bytes copied, even for partial reads
- * * negative error code (or 0 if IOCB_NOIO) if nothing was read
- */
-ssize_t
-generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
-{
-	size_t count = iov_iter_count(iter);
-	ssize_t retval = 0;
-
-	if (!count)
-		return 0; /* skip atime */
-
-	if (iocb->ki_flags & IOCB_DIRECT) {
-		struct file *file = iocb->ki_filp;
-		struct address_space *mapping = file->f_mapping;
-		struct inode *inode = mapping->host;
-
-		retval = kiocb_write_and_wait(iocb, count);
-		if (retval < 0)
-			return retval;
-		file_accessed(file);
-
-		retval = mapping->a_ops->direct_IO(iocb, iter);
-		if (retval >= 0) {
-			iocb->ki_pos += retval;
-			count -= retval;
-		}
-		if (retval != -EIOCBQUEUED)
-			iov_iter_revert(iter, count - iov_iter_count(iter));
-
-		/*
-		 * Btrfs can have a short DIO read if we encounter
-		 * compressed extents, so if there was an error, or if
-		 * we've already read everything we wanted to, or if
-		 * there was a short read because we hit EOF, go ahead
-		 * and return.  Otherwise fallthrough to buffered io for
-		 * the rest of the read.  Buffered reads will not work for
-		 * DAX files, so don't bother trying.
-		 */
-		if (retval < 0 || !count || IS_DAX(inode))
-			return retval;
-		if (iocb->ki_pos >= i_size_read(inode))
-			return retval;
-	}
-
-	return filemap_read(iocb, iter, retval);
-}
-EXPORT_SYMBOL(generic_file_read_iter);
 
 /*
  * Splice subpages from a folio into a pipe.

-- 
2.39.5

