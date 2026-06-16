Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CEA3CFF60
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 05:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588923; cv=none; b=S/3nP10OhukiJWbG/QWRKT5Y5+fE81o5SVmwmTqMVv+V2gngmfoNKKRQ9R6c+q/FgwVx/LmkNkcslBeuEP5G76cN/nSSmVdEIH+iuXcqcwEfSlzcoYDEj0NcEvL7MUZsN/VQ3ha2ThR/++xPM9dnUhORDa5WXwm4BFkz09THdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588923; c=relaxed/simple;
	bh=fgTYOzDi7Yp08I8w7uEkpIGyeh5Cl9Yt6cXitN/ZgKc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=OykMMiTte8Zt0qpW6zzga0iJu3p+M+vILNZ95Z0SwGGI37Bpn6zC/mA13tiyGPGYjlACe1lJXwJJbrbfuGOzym1Wlk1IAjD7yYSYrIStnS4H692gN9rdMI8GxcqvmtyjCyoyTk/7/QiqFImJJWWg6L7jY+yEcMGbPEbvF5qdzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=cCtCq6Az; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="cCtCq6Az"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68d65d24so3766380e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 22:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781588919; x=1782193719; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpyvMyTtYWxHLnxtKTBgFPEcwA+nlx+qU+ONZYFFYk4=;
        b=cCtCq6Az3Rm4q7K63YQu/lDsvhEWxOQ4Tqb60DZqnJIPML7qllYgvfoz7pHrc1Xnxc
         pBEa12QuNLJMMsey7j43fuz9JXc0MtjbUiWCRLmqpKJmW9emZM8lSyyMOo0/XvczLvV/
         fi/LuQmPX3wO/Nwpm8MgUIF7KB3YvjwlpiYLGqOP+/cgsHH1v9rOYo/5M90GofEoSJC4
         kvLBhAHYJ/QrzFN2niQ7eYc5U3PYqnZL4i1vAOUHjXTeIfpksUKJ+AetjRFSOjexgkh/
         KRRzWc+3wYMW2iKudUMR6GYsXWb9W4uUdlYfFRFQbQxxIub3WKmGe2sLOg483BAKYzHd
         EGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781588919; x=1782193719;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpyvMyTtYWxHLnxtKTBgFPEcwA+nlx+qU+ONZYFFYk4=;
        b=HXaA+QA/v3DwwFrmFaSFCXa1+6iSpnk5mLJe9LWyOfJWxpKFGptRqSwWJkSJsIudIV
         GT8dAmC+xkYJo+Mgb01Yxf7e0pK5zbZ6Td78DhAso0I685FP3JJVIJQmHo5Lv7i7ugQj
         cWgEoiwauua49aj6SgLGIv9V4fX0ngxKNxnXrbE8zhM1Y1mQDPKo+NRabw2QGoI2BA62
         I6ucisZkeYrs1VHQTvDIUcRbAydyym3qtw71gpC/GwKdqVhH1bwSSd32JefISdhGvt3C
         K/IweHLDkmAVtOAwhSGjgz0rRXxXd33f5vmEzpLpFNdZ56X0mcCyMg6PcAI9sDa/+p40
         h66A==
X-Gm-Message-State: AOJu0Ywe5x4HI2WvfXwWOpHR+gIVWUe7ieGBWtzE/rgfj4YqoooGSab2
	KKpVGeHAynY8lcomVcKo50QlYJ53AScDN3mUn4gvMSRgBF04iCss6R16TUhxoAk4m+U=
X-Gm-Gg: Acq92OGOtEVGpBgSkeb9GvwVgGASwq+ASXsley6+f4yzaEtrYKNO+7xzUtshfVdruHB
	6SKymhmRhG6MmzS0wcSzcrv8wPCVU+vDReHHQWwO8KynK9Crpxb6OfMJFdLTLxTB6vfE3Qw2mAY
	3WaYwkzUo6P7IeNSvhrWtfPSLxBWJc+vr9r+c/Vs0hpz0OQCvTKCb+toxXmHcmacLS1k6BiOgAa
	HYq24h3og70qFbUbOlF3F0YWanwY24QeQDG45gMSqaBRrzbOq3kMQFMyTEs53uwLf68NFIfcAUX
	YpHQ08B0lsSkxlV6vYa929fGG7+0dzoqOGz1ca/nkgPM9ZRmHoHnwXSlucbwbAdYrUGBJAZL6WK
	GA5SfL5B7pprnt5qccuZw2J+A64moX3U8AZblLbUORfN/wIybm6JQXFEnFBKryTzr6JneWZUIoy
	eBWw0MLZoSrueBAiHxBVjeYJh05dqjWdz5KFxv9xfcD+MZcmRSrotWQHaP+ZjAtuEqM6lWUkruQ
	cs90CntEA==
