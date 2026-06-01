Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7E38AC91
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302521; cv=pass; b=OO8C//cZ+bkLAYLjDayaSm/PWdJUxLWEdQ+4O1wGLpKoICPmIEgd6p7Tdq1f+ZXyw0JyFEo4xBR7MWqd7+G/KjXqQR7KJsRxgEp1Dnb3TMLtUYUNInl/wQNvEdvoRMCwYJMCiOu/YeMCeoQub/DJNuuZZGbuUeg7+z2QID4pbvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302521; c=relaxed/simple;
	bh=c1ig9xcJuO9YJZkXzdXUaCf+kDMbbyvLWLLXcmr8+UI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XkubEFyQsEA3J+BTVhtNWXjgrRUGiMNfBDr2BZqQEi3bBAk5kTthW6ay9ZuVBozJgZm6hN2tRpJo0vWU8Ak5gq9pu/Kk7yNpE+8u2c44wqTV3GNb83S1OrpqLc0dvTNagCigg09UYw1Grg3Q9fNFdc9cHb4qaM6V5mZznPsU1Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdZsavHj; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdZsavHj"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-516d634956fso114697211cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 01:28:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780302519; cv=none;
        d=google.com; s=arc-20240605;
        b=E5+RhZEPw/h1XsYT4OAmzn7ue0kpUS0/AFl3efkdi9S0E277IpHO9hcmmK6uSm5kZd
         DC/haNbA3pnqyGrq7iGzu6tVJgm0gN3VPruPkMboDMjdgp0sw7zRKlAfExOm6uBbxxqj
         5mC077VCpiHf8xG33s9jRfhq6MzJExDTh4IeSWoMj+dBJV5GCLWS1s8jUB5mc3MlX6C0
         ipQVp3B8eOX5GL9qq9NczrdaDF1hlS4ICtnao4AYHCEP5gUQG2Vg+0Dnuy5I28PNT+9N
         viKvE4RiPxCs04q9lRlR7T1Pepys99GxgRFXwazpII5DL5Hp9zrbtxDj4dz8sb1aUa9U
         oPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=chy4CiOufXTSxPnyWfni+DiT9+e7J+p1A7Jsak6bS+8=;
        fh=NvW0M1HP+F1Of6rGMiZYFxuaSNs03uAbuzZpJQMJmV0=;
        b=QYmpkjwPqvOA6PVCSSDJa9g1XbZrM1GJp3bkj/NwcLmqlA38vdj17nZOwXYN8nNeUP
         FnwSzSXttGx3Aov++5hey7yO3OPE0cDFP8WhuEzaXrLP94viLfZecHoTUfeq6h2OIw5+
         IJEQq9S1Jplyqt4V9LJwsQcjaYFI6GbEqjfCZenUT769+UO+w2acp9g8DHvzbQkwZqfm
         4L15UiMvrBcB8Qy0CWCgO3INY1/iSEHIVbK1MUVOjuUt8xTVu9xujBsVLqq5wlrLlmbx
         x52gqlpKPXelz/JbPdAcfp3bLDw8sxeDVOy6xwcx8s/jZ2BH15d568oVnCSFe6W9NLN1
         OJjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780302519; x=1780907319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=chy4CiOufXTSxPnyWfni+DiT9+e7J+p1A7Jsak6bS+8=;
        b=fdZsavHjIj2XpSTjmx1ft7As0F/TdqfpaHTpi7QmyJHyEk49In8ShXCHgl8nNCIrUI
         ptcLlnX1DMsowhlgVZWneu71hQd76YcIulb7JO8x3dgiBZM7UbCvFoKvOPCWsKT1587y
         Hje+OxxZPHb7OGukzcv0t0zsasgWhw4qdztER0wrkSXvdpxTC7zAQfaI9sOVUxQppKgZ
         4+EKVgVRGNYfuYxnLMQ4x6MgwM8WGNwJHkkY/0OFkig4ei6BuxkgQnKdIXVBInmCLD+q
         cjE3xutL5PGn9a5joicC4GrXo3CvjMtKDDH8wDqgOHrQPZf9DVbe6k97gfpEV3sJc1GX
         VNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302519; x=1780907319;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chy4CiOufXTSxPnyWfni+DiT9+e7J+p1A7Jsak6bS+8=;
        b=EIWqG6rdU3RpBI9z3TMkM1coqiJ72hipw7QkoV5bBL+z/Wemhvh1XFIDs02Dhc8rQy
         IYVHQnCucykcHWuR3/NaqrZ7ccNJ49bbD6bwfxYGZ1oUw0ejv5lFkLmxZhtnNsCMQN/T
         vGe0j2sTdG3OoFhzhFg6EtjjqW+PvFSa3q9Epm7PzmGffTzPx4jB4fJll03yq+HXc91+
         I8/A2yCEU48lH6oYb5Hb+FuGKDZMN5ZD+omhmUfCZD31J2n/12hydUvy9CBbEnxLXc4p
         LS228eHv9wVLk4EduowGfFq0SuQxjcJBMeiHS9dOjCL3sBZ7sozaVpQyWmF1EHczQ3Iu
         XMWw==
X-Gm-Message-State: AOJu0Yytd4SWtXRnFRrwvbGUKx2M43gDRrFqoSPAoATh3I1fcMPNgAZO
	RVsZGWzg/ZYFWgzKUC0Mdh2u/BHyofSmdBDAPIq50Ue1RW5SqMyeodLX1pb7TMqt6JdxYksRaDp
	vQHtGmBAbjvceswNcmQZU9dTqj4W5PKs=
