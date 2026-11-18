Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962941;
	b=gRmFZSSMt9yV/x5Q9J4G55x/XfRxtY3/76g3/YtiyLF3X1Y/N9DHXhs9qzYeK0eXtZTo
	 kmfGC8MZuzCwW6lQmjtV3a0T/SjdLT7gMRVrkdZpShvtwAug+VfVPnHXmCo+QM+uXnknI
	 z0KNMV0eIIM34eFkhUo16L6TYqcVQJJc4iEL/WPwAuehOUj1z1Z/Pvxp+DwcPgL02LabE
	 7Xrv1msNNlqI7ZPli53ts0Nsttie6qFmyNbapsifBvMxRjPHwpQvG6vIT+lZ5vC9aWuYW
	 xeY6NAPchAAn2s2sD9spNKMcqNkEg5wonlJhZzMl2SG6ioCvmIuCSdww4EeSaMV9r3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JT5GitO9guQMxmpDsN7N3JTT9ZwlLUCA63pj7Wlo4Ow=;
	b=0clObnr4xGHP9Ha25WNEkOwS22oDDLKcdXjy4hhgzS1yXar+PCvK5Ngee+6rkvPJJs6H
	 KJb+FpC68pMioTMQQSFz8w+SI2rizy+YAdc9O02wo0PyQ6jqSEWYgGfDOkc/8Bg850Umh
	 7uKCMWEkHiBUVxZGwiPI98ZfYYFKPZJNx9bZ2eI7rUxyKlX+3i3C2F/8KzgLiRUcW/Ca0
	 Sp8C/YTszOp6k/QH4BdxmIaoJ9bVvhnJqmW/jMTPnk6teiLuHe0U4OP5lM1rPI/Rl40LQ
	 jRz+avTvPj/JNRTm3OOQ1/OYMg/17sXPc1yXMyofbEgaCb1/vFKUJfz7I9j/z2hbIkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gsVY7QIi;
	arc=none smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B181606A88E
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 00:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B181606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gsVY7QIi
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-67c24619b19so268331d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 16:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794962937; x=1795567737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JT5GitO9guQMxmpDsN7N3JTT9ZwlLUCA63pj7Wlo4Ow=;
        b=gsVY7QIiaHuhXw9hDeLuIoiMd7+78YSHKcBI9sh7vklFBT18aPuLoJ/EvDFS5jWINs
         A8A+MhYvjG5S5diQqSdSqdaPIkk5E6Dgqm3AFJ++EZdT0hD/zxy7599MQIFvC9ljaMBv
         bc+x/vl1OKmKcsPcR15R+h9UaLmVgYRvE8285uSTgRJCrD1TJDlZCZQM+r4YG2t//5L7
         JJ3H7a5uK7cr2zKAhn97lL6DVH/mXjcVgHNiDZzUPSO4iijb02o2X/d/fBRNOxAc7sIw
         C4vQVo3ArK8dsDolaUO4laRWjoBDohTdoiBtEEeul4wFrboxl8AGWUj5m2Ng7jzslNRT
         5McQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794962937; x=1795567737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JT5GitO9guQMxmpDsN7N3JTT9ZwlLUCA63pj7Wlo4Ow=;
        b=RXRQuBtMm0Wsc+8mGMYNV5lacBDleS8n5A+NrXgHqPA5fY8sN9lRCfhIblPrSbGv2G
         9ZXvR3khcI7Kf5V6M2t2FApSei37wCPgNiOOkSaOOydNDIyZMKyox78YDEAYe65TBC4n
         RNQcu+dQXSJqdYSoVLEKKh+7c2oolrX8uwRQBl8X+91/1XfMoEP1DU8RawzxqghWSZAQ
         D7qT+R2wzbsIEodZT8nRFX20A6Un7hzZDLvhQnvl/6Thd9ut77nmkXa3ZYnpBL38AW1O
         XU8pOakE7kyCsTKK+g6ZcrjExvT3c03s4dTIVP/4ONqPu9XVM5cXi6iyZKhvCihtjGJm
         50/A==
