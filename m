Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9463290AD
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667609; cv=none; b=ByTPPdl0d5Ansy8y98XOoRKa8+ptA4Nnnq2zQOeJj6KFaDKQ0Nkp4zKDgE6EZQEj8aOdTpv0LftTNCed2T7BAd8jz3ZwnGgUQanQedD6hqf3KAZw2tegdjfzwsNFm+DrT07ouCi+QzZMw+gkjgpW7Pt/ga3/46N122M9iwoPWAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667609; c=relaxed/simple;
	bh=5b/vxHOQ4zrZmVhkBGEUqKOegoLY2CAQWqR/ZV6IBdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ds3frtjYVZEpildxVmy0J7UsTOTbEOYnJEpmS/C2hbUoO1HnX1kodS4JqstCGl19iZCv++fHXspkw/LTTp9lgAHdQWXzs0nZMRbHYyR29Dh5kxlOAJuQ7HlM0OcI6FSZd5CtVkEr8K3dkgMo+bzMKfBTRbYz33034d3effZlkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcQzcTOe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KjUOMk24; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcQzcTOe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KjUOMk24"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780667607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iavcFnyVi7+3Trg9epYKO4ba/4sETBjrALB/+SG2R4E=;
	b=UcQzcTOezm8OI0BJ0OMEQJKmURKuVO/OrujB5aqyti9GgcjMq4n4S+qFJOCCDCb/jeUlYj
	ESa0thUg9ABUSJ3Lm5ZoKqtXk4zzuqCWF4bL8YZoy9A8u1yYB1COhOYXHPQ0y51ZYdHZmD
	II/KTErkHHMQxs6K2Cv/nlm7M+w8WFQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-isiA2FK-M9Kt20d-9YqLLg-1; Fri, 05 Jun 2026 09:53:25 -0400
X-MC-Unique: isiA2FK-M9Kt20d-9YqLLg-1
X-Mimecast-MFC-AGG-ID: isiA2FK-M9Kt20d-9YqLLg_1780667604
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b9cd54f3so16965835e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780667604; x=1781272404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iavcFnyVi7+3Trg9epYKO4ba/4sETBjrALB/+SG2R4E=;
        b=KjUOMk24JWhbK+9iEqSfwqdo5AMzu5kI15Vnqb09rbtLC7hc5OTSnPQ8D12qt8Otxm
         NvFtxZgTf/zaefTmAKA2RSBSVKTJv9kB6Atlwp+/8RKlgsJQUc9dRU4O4z92yaT0VV1E
         kRymV2Vkc5ZpnrzWxot5y2UHjkc93NE9ufBbGxZ3pAjeJ+onB4cbGAb+erqsPYNuuhV0
         yK9Y8lTcrYmMwSZNWRRU45tJoKnM+q5i+JaGnhBn7qTKvURWtNH0036HxuXNpxOl7Rs4
         ngSGSHZDhZhtMxRC3/ZIuF4xkgdN3j6Qw/0HHZx2n0iqFNiIketa11PsXTE3r24uEwgF
         ftgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667604; x=1781272404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iavcFnyVi7+3Trg9epYKO4ba/4sETBjrALB/+SG2R4E=;
        b=Rb5NYJPctVSTkXhpXxZZan9E/n0fsVFxZEt3AE8XDiHGQOhWfm1xYaMsbxOsQ0lxps
         BYyzjJu6XrMZ0ykAUZGHeVpDHNRYba9/YcYHCjtrRrZwS4XlKFYJQmc/hQ7gFtvG6SN+
         8sSkbA0V6JrBGJUJCh2Or3JGJwNqrnk+2Z5iMamvek5YeEgaTZPQxMos32aXQGxAuJr3
         tFwK5AWw/ZR+ZokbsHw74t4qR/MiZ63ULAt8UMfNNb1dA6uX884yAIA55HxOEU/EXxto
         +MeMXjQaTroREKb57bkAED6silQQ90zrS17xb25ZKIpBQxA3lZLK6yT4FgbOhRD8eTI6
         e2eA==
