Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86AA486E62
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944489; cv=none; b=iME+SJ3ZO4hA4YzwhHNCau71ipT3ReDfNbg2XJFl9igTSYnXm9It/TV/CWBaUPLZCjpgOtVuWvKByIE5ZS5YTYAYqWJERldZluMMLaoPAg02fpdrJYiKEIWOtrDDtymhbcYjOZcel2zs/ioDmSQ7K3PsPOKMw8Xg+AnzxSe/RSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944489; c=relaxed/simple;
	bh=qIa/OOPRF8eUOfN7emCsEmTA8N7RP5NPcMNXTb2hiYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTcQeGUVfEow4NatZ/k7et+FJbQiS4qqNjigAnP/IMu7WW5FN9jMjogA69cPS0QFs44602RfXh1iNGjdbbBPsRvGb+AkD/O4gydvGUk4UDtTF109vcwfKJxFgPD6h57itUqUahUmRfKWDtJ7w/F/MptP6OMvPGEp6ppgALsMtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N5rexhK5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N5rexhK5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2db18e5cb56so54336365ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944481; x=1789549281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiZZoK2m1udHvSG78cGXbZoP5Fh5l1Q4IJu628L6gi0=;
        b=N5rexhK54hW8LkwJo0LqWrTWWjtA9BLi09Bux1+r2elIndwkZ8wlHwub/mMWWz0Lw0
         PMAD6gqlt8bTZBkgF7NNVagwqb6eiHfQbAPrvJFyFkpKzBKfhuooCpygYkj8zMTkKZTY
         OcOm5AfAj4crVdHHxzlBZqiG2C1nRxKoas3weyDzuJ6IszzobmrrgKhfuCIatH6B/RnD
         wTRIWM7UrRmo5a1sjFxrN1p5n8gH11MJIZBcoeigdpb5tPXe9yuzo0DWOvitBoauZHhg
         PgpEZTK3z2Iu6qIOZU5Dh9qRIijabFxOjP25rQZ9ThVycyhGovY9vc19Z1Dn9vszuhoG
         FEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944481; x=1789549281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiZZoK2m1udHvSG78cGXbZoP5Fh5l1Q4IJu628L6gi0=;
        b=lpCCa3ohaUdsVAXRf2dO5xgDvLbvYtfU6txlotczLH1eq9yS6bVPvyor6UuOnwo4Rm
         tREgyboeyX5fZC5BZmmAO+/TojJ3SydSM6etMeuakDkD8LjHEFaRT0tFfGK6Vpo7fPZV
         5g6zCQ2DuBF0C0F0+sftDwB1jC2+qFJKAxlAgVn0U5G6SsdAHXT7EgwpWKe9k8Ygdi9M
         YwiI7v2mj3ICjjxXDnXCUjfxl3gEgtda3KTKclNEv6SIGUCKFWkKXrxG15YtYfFzshCF
         0KT9SmglmQRFnWVXnZn6aUqLlfxT98Eg6Sji/qfovBNQfftIIb4xZ5E74CTiPusZe92A
         aAFQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/L9hMfPF2bKLd+DNdQcXmQ/Ka0f0t5e8xCpBddpXWSiUhdLkUSaQiEHtF3r/iglkDvac9Zp1pBsPZeYvI@vger.kernel.org
X-Gm-Message-State: AFuF++nryPfF2qu2ym+ZI5sOVv2bSRqaQ5NK2QAB+7NWtN5G/qMC6Tj3
	gdNs72oqIYlhHG/BMN/1fnFraJs3EfIL7gD3xq02yQHWRRdKCrxykqr1TjgVkAGDnQE=
X-Gm-Gg: AYBFou1e2PEbAfe4ZdJJxUQeU/Hxk5/rlYHkYrSlS8evHXr5AmH2VO5VKOk4t2l0ayl
	lo0EUzWCegeckV0Y0hzTz1TEGkMn/+ny9B2RoArv0MwXuHunDY5YDaKOn8ewRpbCBD2umOKfOg8
	0quvUFRG5x4j5IujLBNBnQXsKGUideeFQFaQgKM7RYM5FRI33bcxXV7mwe6LCD6cqZ0fR4mrQHf
	R1I/Z0rOS0FoIf7swL8Wkt6TZAlF1CvjeM22bze1a1q+d7lfoh+dFhrCTpyQt1ipJwMLJwpjBqy
	PJAKn8/dWZFwzelRH97TA8sHctEcUt+73PdANgJlXjuJhzvuOP8rCVtDJlUvb/ZxIbHQFRrFSI8
	ljisGzmHh0WudyHlBtupl3LU03b7CAdTuwldBc/pk2WL4N5MQNYaFdWZaHPUCc621ucfEm6Fcc9
	iqeDBrEDWOUJX1DqMCo+BOgZFEAYpMO+uWfLg1fTdTRHMb38iKHLq/5vL5xybwC6VaGUIEGooOI
	us=
