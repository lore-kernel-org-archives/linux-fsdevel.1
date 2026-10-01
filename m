Received: from mail-oa2-f18.google.com (mail-oa2-f18.google.com [74.125.231.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED535E956
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790872495; cv=none; b=QOpXiU5SZz3QqrvlOH5GVReeNmy+n666eV+3AD9pX/9Q7w3V3PRqDTH0sN7+583+MTXyqyye+URC+OW2Crrl/7lOIJm8S3eYZZrNG7WyY+1r14VVo7O+t7mJ8Nn7klI1ByMBLS8dMKSV+QJbry7N17wcxh3l7E6hy3sWqqjIxxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790872495; c=relaxed/simple;
	bh=WkmK+XlQQX3qUXwgZnim03kUSt20YXcbzmJHM/2EZJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNLx8z5WY5IlgI6opqXygPwTDBaBY5FUm8SAaIJrvYODUiZmDFlGzHPVLAuqD8tLL5zoPJZWfAJBWqA08KIUCRXZbGHIycsSSjCRcjA8e7quEMxtVbbYmZv2kcgTAFWZmDEa2rV7QQCORTA2p3pkJbLgxaZQrvU9rcjR620cGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUzUGctO; arc=none smtp.client-ip=74.125.231.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUzUGctO"
Received: by mail-oa2-f18.google.com with SMTP id 586e51a60fabf-466ccde2ad8so4185904fac.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790872493; x=1791477293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kiju55ygaJriB4Kwb2rimCLoHI2M8u9N+dHPGcKCxK4=;
        b=nUzUGctO/kbRLN3a0OZrdTb4uZv/8zHIKGs+eVPFT2GiFaOSeEg4N+/GtJ8Vmv/hu0
         1hXSJ3g09GTFL2kUWLkaIFxQ2OYtMlRBk7biyHA3acVYsw4Xu9qbLw3xPK8x5fmh/6ZN
         dna9vX/Ce2hxNP0292WNB/WPAOzyh8yrKwDmOAugLyp7F+drggw1nN7zXV0G0rQbVpy4
         QFpjsxvvdLR91nNbpNLrW5R45DUYln5ga+sU3zn8/dhpddEi67/bXsbOvMMxIoIbQiuq
         24T51lIpqI0X2ECp8DDpO/7loXfVfHM+SvWUeCNluIHLiNYxBnxJ1JfQHx6CESUJQ+GO
         meFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790872493; x=1791477293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kiju55ygaJriB4Kwb2rimCLoHI2M8u9N+dHPGcKCxK4=;
        b=CBV8VMIrjUQvxAFx4H6FCiJ2mBg2H3WdaCyDizoYskGsSyTiYf5I4LQwfb4TjEirmc
         gJtpWtiZ7OgjOTvlQ8OHweZrcOEYWphCLuhogzgb+xMbHXOQuW9rBBPYlJDsx7o+elyl
         U/dPGLgCHsStOlYUWqXvjqBeiVfn38IEoyolcQo8vgKPHfnJ9+ZRpFwnLHcmiQpSLrYR
         SIJMrSWM0eYp0czpg4bHGKOzK6Z7qZi3q49DZ9koSg3bOMvCVXRU4RkG2ko8GdKfoXsk
         W+23RyeYJtDyZXOJeDi6YsKy3m69tw5e/r58dxnRxaL3t8YFZ2YQp+8pTo1OCBN9yG2N
         vgHg==
X-Gm-Message-State: AFuF++lv6gA2IyTyi87KNyba9wf1bcfyD5BNFCb6pfuCrTOcC+hQolD1
	qzY05nY7RT73BP/ws0oB1pjETbTB6OlBqjPVyaHdmW6Qlwe95U+nvvo1
X-Gm-Gg: AYBFou1bNFNhhTFMfl5qLVMfJ0XvZgaujneh5XuOmlKhVT+4wiIHR4KdNxHcZohLcU4
	Wa4h7x/02hwBso3d+Lwx3Sknu3Uu+xIEb4WQi2pG4jJTO3xNYpuDvOmaGAhSmYgIZcAU48dwTic
	z+pDldXhU318p4LDoC1nhPafaE+4fxqfYACbly7bM1YvHerRIxqVBGGlWEqHvsnNq0fJIfu5cCn
	vz9ys+8MyU3raZxwcBOKKRvzr3ixwfPRT8bhhja1PvCrtBsj7r/wLCzL++gbptH8aOYve+eeMR+
	Ew193OOBMBjxKYGaOTstzcxWViWXY2KCkWFSMAJIfs4sVuz6HFilUGQ0M12n1+a2TgH9tikVGN8
	xTydQepySRdDIvKnaIFUoUckrMBsi6lMzFINcMXacEfdVc6BmG6DUQHnHTxtnECf5lJYFqaN6sn
	CH6tD3IN5d1xEMRpxZtWHBAm04u9cayWQ8OemWv7QLoZBaJDhuLzN4uW5W2bJ4+iy1y9aRVH4I/
	4TB4a08r2KgZiRbxXtnCUwNyXSMG+qzIz5vZjPfYM2BnA3T54mrF11ePHXM0fhj6pkoAoSOMFZw
	urZQPMS9S8yVBzrFXnroYsGvUsuSnKuPMEHvEUTS6SNi+LBrdjH90Qzu0ZkGWtn0EaPE5yc=
X-Received: by 2002:a05:6870:c192:b0:46a:e0c1:6b34 with SMTP id 586e51a60fabf-49e15c57bd0mr24722fac.12.1790872492871;
        Thu, 01 Oct 2026 09:34:52 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49ded33505esm2712687fac.18.2026.10.01.09.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 09:34:52 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com,
	syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH 0/3] udf: fix double allocation from the unallocated space table
Date: Fri,  2 Oct 2026 00:34:45 +0800
Message-ID: <20261001163448.753190-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Honza,

A filesystem made with "mkudffs --space=unalloctable" hands out blocks
that are still in use, for two separate reasons.

Patch 1: udf_table_new_block() keeps the extent type in the length
word, so an exhausted type-1 table extent (the type mkudffs writes)
survives as a zero-length extent pointing at an in-use block, and the
next allocation from it underflows into about a gigabyte of "free"
space.  Filling a fresh 1 MiB image with empty files is enough to
overwrite the reserve VDS and the backup anchor.  This is the double
allocation behind the two syzbot reports linked in the patch.

Patch 2 checks the table once at mount and refuses read-write access
if it is damaged, for example by the bug in patch 1.

Patch 3: when a file's extent list ends in an empty allocation extent,
udf_next_aext() returns 0 with its outputs describing the continuation
descriptor, and udf_discard_prealloc() frees that block a second time
instead of the preallocated blocks.  On a table the block is then
handed out twice, and the fsx runs of generic/091 and generic/263 read
back bad data, with or without patches 1 and 2.  On a bitmap the
preallocated blocks leak.

With the series, fstests -g quick (2 GiB images; KASAN, UBSAN and
lockdep enabled) passes generic/091 and generic/263 on a table.  The
remaining failures (generic/131, 360, 563, 634 and 777, and a hang in
generic/346) are the same without the series and on a bitmap, where
the series changes no result.  The reproducers are below the --- of
patches 1 and 3.

The series is based on your for_next and applies to v7.3-rc5 as well.

Thanks,
Matthias

---
For stable: patch 3 builds on the int return of udf_next_aext()
(b405c1e58b73, v6.12, also backported to 6.6.y) and applies as is to
6.6.y and later; older stable trees need a trivial adaptation.

Matthias Goergens (3):
  udf: don't let the extent type hide an exhausted free-space table
    extent
  udf: check the unallocated space table when it is loaded
  udf: leave udf_next_aext() outputs alone at the end of the extent list

 fs/udf/balloc.c |  9 ++++--
 fs/udf/inode.c  | 21 ++++++++++---
 fs/udf/super.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 102 insertions(+), 8 deletions(-)


base-commit: ba5855e74bcd761123e39f4708834a0015a74a8b
-- 
2.55.0

