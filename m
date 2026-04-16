Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4471939A04D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331045; cv=none; b=q6hdWiljsWB84nFmm3hsHFsY3X7zsOKKoTjJkBxJGMdtyOE3pjPX93HfFiXTOsQmTlhupgbONe4un6X+MotJF+w1qqH3J308crQpIRP4yapKnBEtJkxe4wo3xxCxpb8M7DTwJVsu5ECl932Cf1Yxcm/C/95YN1YZhks8Rfn2Ah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331045; c=relaxed/simple;
	bh=lRXrp+/Wt/3Jzs2Mlf5Uv6d4sQzdg+Md+hVUVfGqsrk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFpQ8Q3iXyerL90FnlUQc0q/r1yicHJyNsKyXPr285K2iTj6TskOem6bgaGq4DaAqWITNlw9DG7cJBGMR+pNUtKEia6zfi9zr2Hu0i0H7A7RjeIxynpQE40XW00amO6A8iuv0HgLKpKaDGxWvkaOg5Ja2sgeRdQFP8TdQbmHfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hWmcX+BV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOCv7MoI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hWmcX+BV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOCv7MoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1UEmHJjJy26/ZcPFHdwiCnQsN4/c3i71hg7W4e/53U=;
	b=hWmcX+BVz43J1fOQ6c8r3utWl9AQb4WQGXUV/URsPAqKmzR5zE7Tq7Rte8G29/am+l4UrU
	ltFvetMa8zBPhh7lS13XCxGY5xV3TzafbDfgP5/J7kEbeNiNG6n6R9AbG1ppYMDDIMpcOb
	srlL2os/A7yV2SCvh1yQOxIuMRAX5B4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-IvpsWRqIOeOWMI8c7-PAmg-1; Thu, 16 Apr 2026 05:17:19 -0400
X-MC-Unique: IvpsWRqIOeOWMI8c7-PAmg-1
X-Mimecast-MFC-AGG-ID: IvpsWRqIOeOWMI8c7-PAmg_1776331038
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488e1757205so29452765e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331038; x=1776935838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1UEmHJjJy26/ZcPFHdwiCnQsN4/c3i71hg7W4e/53U=;
        b=XOCv7MoIqtsXYC7TQuX2GuDOLcYTvStB6Sx6vjIx0WpxU6tZhq2Cqe9sF0x0SjtT9t
         +GpFMSEakmNSFP9Z+VM1o4m3u9McQ/34jDkrBCxKVTbMx0fVii14Ez8Gtyq0QVBCkSPN
         5DCXubqECHkOt8rnwPCeJrFFZss7qqWaXilgjDFOkeBXpA7BOzeVSIJE5Xe56QJANVji
         EZ96Dz6rFj0OxirIqXG58+NvZglYsb6Kf8EM0Wcj3mvi8s7QTF4uWaOGo1lPlV9nASDm
         T6zyswVXUpTJftKJlP8oEmIIi/wbXcZjRA1FpO6ZMHsUSJdY99jweYIWRh6dZ3ZoyXjo
         JcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331038; x=1776935838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m1UEmHJjJy26/ZcPFHdwiCnQsN4/c3i71hg7W4e/53U=;
        b=GjVWQNqhCMjJqdToWBupn7C1MQ2Tm8jgKBnDX07YFAA1TYzfg3xuUYlp7+PMIsxMRg
         BM3lIBcehLxSiFaJ2lisnsFam68H+f5pxwWfq8a+PPU3T889849ez+5yYDbH91dMj/Hd
         /XA43+IiCuDSc1ttoxLF7SjFAM7ZsbJ7fJgsr3RTlXpPdyvC7gAe8sVytmv6OoKgHOB4
         sDP48z2Zn/JQ1EUY2G7jw0QKAF6c9L6WQbHy0DO/ZmZU3uW7Ez2m4vayjhkarxeyI+ex
         VDxBKQQyek3K5PSSRapv9JkDTWIlSyeir22CSUaOz4BavKtz/8xlaJFDdgdpWCmW71c3
         KQTw==
X-Forwarded-Encrypted: i=1; AFNElJ8uMgAHB0eqdqG+IFc1NxENIULeY1bzWxSuQNtXGVw2E1aUDSWvSq3mtlH2Dd68kz4BZQy2SHAvjswCx+au@vger.kernel.org
X-Gm-Message-State: AOJu0YzdAYjcPFRHsF7vfQ16Igf0rUjzy1M5cZ01EWXkpdtUUTAPceuz
	t3tBXtq/+yF+v8KBd7gMs47STCULzy33Pvx+3rJXF2+RzB+cljgJcVzGZFX3pA/UUExlxehPFjA
	JfRZjGqmtfdDItO+10IVmj7g9l1Q8XSu0ODQoKXOuT9i/R3p44l7KowEUJLp8pewDR1FnGEZ52r
	Y=
X-Gm-Gg: AeBDietqgZ6ZqAXQq2RBv5FcnZjx5/Nk3mHe675EiJhgyFxDXsadt3J6jkP7uaAQE8D
	0D2nGtf7F4zNWJ0HAGiKyCGwElTKfRNVzzcH9QW+3aAUPXWrTU1UuvsodxC0W4Ta03l/fV7YvyO
	bRW20PuoQ6CUTC8sp0ru7D5usz48ZY2gTKGd+a3gxSgOR+29QDpE9V9oOWLVeYXDb1eA9vrhf16
	6J1AhqLhcc1KAqz4Rj6RqZfWfixAqqCGedWrfW7VSMghOr8ie9xXy0YI/BeG2ML1AQOYAogq2HP
	qtf0Y46JSYfMyZIC+sC05/+NiGXr7+Z/KpUumdST2s0iZDunwa+oasuASwBlwPwGf3m6R/PM+XW
	MFwqJED9oWAJGJ2XklaYC0uPR4cYm4MKbllBBwkGIquKzh79hbFWfI6s7BREF+2quOvt7a5mn1d
	mkM+/5vw==
X-Received: by 2002:a05:600d:d:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-488d67b8db8mr271988245e9.2.1776331037747;
        Thu, 16 Apr 2026 02:17:17 -0700 (PDT)
X-Received: by 2002:a05:600d:d:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-488d67b8db8mr271987945e9.2.1776331037299;
        Thu, 16 Apr 2026 02:17:17 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:16 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/32] fuse: add back pointer from fuse_chan to fuse_conn
Date: Thu, 16 Apr 2026 11:16:35 +0200
Message-ID: <20260416091658.462783-12-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416091658.462783-1-mszeredi@redhat.com>
References: <20260416091658.462783-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will be needed by callbacks from the transport layer to the fs layer.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/fuse_dev_i.h | 3 +++
 fs/fuse/inode.c      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 472ee0624a27..0bace11373b9 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -96,6 +96,9 @@ struct fuse_chan {
 	 */
 	spinlock_t lock;
 
+	/* back pointer: fc->chan->conn == fc */
+	struct fuse_conn *conn;
+
 	/** Input queue */
 	struct fuse_iqueue iq;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c7f7e0ff12f7..d31d7b80c184 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -995,6 +995,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
+	fch->conn = fc;
 	fc->chan = fch;
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
-- 
2.53.0

