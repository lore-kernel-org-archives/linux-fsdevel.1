Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DDE32B118
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619805; cv=pass; b=hIBs+fiWYN0Ui7Q0Tf1BK8k5vCUU3HGV9/CgbJH6UmbM0Vo75yfIRHSUSwY2jT0n90qJi7fR/286auolbd3FmbUOobrftCkp4cyP9K3ukJShzOg6DLoA2wpYTCRNYvd97/kLXAs9ztuCmUj77JgoItjY5kAIZFw8/807/5uhM10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619805; c=relaxed/simple;
	bh=fzr9lDlARqBgoOUrRCuEssIpApn3qPTWlKJ6EQG7dFM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VAJZHd6mJFTEg0kCOsHJyzoFgUnWMyYjjCSIrmrlQdDhhxZX6BMZ/aRA4n5YblA1X65CS/6X+ZUTA1laAhZ9MFMANndqkXj89OHv6tDlF987U+gf3j9BZF8jUlz0GZkv7utpixAlnYS6ZJtgkKtY8wxfbzmJPnEBEpHKTr8Qj5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jxTOY7yw; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jxTOY7yw"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-91562bf6c12so542180385a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 07:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781619802; cv=none;
        d=google.com; s=arc-20240605;
        b=etBM5ZGDvIHoD5nMiFR3p8Y+TyRDwZJa6gZ008Id2Wxjz1qWZYsBYwJrAyxDwkVszN
         KcS29PFkDThcWW2HpJJt8K0vxQqUR7oeEREH9YJ/nQ9Fc2hsIiwxXdx4d4wn6x4P+WQ1
         VGYwLConUFB6A3ZlXX6jZrMO83L74Rsoaceh4bvPFIoG++5LQ7tgf2ZHvLw4vNkXSgd/
         HAw6H0deHsOYFyn8wMwA9NHLHN8QjWSq2oBsF//OqTO4pYTIX3kLayWy5gnYuHi0FkrT
         llXMAMF0InSH3FVrSqAGNliNxPCBwd0Az8d+oFW/FO/qPRuxut39bG9X00emEzJcXGTw
         KDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MIq6a2DO3PE+G10OnlmjuAsTYc88sw31FWk5LO5QiDQ=;
        fh=hOGuD80wO0yS+iUkbbCj9dbmg+6pGU7AqRAALSIstSI=;
        b=PfmCThmDvzcSxLE4qDN6019aXLpVBqzVW4j4ECEXlkSxDcqQzvudyeSE9rw99e2Daz
         6R8e2tnhjT16khHfp/yMeIuOy2Ln55twCT4c+wTZz5dCDeefIqrm9ZGuYQIz6kOJAbga
         x0ocfVH1Us77WS6MxuxlOop2EdWnAOKmQAOehrIYLACx5/Xm9fTTWycoygLE2drPvfpj
         KJ1QkGMYO4i0gMIqoL+qaPOyjgAGhm5XbGM2X78Xi4fBbtOPmdpBX7mp6ZXcJJXlAshc
         x67h616K9PewcsOpkqA5ySGctkDpjor4YpgznmCg/BYl5j9yFXcbcyckV7A2wcg0GJFQ
         9HZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781619802; x=1782224602; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MIq6a2DO3PE+G10OnlmjuAsTYc88sw31FWk5LO5QiDQ=;
        b=jxTOY7ywVt3bWboEAqgXp9MRdD/O46kzXJoVD58vTfaREu0+rSRnzNG519nVdSKtV7
         9Sa1kVioL/L8ofw3qPZdQ/WlXhBkztvzI9VQ0Z6uiwUGlcxRQHZ4ywXippCkqKzzix6V
         ivVVUEx0Fpo1uZwvG8YRvj0dwXsbvo/5kSOi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619802; x=1782224602;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIq6a2DO3PE+G10OnlmjuAsTYc88sw31FWk5LO5QiDQ=;
        b=jzDxU0QTzHYjtZ3bneWjZZAQnPGuXA4c9ktJ/HOi06pDy06oAFIvYGK9uToDnZyrvy
         +7SAm2kscWKGgZLavXNaGcVpcHsikMgBfu07kraua0CFPJGNpQWelMuOAZoImF1fnA6z
         uwSYa9i0FFLbomZGG/6ZvoAJDPGXwzrCSNHjUjx5601Zd9a3rJnHkB3yXJkbYgP9TfEv
         bJ/ped//vK3DZZNDJJdK9XPFTw2/sOD9ds6GA+VMOGD9aWout88CwpJRMdsYitelzbk7
         98A8DRi3mEGtccpS/GeD+a+j8JRxje3yaDeLcr/vidPpqr/QnG2rabai/g1pLg1ZNTVm
         smXg==
