Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675153921C3
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650857; cv=pass; b=iktVFLrIEkX/Gfu/S5e7bini2FMU7KGuCMZtmFbQ+hlxMCByCsofVocM27M9u7KxeOILhbE792pIe1lfXqW6NnzEC9ZRzGPyJ2u0k9ebCYkGJeIiAMo/Bk11wW2iFN0OmzY4FaxiSoRe/7s7ssewt44dWaQQbyQt7aGn2FJUshM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650857; c=relaxed/simple;
	bh=mXiMtyLOOYxxVMQ8MUK/K08ApFUpRcECz0ksD1wsMDE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uf7lfIeC74Kr4IbORFF8Rr/2paVzJJF7+83zMmfkmWWxZV4XQM/6WIktgp/siXiO0r32xzcklvJLTgB20hdavMTwTo6AJ0i5rt/+Lg4B7UknUhXuD3WvMsDq4Jnfiz/fpvI7BHHLkl1+NkhSli7Tvd3kbfHQgWTh1XobeqDILAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=UJQyDiFx; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UJQyDiFx"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-526f963372aso32247781cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 02:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787650852; cv=none;
        d=google.com; s=arc-20260327;
        b=g/0vu0QaIXyW2OL52QacAWF7TSVe0yfJigQXF+Z9y9J51Ahh3RTeiNs8P+ijLM3MO7
         PL/+pkOMx0LmcXE5r4KLT+ggeqJIG/DOt3oXDtmKUHIcIqLN4iW5AKm/ERYeZ2Fu1Vmf
         S5myhnYUCQC1b4RCvxqGjN3mMkkCPCZVoLPX5Oe1Cyd0dqBn67guLjSNKWZArdufO7Jx
         PXr2rpd8D2UZPclZPLaxwHonmJIKC81BdfDDICaeuNhQbbPOSsbEv4eUu805GLGI2TRu
         fjNJW/RDy6gpoOXqeBgnO/C6ZD9u5mJIJeRo8/Y0IrdLLngCW/M3vw84pYi9da7tBrV3
         Hhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5+zCHFKCNOCONPbwIiY32D/ElA6N423eilIEaRYhv2E=;
        fh=hOGuD80wO0yS+iUkbbCj9dbmg+6pGU7AqRAALSIstSI=;
        b=DYi07ZODf80RRbHi6I76qXMKe9dBwyqJTt9pNVcRYm+DIhhEimBA51I0xFyLRo8MaS
         /rpaeHPrMtDjpLR4m6bjxKkWD6XLgTCUAy4CIv8DEuCgi9V6UYpMyTWrZchC2yAbUUJP
         ncqewdQgo6RZ7FZ4vTRKYTmM5S8jyiEimXZNHpAaCjNfgB5QAiTh/ApwO/xbO+GFS/sz
         HWxmrlHQf4QZEFiWdxU/KgnMMBsImbjWAuqmnzUdGmG3dS56yBwLqadBBfrfi0Lcmio7
         L6IeabXkkcfwXEN1OltyWXSNT/kB38ado3Lef2qq+DdCjHGisg7RI9QTOIdqTTppO+Fl
         6RIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787650852; x=1788255652; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5+zCHFKCNOCONPbwIiY32D/ElA6N423eilIEaRYhv2E=;
        b=UJQyDiFx4O6vTvwoXmkWaqllwM1utOvzyZJM9KSAR1emNgI6dzCHoRGdaadKVsLqUy
         8fOcRTr1DacA+wY4MtwhHQKC5hv0nIP4xh/CaAZBs3vQLpK1msy2vBjG7aZqolzweO48
         ywwLR6QfAN9kRPBkQcgUnJp1JUwB9CQy3ZI9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650852; x=1788255652;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5+zCHFKCNOCONPbwIiY32D/ElA6N423eilIEaRYhv2E=;
        b=mwXGKsIbZX+sW3cox1UoDBGPM9IUQwUyxpnbPEPD0D64QI4GYkSv/5tO0fdY6lxeUA
         6BxFPysEq135AkjTbkPRWBO8G4IhHFNxQWWobD10PiunIGF7GTQokiU3yGofM7JeTNEq
         0oCVMsUQXv/9AP6YKm/VVfFfiDvfvkhcHS5iM77aZIog0gAS4C1Ws92ShUcevqEFxpJ9
         WEPkj0SOqaAZn6Cf4mqXHv+pAhKbpIiuj0DsipU0WAy8AqwpuuhTML6hB55ip44gOqms
         EbiXYoiSW4bw22MdzWEZT9nR1ks+S8gfdieqSgNEXcqXN/PpD+M+ys6398G+QzKWjrS+
         URGQ==