X-Gm-Message-State: AOJu0YyUNttNeVELBfkHh08v567V072WpN1Oa2G89uyimubd1fsonOAM
	WTNnTC7uLioue03vaf5JkFeUmaRwkKFkqHC0momjxm6J/kLVZ65YFVeoLxQ41SqpXp5SGfGeICN
	SF8ZjfZrso0s+hSYs2LCcWlvyM04jUjNVQ6MMNbuQ2pHEW8OHYyDDuGZayLNV+In1jRs3fNlFYn
	QYZbo6kqZ+yEnjGtO4qngGBksnrOR8yrf7zHUiISHsTY0ETfKb5lQ=
X-Gm-Gg: Acq92OGe4F3zbrKLZcoWIWm6sSGwUScWfDYPumBT6te+mlyLoPT6hRG1hylLupAEGdH
	JxJ4FqWuWanyRiPf8VpTR1BEVZJE8qsJK5mVtqkBQ8OiFrxBKApwMTu7rhdxygMFd32ioCYFfu0
	OUHuZmIrdySJ/DPjAtSSjl/UZfmTFD2fegN043EroS5unbG8G71a0tb98K4yRZChDnTWwxREM7Q
	XJYKx7qckqW7+2mqFkHkR99G90M7VGocO/TBiBFRFGR22z7wurPrlQ58eE0P6hsOLITCAQt2uhd
	0SjpJSmkbDtow9ko/VwAWh2UdDcoWNxhlAInc2AG4Iq2hxqbpIlorlDrhVZOGYI7p6/WauhzROd
	0oVprd0st179YV7OaOzsx5RGQS98xEIB29/apDSjzMjKvX1cgjDqRPUH926SpTL9Jw3eVo+gu+O
	wN6cy1yg==
X-Received: by 2002:a05:600c:620d:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-490c25fa907mr53133325e9.18.1780667604532;
        Fri, 05 Jun 2026 06:53:24 -0700 (PDT)
X-Received: by 2002:a05:600c:620d:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-490c25fa907mr53132865e9.18.1780667604107;
        Fri, 05 Jun 2026 06:53:24 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (84-236-1-92.pool.digikabel.hu. [84.236.1.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm157999025e9.7.2026.06.05.06.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 06:53:23 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 0/4] simple xattr improvements
Date: Fri,  5 Jun 2026 15:53:15 +0200
Message-ID: <20260605135322.2632068-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
 - yet another accounting fix for shmem_initxattrs

v3:
 - need per kernfs_node locking for simple_xattr_set
 - another accounting fix for shmem_initxattrs

v2:
 - don't use xxhash
 - fix lazy alloc concurrency
 - fix rcu freeing on evict
 - fix rcu walk of per-inode list
 - don't double account freed space

---
Miklos Szeredi (4):
  kernfs: fix xattr race condition with multiple superblocks
  tmpfs: simplify constructing "security.foo" xattr names
  simple_xattr: change interface to pass struct simple_xattrs **
  simpe_xattr: use per-sb cache

 fs/kernfs/dir.c             |  13 +-
 fs/kernfs/file.c            |  13 +-
 fs/kernfs/inode.c           |  36 ++---
 fs/kernfs/kernfs-internal.h |  24 +++-
 fs/kernfs/mount.c           |   2 +-
 fs/pidfs.c                  |  45 ++-----
 fs/xattr.c                  | 261 +++++++++++++++++++-----------------
 include/linux/kernfs.h      |  11 +-
 include/linux/shmem_fs.h    |   3 +-
 include/linux/xattr.h       |  35 +++--
 mm/shmem.c                  |  50 +++----
 net/socket.c                |  30 ++---
 12 files changed, 252 insertions(+), 271 deletions(-)

-- 
2.54.0

