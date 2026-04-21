Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BF3750B6
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795965; cv=none; b=oEhcn6VTV5JhtAq1QkYoy033vy44OqiH8P5P6OhIbNk1Taiw7VqrA07Kf1P+xgfMLNJWOPZai2YaG/TcJMbshYmuPB3CCgqQi1WYFlcV1XxZJrGG1B3CHfmEXtI/KhkPh+9A5XSoFg3A5bf9kYo8o2mKlmLzAzgeG2aSbmM7neA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795965; c=relaxed/simple;
	bh=fG/Smu8c4Fbz698J/8LIZMpA/DvI7evtlvs57A4nnZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPLxbSqvfvNfxPiYMExvYOnMXP/zv3zwf3+LHWZ/U5sujemCmQBPjlNPGSLEJdyjGcb6ZZEj3B9x7DfyBAxZI4IV0zG2+Rvu8yheLwXNZj2wxvicGIJcO6EkJ5XalPK92tV4uloVw+1Ge5PnmhYEcw2ohjO8tk+tAep+KwsDeuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNcYY3kt; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNcYY3kt"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-441209fb77eso652194f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 11:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795949; x=1777400749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn7Ydh4WOilQSxdiTFvb+YkeL8VBZsiG7EJ/UuoUcpg=;
        b=pNcYY3ktRsLgtPXC+Y8i9CaIJm9G79T2MViMuILZFvlF8VjlNBaaON00lJyXizz0NG
         j5OT3dqrUa1j40L3zA7BoRY2GP8MIJ9iKOJXgovgdJFA1/rqwoFdVmjo3c/FdNXsmCvC
         QgB3q6hHecMcXISh1bKKPFaJXb/YtCkU3Gr9kZCRhwsw+ABC6MfK9g6idYfpmn1R7608
         Te/MbALktvrfDaxcrdAtrFLBgYUFiOP+yNMLR6/woF41vdLtsVBy9JjfmfmIcD/Ld9Rd
         4tJY2l6SN9gYZU0QIYbyCNp7nWtDJUgNyIn2oeaK5bOExLcnN9PQYTJtFoDrR9vVQ1N5
         V/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795949; x=1777400749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn7Ydh4WOilQSxdiTFvb+YkeL8VBZsiG7EJ/UuoUcpg=;
        b=YmeFX8e6EjsXhCikHY2az/gItE8Ox5Vva6s2Q0iIFjhu1Z/wuphhPrP82E8Llod289
         p77sB86vThblPQSiXgx3ZzILLmjAbTHCHgXVy0TJsHoXREQZK7Rf4jo+qpFo6t17YHic
         3gzpD4r8IFJv4VZXvE+Do1XXNqZk6Nj9mi574M+m24Au7Ey7nkabn2aazsjXTb+XiZR/
         KH3VVGxQFh/ZMbYAVhQIYGnoPUfKUy1mNfgen1wt49InnCoMwFftdsnudhaG4KF1tJaS
         wpcz5/G+C5dg14cbqBec5tPyvT89skdChR+5Hj2LAPhX+9fGsGdhWy/1tZ5FsKPhOVDu
         j2+g==
X-Forwarded-Encrypted: i=1; AFNElJ/Lgr7eR1LqPpmsPwW1dZomEzH3CB4Ux81D/B5NNUC4F/GSqJir1UBy0C58Adlp/S/YPFqc+3VNKVAhYx0O@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8IJUbpk2G9aDO3Yk8c6rbl7kU+QveLFc9pFf78lujuCWERI+
	q+0nzNjE1LHCXLN6YBNGcqxDdP7JlIZxRglTIBm9p7XfpmEGgWVZaem9
