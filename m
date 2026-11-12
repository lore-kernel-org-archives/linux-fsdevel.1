Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.195
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502912;
	b=YZIZtyxe4zZb1IwvR1kTYAtIX2AtF68aCgQ2HxYPFCWNfuYF4h2t4ahAOtnXnu1QXjCW
	 z9qCj/0uDlfGOUNic0Gx5DFJJEEPBTncMArgBf9WUXGaTZcMUcqvS/1WbGyfFijJA5lin
	 wpBIJwvi8L/qITaPkPPH7+hOKo7Xc3o61Pqekmuva+jmsgELWuhju9tN/t9tuQB5zcPkf
	 owG90jnyFuCs6kcBYT8aRF+2zmY+yqG/yuFPpcffjN8/qI008po+uF6UZjdh227rCHJMN
	 eFJLqk9YW84LVG8f4+TaZ6Z43DFIvqfkgJdzIW7/74aj53JbFgr+BYHBAYMwLJIT7sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=LE1pJkJzQmD4KHZy3KibAk6pagP6QWSp8ER9p+DD6nk=;
	b=oLUsMiNI5Hr8bDKAvKuBSrYO0CyqOoIg6KLxe2cmN6F/AZ8kjMavLEbCSw6yau+zq+lr
	 g/Wv68/tJw4GhSBEEYuVJkSFHvR5f2DuYbovd1aBxp1728cpxM04w3WDOxBmTCz2QCPAG
	 2tL3I+ATAbqYdpZ6pUxgBdBOY+FESD8oV7hZfg6mayeIPTDinClxtEZFKU8wkVtYoDOi3
	 fxmZEEkUcKF90Ff92S7LM7xqVzmvPq1NGV/G2bLGj2tQiaAsAkHxRxc2U3ygw2ouL0HdO
	 df8+ZR37cvIEKTg2jfyINB+N7aWH0G4quIDjpjtNKE12dR84EU4s8UImM2zSz+xj9ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rklWZWfh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.195
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com [209.85.208.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E7F606A327
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E7F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rklWZWfh
Received: by mail-lj1-f195.google.com with SMTP id 38308e7fff4ca-3adf9b1f5aeso10470301fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:01:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794502910; cv=none;
        d=google.com; s=arc-20260327;
        b=MHpsS+XIE2f9EvnHVc2duMjQIVCxxwpfEz2q4bVl5r3fby4bRmnFnwDkVf53jN9i9i
         fOlxrjuSaVc6svGX2qFon1NabB+YgWC8lIaHyifgnXUWYuOI/V4LGKB4M5e4yAm0leO6
         IH8Ch1lDTmv8iWY+y5V/x3ysugzc/azo4w8LXUohhGXfzSrvDZPsClQxVN2IYddWIyk5
         XtFvq+lh4FolcDCxVoq1KdSshX7z33OunJM5f39uZxfSnRhU3y6nYFnVD1OdO32myXaK
         +AZl5gR7MmS6okG/KP8CTHADWHm0K/JKJ4SM7h8dnJpuGYhPhdlIAPaYOspcrHduk7FG
         Q4wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LE1pJkJzQmD4KHZy3KibAk6pagP6QWSp8ER9p+DD6nk=;
        fh=XPG4UNuME41aciJge0TpC3LCJ+y3sbuuVzyHt+31FUk=;
        b=A6PJSHBgb8R8kkfuMVbcMlb+weao/JEAB1aWThngqs6gVgcrFrHdfflv6OLrxa7KqH
         1dFpwcxAVwItEoi1MxbUM1g9Y2P/5lGP0XolXdY/0VQJPj6gwVIo9+KfUBuY7vG6Cxh9
         WsTIk2wzC1hzsGqaBoGh7LJMfOn21XuUYp4c44Hihe64jIH1dTRujz7hbHBVeawX8gDH
         pGOAcoZva6jBRrBT+MqRXj00/ORdCxBSf8vBkGL5nirmDLTBHoUJ7UIYRrwSTh6K9UvB
         iswYYdycbeOh1SWuieUtTPkUZjE1ncDtMt/47AA3j8tP8BJR3v6gR4p/dI690/6TwytV
         PzHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794502910; x=1795107710; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LE1pJkJzQmD4KHZy3KibAk6pagP6QWSp8ER9p+DD6nk=;
        b=rklWZWfhrj53wAWPR76QmBFXjRMLzzHCqWJHEJSHWW99JHS6GvghPeQlUSoKCL2A7D
         Jsbb8ETKSOAmmbgYrs0YY8bpo/A2qTDgn/8ruyBhyAVT85kpAyt/M396lR3BJF62g5i2
         KSKrO+vOXl4dGMsbUd5L23VbxY2eYTJzbp6IxQqrAr+ckfFHpyzYez0a9nNbxkbKkjSC
         s8vh/xYn3AG5VLJObz/zutqVI8+oe0PEdReZxXGNiwznYP/o85Nmq1UCCsO2AN43eXNj
         X0xB6YIeB+qcfWSZGA9T+EoGHgMGarhxiydvLT1K1RfUc1bZf5wzecYf2yqmLFcIUvL2
         2WNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794502910; x=1795107710;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LE1pJkJzQmD4KHZy3KibAk6pagP6QWSp8ER9p+DD6nk=;
        b=glEgyenLeXixNVkoCbzUaHRWuFVYBrWYfbQ7wBmF2WJG4F0gLIi14v/3lOWuH8oWFk
         sTbInfX3ACirBuqce+b3d52pSoLadhcSsOizILAWNBDCTl6kZChujUCtCZVotLVi6geK
         AKCOlceFHMF0PY7o3nlEpBHi4g43TNQAkOCiK433Kn9ZWEbdGE3yjK2T7+DN4mB+LXa7
         97GbIiozyZ2sbkJYU+pqWk122RfFv5/xCBD+Ltx6LKAewXz2WOx5e9vw8LJ+0U/Y+09a
         ic3i+GDPfVFuR9MrJhlLC+GrE5mbopIedo7wIsAskaMP1v3UtRg7ArjwNlBj/IdcxNAI
         TLLg==
X-Forwarded-Encrypted: i=1; AL+hErEsjFgsQGZMksr0MVCCyLNgQ9yVaPZoI8FDbJM+7wnTnxpMRMChnwgGpQGEKFH6egALQK4oK2a1n8kY1H7x@vger.kernel.org
X-Gm-Message-State: APuU4Z/6r6mU++k6ogNWjbNWxcCdVTQueXfHd1PCghWe8c7QZDEEj1hL
	Px3m8Ggt8z95mvioFJPrdtGIZq7zE7pI1GP2rKxmoPGRQiTmhGRQorr756gEX4QN71jipoGkU00
	OWbWKgUrUDpvr5qOFxRetB5vrUnUIx77bvF+rOqIaBFXK
X-Gm-Gg: AYBFou1apvSD/uIQmx2t4ibwXE9+mksY7PZL5UphMQ8aTJ+OhNS9Xx5WfAdNLYAcI4U
	7a4TAz6bflMDCyB8rEg3CPHK4T31blyFRCt3u09JEE5/JMrB7RwMsodA0aD2cH47bykH9keA0bj
	MI8svNnVmt4vOn/hTubjAMWrSSfo18rW5o0QIG5XCAj+9Tt8GZwS9tin1F3n09E64cxZ/QVamu1
	Oq88LG0xvuNFCKSS4IBvQJCsUlYii4mcxDwyatovRpApZGWsNw6KQJjF+E9LnbQ05x/G7ql5NAJ
	og0gkvtod+Zc034Uqt7wygCVEnCpuZUB15/nCqDV/IW+sbryIcn+6Xp2tiYo6JtzjfLG50Meg5S
	BoSIfDD/V46dIXWOJrLtY0+TWspGzVED8GZUR0lm010ESSvHlQfDx3yEg7W5aLDwhveyiEe+H7z
	hDIzNvevi7qbsuXg==
X-Received: by 2002:a2e:a543:0:b0:3ad:fd26:fd2a with SMTP id
 38308e7fff4ca-3ae1bfb8004mr8647671fa.7.1794502909765; Thu, 12 Nov 2026
 09:01:49 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?6ZOu?= <fengaojigui88@gmail.com>
Date: Fri, 13 Nov 2026 01:01:37 +0800
X-Gm-Features: AclHuK-drOWyFhSlQjdMJ_5Q4lK9tj9u39cXrmTuwnolZTO9jGZH0B97pKhU-6M
Message-ID: <CAO-4RZ0x1FLMRWHV5pE+oxf1ttPLQLzaJfLqKcacXyNSdXVOmA@mail.gmail.com>
Subject: [BUG] xfs: WARNING in inc_nlink (fs/inode.c:465) via mkdir on crafted
 XFS image (v7.4-rc2)
To: Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Carlos,

We found a reproducible XFS warning on v7.4-rc2 with syzkaller. Creating a
directory on a crafted XFS image trips the VFS link-count sanity check:

  WARNING: fs/inode.c:465 at inc_nlink+0x168/0x180, CPU#2: syz.0.17/25512
  RIP: 0010:inc_nlink+0x168/0x180 fs/inode.c:465
  Call Trace:
   xfs_bumplink+0x94/0x1e0 fs/xfs/libxfs/xfs_inode_util.c:687
   xfs_dir_create_child+0x340/0x3a0 fs/xfs/libxfs/xfs_dir2.c:872
   xfs_create+0x8bb/0xb80 fs/xfs/xfs_inode.c:728
   xfs_generic_create+0x650/0x800 fs/xfs/xfs_iops.c:216
   xfs_vn_mkdir+0x36/0x50 fs/xfs/xfs_iops.c:308

The warning indicates that inc_nlink() was called with
inode->i_nlink == 0 while I_LINKABLE was not set, via the XFS mkdir path
(xfs_vn_mkdir -> xfs_create -> xfs_dir_create_child -> xfs_bumplink).
The underlying cause of this inode state has not yet been determined.
Our guest runs with panic_on_warn=1, which escalates this warning to a
kernel panic.

Kernel/config: 7.4.0-rc2-kernsight-kasan #1, built from v7.4-rc2 with
CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y, CONFIG_XFS_FS=y, booted with
oops=panic and panic_on_warn=1.

The reproducer contains a set of 83 state-reconstruction programs and
triggering operations. The programs are replayed repeatedly with 8
parallel workers. The warning is reached through the XFS mkdir path:

  syz-execprog -procs=8 -threaded -repeat=0 -executor ./syz-executor
repro.kernsight.prog

Verified on a fresh VM: the warning fires 230.6 s after guest boot and
panic_on_warn escalates it to a kernel panic (full console in the
repository).

A full write-up, the reproducer and the verified console log are available
at https://github.com/Zheng-zheng-codes/xfs-inc-nlink-warning.

Repository contents:
  - README.md                      full bug report: phenomenon, stack trace,
                                   mechanism, reproduction steps, timings
  - reproducer/repro.kernsight.prog
                                   pipeline-verified reproducer (83-program
                                   ordered set + triggering mkdir)
  - reproducer/repro.prog          original syzkaller-extracted program
                                 (pipeline evidence; not a standalone
reproducer)
  - reproducer/repro.priming.prog  state-priming program set (pipeline recipe)
  - kernel.config                  kernel configuration used
  - environment.txt                kernel image info (sha256), QEMU command
                                   line, syzkaller commit, reproducer command
  - logs/log-*.txt, logs/report-*.txt
                                   original syzkaller execution logs and crash
                                   reports from the fuzzing pipeline
  - logs/machineInfo-*.txt, logs/title-stat.json
                                   guest environment info and title statistics
  - logs/external-verification/    external standalone verification artifacts
                                   (serial console of the verified run)


Happy to provide the kernel image, the crafted XFS image, additional crash
instances or raw artifacts if useful.

Best regards,
Zheng Zheng