X-Gm-Message-State: AOJu0YwAFOSiUxm0+qdEuHDrqtgEgnTWQsb068/njh58LRVinLqRwT5v
	/PNo1G9bPK30dIDFEYsY3/aPukZiLDzBA23v2NzqYSoZP7Qnp1qFBV2V69xsflFV0CvA9e1DTnc
	C2OAlcMo1oFpF8efRQrqxYuG1Kp3JHvc9X9IslZTtPg==
X-Gm-Gg: Acq92OF7Etf8AAp3dHfmC/fEbA9LrqVP71sl72i+Yg7lgYl6Foyt/kQg/SpFOH1HuE1
	uPOT8z9yA7KCmwJpUt7byo5wNxiYkErcDannC5eol78IJIYuoKEskdrgSCm+lJhji86X4Qf+DqV
	qTnSunT11A6O4biFeQQN6lh7HLa6dOlpVYu6srfG4Ct7ECW6kNRGb5EMOuFDRWTiBtwajDhDEPs
	pzGgxoFlwUpS6axINGW5obuWPk90Rqm75SbtDYrNEYrun//Vde7QRlc6V0bStqvtzDSzOkG1xWS
	yoPpY1iGG2eUGoMKLF9oATNXP/l+NSvkgDXflA==
X-Received: by 2002:a05:620a:458b:b0:915:8f76:8029 with SMTP id
 af79cd13be357-9161bf6c39emr2784387385a.44.1781619802196; Tue, 16 Jun 2026
 07:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Jun 2026 16:23:10 +0200
X-Gm-Features: AVVi8Cd0AIeavaRflbghiON-bTSlFxcP2divx-eLpYAEhK8HTWW3Md02x4TkOqw
Message-ID: <CAJfpegtvWRiFQWzr9eXN5gr6cAwwR_wqqRy4K-nyvg3B7u-vrw@mail.gmail.com>
Subject: [GIT PULL] fuse update for 7.2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-7.2

- Fix lots of bugs, most from the late 6.x era, but some going back to 2.6.x

- Add subsystems (io-uring, passthrough) and respective maintainers
(Bernd, Joanne and Amir)

- Separate transport and fs layers (Miklos)

- Don't block on cat /dev/fuse (Joanne)

- Perform some refactoring in fuse-uring (Joanne)

- Don't use bounce-buffer for READDIR reply in virtio-fs (Matthew R. Ochs)

- Clean up documentation (Randy)

- Improve tracing (Amir)

- Extend page cache invalidation after DIO (Cheng Ding)

- Invalidate readdir cache on epoch change (Jun Wu)

- Misc cleanups

Thanks,
Miklos

---
Alberto Ruiz (1):
      fuse: fix device node leak in cuse_process_init_reply()

Amir Goldstein (1):
      fuse: add fuse_request_sent tracepoint

Bernd Schubert (3):
      fuse-uring: Avoid use-after-free in fuse_uring_async_stop_queues
      fuse-uring: Avoid queue->stopped races and set/read that value under lock
      fuse-uring: make a fuse_req on SQE commit only findable after memcpy

Cheng Ding (1):
      fuse: invalidate page cache after DIO and async DIO writes

Chris Mason (3):
      fuse-uring: fix EFAULT clobber in fuse_uring_commit
      fuse-uring: fix data races on ring->ready
      fuse-uring: end fuse_req on io-uring cancel task work

GuoHan Zhao (1):
      fuse: use current creds for backing files

Ji'an Zhou (1):
      fuse: clear intr_entry in fuse_resend and fuse_remove_pending_req

Joanne Koong (17):
      fuse: don't block in fuse_get_dev() for non-sync_init case
      fuse: re-lock request before replacing page cache folio
      fuse: re-lock request before returning from fuse_ref_folio()
      fuse-uring: fix race between registration and connection abortion
      fuse-uring: check connection abort during ring creation
      fuse-uring: fix moving cancelled entry to ent_in_userspace list
      fuse-uring: remove request-less entries from ent_w_req_queue to
fix NULL deref
      fuse: fix io-uring background queue dispatch on request completion
      fuse: remove redundant buffer size checks for interrupt and
forget requests
      fuse: remove stray newline in fuse_dev_do_read()
      fuse: clean up interrupt reading
      fuse-uring: separate next request fetching from sending logic
      fuse-uring: refactor io-uring header copying to ring
      fuse-uring: refactor io-uring header copying from ring
      fuse-uring: use enum types for header copying
      fuse-uring: refactor setting up copy state for payload copying
      fuse-uring: use named constants for io-uring iovec indices

Jun Wu (1):
      fuse: invalidate readdir cache on epoch bump

Konrad Sztyber (1):
      fuse: reduce attributes invalidated on directory change

Li Wang (3):
      fuse: drop redundant err assignment in fuse_create_open()
      fuse: drop redundant check in fuse_sync_bucket_alloc()
      fuse: use READ_ONCE in fuse_chan_num_background()

Marco Crivellari (1):
      fuse: dax: Move long delayed work on system_dfl_long_wq

Matthew R. Ochs (1):
      fuse: back uncached readdir buffers with pages

