Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD2211466
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662818; cv=none; b=I/JFtpjNmwuYX+0VZj/APuzK62iY4pqL6QRF+hRJjVzyOqXwqu5XamO+uFOgRNgprTgRMc0jj76hpLtH2Ga3r2PPYDJWdiX3jl9p6gUjijrWHeuueY56J02bDHF14M57q4sypOo9ymRkIXH2oLfYHUWh9e6571y1y/DZtM5D4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662818; c=relaxed/simple;
	bh=oDZF84rroP3FQTLj8IKpJ7OIXjqIIRSha6QDeYxLv5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ibIznRUcNufCUq4Q6BAwBEFSwoelIXYrTYW0XQ4sFMyv612OI2unae43VtzerVmOt+eZ5ApupaplJRSuWzTa5/4/RQ6H3a2VZDNd4BLj7kldBAXodIxvR1qOa+nPOLm+f3V162QC8HSNGNwjjKSLV7rzQSZOIFQWqh/TvYuvbu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoW2ami1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/qkgFcQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoW2ami1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/qkgFcQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780662815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=19vOK/aljw0dP+/71WiEI9NMzlYECl5zmc4CQK8fGGU=;
	b=IoW2ami1VS2oGpJ5adMZxa2HZFjRR+rgx8j6BUDpxXOASiaiZEwhaMaRPC+esZ4B3QNtN5
	BuLYTuL/XRpaX6HnUZ3pw1UgpWKlg9decOpTkE55wqjGGvHXxrZPk4zLj/jW+ei3o2s11p
	xLEfc6QZ2lGVL5/Y++CcdThT690sSuo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-X26Qv72bN3yapj-X_ipKHg-1; Fri, 05 Jun 2026 08:33:34 -0400
X-MC-Unique: X26Qv72bN3yapj-X_ipKHg-1
X-Mimecast-MFC-AGG-ID: X26Qv72bN3yapj-X_ipKHg_1780662813
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45efa2f7009so1153276f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 05:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780662813; x=1781267613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19vOK/aljw0dP+/71WiEI9NMzlYECl5zmc4CQK8fGGU=;
        b=T/qkgFcQPqtXoc3NDV04VAScqoE/SvZ2umLZxodgJ1KZMWiYcb4tLJ8WW39OFse++Q
         OdS80cz+HktsMqUYZEGLAJ4maV2ra4AG24NSX68BE0m+IBCpteItyOmql2JF1Sm2Qgi7
         wflK7nTy+TfSgNVZSlQsl9GgJlp3+fUW6tjSpBGf7MzXvtanl4+klVUrt3/OqzAsDBy4
         AoLdQ1zAXBWaJZ6MXSQ768z/luUQ0VRlZTo2qj0DDxFsdDbGFpoTmy31UjFenU970Mox
         Owr3zsX2UDXVsj5iAAb8ub9Xb+vvK4MmFiwSqSzKqZIC9IVDHtGUoEn1EfI2kLcEzvMM
         gGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780662813; x=1781267613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19vOK/aljw0dP+/71WiEI9NMzlYECl5zmc4CQK8fGGU=;
        b=rDBIlxpEq/wh35FKhodEbkBGShrPQBu1ByjJ/C1Oj0Yv3LlnV+E7qcKwn+YAf97BQh
         1ZMHE4wc8aF55Vs1x65Elz2+jN42GtqnTvf+3zePCftXDOuvgJ6OaCvP0oDtIknLcSU5
         hOcg6Yt1NdQ/1Ew+HG94y9b8xLKol/CWZ1JYiBLpLZMPhTxZM8wAV0JpOUaT3A+2/CtT
         5l1mpnnTNLToJuUJSE//yLs6PHdZxrNcjvJ0DzJ015DknTh1DTsTdAWqzK1lZa20U5fO
         YhLRNRPh2Q3FVaUmRYZ8y5oFJtBY/TryCSzcjZCpfiEkvaGZyB05gVALOuYj6aa3mVy/
         5Hdw==
X-Gm-Message-State: AOJu0YwfpZ0fSl8mXxmfUIuVS/NXtDO4xYRyF9hKI2mNUVr0XUig3p2s
	BO6qWER0c/9sMLOW1ABW4mOYU7qQf8Se8wBHawlN8KCgjKj6IEWIWR+yvVCO1XejeLGNpcAzFbp
	osWdluxlwoTS+/aQ4MMKgdyzNCBFtEVM0xAzZhuZoRzdn1dOeHJNSn6NtyhKtSJUvbs65jhRcK2
	xByzF8p/uXusx2B7RVOgiP41yx33oaXCqK7d3TBWndo6KdSz14oVk=
X-Gm-Gg: Acq92OH7pXblB2HgkQHciQ+8jNL+rJRAk5s6iPa1ySgaM1FTT3Au5b7BLhBC33cMFky
	rxm/oHNjFlUjGaw5beeaHPXj+tCS71lWz7vzi0MBwSVzT+ARLzzfFlex4cKmSYcN9KsTDuYGkfO
	JOXfRNMhTR79d2DA+ESRCQ4MAJF1T421Y++H/OJ5TZ8SYZZaTw+YEFQ6xcKNibX/uck0zDGW4r6
	bXpsSQkBzRnTUU6go1sdZ9TUSfI0+ruypx199XKs+7Kaipn9wNKDiSGAe9gfOh3IFotXzSZOGQF
	rzMYO+en6RagbeYQdhqn+1S1Lb7ZkLFh5bAl0GradNr8lEpA2KdcSWi8vaEpbm7ZwQbfFdfurri
	vIDklt6yRbVYmd3RIchX/5e+5UZAeXdgw36giQr5LEmwG+HbU2wrvBKB81qMipglpAUqANGAgGy
	GTqMVK7A==
X-Received: by 2002:a05:6000:1e4d:b0:460:1168:6dd4 with SMTP id ffacd0b85a97d-460302e49acmr3984561f8f.14.1780662813479;
        Fri, 05 Jun 2026 05:33:33 -0700 (PDT)
X-Received: by 2002:a05:6000:1e4d:b0:460:1168:6dd4 with SMTP id ffacd0b85a97d-460302e49acmr3984523f8f.14.1780662813031;
        Fri, 05 Jun 2026 05:33:33 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (84-236-1-92.pool.digikabel.hu. [84.236.1.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm12702780f8f.32.2026.06.05.05.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:33:32 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/4] simple xattr improvements
Date: Fri,  5 Jun 2026 14:33:25 +0200
Message-ID: <20260605123331.2621677-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 mm/shmem.c                  |  49 +++----
 net/socket.c                |  30 ++---
 12 files changed, 251 insertions(+), 271 deletions(-)

-- 
2.54.0