X-Gm-Gg: Acq92OHCkUoWT22TOhj8U6Z5/WFK4hmcSAfRvfccsmU/hOUjiKZiYN4oXjNe4WmWMqB
	R/X/n1MI+M2dunc49CScVZn1lNMommadpnm1O5dLkbMuYyRpknZrPVbsjEZeJMFmQjUzhDkjR2O
	PiDx+jsVNROZcpK+WkhA7c42jGVv0p29wegz+Z83Fn128VERc816qy9NaL43mrjaK5nPV468jRK
	7qkkLBFiLMbets8yWkvUi8hIgPGh/5R105Q3kIFw0DcXN/WI20QHjJtFzh99q3BgPHlzxYLPzdo
	3GsuzhyQ/4W4RLyf
X-Received: by 2002:a05:622a:830b:b0:516:e062:1a8c with SMTP id
 d75a77b69052e-5173a7a2ea1mr113192091cf.37.1780302519187; Mon, 01 Jun 2026
 01:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6rmA66+87ISc?= <neck3922@gmail.com>
Date: Mon, 1 Jun 2026 17:28:28 +0900
X-Gm-Features: AVHnY4Jmnl-8FOixwQi52djqGt8p-nCRErtCM1XZESChjmeG5OkicHzsEnjN758
Message-ID: <CAFmvuTW=gntFCBtuHGAu7caC9FM4Ovf_r1ng5gmy6djn9ziLqg@mail.gmail.com>
Subject: [BUG] fuse: KASAN slab-use-after-free in fuse_uring_copy_to_ring()
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a FUSE-over-io_uring bug reproduced on upstream v7.1-rc6
with KASAN enabled. The bug was found with a local syzkaller setup.

Target file: fs/fuse/dev_uring.c
Subsystem: FUSE
Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
Git head: e43ffb69e0438cddd72aaa30898b4dc446f664f8
Kernel release: v7.1-rc6

Observed crash:

  BUG: KASAN: slab-use-after-free in fuse_uring_copy_to_ring+0x20b/0x230

The same issue was also observed on v7.1-rc5:

  Git head: e7ae89a0c97ce2b68b0983cd01eda67cf373517d

Root cause analysis:

The crash appears to be caused by a lifetime/state mismatch between
struct fuse_req and the FUSE io_uring ring entry state machine.

The KASAN report shows that the affected object is a struct fuse_req from
the fuse_request cache. It is allocated in the FUSE open path via
fuse_request_alloc() and freed later in the same open path via
fuse_put_request(), but it is subsequently accessed from
fuse_uring_copy_to_ring() while FUSE io_uring is sending a request to the
userspace ring.

The preceding warning in fuse_ring_ent_set_commit() also shows an unexpected
ring entry state:

  WARNING: fs/fuse/dev_uring.c:865
  fuse: qid=0 commit_id 4 state 3

My current guess is that an error/teardown/commit-and-fetch sequence may
leave a stale fuse_req reachable from the FUSE io_uring ring/request queues.

Reproducer:

C reproducer:
  https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main/fuse-uring-uaf-v7.1-rc6/repro_fuse_uring_uaf_userns.c

Full symbolized console log:
  https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main/fuse-uring-uaf-v7.1-rc6/clean_userns_report_rc6.txt

Kernel config:
  https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main/fuse-uring-uaf-v7.1-rc6/kernel-config-v7.1-rc6.config

Key config options:

  CONFIG_FUSE_FS=y
  CONFIG_FUSE_IO_URING=y
  CONFIG_FUSE_PASSTHROUGH=y
  CONFIG_IO_URING=y
  CONFIG_KASAN=y
  CONFIG_KASAN_VMALLOC=y
  CONFIG_KASAN_EXTRA_INFO=y
  CONFIG_USER_NS=y

Runtime conditions:

  fuse.enable_uring=1
  unprivileged user namespaces enabled
  /dev/fuse accessible to the reproducer

I verified the C reproducer by running it as uid 1000; it then creates a
user namespace. In my minimal QEMU rootfs, /dev/fuse was chmod 0666 before
running the reproducer because the device node is root:root 0600 by default.

Without a user namespace, uid 1000 can open /dev/fuse in this setup but
mount(fuse) fails with EPERM, so the provided reproducer uses CLONE_NEWUSER.

Brief KASAN excerpt:

  BUG: KASAN: slab-use-after-free in fuse_uring_copy_to_ring+0x20b/0x230
  Read of size 8 at addr ffff888009ecc698 by task repro_minimal_u/153

  Allocated by task 153:
    fuse_request_alloc
    fuse_get_req
    __fuse_simple_request
    fuse_send_open
    fuse_file_open
    fuse_do_open
    fuse_dir_open
    do_dentry_open
    vfs_open
    path_openat
    do_file_open
    do_sys_openat2
    __x64_sys_openat

  Freed by task 153:
    fuse_put_request
    __fuse_simple_request
    fuse_send_open
    fuse_file_open
    fuse_do_open
    fuse_dir_open
    do_dentry_open
    vfs_open
    path_openat
    do_file_open
    do_sys_openat2
    __x64_sys_openat

If you fix this issue, please add the following tag to the commit:

  Reported-by: Minseo Kim <neck3922@gmail.com>

If you need anything else, please let me know.

Best regards,
Minseo Kim
