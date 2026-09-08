Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED342FCBF
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901506; cv=none; b=nB3hcf+w1X+ause7W+5KeI6DDbZEpfeJJ6jDrysJFfWQE6a4clq4csvi5mUUBYdyNpc46Q2xrNXfhXVXEaccXnKHz9FAaxVVk1DrAqxINyZQP76xb0KL5dgN9dNRp2JN4EnXPnsb8wR23S6WI2D/FzWbYm2nWcn5TP9IrsAJVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901506; c=relaxed/simple;
	bh=M70UUZB8RbEdIQDSJGfK6gfuonjBPkMbGzk2H0VfuAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3ezl9lTDX5V3rB09IFWxzgDwpay24cXvqERqVbO+mXHA9sCcSerXOKRKW/vrY9m+i8rtNphh5efVp8bZvVaUjO3rAW7ONe/vgQ9uOthEIIbuLDgpit6zL8p7CVb7VNGOGrGMOgyVOAaVPf3izAQukRGemQzUNpSq+ZUUvXQQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=SuwKru7Q; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="SuwKru7Q"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66d116f0de8so4453258d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 14:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788901503; x=1789506303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IymBD51GU+QA9NI7RVfxi4wRYbsFayp2/H5ySdDwOmE=;
        b=SuwKru7QT4f/FBG4Y+Udyf2t86xVSe4ZyRWEJYYVS6lQ5wuSiQL2pmKKSWim9gA0xh
         P9vBCH470EY07jzwMkPnM2vxgvQ/hL8/JfJUfTO1X9xM2zrH4zz3moK93PeRvXVXyohv
         oDAu6/76wpyzyVIQz+aosSIJ0b6acfusSky9Db4mwWD8Ag98xb1x3ICNxGfzh1z+H8qQ
         bSFUj7Q04zyMOHhQMTqcj2xlyictVlt6r786ekDStbGrWXET9aHRUGRQeetK1WTL9A/j
         YP+nwDHuIB2biFmP2f9zsSqPPruqWYovQ2yPuPiIjRrISyMCUzF9GKOK1sSNloLRDGbs
         G8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788901503; x=1789506303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IymBD51GU+QA9NI7RVfxi4wRYbsFayp2/H5ySdDwOmE=;
        b=tTuwP4VjqstHL6g3HaQQUPtk+bI1qg15R+RHcNfqPye6RSn0oUnQze84hQ3YRWbTsb
         OwqT5I/LuSxS3Am8jsa9OSKt//GYmNa06wa5825r+hneUmBgv0CwgLSmzFEV+blQrfeJ
         DHb/pToIZqJwPyO0KKio+GnIxgr9J9ujLyszj1eHj+r/XMAi3upvDndV7X64tOX5OCCp
         /sx0ipO4p4R7ShU9iyK0PL/0xS5w5g5UBb/s89G+MhNqowrCDWku3mpNdK/fRIbj1RIy
         txz3Rn6YcRhhK7IDhphq6dy5FdYOs5aIQjUlZyvRoGTdwShlm+C/MbDsJ7U/T2Apkda/
         sQzA==
X-Gm-Message-State: AFuF++l3IVsXRlLKJr2tFBcc9ABnOCZvgiievyqlUTbiRfWqrahvoRSW
	p1HpnffhbRdUTrXhTsER6cCbCNSzwl88CeA2lD33Zh2ssn6FLquKs1uOdWJNUEUYYVI=
X-Gm-Gg: AYBFou02VcEOA2hQ0u7Q5VHjRYQLboLMKz2RJce4CYCdDarI+sxCmUXgTjdSNOKLY9O
	y5rwWktHB+j2negbnhBPGEv6Ib7BpN9lhf3x/cZvir/a1/UAStJCXCe93VrJtoW9LTOrwLwknBj
	Qhl9jfVToNuZnCNTwyxOECs+4ljQQg9i/p4uQjvCwmMWBccbhTjLeihe3+QPyXmRRSES+phPY3x
	d8IFO9nuzi2a+9piEzvUZFix1hLHgibpqtiHsJJEoodqmDLuznOclNwdrZ1Il0umon0Q2gNqzXd
	jNfVfS8PUIe3naIgY5oZI35YNE1F8cylcYusCjUgOE5ZaWrVZQ7Y6bVzafKL4HQp2CixZDbopf6
	z0mosyG5/17Wp1CrGlh3Ggg7F8h3DURkZbBiOzeq526f9o7KkuvJkNbSB7434cdxgWwFfKaQfji
	nLbqWj7S+/zfefNfGUZSRNIQrVQuigqdEIXSzvsXjZV0RWxu6ZHSQCZ17ZVKZDmz1c9k2Pl7ETo
	fH/AZe+lLOzNdsRHOYUbz+R67yDeOeFlhydc1Ldk7vH5uDL8eWZ2ilAmOptN0oyDn5mOwSzEV6y
	FeZ3d9lQtFVWZjLJ
X-Received: by 2002:a05:690e:439b:b0:66f:a87e:2fdb with SMTP id 956f58d0204a3-66fc1ae0b79mr5594493d50.8.1788901498761;
        Tue, 08 Sep 2026 14:04:58 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1eca:212:86d0:4e87])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb495eccesm11078129d50.18.2026.09.08.14.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:04:58 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	willy@infradead.org,
	brauner@kernel.org,
	djwong@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v3 0/7] hfsplus: convert regular file I/O to iomap-based operations
Date: Tue,  8 Sep 2026 14:04:41 -0700
Message-ID: <20260908210448.296772-1-slava@dubeyko.com>
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

v3
Matthew Wilcox recommended to use folio_wait_writeback()
instead of folio_wait_stable().

Fix failures in generic/091, generic/521, and generic/551.

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
 fs/hfsplus/extents.c       | 164 ++++++++++++++------
 fs/hfsplus/file.c          | 304 +++++++++++++++++++++++++++++++++++++
 fs/hfsplus/hfsplus_fs.h    |  26 +++-
 fs/hfsplus/inode.c         | 281 ++++++++++------------------------
 fs/hfsplus/iomap.c         | 192 +++++++++++++++++++++++
 fs/hfsplus/iomap.h         |  18 +++
 include/linux/hfs_common.h |   8 +-
 include/linux/iomap.h      |  20 +++
 11 files changed, 787 insertions(+), 251 deletions(-)
 create mode 100644 fs/hfsplus/file.c
 create mode 100644 fs/hfsplus/iomap.c
 create mode 100644 fs/hfsplus/iomap.h

-- 
2.43.0

