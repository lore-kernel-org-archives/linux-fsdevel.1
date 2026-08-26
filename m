Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBAB3CCFD2
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787784998; cv=none; b=KZnp+AlCA5IM2SxzmCUwDjDroNikDObkajz9sRXHL8NXITFA7vVJrRfSQvAYCr9V4udOHeYblwYU3DjQS0nbzfvW5kwEJ1aiRSspM/N1vG2nAv5mp/twQ6PEimFHzm5twq8u+wXYZP0MsKOBgkU2jUHpcfARAzWW5+x3riuNOfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787784998; c=relaxed/simple;
	bh=/fOSJxoORQPFwEkxLBYrBgJUXUsKK/Qa7GdbUhqFR7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VyA5EKLFGYXwvQKH5TCBjFqSuutdqGFsU1EDMg6Ha8Ko+OlCOsnIYMboyhT4hSAm9+mkg1/G39VHavHmWD7Ee7zNxrW8v/l/AqhPYkcZ7f7B3HerXgKZIhyoHfBx8y/q6Yl1NVtEAajWPx+oSLH2KL1dUIfcU2ME26eDKXFMPsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Sr/uhZjL; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Sr/uhZjL"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66e4027b6cfso17097d50.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 15:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787784994; x=1788389794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=odRjals7plgfDmlLW7eoxqdnO4aTDygPpbBfRGnnFGw=;
        b=Sr/uhZjLsKRfCzwyqQn0Uchpj/BKVirTzLDj0iPQQ+FbI+t+nG0W5YpemlBDHS+Ew+
         ksBWk46sCDxiY4syxa2s7NFWbyeb7uZS806yuSnD5ca0BXhCrqYaeByy2p/8crkBgPfD
         fNrZh/z+cUf52K8WohIioav3uAGfaO9y3YNuD6ZoPesK1xGO8oyeWkDQigaDrXwVORId
         K7k6ZOWitAw8zA1kTji3Wmrb+nQZv4pJwCX9VGLt+F/ZVXitsTM3vhjai9epAV2oDdWr
         zgERyuCle8VLGsvMM1rsVfi1KcyEqerNmSssPVaqzLRJG/5P/rmqVpmSRTWL1bs2Z64I
         MBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787784994; x=1788389794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=odRjals7plgfDmlLW7eoxqdnO4aTDygPpbBfRGnnFGw=;
        b=jBmWwIv9pej8mQQVD+1n+CA4muAIonwI5HpHy/rq0te5kKFKXSkCjnQsLLRFmh8TYx
         M+orz6QN5CeoWtigSchhrjEjBoTiduVrxSfIPkmXqPsc4+CcFbGL6O9g533mHbsFKm1N
         hO+/2n6Wj6GV/7CIknAj8/F/GWjx9blWT2suhsD0yRYW7zSU1ep2fvh/7jYnZioVNe0B
         WTxjpMSEEdOeu6PkR6dN5Ovx7Txlx0X/NV4XkLeKC8s2FpOEz4imGPqv3IlhpWO1D0Rf
         pjErBNwBjEwM9vbjJi9QzQwf1PaYE98stfEJ+bcAIGh8H3lwIv+TcZMDIFRi9jId6HDr
         xm4w==
X-Gm-Message-State: AFuF++klEomNwFqWff7165CHJZgAAijlQKkk8TuQVM1CcKGvt0MuNUwo
	rGxEV8MBw95GKTKgatQttcXmENiNFONiRLrGl0cXRosyB2qIrgrwIAZI8VrErxsZtvA=