X-Gm-Message-State: APuU4Z/3aXzxolNscnsvwf4BoVRC1tMkfYAdvoY+Uu3tB2bL4u5n8V+E
	oYn3qXDk/p0vfBZOiOsXeD+N1wNRkYtA8idMefeUmOr2gDM1m59g1h3XjpGLID4TVL0=
X-Gm-Gg: AZFdTZe8xeMPItX0q8nkG7I+3wXO6q0v3tz9e56DyTEgFW1u3CZGy8wgi1HfUhJ1w43
	A9nNqLCeD8tJeiLp8HmmDokUDpr1/bzGpsKLFoAKbLCAI/HkJTx2tLUhffk6z2NOkCsxqSSZjfA
	gyy8rxVcQ2bw/iYAStgpTsUNTlTVS2XdXPhwpoB+NTyrX7DYuEatb1HLCdZiDTad20Il1TYmPCL
	x5OQqC9gQQGOoS3jmcCfyPQWtpEKH4gjD/gNAa/XFhNVD0rTkUvub7ENN9JUMCyI59ye/BAP5gb
	ekw+KAKuDRetyChcED211jFtkovTJ9LfRv6YDWHNL4AzPXvsly583oNRGCTXkVfPgej3g/JUYL1
	gjQxUQojyamFRqg6aO+uq6rxkmhiQzj7VW/pAGivmzstLBdFO+fZlKaSHzoGk+5juSwHwOXIt6c
	YwXgMx6DHSNKlaJ0Xm5Xx7frYbPetJ9DNpxGPg6WdXlBGZixoiQuU6/gVdpwM146Jjvrg3uaPLw
	XDrpj8AtWx95JbvU3O5awd8H5nTZCLPK6YEDYAqkipk/+RsK0MbSwN7fSp2uO5nZjSXkUs4t3b/
	7RfVvzlh+SPU7Q2h83jORm8qQ68q418YUIb8wFh+BZP3TkuBuEXOrvxa86nD1bMMMb3iGU4ardQ
	2cNDNw2Si1QehKjudeRyhh7Z0CqUIZaa3nlxn5Gk9XU3SoI5K9cnwJao8iJanL/g10BVXzuE=
X-Received: by 2002:a05:690e:1348:b0:67d:bb89:acd8 with SMTP id 956f58d0204a3-67dd459e236mr521095d50.76.1794962937364;
        Tue, 17 Nov 2026 16:48:57 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:5fae:4d02:7055:94ad])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd56ead87sm729575d50.1.2026.11.17.16.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:48:56 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v5 1/5] iomap: add iomap_dio_end_io() helper
Date: Tue, 17 Nov 2026 16:48:40 -0800
Message-ID: <20261118004844.3849979-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118004844.3849979-1-slava@dubeyko.com>
References: <20261118004844.3849979-1-slava@dubeyko.com>
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

Several file systems implement an almost identical ->end_io callback
for direct writes: if the write succeeded and went beyond the current
end-of-file, update i_size and mark the inode dirty (for example,
ext2_dio_write_end_io()). Add a generic iomap_dio_end_io() helper for
this case, so that file systems don't need to open-code it.

The helper updates i_size without any locking, so it can be used only
by file systems that issue all direct writes extending i_size
synchronously (IOMAP_DIO_FORCE_WAIT) under inode_lock.

The first user will be HFS+.

cc: Christian Brauner <brauner@kernel.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Darrick J. Wong <djwong@kernel.org>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 include/linux/iomap.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 5254430844b2..616abe7ebad9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -672,6 +672,26 @@ struct iomap_dio_ops {
 	struct bio_set *bio_set;
 };
 
+/*
+ * Direct I/O completion handler
+ */
+static inline
+int iomap_dio_end_io(struct kiocb *iocb, ssize_t size,
+		     int error, unsigned int flags)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (error)
+		return error;
+
+	if (size && i_size_read(inode) < iocb->ki_pos + size) {
+		i_size_write(inode, iocb->ki_pos + size);
+		mark_inode_dirty(inode);
+	}
+
+	return 0;
+}
+
 /*
  * Wait for the I/O to complete in iomap_dio_rw even if the kiocb is not
  * synchronous.
-- 
2.53.0