Miklos Szeredi (36):
      virtiofs: fix UAF on submount umount
      Revert "fuse: fix conversion of fuse_reverse_inval_entry() to
start_removing()"
      fuse: do not use start_removing_noperm()
      fuse: move request timeout code to a new source file
      fuse: add struct fuse_chan
      fuse: move fuse_iqueue to fuse_chan
      fuse: move fuse_dev and fuse_pqueue to dev.c
      fuse: move 'devices' member from fuse_conn to fuse_chan
      fuse: move background queuing related members to fuse_chan
      fuse: move request blocking related members to fuse_chan
      fuse: move io_uring related members to fuse_chan
      fuse: move interrupt related members to fuse_chan
      fuse: split off fch->lock from fc->lock
      fuse: add back pointer from fuse_chan to fuse_conn
      fuse: move request timeout to fuse_chan
      fuse: move struct fuse_req and related to fuse_dev_i.h
      fuse: don't access transport layer structs directly from the fs layer
      fuse: move forget related struct and helpers
      fuse: move fuse_dev_waitq to dev.c
      fuse: remove #include "fuse_i.h" from "dev_uring_i.h"
      fuse: remove #include "fuse_i.h" from "req_timeout.c"
      fuse: abort related layering cleanup
      fuse: split off fuse_args and related definitions into a separate header
      fuse: remove fm arg of args->end callback
      fuse: change req->fm to req->chan
      fuse: split out filesystem part of request sending
      fuse: change fud->fc to fud->chan
      fuse: create poll.c
      fuse: create notify.c
      fuse: set params in fuse_chan_set_initialized()
      fuse: remove fuse_mutex protection from fuse_dev_ioctl_sync_init()
      fuse: change ring->fc to ring->chan
      fuse: remove #include "fuse_i.h" from dev.c and dev_uring.c
      fuse: alloc pqueue before installing fch in fuse_dev
      fuse: simplify fuse_dev_ioctl_clone()
      fuse: expand MAINTAINERS with subsystem info, update mailing list

Randy Dunlap (3):
      fuse-uring: drop kernel-doc notation for a comment
      fuse: fuse_dev_i.h: clean up kernel-doc warnings
      fuse: fuse_i.h: clean up kernel-doc comments

Samuel Moelius (1):
      fuse: avoid 32-bit prune notification count wrap

Thorsten Blum (1):
      fuse: use QSTR() instead of QSTR_INIT() in fuse_get_dentry

Tim Bird (1):
      fuse: Add SPDX ID lines to some files

William Theesfeld (1):
      fuse: convert page array allocation to kcalloc()

Yung-Tse Cheng (1):
      virtio-fs: avoid double-free on failed queue setup

Zhang Tianci (1):
      fuse: set ff->flock only on success

Zhenghang Xiao (1):
      fuse-uring: clear ent->fuse_req in commit_fetch error path

---
 MAINTAINERS              |   26 +-
 fs/fuse/Makefile         |    3 +-
 fs/fuse/acl.c            |    4 +-
 fs/fuse/args.h           |   65 +++
 fs/fuse/backing.c        |    3 +-
 fs/fuse/control.c        |   20 +-
 fs/fuse/cuse.c           |   32 +-
 fs/fuse/dax.c            |    2 +-
 fs/fuse/dev.c            | 1361 ++++++++++++++++++----------------------------
 fs/fuse/dev.h            |  110 ++++
 fs/fuse/dev_uring.c      |  491 ++++++++++-------
 fs/fuse/dev_uring_i.h    |   47 +-
 fs/fuse/dir.c            |   52 +-
 fs/fuse/file.c           |  220 +++-----
 fs/fuse/fuse_dev_i.h     |  351 +++++++++++-
 fs/fuse/fuse_i.h         |  872 ++++++++++-------------------
 fs/fuse/fuse_trace.h     |   26 +-
 fs/fuse/inode.c          |  270 ++-------
 fs/fuse/notify.c         |  434 +++++++++++++++
 fs/fuse/poll.c           |  141 +++++
 fs/fuse/readdir.c        |   94 +++-
 fs/fuse/req.c            |   99 ++++
 fs/fuse/req_timeout.c    |  148 +++++
 fs/fuse/sysctl.c         |    1 +
 fs/fuse/sysctl.h         |    9 +
 fs/fuse/virtio_fs.c      |   23 +-
 fs/fuse/xattr.c          |    4 +-
 fs/internal.h            |    1 -
 include/linux/fs/super.h |    2 +
 29 files changed, 2776 insertions(+), 2135 deletions(-)
 create mode 100644 fs/fuse/args.h
 create mode 100644 fs/fuse/dev.h
 create mode 100644 fs/fuse/notify.c
 create mode 100644 fs/fuse/poll.c
 create mode 100644 fs/fuse/req.c
 create mode 100644 fs/fuse/req_timeout.c
 create mode 100644 fs/fuse/sysctl.h
