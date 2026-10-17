Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60970394797
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248527; cv=none; b=Q0/9LiVyrfenx3FJ+4agE2XgtQerTKsNheUjUjwK4R6xRsqnQ1wH7b2suWRppCR/DRvaBqMCtd0WPN3qdKejgm0EiNWdmcv/JU5xJR8XG/F6Mh+HHzxwfP5YFarzZZOqJWD+PpqCHnlrWnva37o48uIuKL/Wqtz++DcLtdF1w/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248527; c=relaxed/simple;
	bh=fGhpFHhnxJbeuyXdQDXOoiQeUDoWhcJ8jAOHC6D6C1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=amz9H+QfnFULz6xlUXqFx0PvQgWiwYMQDJVIpL96R52d8OhXNg+j1ASpdXip9aB/egbM7NJWc2k0NNy9lh7WojfCzDj1S8ykUQ1qwaXYqfeQgzJby+VtimrpktwYt+jmN8ViHmckfQltyzG59vdTBP5KZcNc2AjcI4u0viwkDNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OVX35ySl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqSKst/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OVX35ySl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqSKst/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792248525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A3sJ25QlDwNYlnIG0z6n02tfJnAa4hWqpwhse3XHRzk=;
	b=OVX35ySlv3mJT9KC6eSHIZi04H3Sd5ycRgYLNnwJD8U/Bn6Ud0/dmkRw6opImH+aIB6zA9
	JrEB5g32X4PnrcRyFRiX+sbWc5b0Rkn2+WJrRbPD+llmOrgX6vsg8uvdyer3/8mrtlL/u9
	wKTcmJUbuuVtcEyivvFbZViVUN6rmp0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Y4zQxih4NjqqKW6mdex0Eg-1; Sat, 17 Oct 2026 14:48:43 +0000
X-MC-Unique: Y4zQxih4NjqqKW6mdex0Eg-1
X-Mimecast-MFC-AGG-ID: Y4zQxih4NjqqKW6mdex0Eg_1792248523
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c4108bfb63dso40523066b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792248522; x=1792853322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A3sJ25QlDwNYlnIG0z6n02tfJnAa4hWqpwhse3XHRzk=;
        b=aqSKst/tc7gzLDMnWhD4zzdPdHVCjqo4ufMeL1zLAId9RPV4EImjqqE73+8Eox2YdS
         Mve3C/vdCaR0pQuoXpkz3QAndPfjyrPMQZvPg7NUc2/PGQeriX4+fbAVS/E9x7nWF2Aq
         /8mbUps5JWpkiAOkVOI9SAPoK03g6rLGCXFfJdN5yatyANrFQ7z3ufEmonOXTd0Pk2Jf
         A3yyvqJVZvGLJ7dYQDYwYsSCkru6Xb2XiCaALS+VAIYf5KAKYnPK9Po2uCBlkx2roWr1
         BX8Ds8MTAJts3gWYNPe3zyV7TRdQbUgtenVnAVz9defq4DmmZQwkWiCqbUQmPFHU7zt4
         7O0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792248522; x=1792853322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3sJ25QlDwNYlnIG0z6n02tfJnAa4hWqpwhse3XHRzk=;
        b=MLHmRJMyvtupbSVXzFw+g63LB5ZkKv54gGHl5sb3UNIRUE9nhkWDw6OWJPdqpTB9KZ
         nKCEtHHY3uvg61XGDqUscFfBoqNogkNC8Pp4mI0ORMFvDuEJSNI1wS9fdhFXKuGjtwlQ
         SvzPQcE+KhfouP9eLIzOKISIBmFPx34uRoKT5dzPKAYFPKGK3uew3XVka8rvSuuWLt/6
         eCNa44wQ1fDQIoB2kXteGxwpGS/Js+kfZewdbjonom5NRo6lz00HVeHOLHZZqH26Cyqy
         KpNR/CsjMvOjgrGLOYnXwsLLzwcXUwLqkmeOAkrBLzlLJNs22lmoAPI2ey7ceZR9oTqg
         J3tw==
X-Forwarded-Encrypted: i=1; AKwUvByavkKhC8TNz7Sy0XE1vdPZS4axDrLvsIJOnahX+f+O4z64Wgw/qo0itm9kAp7tmuFytiCvK8sHETT/XHZi@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+hZFAUAFfRsRKUOBAY/4ifcm0D6aMfG52J3/9SrumidQGsXiX
	T1MPSJbcUw9l7D6a633hYnq8F9GEQJPV+yDf3ZGrI/CCM0sq0ejtTio4t1KJDZjgdubaQp50Ueh
	nrPX+xqzB/6aA71RMtmIuUPeG8hwX3LRjPUIFo2u5l8jnH/eCHeI7F3ZPqLHWCNkVQhQ=