X-Received: by 2002:a17:90b:528e:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-39b25ee67f0mr51440982a91.0.1788944476217;
        Wed, 09 Sep 2026 02:01:16 -0700 (PDT)
Received: from localhost ([106.38.226.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612d3f1sm30763517a91.13.2026.09.09.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:15 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 0/7] fs: preserve superblock inode walk positions across lock drops
Date: Wed,  9 Sep 2026 17:01:05 +0800
Message-Id: <20260909090112.790006-1-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Motivation]

We observed hung tasks in production during disk hotplug operations. A
kernel thread spends a long time in evict_inodes() while holding s_umount,
blocking other users of that lock and causing further stalls.

The problem is that evict_inodes() restarts its walk from the head of
sb->s_inodes every time it reschedules. When a large number of referenced
inodes remain near the head, each restart scans those inodes again without
making progress through that part of the list. The repeated scans can
delay eviction long enough to trigger hung-task reports. This is the same
problem that [1] attempted to address.

[Approach]

This series introduces sb_for_each_inodes() for two purposes:

  1. Consolidate open-coded s_inodes walks behind a common entry point.
  2. Retain each walk's position across drops of s_inode_list_lock.

The iterator mechanism follows the approach used by cgroup task iteration,
such as css_task_iter_next(). Active iterators are registered on a separate
list, sb->s_inodes_iters. Before removing an inode from s_inodes, the
removal path advances any iterator whose next position points to that
inode. These updates are protected by s_inode_list_lock, so a walker can
drop the lock and later resume from its saved position.

Existing walkers, such as drop_pagecache_sb() and add_dquot_ref(), already
contain their own position-preserving logic: they carry an inode reference
across iterations so that they can resume after dropping the list lock.
Moving that responsibility into sb_for_each_inodes() simplifies these
callers and lets their callbacks focus on the per-inode work.

Patch 1 removes trailing whitespace from include/linux/fs.h.
Patch 2 introduces sb_for_each_inodes().
The remaining patches convert existing walks to the new interface.
remove_dquot_ref() and nr_blockdev_pages() are left unchanged: their
walks are simple and do not require the inode->i_lock locking imposed
by the callback interface. Converting them would add an unnecessary
lock/unlock overhead for every inode.

[Testing]

I tested this series with approximately 20 hours of xfstests case
execution, repeatedly running the auto group on ext4 and XFS, no new
issues were observed. And with this patch applied, the hung task that
previously occurred on every run no longer occurs.

[1] https://lore.kernel.org/all/20241118114508.1405494-1-yebin@huaweicloud.com/

Julian Sun (7):
  fs: remove trailing whitespace from include/linux/fs.h
  fs: introduce sb_for_each_inodes().
  block: use sb_for_each_inodes() in sync_bdevs()
  fs: use sb_for_each_inodes() API.
  gfs2: use sb_for_each_inodes() for cooperative eviction
  quota: use sb_for_each_inodes() in add_dquot_ref()
  landlock: use sb_for_each_inodes() when detaching a superblock

 block/bdev.c                   |  85 +++++++++----------
 fs/drop_caches.c               |  44 +++++-----
 fs/gfs2/ops_fstype.c           |  38 ++++-----
 fs/inode.c                     | 142 +++++++++++++++++++++++--------
 fs/quota/dquot.c               |  72 ++++++----------
 fs/super.c                     |   1 +
 include/linux/fs.h             |  29 +++++--
 include/linux/fs/super_types.h |   3 +-
 security/landlock/fs.c         | 150 +++++++++++++--------------------
 9 files changed, 295 insertions(+), 269 deletions(-)

-- 
2.39.5

