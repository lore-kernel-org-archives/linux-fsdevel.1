Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72A3A6EE3
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782943966; cv=none; b=Xc9otS83lWEArC4QAIeyWs9L9N1A01Q8CXJAhQLGmgxf9aPKUuG6z6EiXAsiVuSM6nJ1j72n87QDvIksHxVzrK961wyPs4k5mXrf3/snqR/XPQOr92PsKg67tygP2Qb23uEd4SZ2bdRi9vZZQ8WZV0YL68TPS9zr6v0dq9o4uzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782943966; c=relaxed/simple;
	bh=ka8gPEmyfqzBFsUMgLAkSisRH1vQW2tER46iuHNVhL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b+mty248P04MgqRZ/XOoo1NeJydSMVxRPkxUz+1/w53/PE+31KTJcq/XXRxugAcRJYDayi0s9+vtZUjeSZLwvmf6LUWC6oJdRaD9wyBH6LxdXq/yxHrgHBEWUGnsV2/HSWJJfP4t2i4zW7PcqhuOa8FjNkhGZ1iq7P92FqRYhic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBx42Suf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBx42Suf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c99672293cso10170195ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782943964; x=1783548764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uy9dIN6TDlPqLoiaW8jsGbOVS1uf9xXByuLYxsJLLP4=;
        b=HBx42Suf3xgTQqGkgMcM1WTZ/RKyDlXQfLWmmmat6qwmSqLZiTrxZCiFZHgpaPix72
         AjUziRtkutYMm9ZHRbyk62L1n3rQYBv/iCIvPACZtZzXryRSdUPRS8jmExyxYBfEboNj
         7YeQnRaOfdjKIo2I7wd20mXV/Fm4SA8jdurN/gOMoRkkrGkWg1TbkKR0uNdIlM9/vJCs
         7kJw4UbYGwbOhx83Y9yWqw50CNXDxYiNui4uszmMxW+a9Ljc0buixQ6D3MM2SSASBetd
         Iau4TCaMiMT+sgR4k/4sOgmbE9cSE6yoVKj/zdxU3btVybonbe+CwdtnB5HQjFWXaZol
         sDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782943964; x=1783548764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uy9dIN6TDlPqLoiaW8jsGbOVS1uf9xXByuLYxsJLLP4=;
        b=F3xIl9e96I/uCDf12fgSRI+hR9qPGX1XIMnHma+Xnm0gCAdVlBnYO4Stkzmapmwl+E
         tC5pXYlpjatPVK4Abmq2Kkd+J5UB9/LWUu0KxZhRHD4sOt5PaJDwZLnYjJaa6itHPFIl
         03jEw/2P58ZCJ34P3rsIUMuWsbVDxllE+kyVEUN87noyGWhrv8AL7i8IUNhN4OovJ2dB
         ZaB7oEAEobocGI+ezq6meavHwyyulNrNYVv97KVuIYuKng5jeDjkqW2HNv8OyNJ2MoP/
         800yaeHAnLw5UrtLH8l8+CuHwWDF4u8epKQGOIQ2CvUh54WxmQOJUW5oQGvJh0Ub8P1m
         KDEw==
X-Forwarded-Encrypted: i=1; AHgh+RqrnzK7TsnfCORIBjY306RpNkA7PqgQPU9DtNAVKAlScwJyI261UYQLaJqYgrWJcn8w8BQCU01EDnb3Gzvd@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfF++Id5YqDPVXDPyvxWwXZQhtrak2oZxpw2Td5yb786b7g9h
	BmU9go/dJGnaNpBHuxjVByI3lmNe5rqSTYJDOJOzISR8PbmOwWotAFWl
X-Gm-Gg: AfdE7ck/iaUBvNmWt2mV9dh7EDKlvOBhuUBxQ15fUjOxFvsHiKQ2g0H1TOPnEdiqDRe
	fHwKzO+8CUDNZyz5ybeJEIVb4eUJWFzQL/JbQLrGnjCdT41CVgURP1ryKsW46xsrPyF+MhBXFgB
	3D0D/JcPdNktF63SAGlZDCIXUnFIeHkTkh+y256s7AHctuGDzHd8kMET+IZ2CwsErMS8SVUr9PI
	/R7VKjgHuF0MfB1ZTxNCZQQr1C9Sdd09SRhWk0YxkHBGhrCSrKxS/v2VwFcMXcwWzaqH2NC50Vh
	RJlUwVZqbG0RSFMbiVV5CpqaC6FHfJtAlRnjU+Gtw+9uh+WNrM4t/kXs+AWc3Kx31vxKsJ2NgCb
	0rugWop+JHUOiU04G6fQBVpx/00rSh6y5CocW5SsrCIcptcwrYJY37VybbKFLwX3QiyVL7LAZ45
	g9pCmD0baosjxtAAbeJcFdHqXLvl4QuJREjM0mXYGaNdtrYxEHD26BisuwbBbpbW0=
X-Received: by 2002:a17:902:d549:b0:2c9:c991:3bf0 with SMTP id d9443c01a7336-2ca7e682ad6mr38439375ad.8.1782943964222;
        Wed, 01 Jul 2026 15:12:44 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dade5sm4384595ad.13.2026.07.01.15.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:12:40 -0700 (PDT)
From: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG/RFC] ntfs: crafted image triggers WARN_ON in ntfs_map_runlist_nolock()
Date: Thu,  2 Jul 2026 07:12:37 +0900
Message-ID: <20260701221237.822167-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I found a crafted NTFS image that triggers the following warning during
mount-time NTFS logfile handling:

  WARNING: fs/ntfs/attrib.c:177 at ntfs_map_runlist_nolock+0x1275/0x17b0

The observed stack is:

  ntfs_map_runlist_nolock
  ntfs_empty_logfile
  load_system_files
  ntfs_fill_super
  get_tree_bdev_flags
  vfs_get_tree
  do_new_mount
  __se_sys_mount

The warning site is:

  fs/ntfs/attrib.c:177
  WARN_ON(!ctx->attr->non_resident);

The caller path reaches this through:

  fs/ntfs/logfile.c:677
  err = ntfs_map_runlist_nolock(log_ni, vcn, NULL);

The current hypothesis is that a malformed image reaches the $LogFile cleanup
path and causes ntfs_map_runlist_nolock() to find a resident attribute where it
expects a non-resident one. Since the input is a crafted filesystem image, this
looks like it should be rejected through an ordinary mount error path rather
than tripping a kernel WARN_ON().

The crash was found with syzkaller/SyzDirect on a recent local mainline build.
syz-repro reproduced the warning during minimization and reduced the syscall
sequence to syz_mount_image$ntfs. I also extracted the crashing program from
the syzkaller log and generated a standalone C reproducer from it. The generated
C reproducer compiles locally.

I have not yet confirmed whether this has impact beyond a mount-time warning
from a crafted NTFS image. I can provide the full syzkaller/C reproducer and
kernel config if useful.

Thanks,
이상호
