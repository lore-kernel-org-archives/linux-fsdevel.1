Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751557;
	b=J8IlUXtDvGyYXFhDf4MwtwNGYZVnOFN6h/AgZG0XlHY1DFWgw65FGqbToY6PZuZpGu1G
	 WZZtMZ3z3WEIeoV0oeL7jOjdIqhV+xPDbCgJocC7gwpHcc0fntI6mBpaJNwpdrTrdmScx
	 JF/M3iviT1pexCcO/iReJrqi1p/ORtE04valVbnX2dUuIpbk/vhsyEStQbQsdsNA/wVk5
	 k1hH6ZXLiLfrFHCnf9LyRNlQsTcRUM/0rm+t7GH2V9Wf1Rgj8z+ta8bkCNmUi1dbdx6Xd
	 BnUqkkRlOtHZMEGEbrnuu/3RaopOV7lU/dXUjGuqQAuHTxawoEHGJjvRBRMG49bAu1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hxI6oNEf2EvFWjGeDFQYrrcpmAnzoeBTieQsEmlXNt0=;
	b=scMMSklzhOd94OV2tpO9vxMZXxfy4G6Yf8/5VVVou9DgBrYWKJ/bUA845IrpSSsMEkub
	 3UfPO3YtZgsXKUGKS/3uVYoh9fi65Q/qRg+W7zq8B4ix9DjrMKOoRCh1UceLGTGs56QdM
	 L1ftyhwBNcz/7cBdK5DXoRnrRU82QMfxWfOANhuK9z5MBi12Xco13ihk5S/mj/nYd8VYu
	 42rB4bbmXHwwAFXfV5lwLr6XWCfN1zaqLnu91tBZDPqI+QQpPFG94+VnDr9hlkdfz0+zR
	 bFcnoBE04llKGTosv9h3kg/SM6wVGko6ACg+epJxe4EFaDH6J4SZoo8D92LCYdE4bPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tRuoCViD;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3BA606A328
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 00:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB3BA606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tRuoCViD
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso106025f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 16:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751555; x=1794356355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hxI6oNEf2EvFWjGeDFQYrrcpmAnzoeBTieQsEmlXNt0=;
        b=tRuoCViDiz1iXYAGfLXl4R7y+RpayZrjfUA/EIamwmY7fg2tTWVGnvqmEJ6GzuXb0n
         L9q8v7usrCBqH5nyZDGX3z5SVn8+UF5iEWXHYkpiDZZkH6OMnjwQ1ejQfNwV7dFEy5jR
         DSP46baP6aBJKObk8ZJZHOyfFAhX8L5VsVcCNcqNk/mFdWI5qCvSP6bBvypVKaDv4xi/
         8c6dTf5zVxiHwLo6vGHS2EpUHkAVNBNV783B22uCwCuIUaqIQOFbFClcmBQ+gvX4CByQ
         U8Cb/QdTzUTQVtsrQ+rA+9i1ftqGQQFxCenLkBm5DlCh+HED1O+6CcYoZVfCg0pv/4IE
         DN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751555; x=1794356355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hxI6oNEf2EvFWjGeDFQYrrcpmAnzoeBTieQsEmlXNt0=;
        b=wN28OakaWjY1JSv0/r/HF4CnLvopNIp+wfleNKr6Ft+uelX9SQfs+kV9jlkJSDVEsi
         yRjMD5ojVnWBmMxovUU85nrAfCmP2HfKPO7qsHRBNx2RtBgNlEZBTSxbXcsivQ/gFv+L
         QhLAerQTJd3STlxYWYrZhVNilYzmT0f8UqfofifRpJAXtgB1jy3m6Hn+GZorqJu7sIBi
         HbB8Wx27rN9HJBpRyV6L4GuYAceVuJKpszgPvl4w05OSYQcdHTorkkTTHJ1hsuZ3GlML
         IK0Rb8F/yuXR+c0YfE9C8Z/p2VpFyQqXQzwRWOoy9F0tzW5obxTsq59ky9yGxtRjtzNp
         3wwg==
X-Forwarded-Encrypted: i=1; AKwUvBxaceBAFvqzE2QpfBjdaN2EtWNVXlVduuDEcMUWccnVJgdYgAjjsFWd3UhcpO86Op/AwWjZd/l4hq3mWJfs@vger.kernel.org
X-Gm-Message-State: APuU4Z/JwRkSLpOqcia0ZxGU1A/VW2endf7LUWklsP/MJV8Jbuq2goD2
	gawBsd31pVCfNiUKCNv1/Rt8+DJKnC5kmmVAwBb6fFfh7vRGyiG+tzDA