X-Received: by 2002:ac2:4554:0:b0:5aa:6db6:537 with SMTP id 2adb3069b0e04-5ad42775345mr551613e87.16.1781588918764;
        Mon, 15 Jun 2026 22:48:38 -0700 (PDT)
Received: from [192.168.3.148] ([31.23.24.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a725esm3248472e87.48.2026.06.15.22.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:48:38 -0700 (PDT)
Message-ID: <fa1082e07e6396634c97d28d4489ab1902cad099.camel@dubeyko.com>
Subject: [GIT PULL] hfs/hfsplus changes for 7.2-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com, eadavis@qq.com,
 rosenp@gmail.com, 	tristan@talencesecurity.com, Slava.Dubeyko@ibm.com
Date: Mon, 15 Jun 2026 22:48:36 -0700
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Linus,

This pull request contains several fixes in HFS/HFS+ of syzbot
reported issues and HFS//HFS+ fixes of xfstests failures.

Edward Adam Davis has fixed a null-ptr-deref issue reported by
syzbot in hfsplus_create_attributes_file() for the case if
the attributes file is not loaded during system mount. Also,
it was added b-tree node size check in hfs_btree_open() with
the goal to prevent an uninit-value bug reported by syzbot
for the case of corrupted HFS+ image.

Rosen Penev suggested a nice fix in __hfs_bnode_create() by
using kzalloc_flex() instead of kzalloc().

Tristan Madani suggested really useful fix in hfs_bnode_read().
hfs_bnode_read() can return early without writing to the output buffer
when is_bnode_offset_valid() fails or when check_and_correct_requested_
length() corrects the length to zero.  Callers such as hfs_bnode_read_
u16() and hfs_bnode_read_u8() pass stack-allocated buffers and use the
result unconditionally, leading to KMSAN uninit-value reports.

The rest patches suggest teh fixes: (1) generic/637, generic/729 issue
for the case of HFS+ file system, (2) generic/003, generic/637
for the case of HFS file system.

The following changes since commit
254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
tags/hfs-v7.2-tag1

for you to fetch changes up to
7fde7e806657fbe0d33f489521b488eed94f9b39:

  hfs: rework hfsplus_readdir() logic (2026-05-27 11:24:05 -0700)

----------------------------------------------------------------
hfs/hfsplus updates for v7.2

- hfs: rework hfsplus_readdir() logic
- hfs: disable the updating of file access times (atime)
- hfs: fix incorrect inode ID assignment in hfs_new_inode()
- hfsplus: rework hfsplus_readdir() logic
- hfs/hfsplus: zero-initialize buffer in hfs_bnode_read
- hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
- hfsplus: Add a sanity check for btree node size
- hfsplus: fix issue of direct writes beyond end-of-file
- hfs/hfxplus: use kzalloc_flex()
- hfsplus: Remove the duplicate attr inode dirty marking action

----------------------------------------------------------------
Edward Adam Davis (2):
      hfsplus: Remove the duplicate attr inode dirty marking action
      hfsplus: Add a sanity check for btree node size

Rosen Penev (1):
      hfs/hfxplus: use kzalloc_flex()

Tristan Madani (2):
      hfs/hfsplus: fix u32 overflow in
check_and_correct_requested_length
      hfs/hfsplus: zero-initialize buffer in hfs_bnode_read

Viacheslav Dubeyko (5):
      hfsplus: fix issue of direct writes beyond end-of-file
      hfsplus: rework hfsplus_readdir() logic
      hfs: fix incorrect inode ID assignment in hfs_new_inode()
      hfs: disable the updating of file access times (atime)
      hfs: rework hfsplus_readdir() logic

 fs/hfs/bnode.c             | 10 +++++-----
 fs/hfs/catalog.c           |  9 ---------
 fs/hfs/dir.c               | 37 ++++++++++++++++++-------------------
 fs/hfs/hfs.h               |  3 +--
 fs/hfs/hfs_fs.h            |  2 --
 fs/hfs/inode.c             | 21 +++++++++++----------
 fs/hfs/super.c             |  2 +-
 fs/hfsplus/bnode.c         |  8 ++++----
 fs/hfsplus/btree.c         |  2 ++
 fs/hfsplus/catalog.c       | 11 -----------
 fs/hfsplus/dir.c           | 28 +++++++++++-----------------
 fs/hfsplus/hfsplus_fs.h    |  7 ++-----
 fs/hfsplus/inode.c         | 40 ++++++++++++++++++++++++++++++++++++--
--
 fs/hfsplus/super.c         |  2 --
 fs/hfsplus/xattr.c         |  1 -
 include/linux/hfs_common.h |  1 +
 16 files changed, 92 insertions(+), 92 deletions(-)
