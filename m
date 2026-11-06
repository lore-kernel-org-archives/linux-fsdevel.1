Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947622;
	b=5i61rspyPY/8chyh5peeX+VlVfm8yFEne1sAP1VddTBELOF1QHFSuUbTgtGRC7pgmAtA
	 pjxgvVJ8Vvyfj8B2yRuR502il2gkL8aizwdoRxnUl0A/oT5DsVOp0ABNdm0CFdDB9+KpZ
	 hVXA3hUnmmEO4mDUBCx0Z60Z0I9JvfWlxDuRcdtCjZPROiNZl/ppdt+I1Iyp8F+ha8f8K
	 uVL1xNNd4zrrtV7lohyf8FsMiwXvsb01N/4hJw4umQQz+iy32w3ohAnkgBCukZubX7/H2
	 /3PDWcHazx5T2fWYQHVlEIgAF+l0IJyRjz7t+04W8fIr4iQdNhBYMuWw5Qe0jAKhA8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hIiJTHVvnRcW94BgAfPLzMPiYxMM33qks5DkmeQr+Ak=;
	b=aAr+voxfHZOv3t2q3ONQP5pxc9000HvtR71JNf1YOy3Jpp2hx6j6nJAxyq73rf/nNlE5
	 7oZ72480rmLVl5W9ksvsSH5PhEOqQw49QgyMJrE5y2oIEwsLGy6ztczx/QUZipz0THOy9
	 d9h8zduQYEEiFsgLmIJEQ4JHefK9bSvoFBAS0Bvni+Aeh02o3KT5TzO93iiBUIOXVsUlA
	 yGfvgdeL8Sm900vbzG1CiKYKRR/9aS0KU5G9MonllpcswdpebA+0ZnhRwuPvfYf0thwW4
	 r5M5tQnw2r3zu/LbKbxZcT3Y5Dp7HvVCrfAaHBQyiFLc2nIVaIlJEIAaRhzxEb+/0rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g6DnxrD/";
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE9606A329
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 06:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03CE9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g6DnxrD/
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso49469766b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 22:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793947620; x=1794552420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hIiJTHVvnRcW94BgAfPLzMPiYxMM33qks5DkmeQr+Ak=;
        b=g6DnxrD/K96AYO1B7tiDT6BfiOA4apqHQiYNM04gubZiCRYnStB+SjpfQuoxjfi4fJ
         a0WpnVMLWTWH281kH6Uv80/8Xbbd2/utITQ7T5H/2hmayMLGKJUwPZza7WKopmyX2yqM
         mmQaiHm0yAa1UqVBf/WI+YZYGianrILUH2+IA/EegHVDEgY9ujbbkrf4LmEy4Jw67Br8
         54g/wGGUtM2o7f2dzLXbGoZI4B9h0Cld1c3VdqnCIsDbuZWVEwQa9ybgUh6LE01l2fhh
         83B6WuqKrPbh+PP7AacD3BsZmRFGvbEmz+8AXqna49n7my/LggaBbQ2RMJW7/gjEBjQG
         t3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793947620; x=1794552420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hIiJTHVvnRcW94BgAfPLzMPiYxMM33qks5DkmeQr+Ak=;
        b=EsB1McuH4QjDS/nlWwdp6i+m/qqMtERvjalIwD2MpHq2odWVSghZagL45Sc36MmjZ1
         xWIGrvpeybTxb/AF4e2/V/Imr1zs54M3fHLy7fwF12vBt2WyvysMDRJf9Kr4kjZm1uUd
         MnkNSoeEWAkgE21bVGI70yJl5GscvkO8Im6VNALVUgIrt1Dc2VSNsQnB9f5UhLf3XJbL
         5cNWlCQeDygXYrXhsVLfrMftWVyLvEzF56uJwtKIjuLfUInA90FbE83y61ZdG74sFobK
         zgVppazsoyccV86Vxpwe4EGUPQNpAVrwXVgtDHgvLHcjelg34P9GL7RwpGbAOhFrkJCw
         b96w==
X-Forwarded-Encrypted: i=1; AKwUvBxktUeGHxXTB05xt7d9saQDCFzfxHkh6mNEwEC/BQ9Kxe+3Qs2VgG3Mdcp8fsNZvtOrqN5D8zt1uvzCUJam@vger.kernel.org
X-Gm-Message-State: APuU4Z9I/+yf/ujGw4skkgr0jY1k3shQcB9EvniD9+pkJh6O9wL8lq3n
	3HgultvIkB+xo2sqGV93f12gKL8YwAgCJRvUyUG3mfSOoNRwRhTENt8z