X-Gm-Gg: AeBDiet93bGftrQSUNyL55zSDOmti9ng1gK7irFRFYnA4VCNS/Hq1GOIkd85jeVZ87+
	g590JrPbBpKS/nZ62hUmq7OgJGDeOzvvl+sKOmQaw0gVQuM7WDZIdW4Gm1PA1dMeaMU4dQJKCHm
	keLoKGh7DWFdYDjSBF11dIcJ4hH69E6vDybDHMwtH08IWlUeAvc5ZnQkvVuzNDjLKBpKMVfY1yq
	lq8icACesI31coMMHAt88Up1mYpIpxDLbgyh6XKojG1g7erBNCEzFNny9+N/XGZp3Key6L/BbWY
	K+JqC5Upo3zpGNVr/uflk8zhWy+liJA1LCGl+Ix1399gb2DC1kejX0YIOgbA+Geb7s0a2m+ch1d
	qpqk/4jcL2w4Rmf6uuOqgnP97DquH3EjsXVV4QRIXl2j7FDOTeo/6BXyjGTDpSQ9fZKDTP7iBlE
	kmskZrjbye+lDTRx0OAf4sjMPAwFsZFRLo8mQW3WPektES8bOiZU2u8Lvc6mQpNS2rnGHms92ob
	y1wOLjCfg==
X-Received: by 2002:a05:6000:15d2:b0:43f:e571:184d with SMTP id ffacd0b85a97d-43fe5711898mr19129355f8f.28.1776795948775;
        Tue, 21 Apr 2026 11:25:48 -0700 (PDT)
Received: from f.. (cst-prg-4-152.cust.vodafone.cz. [46.135.4.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1405sm38694053f8f.4.2026.04.21.11.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:25:47 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v6 0/3] assorted ->i_count changes + extension of lockless handling
Date: Tue, 21 Apr 2026 20:25:35 +0200
Message-ID: <20260421182538.1215894-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stock kernel support partial lockless in handling in that iput() can
decrement any value > 1. Any ref acquire however requires the spinlock.

With this patchset ref acquires when the value was already at least 1
also become lockless. That is, only transitions 0->1 and 1->0 take the
lock.

I verified when nfs calls into the hash taking the lock is typically
avoided. Similarly, btrfs likes to igrab() and avoids the lock.
However, I have to fully admit I did not perform any benchmarks. While
cleaning stuff up I noticed lockless operation is almost readily
available so I went for it.

Clean-up wise, the icount_read_once() stuff lines up with inode_state_read_once().
The prefix is different but I opted to not change it due to igrab(), ihold() et al.

v6
- remove the DONTCACHE vs drop patch for the time being
- s/igrab_try_lockless/igrab_from_hash/

v5:
- reword some commentary
- add unlikely to the new icount check in iput_final()

v4:
- squash icount_read patches
- use icount_read_once in the new ihold assert, reported by syzbot
- squash lockless ref acquire patches, rewrite new comments

v3:
- tidy up ihold
- add lockless handling to the hash

Mateusz Guzik (3):
  fs: add icount_read_once() and stop open-coding ->i_count loads
  fs: relocate and tidy up ihold()
  fs: allow lockless ->i_count bumps as long as it does not transition
    0->1

 arch/powerpc/platforms/cell/spufs/file.c |  2 +-
 fs/btrfs/inode.c                         |  2 +-
 fs/ceph/mds_client.c                     |  2 +-
 fs/dcache.c                              |  4 +
 fs/ext4/ialloc.c                         |  4 +-
 fs/hpfs/inode.c                          |  2 +-
 fs/inode.c                               | 96 ++++++++++++++++++++----
 fs/nfs/inode.c                           |  4 +-
 fs/smb/client/inode.c                    |  2 +-
 fs/ubifs/super.c                         |  2 +-
 fs/xfs/xfs_inode.c                       |  2 +-
 fs/xfs/xfs_trace.h                       |  2 +-
 include/linux/fs.h                       | 13 ++++
 include/trace/events/filelock.h          |  2 +-
 security/landlock/fs.c                   |  2 +-
 15 files changed, 112 insertions(+), 29 deletions(-)

-- 
2.48.1