X-Gm-Gg: AYBFou2dVvEYQ3194XQ7xVyPeq60W37ZQbO6HOUo7XxTNX857L6+Ng1at3pMzxVoq6K
	OUEK9P2ItrChVCtWHCgNDo38T3q1U3HA31iIn4JdL9nCfpWBKV5ZIF5iYP1yOs+DlpoLZQ993wn
	GYGm1P6zSkeQnUlZaZJ3YwGvUxpPAZg321wW23zQJ39YsVzuVN5yfhxqvcPK009aeMNhGAVvbID
	jgMfxiPATJC93LhEq4Oavr4otU0Vs9PMPEoxox8nswNnj4eCT6bCSKH+3ikKXTIl5bTkRhbWkJI
	zJmuL2C6kc6Za0dOg0m0J0d0FQzkVIphF9XMLw3zRiOk4HUY9SLgQ3ejekXqdt8tbxyZjD9z05o
	r/194vxwt5SGIImVynhWAFO0rRWTwG/vPX7is8zv1st+V36wH4MVIJt/HX0Dp4WWUDjJVr31vDi
	QBYvvKSaMGkrbO/+BNK6vk5g9MxuK6OMfd6CYkob3bbi5F3YM/T2fs1ppzNq9lndsqR8/1r1GwZ
	eM=
X-Received: by 2002:a17:907:398f:b0:c40:f9ea:7382 with SMTP id a640c23a62f3a-c4196f9d8e4mr185643066b.0.1792248522649;
        Sat, 17 Oct 2026 07:48:42 -0700 (PDT)
X-Received: by 2002:a17:907:398f:b0:c40:f9ea:7382 with SMTP id a640c23a62f3a-c4196f9d8e4mr185642166b.0.1792248522284;
        Sat, 17 Oct 2026 07:48:42 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32878bsm181645366b.12.2026.10.17.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:48:41 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] ceph: support subvolume quarantine
Date: Sat, 17 Oct 2026 14:48:35 +0000
Message-Id: <cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CephFS subvolume quarantine isolates a subvolume while allowing access
by recovery clients with q/Q MDS auth caps. The kernel client currently
does not advertise quarantine support, so the MDS can hold its requests
until quarantine is lifted.

This series handles MClientCaps v14 quarantine notifications, checks
cached data and metadata access, and handles disable notifications.
Fresh MDS replies allow recovery after a lost disable. It applies directly
to the base below and has no fscrypt prerequisite.

The first patch exports d_find_alias_rcu() to GPL modules. The remaining
three patches add the wire definitions, record quarantine state and
ancestry generations, then install the access checks before advertising
the session feature.

Changes since v2:
- Add the VFS export prerequisite to fix the undefined d_find_alias_rcu
  symbol reported by the kernel test robot with CONFIG_CEPH_FS=m.
  The fix carries Reported-by and Closes tags.
- Keep all three Ceph patches unchanged from v2.
- Replace object-only compile validation with a complete W=1 kernel and
  module build using GCC 14.2.0 and the robot's x86_64-rhel-9.4 config.

Validation:
A complete W=1 build with the kernel.org GCC 14.2.0 toolchain and the
robot's x86_64-rhel-9.4 config after olddefconfig passes. It produces
vmlinux, bzImage and all 2,233 configured modules, including ceph.ko and
libceph.ko. MODPOST succeeds, and Module.symvers contains the GPL export
of d_find_alias_rcu. Configuration changes are limited to olddefconfig's
toolchain capability normalization; there are no manual config changes.
W=1 warnings remain elsewhere in the kernel; none come from Ceph or
dcache.c.
All four patches pass strict checkpatch and apply in order to reproduce
the tested source tree. Seven deterministic source-extraction regression
runners pass; the ASan/UBSan/LSan VFS runner also demonstrates the remaining
cached encrypted-readlink bypass.

Known limitation: cached encrypted symlink targets can bypass quarantine
checks. fscrypt populates inode->i_link, which the VFS can use for readlink
or symlink traversal without calling Ceph's get_link operation. Uncached
encrypted targets and plaintext symlinks still pass through Ceph's checks.
Closing the encrypted-target cache gap needs the separate fscrypt support
and Ceph opt-in follow-up.

Live cluster, KASAN/lockdep, multi-MDS recovery and depth benchmarks have
not been run for this version. Existing snapshot mappings need server
notifications to revoke already installed PTEs. Disable messages carry
no generation, so same-rank ordering relies on ordered MDS delivery.
Recovery assumes the intended rwq/rwQ delegation; overlapping ordinary
rw and read-only q/Q grants still need server-side cap filtering.

v2: https://lore.kernel.org/r/cover.1792074165.git.amarkuze@redhat.com
Robot report:
https://lore.kernel.org/oe-kbuild-all/202610171220.i77KPiw5-lkp@intel.com/

Alex Markuze (4):
  dcache: export d_find_alias_rcu() for modular filesystems
  ceph: add subvolume quarantine wire definitions
  ceph: record subvolume quarantine from MDS cap updates
  ceph: fail quarantined subvolume access with EACCES

 fs/ceph/acl.c                |  28 +-
 fs/ceph/addr.c               |  72 ++-
 fs/ceph/caps.c               | 291 +++++++++++-
 fs/ceph/debugfs.c            |   1 +
 fs/ceph/dir.c                |  51 ++-
 fs/ceph/file.c               | 117 +++--
 fs/ceph/inode.c              | 841 ++++++++++++++++++++++++++++++++++-
 fs/ceph/ioctl.c              |  13 +
 fs/ceph/mds_client.c         |  23 +-
 fs/ceph/mds_client.h         |  26 +-
 fs/ceph/super.c              |   2 +
 fs/ceph/super.h              |  80 +++-
 fs/ceph/xattr.c              |  54 ++-
 fs/dcache.c                  |   1 +
 include/linux/ceph/ceph_fs.h |  13 +
 net/ceph/ceph_common.c       |   2 +
 16 files changed, 1482 insertions(+), 133 deletions(-)


base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
-- 
2.34.1

