Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31F378D85
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675707; cv=none; b=AztjnrZKgwlovaRbrO1kJe9DYHTMQzyFXg01YQYWtXXGP04hMqjTjk3/N07RkIGjWnExdfAZ0aDkkUlO5uR4ooIJL6nAZ47WTdsprSc2mbBKoh3Sz3dB2FOK+dQGBHElfo3UFfJVAHGx5PovSb0CKrkqClh+h0PztJZahWYlfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675707; c=relaxed/simple;
	bh=V/Jtl//8CLGHqFrgZDH2CVGljpJr2maDlNy9JvCsxZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gl/eYB+xtVK/+cbFlh9SB1wkOcdfXB5z7p45IwSfs5o71IF6Jpa41GUB5knnPJXcInYS6XOerI6MGudUr8nSOLZZx08DB9jvTlhlbQC002EIJgNB54O9bqEltZQNN39dNwljSzJRRwI/yj2mFxpwlWgUpRSAcrgLQrEJ2LLdJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8XPhyDJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tInwUF9D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8XPhyDJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tInwUF9D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776675704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gqkbOMppUZI/mnfihhZglDkygJ5RC7Zg7E8StFuzWbk=;
	b=e8XPhyDJElufNhEJlyQjxt++MvWNs2fy+QusNHRDxMWS/3KEPFUhRxDgez06sZCQdonBaF
	GqiHySL5fJVWl0Ly8SizL8vDw0Sy5ioUYgXaN2gLmzaIF8qZyzoH75dZQvdMiNMRzUwTny
	YAnPewGQI7Rnv3lgmfMLD7jzlM5kQd4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-f-eRUxxLP7-b6f3hbdt-HQ-1; Mon, 20 Apr 2026 05:01:43 -0400
X-MC-Unique: f-eRUxxLP7-b6f3hbdt-HQ-1
X-Mimecast-MFC-AGG-ID: f-eRUxxLP7-b6f3hbdt-HQ_1776675702
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d780757eeso1595470f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776675702; x=1777280502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gqkbOMppUZI/mnfihhZglDkygJ5RC7Zg7E8StFuzWbk=;
        b=tInwUF9DnFS3hUP1aF33jy2LVyxIYXi/eLobNbz25QAk5laufqe+gMrxzsgcZmF4DR
         xwPuoypzZVYn3/sguqGwRddhNER6POekbkqqsnRiGMKmEunmoGOEDE6cbUfPho1FO3GY
         tSwCp4z5NSKPCm3Cb/OlRibqOpoaro7YOR5kcaBEharNvCDv3Y1rJ31DwV09oSl9QfGu
         rX+5AYyFB8++kKSMvQ8kXukxhWTouS0crrucW6esJj1Yz8vMgMfu2Jt2c5nZZZewPq/s
         +BQZSAJQY//UexTXi1+3ZtPVcxqVhpPrkIK10ccnFCg53L80aJ4HeJyx6riQqdl2ELZW
         Lekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776675702; x=1777280502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqkbOMppUZI/mnfihhZglDkygJ5RC7Zg7E8StFuzWbk=;
        b=Y5Vc0yifbP6/pU90Q5PQMkZ5Wy1emveZl5dB4BOUP6toa2b6mzaHO7pUNjNw839uNH
         CyRF9+4pIeDhiicLSUl7ZlW3gssVJGdMERQBPp5xTUUxJEytLLqOH3TNQz1nctVX6GjK
         bUT5VRI7Yy5Z8ZHYcR/yO46O9q9ZAUiGOBR+q0wJE6EmHKCFdXSHReQDmUayOkWKoRcl
         f/JrxsO2O0H2aOqdtXSGjVos6u43YvzJJV57/9CLq/XoqTxV6hd91QStvI/AAHkqrIQz
         08RpwFQ7SobS38x4oOn7Wbm9FNaCHOdMH55OPUOlNOkTcvVlEo8dXkRwUDHC60vjJrwh
         Sqig==