X-Gm-Message-State: AFuF++kv/uEiATFQ2W1ea8jPar18SsowTjC3PGfZXV7SQF29Rj6Y86M6
	9LKbnIkt2hK4d6eGe4YvvVA3WIbPrhZ4A+IRhHhKdVzg4DMU7FRbbbIWmPhJSug0IDiaFsmJn7P
	uitJkiRQSk1eKMSd8YfJSl2UsfmZCARtY2gB2xTBkUW5nozd7Iz/pvvuuEQ==
X-Gm-Gg: AR+sD13tFmE0zKNDhxtYROa8jSXohwlhM/xGBe2zUfby6+UIvSnkjwlgDjVJR1a4vfQ
	EhRhigvnWXbDNX59DmVbuIfUAURTyuz5cOKRxmgS6SaNUAGeiZfYBv68ZPVcO0lUBk0iuqcLwKW
	PyDnLUdHvsLFcaJ1bjq36KyVNYypDjUlxBUwIMh0Yqk+nM4q+DxLI3aEMt5+n1p9jxtQHDCBdYF
	jzBxVUepV33n3l2TQpPnsDHv/NXyQ2ZfAWAJZetaisvCyRkBvyB7HTppA3jWLKFFJ5Kzhx3SFV+
	pRJGPoh/NgrC4D8EygfWrfA+5iHbzvGqT6k1Jq+GGzw8b9bW2xCfaaqhfyKdwj0JlRui2CPqx4u
	+Ds8JUVMT7t1Z5w==
X-Received: by 2002:a05:622a:2b09:b0:51b:fc67:c73c with SMTP id
 d75a77b69052e-52e09bb401amr277343041cf.16.1787650852351; Tue, 25 Aug 2026
 02:40:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 25 Aug 2026 11:40:40 +0200
X-Gm-Features: AcwNN1X_1gdCMa4DF67VXGoGPqzeSAs-aOF2k1OnofG-LbfJv4e1RDFSRaIrsoo
Message-ID: <CAJfpegu_5Sfbbi36ss3_4k_3Va+RSbnHxRbCUxWoTRcraQ07cw@mail.gmail.com>
Subject: [GIT PULL] fuse update for 7.3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-7.3

- Improve performance of the io-uring transport by introducing buffer
pools and zero-copy (Joanne)

- Fix lots of bugs (Baokun Li)

- Fix io-uring initialization issues (Joanne, Bernd)

- More prep work for large folios (Joanne)

- Don't limit buffered read to 128k (Jim Harris)

- Fix zeroing of page end (dirtied with mmap) on file size extension
(Jimmy Zuber)

- Improve performance in certain cases with wake_up_sync() when
queuing request (Xuewen Yan)

- Misc fixes and cleanups (Xuewen Yan)

Note: some commits touch io-uring source files, these have been in the
io-uring tree and have Jens' SoB.

Thanks,
Miklos

---
Baokun Li (7):
      fuse: fix invalidate lock leak on setattr writeback failure
      fuse: fix invalidate lock leak on open O_TRUNC DAX failure
      cuse: wait for pending RCU callbacks on module exit
      fuse: reject a duplicate fd= mount option
      fuse: check for NULL root inode in fuse_fill_super_submount
      fuse: wake one waiter per freed slot when raising max_background
      fuse: invalidate the correct range after O_APPEND direct write

Ben Dooks (1):
      fuse: make dentry_tree_work static

