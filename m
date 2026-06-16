Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4337C0FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574270; cv=none; b=L1E5f4x6F5vuNMz8lR19F7U59Z4L1GgbhDG555+CM7ClfXSTViqmrBbwzx5BjYdZoONbOlvuRKqLkcMS8Ys+gUXVFEXkGQv2jJ+qvbCgnbY3bP3apCNx6S7y0jAJS11JjARlDd6THBhLhKMB+BcnPFEd/X6J/uAfDA8VDcgZszM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574270; c=relaxed/simple;
	bh=9rYPaGYsOYUIgGN1Dln2YFc3H/t6q4g3GdGVslp0cVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7NKhiJYOqdylQKfOuScg+NBA8uBGpBcP1B/rfkteREdXj8ndgmdEKRbfzLOMYY/B87IzeLFKWxaG0u5YZafvao10jknlayy2SNaagIZOP/8nw8kl4yKJgboMyr7i7Xxi9PRoznM141puYK3xRDHf0wb7PzxzqFI25tn2j8/o4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgQV9ayV; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgQV9ayV"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69e8aa31e9fso1848905eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 18:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781574268; x=1782179068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=106sFJEsXiYesLx4tGkbN/uNTqLMyOGAl2xASJCN0Xk=;
        b=GgQV9ayVYgF6oVVi2yPYs3/Ntp07rHfU2SeM0bxOnWamOtZqDV2rTcsUDxdp0AA+ti
         mLlWbew5KeRfwmjABYClxuVJL2nS4UW/5Ja8yIpSFK/zxGrhgcOCmoobpus3ziQHLZ5h
         mXobuRa57Qhds5MlcOx/rup1cWTCz6D5Kg8G2X2JigwwmosdYhlgV+wNWzq9/+jg6K0v
         AlO3Xmg4vvzcv0Yi+vsuiYUZGokNJdJjXsjLD8T9YNRgWa3jsTt0FH2jGWmcpKiJuDZ+
         1zDQ+LukgcLGjSvYFJsgtXn54Lc7bsUWoLoCXmNKbuGtNG8BFtw+hLlZEvvpnW2fPzET
         Dwpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781574268; x=1782179068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=106sFJEsXiYesLx4tGkbN/uNTqLMyOGAl2xASJCN0Xk=;
        b=f2kEs/zC+2WeUgCyT/ht6gh7h8DUh2UdfbMkAEXUrUz4YeOsxYosTDpHTOvkPBOc0v
         r840I6HHbSIFHUD0ZE4xDn8XqnBvL3aQXosBWF7xxcTClzrhXBejaAapM5kqTbfSKeGw
         C4EIUnIDNNf8+QeBueTkfP8SVtEm/dSUVY9PDK+hcurGOj4rkqHiTkbsdPO2XmCuIji8
         uuohUDmTczP45mz+HgDFTPapqWoOHPfM6ry6Wwd1g08PcVivdhiZwBiuoKWwBCfidPTy
         KI+hlI4V7jlrvpOoT6TDwgHTmBTa9DDHQBFIIUh5OrS/hzrzUIz/udVqBJ2iYZ5BbR87
         EfMw==
X-Forwarded-Encrypted: i=1; AFNElJ8hVViQ6zniUFX6Fl80DumTUaqYnttM8+y54rQ+H0Ybu0vd8RJXk5xbZGAzavPvMh3Vt62ypn1J/QBuYqz5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7H3oWo5aonOQdzu2Y4p6Hf/AKLBPMSYxiLb5OECw4CZmTtypt
	GDfL2wxOENaPMefO4DKRtFwKZsbAUl7hFPd7WdZlRHbr5Ycpnj3A94m7
X-Gm-Gg: Acq92OElfvc8gub82uf5hcNmAQtNen0Bx1KEyd06XmSMx1Wk2gt4KKtUmt27V33YirO
	z7UdEOCe6C8bkVu12l2l9bOaXU4eLTf1NZeacqE6W7lUg2R/MQrA8ta9kvnxGRzvxrRmbPI+2ia
	z3MfB9fBSA8o65zupnUiZMmx9WMqNn+l0hwpmOoukPdXPTkTF4o74vvBLsuP8vZh/YwU1chgNvW
	p8u+2Y0W1ncuDsiSdUw78hAsozl1puiAGP5mv0GuZYRLcRt7f+keyhY2fmanLD7Rmqt4fot6XrM
	nUQwlKau1vou0EF/kAQW0oLnB+e2Xl8/PhvIydQPQ33tiTWYHmhblmMuoa34TNXwTXAPVv9L3A7
	AunzaDkQVZ8kZwNzm9YbN3ccG97znLtXholCCZmT3Bar5DMoNQfYqXmFn6/toyamZI6S8H3OiWe
	NsgzsbHFyY+Cy2RvvnvNrDCFh4+ASNbb+mHe20sWhfApFZqdbjEgOZqojVDtx4IV4BtIrCC3g0E
	ZECIAp44IwoN0x343E40Y29zlB79MNsY3WBYyTKksEehM0Mr4heoG/EBzKpzwsrlg==