X-Forwarded-Encrypted: i=1; AFNElJ/yHwKAt8g9Hg5ZxogAhHY133BJ2vCQSA0ieVqm56vyqSPHUTKhRfJuNLiCfF8QnxpAVuFKKt9N6z5OvLYw@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqwE16No0ZBOhEcBY9daqUPSiBMBhba3HdXqj2HmOwCJDjWoy
	9R/3Bk9FhP1vjhBSP2nfvysXrJB9XlX39RKFsxZEnKXWqRtzt+zOith5ST0OzA1I5P5fBmO0mJQ
	j6PNpnT5+iqnUosk8AZm/2anRT6QO8pcS22Aj9xz/8D2yiVhUrqDgkOhA5UXZmZK1HvE=
X-Gm-Gg: AeBDiesMwwPkcGXLXQyk2yEd5S+SwX1UQEH4xB4sZEHzBIFwEa2+gMpAI5euBa7x8st
	oGpfIcNwduk/MtoWlOv+mk8LKaMOntctmAieX6nuRSUosdbb8kXDJwYoxiH15Bkzk+mi0jkp6CC
	vfzE5XAN7+8l6fFSk3G0Cbxsjv+1fb7gmi7RAA5xXPXJy5CAHESY2Lp0BHBnD8fCKuRfI8N6TKq
	7lF+v8/P4694R0DxLWR7sEYq+p6/ZFqfZuA+5h37oQTaQ3u8GX2f0T9uUfA4t14vIdB/+g9IZSU
	L7tkWy4vV5XgtATOWUAdhIkJx2iVokGJ5icuC70lcKjr0PLGtitHfDZABH8ipqI4TXM+RIecIZ+
	636GudY5CUGKLKWp0/3gYQwFVNgVbNTH9bchq/TuCRX7q4oMUuF1Jcdh6KV7nHEGt5+r9tbOBHj
	ZCjzbi2xO9GFKgcQ==
X-Received: by 2002:a05:6000:2a0d:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43fe407df74mr12676660f8f.15.1776675701696;
        Mon, 20 Apr 2026 02:01:41 -0700 (PDT)
X-Received: by 2002:a05:6000:2a0d:b0:43d:7a5e:8162 with SMTP id ffacd0b85a97d-43fe407df74mr12676605f8f.15.1776675700918;
        Mon, 20 Apr 2026 02:01:40 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (188-142-153-35.pool.digikabel.hu. [188.142.153.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a18csm31153195f8f.20.2026.04.20.02.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:01:40 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Samuel Page <sam@bynar.io>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>,
	Zijun Hu <nightu@northwestern.edu>
Subject: [PATCH] fuse: reject oversized dirents in page cache
Date: Mon, 20 Apr 2026 11:01:37 +0200
Message-ID: <20260420090139.662772-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Samuel Page <sam@bynar.io>

fuse_add_dirent_to_cache() computes a serialized dirent size from the
server-controlled namelen field and copies the dirent into a single
page-cache page. The existing logic only checks whether the dirent fits
in the remaining space of the current page and advances to a fresh page
if not. It never checks whether the dirent itself exceeds PAGE_SIZE.

As a result, a malicious FUSE server can return a dirent with
namelen=4095, producing a serialized record size of 4120 bytes. On 4 KiB
page systems this causes memcpy() to overflow the cache page by 24 bytes
into the following kernel page.

Reject dirents that cannot fit in a single page before copying them into
the readdir cache.

Fixes: 69e34551152a ("fuse: allow caching readdir")
Cc: stable@vger.kernel.org # v6.16+
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
Reported-by: Qi Tang <tpluszz77@gmail.com>
Reported-by: Zijun Hu <nightu@northwestern.edu>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/readdir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c88194e52d18..db5ae8ec1030 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -41,6 +41,10 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	unsigned int offset;
 	void *addr;
 
+	/* Dirent doesn't fit in readdir cache page?  Skip caching. */
+	if (reclen > PAGE_SIZE)
+		return;
+
 	spin_lock(&fi->rdc.lock);
 	/*
 	 * Is cache already completed?  Or this entry does not go at the end of
-- 
2.53.0