X-Gm-Gg: AYBFou2VBX55VYgWO7KlNI+X4EJBfMmT0Sr7vCsaqoe1DnFApdjtzHl0XSlE//a9kwq
	jazFzUe0spMw82aNdTDdNO+5DugN82ArYpC3d+4pRdYnYe7vnsl+F95MFS0vuD0V6JRLPN8LiJ1
	yyJiod46HUXCfCqSpVxdyv7oM6HXH7eQuCc+CyxNqbYWfoaVFXbOWOVy8WjJzZpmA0GHmS6g1MO
	F+mg4/uN78Lu+xCyZsI9BWtdFCk9HLSizaJz5F+JnbG47E6c+qfh51RPKAJZc5kxwgFPDshYoo2
	YkpuYTYzdJjNeUlL4S6c5dKsD4aYqVItVXF/ZH1lAL9WpJXS5T0upCT74ZEBLO5EzLxZ6Gp0Zx7
	QRCCi+Fg2bO1d5WnIcKIErkmbkhVn2RWvchQzcZ2Mselp4USaKjgo00bu4ya+oWv90IL2ypHZYi
	Q/nrdH5Xff15HxVvGWg+sTVx3bcil+TA59NrnRvgae95ycU0GL2VeN21cSskRuk6nNjsbHoCRdo
	sjmJtZaW3oMmY4RGfJRZ+41M9Fw4KkwmP3HN+14iyF3vVWKtGAwHBQxcNhxUjmdvDLWxLnRfz0K
	XunFjXwkQJXkIlsob/KhylbVG21fN+/hZc1QuuYZunhqh6KVPQxbXDo9/Ct4ucY4dluF6sqnblg
	Zk59pHYBHmMJshY+AaJ1Xu/CzT/oU2M0=
X-Received: by 2002:a05:6000:4027:b0:48d:fbdd:4132 with SMTP id ffacd0b85a97d-48e6e4f540bmr31194343f8f.18.1793751555202;
        Tue, 03 Nov 2026 16:19:15 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:13 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 1/5] dma-buf-io: add tags for sharing ctx b/w files
Date: Wed,  4 Nov 2026 00:18:57 +0000
Message-ID: <9fc301319428c6c47fa183ff90d60abcca8ea63b.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it's only allowed to pass a ctx to the file it was registered
with, which is enforced on the io_uring side. Going forward we want to
support filesystems and not just block device files, and it'd be too
limiting.

Add a dma-buf-io tag to all files. We're going to save a tag of the file
passed during registration and later use to reject files which tags
don't match. A tag should be set for a file by the importer subsystem
implementing ->init_dma_buf_io_ctx on creation and should be unique for
this instance of the subsystem. For simplicity, we're going to use
pointers for which we're going to use pointers, e.g. gendisk for block
files and superblock for filesystems.

This patch adds a new field in struct file to keep a tag, but it can be
then be switched to a new f_op method.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/dma-buf/dma-buf-io.c |  3 +++
 include/linux/dma-buf-io.h   | 22 ++++++++++++++++++++++
 include/linux/fs.h           |  6 ++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/dma-buf/dma-buf-io.c b/drivers/dma-buf/dma-buf-io.c
index 8440151de860..60dc58fc0c23 100644
--- a/drivers/dma-buf/dma-buf-io.c
+++ b/drivers/dma-buf/dma-buf-io.c
@@ -166,12 +166,15 @@ int dma_buf_io_ctx_create(struct file *file,
 
 	if (!file->f_op->init_dma_buf_io_ctx)
 		return -EOPNOTSUPP;
+	if (WARN_ON(!file->f_dma_io_tag))
+		return -EFAULT;
 
 	ctx = kzalloc_obj(*ctx);
 	if (!ctx)
 		return -ENOMEM;
 	ctx->dir = dir;
 	ctx->dmabuf = dmabuf;
+	ctx->importer_tag = file->f_dma_io_tag;
 	get_dma_buf(dmabuf);
 
 	ret = file->f_op->init_dma_buf_io_ctx(file, ctx);
diff --git a/include/linux/dma-buf-io.h b/include/linux/dma-buf-io.h
index d9f27650a851..299edf0baaf3 100644
--- a/include/linux/dma-buf-io.h
+++ b/include/linux/dma-buf-io.h
@@ -48,10 +48,32 @@ struct dma_buf_io_ctx {
 	enum dma_data_direction			dir;
 	bool					is_dead;
 
+	/*
+	 * Tags represent an instance of the subsystem the dma-buf I/O
+	 * context is bound to, the set of underlying devices and subsystem
+	 * specific map / context structure representations. Remember the
+	 * registration file's tag (see struct file::f_dma_io_tag) and use
+	 * it to filter out files that don't share it.
+	 */
+	unsigned long				importer_tag;
+
 	void					*dev_priv;
 	const struct dma_buf_io_ops		*dev_ops;
 };
 
+/**
+ * dma_buf_io_file_compatible - Check compatibility b/w context and file.
+ * @ctx:	[in]	dma-buf I/O context
+ * @file:	[in]	file
+ *
+ * Returns true if the context can be used to issue I/O to the given file.
+ */
+static inline bool dma_buf_io_file_compatible(const struct dma_buf_io_ctx *ctx,
+					      const struct file *file)
+{
+	return file->f_dma_io_tag == ctx->importer_tag;
+}
+
 int dma_buf_io_ctx_create(struct file *file,
 			   struct dma_buf *dmabuf,
 			   enum dma_data_direction dir,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 99caef43ff3c..a9bb63cf6f9d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1293,6 +1293,12 @@ struct file {
 		freeptr_t		f_freeptr;
 	};
 	file_ref_t			f_ref;
+
+	/*
+	 * A tag representing the underlying subsystem for dma-buf I/O.
+	 * See struct dma_buf_io_ctx::importer_tag.
+	 */
+	unsigned long			f_dma_io_tag;
 	/* --- cacheline 3 boundary (192 bytes) --- */
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
-- 
2.54.0