X-Received: by 2002:a05:6820:1a06:b0:69e:41d8:f7e6 with SMTP id 006d021491bc7-69edc620781mr10181870eaf.13.1781574267764;
        Mon, 15 Jun 2026 18:44:27 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00b41ed1sm4093011eaf.0.2026.06.15.18.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 18:44:27 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amir73il@gmail.com,
	Russ Fellows <rfellows@xlrait.dev>
Subject: [PATCH v2 2/2] fuse: allow parallel direct writes in passthrough write_iter
Date: Tue, 16 Jun 2026 01:44:19 +0000
Message-ID: <20260616014419.7913-3-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260616014419.7913-1-russ.fellows@gmail.com>
References: <20260529031918.7361-1-russ.fellows@gmail.com>
 <20260616014419.7913-1-russ.fellows@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Russ Fellows <rfellows@xlrait.dev>

fuse_passthrough_write_iter() currently relies on the generic fuse_dio_lock() path to decide whether writes may run under a shared inode lock. That couples passthrough to the regular direct-IO helpers and does not make the passthrough-specific safety conditions explicit.

Keep the decision local to passthrough.c instead. Allow shared inode locking only when all of the following are true:

- the open carries FOPEN_PARALLEL_DIRECT_WRITES
- the write is direct I/O
- the write is not append
- the write does not extend past EOF

Buffered writes, append writes, and EOF-extending writes remain serialized under the exclusive inode lock.

This preserves the parallel direct-write win for safe overwrite I/O without exporting extra helper APIs from file.c.

Signed-off-by: Russ Fellows <rfellows@xlrait.dev>
---
 fs/fuse/passthrough.c | 46 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index ee822a983..c32b35a6d 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -25,6 +25,38 @@ static void fuse_passthrough_end_write(struct kiocb *iocb, ssize_t ret)
	fuse_write_update_attr(inode, iocb->ki_pos, ret);
 }
 
+static bool fuse_passthrough_io_past_eof(struct kiocb *iocb,
+					 struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
+}
+
+static bool fuse_passthrough_write_exclusive(struct kiocb *iocb,
+					     struct iov_iter *iter)
+{
+	struct file *file = iocb->ki_filp;
+	struct fuse_file *ff = file->private_data;
+
+	if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
+		return true;
+
+	/*
+	 * Passthrough writes do not use the regular FUSE direct-IO iomode path.
+	 * Allow shared locking only for direct overwrite I/O; buffered writes,
+	 * append writes, and writes that may extend EOF remain serialized.
+	 */
+	if (!(iocb->ki_flags & IOCB_DIRECT))
+		return true;
+	if (iocb->ki_flags & IOCB_APPEND)
+		return true;
+	if (fuse_passthrough_io_past_eof(iocb, iter))
+		return true;
+
+	return false;
+}
+
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
	struct file *file = iocb->ki_filp;
@@ -54,6 +86,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
				    struct iov_iter *iter)
 {
	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
	struct fuse_file *ff = file->private_data;
	struct file *backing_file = fuse_file_passthrough(ff);
	size_t count = iov_iter_count(iter);
@@ -70,10 +103,19 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
	if (!count)
		return 0;
 
-	fuse_dio_lock(iocb, iter, &exclusive);
+	exclusive = fuse_passthrough_write_exclusive(iocb, iter);
+	if (exclusive)
+		inode_lock(inode);
+	else
+		inode_lock_shared(inode);
+
	ret = backing_file_write_iter(backing_file, iter, iocb, iocb->ki_flags,
				     &ctx);
-	fuse_dio_unlock(iocb, exclusive);
+
+	if (exclusive)
+		inode_unlock(inode);
+	else
+		inode_unlock_shared(inode);
 
	return ret;
 }
-- 
2.51.0
