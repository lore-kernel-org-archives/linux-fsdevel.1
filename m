Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE82D8796
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581370; cv=none; b=m4BxzrfBAkMajKc8luNl2FZlUdi2uuZTuLlbV8Bt5Va7yGVy0wfMD5h8sg9vEjxNw5KJ+RI7z8osN7tAlqxf8FTtpXzepj5W/GQKsQgsZOb9gkuM3MMUbMJd90DqeNDDfh+uDsfZiBfCSW7sjCt3sbAAn8fe466tc9rrcKAcpVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581370; c=relaxed/simple;
	bh=e0GAJAnBjGzThtOiUviYXDjQ1mnIG7TOtV/MtJSQ/gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIR19TxymR10UUJgr9TrKYX78CmTu++vUF4j2S1Y4plIGs4tbmjAGNNPYLIMa9V//ZsvaEXLpciUeTroL5oGIY6woHwalVoHH1DI26ecRrt/WWNyAlSfgDAVfnSoaY99XMyVo0wzk7w5gC8kcO6Y8tQuHegyoHs1yRzNacRb+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE0m0N4u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE0m0N4u"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cae1a3a744so80121275ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784581369; x=1785186169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TMJTdhWX+xJw/YlzhsGS6pZPGRXv6mQ0Lril2VkwCgM=;
        b=fE0m0N4uyXF+G6/L5gsqBkGpFrQi4StizatdScid7jK0eCLT1noTLV5CN6X0JzKacA
         bqG8nanlBVHGzyhaXFA7xXD4Hitj5hXuy4K7S2EuuIDkMrb8ILE2kmGyBt9VXijgWwm7
         bQnfNWyok0blt1yFNbIF8IfPhHGATo8lMmNmtDWZQFE9P/qsqxi48bVBKUhhR9lciy3B
         wdH7e4GERrxdll5FQECCmNa/MqudSI4OYiTLk+eXNJ662lGH7e8tQw8fPYGfE7HSOjD8
         eSyjxKv/9Ruk7KvHF94A7PI2J41icRMkMhy6iSi4QscK8s/BOE7JQYRGiu/Oe9sdNfU7
         btOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784581369; x=1785186169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TMJTdhWX+xJw/YlzhsGS6pZPGRXv6mQ0Lril2VkwCgM=;
        b=EqyHS7eYryoOjkU4DBXw4Vn/eSBoHwkNBdkAtImXX1DEBxxBgxCpZik1FqCqrFKz6l
         LF5pengVDNO/XxZOOr2EAHUcJaqcBRM84DRoVh39hk9UJcIWG0dbudd1xB0FtOf3zrEO
         ENuXC6eBtwq69Oz7XjJgZCOeMNUiMFZuQKo4rXJxDxBFBIDcl4L0kKXP5bad5RQJbV1z
         7i3pYIsmOyrm+zIzhkJLTFUiTQqAqDmmulFUokv1+mKN3coSVpzs4JtCvyuScytPwj2o
         fuJk3JmHZfe+kGArT4aGTjLyBrwwl1dF+V4l8PDs3Yu9HBNTrDu7/pLL5Jc2+T5aJx+b
         T+pg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0uXDOPGJsgwmwJxQFd7hmqHEoWAhA0hx+wZoOeRDg3AnHhW0qNxS5Z860ZWKRNWfxp+Y0fAtgkGHSkSrH@vger.kernel.org
X-Gm-Message-State: AOJu0YzISiJhAeAX7z9FSQZq1HsMhFuFozbyAoiz7q1IwsOmElfuRufM
	Lb08h9e5NmKl+0cgdJKDoNfVMde/GGp/pC2W60E7EjUttGyFqnBWnbtZ
X-Gm-Gg: AR+sD11OP/9it8e8XX0LXFnnxnuSMg2hno8lmiQqpucAUP/reAKXnmuQZxRpW7Ix8sv
	BOOWKDnjCxwrnrYWeV5gfzd/M0lQ9o+XqE2cThRMuFPsoYBgIrzx8mFdgu2IT96wQThchgAgZPU
	pL8cKCXmWxIoh8g8oKE2mD3TXDlhle0k4j2dZw8vlSzGCkSUY3ZUaqnCjpY9pZaQz4HVRxm6GNr
	jh8hJArGJK8svs1ORAKsAc9Sb9CyZIulrwQqj54P5kqWDJplQ53I/g3fYWEaWlID38wQGLbiZCD
	VJ4jvaM7Emd1QhPfC1vGcXAxAd6KGRIAmxw3/SWAx4tYiBubN5tQCEAT57ct0E/T8uTp5BdQkRP
	C6bc5s+N6eCix5ttGF/wa60CpmU5nGgDfS4Zq/sllDkUskmfy9ygVZ9o4IWRtO6Iq+xf6eE7WGA
	OjMC+7YC6XfC0nyKjY415WlAP3dKwyyYT3w0qsjzcaZUu6TOfgYqoJ
X-Received: by 2002:a17:902:ce8a:b0:2cc:61e8:5fba with SMTP id d9443c01a7336-2cf349a2153mr166897815ad.32.1784581368795;
        Mon, 20 Jul 2026 14:02:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347430e7sm62085485ad.68.2026.07.20.14.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 14:02:47 -0700 (PDT)
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
	Dan Williams <djbw@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v3 16/20] fuse: convert iomap ops to ->iomap_next()
Date: Mon, 20 Jul 2026 14:01:58 -0700
Message-ID: <20260720210202.1163861-17-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720210202.1163861-1-joannelkoong@gmail.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert fuse iomap_ops to the new ->iomap_next() callback. Each callback is
generated with the DEFINE_IOMAP_ITER_NEXT()/DEFINE_IOMAP_ITER_NEXT_END()
macros, which wrap the iomap_iter_next() helper to finish the previous
mapping if needed and produce the next one. No functional changes are
intended.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dax.c       | 6 ++++--
 fs/fuse/file.c      | 4 +++-
 fs/fuse/virtio_fs.c | 3 +--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8b53625ac7ab..85cdf0199bc0 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -653,9 +653,11 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(fuse_iomap_next, fuse_iomap_begin,
+				  fuse_iomap_end);
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin = fuse_iomap_begin,
-	.iomap_end = fuse_iomap_end,
+	.iomap_next = fuse_iomap_next,
 };
 
 static void fuse_wait_dax_page(struct inode *inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e052a0d44dee..403decd4bb52 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -890,8 +890,10 @@ static int fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT(fuse_iomap_next, fuse_iomap_begin);
+
 static const struct iomap_ops fuse_iomap_ops = {
-	.iomap_begin	= fuse_iomap_begin,
+	.iomap_next	= fuse_iomap_next,
 };
 
 struct fuse_fill_read_data {
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index df25d4faca41..f15e516ebcb5 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1024,8 +1024,7 @@ static void virtio_fs_cleanup_vqs(struct virtio_device *vdev)
 }
 
 /* Map a window offset to a page frame number.  The window offset will have
- * been produced by .iomap_begin(), which maps a file offset to a window
- * offset.
+ * been produced by .iomap_next(), which maps a file offset to a window offset.
  */
 static long virtio_fs_direct_access(struct dax_device *dax_dev, pgoff_t pgoff,
 				    long nr_pages, enum dax_access_mode mode,
-- 
2.52.0