X-Gm-Gg: AYBFou3EVqN7PopBpRINoRHh7W023rwyOn5OoLDUKuuXqFN5f4SapjdOpHzpQoRs8wa
	7OfIvOwf9vBwFlQM1qBKBBm11tMN1oNecb4C/Qq+NdVzqU7uKwVKb0jh+h/Gaz9IVwkTjhWvwo1
	F/Aiy873lSnqIaUvUK9/kbeFZMa9FQttwxpcaLEOfug9vwq+CYHgmaUsXoxADeqOeCOZpGI7Kd6
	498y1MlbebsO7GiG64+wsdN9fs0w8PjSWv0VdhDFPxMoGpY+8WU8dmrj+eg9wVqxZAWPSq+Vwcu
	d8ntAvxWrNwFrLwiKfHhJhSNkjflh7911YuQ7rTmuqXDQolmQaO2J8RBUfuzbZyz+qLgHwDvW0V
	KTguXcZpg7NayM67kep2oe/Yu46Bx5xtFwHbsBF8NGz5ITaXpplNSmETgLuVbeAjZbZFWtQ4vJS
	fxlV75sgMQftL2qiu6zvfqkf88ztH+mA+zSeAR5b+Txa3sLNvNkqeYrUpqYkSpKJljwEkTvdTKA
	qQh4msYHN/NNJYaAxVsL9lto2BMeELHqFHRMqzZJhC9zSQXcB5ulM0mLZD66C47IglLJh6Pmpyi
	XRV3x8LL8XAOhGecL1VshrhA++jtEDwxA4a4IIdMEEgnmLlbAf1+/JMTSzr9aQWzDJUG7EcgTCO
	dzT2JTskdWMZ/
X-Received: by 2002:a17:907:9496:b0:c46:8909:963b with SMTP id a640c23a62f3a-c4d35485cf9mr140787466b.9.1793947620154;
        Thu, 05 Nov 2026 22:47:00 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c6025sm51097866b.73.2026.11.05.22.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 22:46:59 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 7.4-rc2
Date: Fri,  6 Nov 2026 07:46:59 +0100
Message-ID: <20261106064659.3809691-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull overlayfs fixes for 7.4-rc2.

- Was in linux-next overnight

- Gone through the usual overlayfs test routines

- Merges cleanly with master branch of the moment

VFS NOTE: added export of symbol dentry_open_nonotify() that was added
by commit ebe559609d78 ("fs: get rid of __FMODE_NONOTIFY kludge").
Note that before removing the __FMODE_NONOTIFY kludge, overlayfs and other
modules could open a FMODE_NONOTIFY file with dentry_open().

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 51628610f9187c1c1cfe499d92e066bc22ad9693:

  vfs: fix take_dentry_name_snapshot() semantics (2026-11-03 08:28:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-7.4-rc2

for you to fetch changes up to db1c5da238dc80a61ab429a7b71b0e2835766c45:

  selftests/fscontext_ns: expect EINVAL for overlay descendant userns create (2026-11-04 21:47:48 +0100)

----------------------------------------------------------------
overlayfs fixes for 7.4-rc2

- Fix a self deadlock of a fanotify permission event listener that also
  watches the layers, when it reads an overlay directory

- Three casefold fixes, found by Chris Mason's AI review

- Fix a decode of a modified file handle with nfs_export=on, which could
  read the stale lower data of a copied up file, also found by Chris
  Mason's AI review

- Fix an overlay selftest after an errno change

----------------------------------------------------------------
Amir Goldstein (3):
      ovl: inherit FMODE_NONOTIFY when opening directory realfiles
      ovl: inherit FMODE_NONOTIFY when reading directory layers
      selftests/fscontext_ns: expect EINVAL for overlay descendant userns create

Chris Mason (4):
      ovl: fail the mount if the casefold flag has changed
      ovl: do not let chattr change the casefold flag
      ovl: fix whiteout creation in casefolded directories
      ovl: look up the index by the decoded origin

 Documentation/filesystems/overlayfs.rst            |  3 +-
 fs/open.c                                          |  1 +
 fs/overlayfs/dir.c                                 | 46 ++++++++++++----------
 fs/overlayfs/export.c                              |  4 +-
 fs/overlayfs/inode.c                               |  8 ++++
 fs/overlayfs/namei.c                               | 13 ++++--
 fs/overlayfs/overlayfs.h                           | 21 +++++-----
 fs/overlayfs/readdir.c                             | 35 +++++++++-------
 fs/overlayfs/super.c                               | 12 +++++-
 fs/overlayfs/util.c                                | 13 +++++-
 .../filesystems/fscontext_ns/fscontext_ns_test.c   |  2 +-
 11 files changed, 102 insertions(+), 56 deletions(-)
