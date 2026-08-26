Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B44480DD5
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780525; cv=none; b=NzhZRegWm1cN83mJSH9UMnh/LGj4A8vqPkiJ2UH+wkumXqGQrZw77hjFOcXFbsuRQoiCasGp7/PA+kFiXknV2D9rUMv9bKRh/Hbo5K46WXBG8RHmVjEL/gIWa9FfjWxNn5a6MSsy5wftGeQ+UjN/i8bt/lLu80CaBYnPkdqif9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780525; c=relaxed/simple;
	bh=z2bpPA0zFqHTTfq+pC+oO6AhfjTtFERuFYEXNXt0CCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txpJ3wDYaVGkAUuzyirnz3ax9Op3ItH2iC9j5lmLa2RONQGPHNMAhQfUVfFAEY1l9Rke1C0ANSZjKXZRDUk5ZVfJNINHKAQsRvhibSUxd8Sph9FbVELtVE23PjpQxwmcAOWTW8Kyu9TdgeRzxxRP5QPM6xoZV+sIdrT9iFfuZiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+Qh0Tvs; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+Qh0Tvs"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1067836a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787780523; x=1788385323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHqs09P+vXI3i5WkDlwO+qGDsL/5qc/GgQNXxBzNt2o=;
        b=Y+Qh0Tvs9a+ktbE7hTYClLf/Mni4+irvkl05dkZBEfz1suzCBdMqyPMcRkdFBQMfkI
         rQNKpIs7fFidScWj/wW9zfezC+VGdQ5b20hIFBSHy2BiM3ZR0wXidLxgkKV+SGH/NXXD
         du8EJmXqF8qrPnvE4sekASP5urEkFywqhAbzVSg6w4tThKecYYgVpNtzApWtI5iqPfDI
         Sv11ysTr7nlV9S1mBC2RDIFQMULED76omDbcopsomZWd2bwMXEDyeBmD6vJruNun1isY
         f8X1QWWdXLSDwgYR9PtyAk7NT7L3/Uy6PkDFI/ty2gwTA/U934ftL4ZJ0KlZdqt182Ig
         +TJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780523; x=1788385323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHqs09P+vXI3i5WkDlwO+qGDsL/5qc/GgQNXxBzNt2o=;
        b=Bu9h1vRV52kms+6YibrC6MIA4kHaXqMXluCPDsmBd+lVlXZ+Fdf5w7PTxwlNYD0U54
         vUVc+y9i2WY5CHo8HAdmn3j/SdNk2dvlquRbtiC8AnqKy4pngoLHQdAR6RDh7tspjtAr
         f1PhmEIdlQ8JMaRNui9v2nyDKrA70Z7Ki008K6aGH6yPHk9B2Tyk0Z3F5cxiq9VvAVci
         PMr3JjoaqUOR7mfEQbH4A5rJLknx2NNv2wjMqBx5vjOmaRRZtexXuwW716+Rwy33z7XV
         XDi5RN7Gxwp77XZukTPWQUPS4ew+Jqh8bBY2OS8OJtj/lYt5s30CDK7PH1Y0nilq8kCF
         H8yA==
X-Gm-Message-State: AFuF++nqFXzADIWaaguBDpAhiYIX5jW0Ie/tKpa4CKtq16hHLFDrlkHr
	Wf1P7V+B0f87YuiUZ11SCctmPVqeSUUWF1Xap0mzDVjitusanSkkV7/omzDxsaC4
X-Gm-Gg: AR+sD11HZJt/bLEOHsPJHmi8WZfZHimN3nWGNqXtTiKczBAUlIc0RhE0I/CzpjxFxEB
	8uPtm4hnu/fhQMN/WAVueysR3vSJBEFhNZCuVeYkalQf78765PIuTGio8i9fE16cTcxINh1BtHr
	Td/LFTq/evqMNUgUyJToJ0hAKPx9PCsycmfjHG9bgoFwc6MoxoLn6tHZ+wOKM+NkYUNRYXLfp0v
	1V6utMmjAQ+JGkHstTALIAQf8JJPPTVc4I2L1iNzQ/nNL53wEkT8vjwbMVnaK6EoLkB1SoPgT6b
	RnxOKIcpu35qwQIXIfD7lPrJp4LHSU2YB8xwF8T5E0f1bWP59t8hKrICXb3sPkwJoNw5wUKNtM6
	ZW4HnGRqepkGuPuEBY8CCjs8dnctSlS9JLOED6G/QdWDHQNvZq/104VIW94tmyxGBb6cGgjafRi
	ku95nmabQ53B6YWvg26zUm5BZTCMFErHYVKHUq
X-Received: by 2002:a17:90b:4e8f:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3966d4032e5mr22602354a91.9.1787780522963;
        Wed, 26 Aug 2026 14:42:02 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396689f1419sm5628673a91.9.2026.08.26.14.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 14:42:02 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	viro@zeniv.linux.org.uk,
	hch@infradead.org,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH v4 1/3] iomap: add iomap_symlink_write
Date: Wed, 26 Aug 2026 14:41:55 -0700
Message-ID: <348ed49a8aa85c6c23c21034c8598401e9938e3d.1787770110.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787770110.git.jbingham@gmail.com>
References: <cover.1787770110.git.jbingham@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new iomap_symlink_write function as an iomap based equivalent to
page_symlink found in fs/namei.c. Part of being that equivalency is
behaving similarly to page_symlink. This function now expects the same
len as page_symlink, where len is the length of the null terminated
target string. The target is still written out without the trailing
null.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Suggested-by: Christoph Hellwig <hch@infradead.org>

Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
---
 fs/iomap/buffered-io.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/iomap.h  |  3 +++
 2 files changed, 37 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0a5ebfda90f1..5e8ac3fad671 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -2100,3 +2100,37 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 	return error;
 }
 EXPORT_SYMBOL_GPL(iomap_writepages);
+
+int iomap_symlink_write(struct inode *inode, const char *target, int len,
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private)
+{
+	struct kvec vec = {
+		.iov_base	= (void *)target,
+		.iov_len	= len - 1,
+	};
+	struct iomap_iter iter = {
+		.inode		= inode,
+		.pos		= 0,
+		.len		= len - 1,
+		.flags		= IOMAP_WRITE,
+		.private	= private,
+	};
+	struct iov_iter iov;
+	int ret;
+
+	iov_iter_kvec(&iov, ITER_SOURCE, &vec, 1, len - 1);
+
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.status = iomap_write_iter(&iter, &iov, write_ops);
+
+	if (ret < 0)
+		return ret;
+
+	if (unlikely(iter.pos == 0))
+		return -EIO;
+
+	mark_inode_dirty(inode);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(iomap_symlink_write);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8c754eb974fb..ab27a3a5b8d2 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -471,6 +471,9 @@ loff_t iomap_seek_data(struct inode *inode, loff_t offset,
 		const struct iomap_ops *ops);
 sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 		const struct iomap_ops *ops);
+int iomap_symlink_write(struct inode *inode, const char *target, int len,
+		const struct iomap_ops *ops,
+		const struct iomap_write_ops *write_ops, void *private);
 
 /*
  * Flags for iomap_ioend->io_flags.
-- 
2.47.3

