Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46E342DA53
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187494; cv=none; b=GpNaEzaYvZf20GzA7a9HYG7zJXYhiiW2gtY8L9tnpLQ1++Tf5EB0eVzWgPlb95y1as87aqZmwpIiHHcC9Z6zqMALefJPVlw1hFa7Jys1G+j6vorSTbe2beSsrKcdY8R1R4o6Czm58x5QpTk1apq8Q+wgPcBZPN/zocp2jHCXJBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187494; c=relaxed/simple;
	bh=NkWTxDB7BVf5kr2NeMKSqq0wtS9n6p/N2UG9HabFDJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KLds2Tx+Ur/N29h1fbfpeF/B+4AS/6y+/USf0z/TG5if0P6fVK9hvKbQVJHTuQjX4hU4MQbn8413QEhBGb0dMr6/HGyY93daIeBJW1VKgdGAiRJga5JhllU7yboYcDxdDi2b4YyPF+mIuugINQ/qzUf2ol1qpqluqhiKcBViPng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbqwMeVC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbqwMeVC"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso307484a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187492; x=1785792292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e6+Ei9NFKggzOoAWAaPtMOQsJgv2L14jqLZIvC8zwcM=;
        b=HbqwMeVCX974YpYO10UEAgGWwkIX6cQ6tYny0r/YvThQigrbWuU7GtnothhhK5fgMx
         9uvIEWz+hVpGFyz8FyO7r96a9NAUzTCyQ5hRxkgJRUimaLKtIOtvjuD8nE+u0rMiF2d6
         mnrzWFfHNj1HkwPGOHjepVxUAFDBDgtKtWiaGuRd9/IGe/Obr0XUDEAkz7Qy9XTVhyjd
         w3oLjb+0rWf3KnTeimJSsnydejkHjnDBGt10nesUmTf6eFl/XPpHtCkJDDcFfBPFDqsL
         8bH9IOi21FNfoZ9HH4d8HInSOmcdX01dYU+bxzczi14R3Mr+vVYiIL0ZFk4htCOfUf3L
         58yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187492; x=1785792292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e6+Ei9NFKggzOoAWAaPtMOQsJgv2L14jqLZIvC8zwcM=;
        b=d2PCul98jrBvV8Nz36JeQpmPxsgpRFCI40XaQ2VexX5F6ake8/1YrQn5Fu/qkyK7aA
         1Z4gOqwRImexWRrDPuGdmF2AP6fYVrZxN5oJy0gpFEhxfdpSFlZg3PeFp3fkCTCyttux
         aVhgzC6buBY9tZuO5RXoRT6FS6H1J5loB3hKJmQ2sEGxzySI03ke6PNSYWkk/nNL1f/H
         W/hrVP9y9pjVbkHWaPh6NsD+wJzuhRpjQLqGZL4W44QmkoxCta2Rrvq+yNNMcq25F/n/
         AjEiuknl5CvLG8b5VHNKEoxHkFm9zZYgrwyqRFMaMtxMNngFxqWWX8NhRt/tqt888UBp
         VWvg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4E2aOov0iIypHQdMSlwRS3rKUCf3safq0EzSuKSNuYTBpKOSYMm7CrIAAHqhGEcGLopbbeoBam3ZT3BnQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjB5JfjE6p5w4wEHHQiWbaQ2li7G3z83r/09DpHu+WY4fsAvz
	8u8xXx6/Mu/eR1GuNz64ycJGW8HoyHl1KX0AwqIsslucxkT8/pw1GzoQ
X-Gm-Gg: AR+sD12AUXCw8Z4Rh5czgriNN+q/ZeZ+Gl6UHF06DXVXm+p0x1EdBPNhn2DWkJLBtZE
	kaF/y6gkGmd5/HxKqSD0EDd7OQw9qWKOQL3HzshB8uLoeR0oPPmzTPHl6QcN2uRJaIuzBu5givq
	0oYZKUjQuSJmhEZB8t+9f1Ukr/WawDGnVsshzHqjxU9lfcQQ7KhTfS108kFgrk4Bed7tHFK5HPC
	4Y6wg+zMj3YpYbGD982TGTzla20Zn7Hw/FPyNceGBAgW40xgIPBSjPddg8MVT+QWliYc+LSZApa
	gHBaJZwRJ7ayPNaVJzRXYHB46ocMW2ok8Nqrm1mFqR63FB3R9j32xHDuB0tT49ThJ/gicUxRdKC
	mJpIyZFMz2//+K+G9BKs1lYoT91C1ozk+JBj7mif/FFI1+GF+0TbqodnVDK/amY5VtZzZWtCI1v
	O9Dj8qiJuTYFGFNKKROV4FsJjrc5xY7O8DOvjhiW2uwzdanV9Hvor52VSLtGP0L3XTX7VF4UtsS
	bHJEYm+9qX3yEI5lau53yYDg5Lr9gnfR+lZaf1Q
X-Received: by 2002:a17:90b:1804:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-38f66c425d2mr347628a91.5.1785187492156;
        Mon, 27 Jul 2026 14:24:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:51::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f6412acd7sm345271a91.6.2026.07.27.14.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:24:51 -0700 (PDT)
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
Subject: [PATCH v4 12/21] ext2: convert iomap ops to ->iomap_next()
Date: Mon, 27 Jul 2026 14:17:49 -0700
Message-ID: <20260727211758.1116539-13-joannelkoong@gmail.com>
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

Convert ext2 iomap_ops to the new ->iomap_next() callback. The callback is
generated with the DEFINE_IOMAP_ITER_NEXT_END() macro, which wraps the
iomap_iter_next() helper to finish the previous mapping if needed and
produce the next one. No functional changes are intended.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/ext2/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 29808629cce5..7e0fa9c454e1 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -860,9 +860,11 @@ ext2_iomap_end(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static DEFINE_IOMAP_ITER_NEXT_END(ext2_iomap_next, ext2_iomap_begin,
+				  ext2_iomap_end);
+
 const struct iomap_ops ext2_iomap_ops = {
-	.iomap_begin		= ext2_iomap_begin,
-	.iomap_end		= ext2_iomap_end,
+	.iomap_next		= ext2_iomap_next,
 };
 
 int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.52.0