Bernd Schubert (1):
      fuse: Fix the condition to enable over-io-uring

Jim Harris (1):
      fuse: allow larger read requests by setting bdi->io_pages

Jimmy Zuber (2):
      selftests/fuse: test post-EOF page zeroing when a file is extended
      fuse: zero the partial EOF page when extending a file

Joanne Koong (16):
      fuse: don't clear folio uptodate on writethrough errors
      iomap: add helper to mark folio uptodate
      fuse: use iomap helper to mark folio uptodate
      fuse: fix missing barrier when checking io-uring readiness
      fuse: use release/acquire for fch->initialized
      fuse: publish io-uring queues with release semantics
      io_uring/rsrc: rename
io_buffer_register_bvec()/io_buffer_unregister_bvec()
      io_uring/rsrc: split io_buffer_register_request() logic
      io_uring/rsrc: add io_buffer_register_bvec()
      io_uring/rsrc: rename and export IO_IMU_DEST / IO_IMU_SOURCE
      fuse: decouple fuse_ring creation from ent registration
      fuse: add FUSE_IO_URING_CMD_ADD_QUEUE
      fuse: add io-uring buffer pools
      fuse: support registered buffer pools in io-uring
      fuse: add zero-copy over io-uring
      docs: fuse: document io-uring buffer pool and zero-copy uapi

Mark Brown (1):
      io_uring: Add missing include for ITER_SOURCE and ITER_DEST

Miklos Szeredi (2):
      fuse: move "epoch" from dentry.d_time to fuse_dentry.epoch
      fuse: fix race between interrupt and resend

Rochan Avlur (1):
      fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free

Sang-Heon Jeon (1):
      fuse: use min_not_zero() in fuse_init_server_timeout()

Xiang Mei (1):
      fuse: copy request headers via a stack buffer for io-uring

Xuewen Yan (1):
      fuse: give wakeup hints to the scheduler for synchronous requests

---
 Documentation/block/ublk.rst                       |  14 +-
 Documentation/filesystems/fuse/fuse-io-uring.rst   |  36 +-
 Documentation/filesystems/fuse/index.rst           |   1 +
 .../filesystems/fuse/uapi/fuse-uapi-io-uring.rst   | 126 ++++
 drivers/block/ublk_drv.c                           |  22 +-
 fs/fuse/args.h                                     |   2 +
 fs/fuse/cuse.c                                     |   8 +-
 fs/fuse/dev.c                                      | 104 ++--
 fs/fuse/dev.h                                      |   2 +-
 fs/fuse/dev_uring.c                                | 633 ++++++++++++++++++---
 fs/fuse/dev_uring_i.h                              |  56 +-
 fs/fuse/dir.c                                      |  37 +-
 fs/fuse/file.c                                     |  40 +-
 fs/fuse/fuse_dev_i.h                               |   5 +
 fs/fuse/fuse_i.h                                   |   2 +
 fs/fuse/inode.c                                    |  16 +-
 fs/fuse/notify.c                                   |   4 +-
 fs/fuse/readdir.c                                  |   2 +-
 fs/fuse/req_timeout.c                              |  12 +-
 fs/iomap/buffered-io.c                             |   6 +
 include/linux/io_uring/cmd.h                       |  38 +-
 include/linux/io_uring_types.h                     |   6 +
 include/linux/iomap.h                              |   1 +
 include/uapi/linux/fuse.h                          |  63 +-
 io_uring/io_uring.c                                |   2 +-
 io_uring/rsrc.c                                    | 127 +++--
 io_uring/rsrc.h                                    |   5 -
 .../testing/selftests/filesystems/fuse/.gitignore  |   1 +
 tools/testing/selftests/filesystems/fuse/Makefile  |   3 +
 .../filesystems/fuse/write_extend_eof_test.c       | 368 ++++++++++++
 30 files changed, 1487 insertions(+), 255 deletions(-)
 create mode 100644 Documentation/filesystems/fuse/uapi/fuse-uapi-io-uring.rst
 create mode 100644
tools/testing/selftests/filesystems/fuse/write_extend_eof_test.c