X-Gm-Gg: AR+sD12WpndWCxN6642CY29v+/KF9aNQPxU6XsfmgKI2LWinD236EmwASAQXwxoIZHz
	RC8KB5OGZp+uKp1EdOPc0hWTREM8XimlubAKLvK9g1dOyeHy9tG3+nQX0qPfy2704M7PxSWa2DQ
	qzF4CZTDesTrgO5n+pSzT49zf4sFDJhCgu++qGmc5fYvzKUcKh3tf1Mu4G0rPpz4X7T2vlaXab+
	+yXYUZXryD26icUMMsAVm2dQ/DLDMyu46TYq2eY9D172+jiKXqDXDzrI6fKwvnjJQpSsVzlKAaW
	JCueT0JLaiLqnv6TxfynuJxCOXwXTUrVTKB1FZgpd7kFqO0v7Z2Z5a+ZOP77jn80Bal2l+rQ9qV
	pq9HwtZEPQAW+v5xucSKYVoxPPItNdHdTdy4OPbfe8PrToo9wZycHL+JVzZVyGHwTCVvFut6Rn6
	jIHmK+XhIZ2Wg3pr5ySx+6nc3NFkJ4JFc9Tq7zAh0wvkg5mFcQ0d92pP7I2UVEAJV9naCUuN+eb
	tSgfcSjwYjK89M16i3U8qSNklmcv+tQY0GKZCNXus4EC2iq3vCmPeW14+XNDrg2NMphEveJpdRG
	lgppFGt0ml2EaFnACQ==
X-Received: by 2002:a53:cd11:0:b0:66c:bf45:bc0a with SMTP id 956f58d0204a3-66d25666916mr3004495d50.11.1787784993982;
        Wed, 26 Aug 2026 15:56:33 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6de1:2161:6e4f:d299])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d243b9d47sm2130161d50.0.2026.08.26.15.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:56:33 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 0/7] hfsplus: convert regular file I/O to iomap-based operations
Date: Wed, 26 Aug 2026 15:56:07 -0700
Message-ID: <20260826225614.486112-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves HFS+ regular file data I/O off the legacy
buffer_head/blockdev_direct_IO() path onto iomap-based operations with
the goal to retire the older buffer_head-based direct I/O infrastructure.

v2
Christoph Hellwig has detected that taking the page lock around
the kmap/modify/kunmap section is not enough on its own:
writeback drops the page lock before the write actually completes,
so a mutator that only waits on the lock can still start rewriting
a page whose old contents are still in flight to the device.
Mark the allocation file's mapping with mapping_set_stable_writes()
and call folio_wait_stable() right after taking the page lock in
both functions, so a mutator also waits out any writeback that was
already in progress when it acquired the lock.

Christoph Hellwig suggested to introduce a generalized version
of iomap_dio_end_io() that was placed into include/linux/iomap.h.

The hfsplus_btree_aops uses hfsplus_btree_read_folio() and
hfsplus_btree_writepages() methods. The hfsplus_symlink_aops
uses hfsplus_symlink_read_folio() and hfsplus_symlink_writepages()
methods. Also, hfsplus_setattr() doesn't distinguish the regular
and not regular file cases anymore.

Viacheslav Dubeyko (7):
  hfs/hfsplus: exchange hardcoded number of extents on named constants
  hfsplus: rework hfsplus_get_block() logic
  hfsplus: take the bitmap page lock for allocate/free
  hfsplus: add iomap operations for regular file data
  hfsplus: move file related operations to file.c
  hfsplus: introduce iomap-based file_operations
  hfsplus: switch address_space_operations on iomap-based support

 fs/hfsplus/Kconfig         |   2 +-
 fs/hfsplus/Makefile        |   5 +-
 fs/hfsplus/bitmap.c        |  18 +++
 fs/hfsplus/extents.c       | 157 +++++++++++++------
 fs/hfsplus/file.c          | 307 +++++++++++++++++++++++++++++++++++++
 fs/hfsplus/hfsplus_fs.h    |  26 +++-
 fs/hfsplus/inode.c         | 269 +++++++++-----------------------
 fs/hfsplus/iomap.c         | 189 +++++++++++++++++++++++
 fs/hfsplus/iomap.h         |  18 +++
 fs/hfsplus/super.c         |   1 +
 include/linux/hfs_common.h |   8 +-
 include/linux/iomap.h      |  20 +++
 12 files changed, 771 insertions(+), 249 deletions(-)
 create mode 100644 fs/hfsplus/file.c
 create mode 100644 fs/hfsplus/iomap.c
 create mode 100644 fs/hfsplus/iomap.h

-- 
2.43.0

