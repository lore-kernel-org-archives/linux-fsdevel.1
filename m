Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793049658;
	b=z1X1byDtGxZtc59jIDMZZwCXuN8vI/i17wgz9RwS1fNFBq6ffaVoyGnWmzKcq8Ms5FA8
	 c/7LEoYK0U1TR9ELmS37jrh44KSIoOOGFLGxnc7O0GhaorHHgHa7ukUhDpNNVelVLBFbz
	 T6q9A+epIqqnQ7S580IpJHNKq6Yc+9qOp3k9iuWVjovJLMnIJYtYdxjYd1wBJLCTd7hzd
	 10vR/UXITVEIXFEHvX/PED5e9f2LhL7FWL55+tpBCA7F36JWi51B49z0dCo8PBQn7hiG9
	 7eejscNr0c/8IpPTYkcug9e6tHGAveFEFDtwR0GQ4j6ujW1mFyPLwyyglsCtYA/304A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=0kaGKxyFPdaHjlAaA4peoPLioREVK5egwb8TsrDox98=;
	b=C31qBx9HT3Gkp9K/kYLER/xVIeVvJuhUADrX8Ps5nmOo/n7kBHzoTWu0skOLzxQjUoCP
	 0ipQAIy1CRbz2oIZUO1OgUmuoYU4OVKhc6B5f3uRIW8oKmgvbTc07qdp/DVDVyvXbGvl8
	 jw4Lwl2PFfNLFxdsQTI0RwDcPeCbsQ5mWmgoUAHBGGGcBaybvJTg6ZNsHth23SHmKXGGp
	 eI9wvzC/prvuCUJJct2GeWG03mLfxLpL7Qzwqzq9C+4rFcV0bGj6m5W37Q5d5yqgzq/Hf
	 UDCHMBt7NY5LPG1IcUdW3CPY3hgjVTPPg4xg38ktqUF4eILvJNU9AC5CeaPTAeIpgZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szeredi.hu;
	spf=pass smtp.mailfrom=szeredi.hu;
	dkim=pass header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=hJBwWH3I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373EE606A31D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 21:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 373EE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=szeredi.hu header.i=@szeredi.hu header.a=rsa-sha256 header.s=google header.b=hJBwWH3I
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-53669f7b518so36261801cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 14:20:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793049656; cv=none;
        d=google.com; s=arc-20260327;
        b=X4poic2GtqOWuYM6Sn6ray1qSXNzUv8GXJ1G5/8/ElZQYIqkxnN802OwxjKiH7G4fQ
         f5tyUYZVl6vFpQVry8ZOrhjr9omRmsSgPA4N8AO4aatR7FcL6ShSyWPInVDIU9vl7/j5
         6keA9w6sNwi66IDWzpXPgjL6vxslgqnPqthVtYf0sjanXzsAJCUQtngOA2Z5A9g5A4cM
         Ix+FDMkfptoZssVK/SOXgQ5lWvb2bTHDZvweBLb9RCbKlXMDPzFPzrPrECfMxzqVgS0w
         kVOf4ggbnEEy5vLXyPCFOGhLOQL0QqGdcZCG5wlyU2LMOZ+WAMMtA8PSAWswAwQw11Xv
         XUrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0kaGKxyFPdaHjlAaA4peoPLioREVK5egwb8TsrDox98=;
        fh=hOGuD80wO0yS+iUkbbCj9dbmg+6pGU7AqRAALSIstSI=;
        b=LjW372fI7lXk7Wm4o9IPqj+1rjBnWBLs+HrSgayrO27Tl2DJC9KlI1yPaHTIT/vRYb
         hCIzssyKgQyicN6iljn4ZGkcKduiM/x1hM/fl4Iqg9pDvLNtwNx8La4HSj/whBv69CEw
         4EdfWz+6629iMM5/wQJ9u0MS/rAJd73HPj3Orrwo73x4SBCssjyEu/AriunQqc1HfZaj
         YvqJJldRRtFw1Ov9LKYWG97XFKtwbBRgFUdhT8L64WQxOqLy2Evw4iG0LPtBNQ3rKTPr
         DwMjYupzIg/6A/ImBrcYTFa5mn/vmwha9bTV3dGpY8Iz4x/vW0yy1/MPatykiRH5lQDN
         7p6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1793049656; x=1793654456; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0kaGKxyFPdaHjlAaA4peoPLioREVK5egwb8TsrDox98=;
        b=hJBwWH3IZFIAqQpWeofV6+rzQ0Cv+caINKpDIN6b3xicWjgH1esb9DORfgVw/3ybqa
         lJd73NieBeBpWsP54CK9kQwJlU9zMZH98UlS2SsJz+NqLy7H/dwbU3oC0nISJr9d9+KB
         4X9M82aJGAJNT+zfgtF26Tk1B+qK4rWuHk6yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049656; x=1793654456;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0kaGKxyFPdaHjlAaA4peoPLioREVK5egwb8TsrDox98=;
        b=qNtjeis4DlFG4b5GX7qXV9GH/eLm7Gy1zoHZKFGbDHFPD3hhE64vc03w0RKZMackxl
         bObkalLFOMWqoRZTdhPSdXJbZg4z5ve0WN7Th7xMisNGJq1+KjcRBKC+D+hwmEEHAZiA
         ISbix3kcF9MFSWSiXvwxcv4UImXCe7mnVKJf5XzmPhN/q4RRt5lSfCPRHZGwIlZw9/a9
         oSAfR6tOPzoLa7zLIPgDAW1+G2L8FUBBXp6ebMGgeqWA+ZsScwB9SG2jVT6s0VeCOPHL
         ELX1kzyw0YOKMl2rALmN3G3BTFbhqQnbnA6BWKP67ORN6L99SYXC4kRAx5TLHVc07uGb
         ISZQ==
X-Gm-Message-State: AFq9FYJrnfEcLS9f2PWD9SkTMcuu/AEbBp/RXEAjtDlhxseIjicyWVq3
	Ze/R238OkU8q1yVs1rsvq0WYeilDPQlFxxRB7CZ1xf1AHvg6LiKUtN5m5hgQV7Q771ZMnaSlSBk
	CWzGJwlQBJF46T3+aUnREJP/fjCD6ibklSGI4orCPvEgr74yX2HsnG+E=
X-Gm-Gg: AYBFou20/m84zOBGlEnta2+ZyVH8J5lgYQVs0dJHbkjynaerNQ+zMxvbdwAD+fis9Tc
	Jno19MvUsUSdSh1gPBg0Yz5UhIHDDW89boAa6T4D2UOFOjRk9+tt7eT/f4RBVv1AUgqedF1ZRNz
	yrNmLIwI+7JLUJGhtqHWo43xWF1RJbP8DNw0jO3zOAJL3TesiQ0OW80ZjZXBGaYAn16mQZn7SLW
	mj8hSATHCLfaBbnrJfHYSzm+0ap6MYDqfctrNXzDRF2IZbs/kumDUv2qu1IFMWUxM5MKlofPrRW
	cZvrABl3efsneBbItaJdUUY4dIElrwtC6Dyyjo8YAHoRS0sS1doiKabDaW2r2Kg6ofvzCM3MC8T
	3fgVR7JapJppj4oIgtbiiPWysqlw53ShfRAnLCV/XXA1YZFruB6415Ou7DDR4epoOK+oJ6n0=
X-Received: by 2002:a05:622a:4814:b0:536:6f16:d923 with SMTP id
 d75a77b69052e-5383b529e0amr131165761cf.40.1793049655915; Mon, 26 Oct 2026
 14:20:55 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 26 Oct 2026 22:20:44 +0100
X-Gm-Features: AclHuK_o-lunJ57CXW4yVmdLlEp357dyXWlAawErz46SB_3NkJUx3Q5tGeTod0Q
Message-ID: <CAJfpeguS78Y_ZB=fNbYqFPcpo_mznJBR=5KTqifMzCm7c3O+8g@mail.gmail.com>
Subject: [GIT PULL] fuse update for 7.4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-update-7.4

- Add dax backing and  extent map support for famfs (John Groves, Miklos)

- Support large folios (Joanne)

- Add selftests and documentation of caching behavior (Luis Henriques)

- Add  FUSE_SYNCFS request (Jimmy Zuber)

- Convert readdir cache to use folios (Tal Zussman)

- Lots of bug fixes

External files touched:

1) fs/file.c: added EXPORT_SYMBOL(fdget_raw); should be okay, since
fget_raw() is already exported.

2) drivers/dax: changes acked by maintainers.

Thanks,
Miklos

---
Ali Nasrollahi (1):
      fuse: ioctl: remove unnecessary comparison in fuse_setup_measure_verity()

Chengfeng Ye (1):
      fuse: fix copy_file_range reply handling race

Fan Wu (1):
      virtio_fs: read the vring size under virtio_fs_mutex in ->get_tree

Hui Peng (1):
      fuse: validate folio state before pipe_buf_try_steal() in
fuse_try_move_folio()

Jimmy Zuber (2):
      fuse: allow FUSE_SYNCFS for privileged userspace servers
      selftests/fuse: add test for FUSE_HAS_SYNCFS privilege gating

Jingbo Xu (1):
      fuse: don't bump attr_version for async direct read completion

Joanne Koong (8):
      fuse: don't shorten the folio descriptor at LLONG_MAX
      fuse: zero the correct range on a short read reply
      fuse: don't drop destination page cache on a zero byte copy reply
      virtio_fs: zero the correct range on a short read reply
      fuse: drop rather than zero the copied range in copy_file_range()
      fuse: replace folio_test_highmem() with folio_test_partial_kmap()
      fuse: enable large folios
      fuse: don't launder folios of a bad inode

John Groves (2):
      fuse: resolve extent maps in O(1) when possible
      fuse: handle extent map files in fuse_passthrough_fadvise()

Karl Mehltretter (1):
      fuse: fix GCC 8 build with CONFIG_PROFILE_ALL_BRANCHES

Luis Henriques (9):
      Documentation: fuse: add document on caches being used by FUSE
      selftests/fuse: convert fusectl test to fuse3
      selftests/fuse: check that fusectlfs is mounted
      selftests/fuse: factor-out test fixture setup/teardown
      selftests/fuse: use dynamically allocated memory to store ACLs
      selftests/fuse: add some extra ACL caching tests
      selftests/fuse: add fuse symlink caching test
      selftests/fuse: add fuse readdir caching test
      fuse: rename fuse_direct_io() to fuse_do_direct_io()

Miklos Szeredi (15):
      fuse: don't fill in.h.pid in case args->nocreds is set
      fuse: fall back to copy_splice_read() on FOPEN_DIRECT_IO
      fuse: use "vdax" naming for virtiofs DAX
      fuse: don't assume ff->passthrough is set for FOPEN_PASSTHROUGH
      fuse: make fuse_backing_get() static
      fuse: fix NULL pointer dereference in fuse_request_find
      dax: add fsdev_dax_from_file()
      dax: use READ_ONCE() in dax_holder()
      fuse: add helpers for EIO return value with kernel message
      fuse: support 64 bit, server allocated backing ID
      fuse: support opening 64 bit backing ID
      fuse: add support for opening dax device as backing
      fuse: add extent map data structure
      fuse: add extent map I/O support
      fuse: add support for striped backing

NeilBrown (1):
      fuse: don't d_drop() before d_splice_alias()

Punit Salian (1):
      fuse: mark DAX VMA page protections as decrypted

Randy Dunlap (1):
      fuse: repair lots of uapi kernel-doc

Sasha Levin (1):
      selftests/fuse: add the missing FUSE_HAS_SYNCFS privilege test

Shai Barack (1):
      fuse: Forward vfs_fadvise to backing_file in passthrough mode

Sung Byeongchan (1):
      virtiofs: validate fixed-output response length

Tal Zussman (2):
      fuse: convert fuse_add_dirent_to_cache() to use folios
      fuse: convert fuse_readdir_cached() to use folios

Tarun Khandelwal (1):
      fuse: propagate SB_POSIXACL to submounts

Xiang Mei (2):
      fuse: don't BUG when the copy buffer is exhausted
      fuse: return -E2BIG for an oversized SETXATTR over io-uring

---
 Documentation/filesystems/fuse/fuse-caches.rst     | 198 +++++++++++
 Documentation/filesystems/fuse/index.rst           |   1 +
 drivers/dax/fsdev.c                                |  23 ++
 drivers/dax/super.c                                |   5 +-
 fs/file.c                                          |   1 +
 fs/fuse/Kconfig                                    |   8 +-
 fs/fuse/Makefile                                   |   4 +-
 fs/fuse/backing.c                                  | 304 ++++++++++++++---
 fs/fuse/cuse.c                                     |   6 +-
 fs/fuse/dax.c                                      | 217 ++++++------
 fs/fuse/dev.c                                      | 165 +++++----
 fs/fuse/dev.h                                      |   5 +-
 fs/fuse/dev_uring.c                                |   6 +
 fs/fuse/dir.c                                      |  11 +-
 fs/fuse/ext_map.c                                  | 376 +++++++++++++++++++++
 fs/fuse/file.c                                     | 194 +++++++----
 fs/fuse/fuse_i.h                                   | 184 ++++++----
 fs/fuse/inode.c                                    | 107 ++++--
 fs/fuse/ioctl.c                                    |   3 -
 fs/fuse/iomode.c                                   | 120 ++++---
 fs/fuse/notify.c                                   |  79 ++++-
 fs/fuse/passthrough.c                              |  96 ++++--
 fs/fuse/readdir.c                                  |  70 ++--
 fs/fuse/req.c                                      |   7 +-
 fs/fuse/virtio_fs.c                                |  79 +++--
 include/linux/dax.h                                |   3 +-
 include/uapi/linux/fuse.h                          | 147 ++++++--
 .../testing/selftests/filesystems/fuse/.gitignore  |   4 +
 tools/testing/selftests/filesystems/fuse/Makefile  |  30 +-
 .../filesystems/fuse/fuse_acl_cache_test.c         | 299 ++++++++++++----
 .../selftests/filesystems/fuse/fuse_common.c       |  58 ++++
 .../selftests/filesystems/fuse/fuse_common.h       |  33 ++
 .../testing/selftests/filesystems/fuse/fuse_mnt.c  |  17 +-
 .../filesystems/fuse/fuse_readdir_cache_test.c     | 273 +++++++++++++++
 .../selftests/filesystems/fuse/fusectl_test.c      |   9 +-
 .../selftests/filesystems/fuse/test_syncfs.c       | 309 +++++++++++++++++
 36 files changed, 2777 insertions(+), 674 deletions(-)
 create mode 100644 Documentation/filesystems/fuse/fuse-caches.rst
 create mode 100644 fs/fuse/ext_map.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_common.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_common.h
 create mode 100644
tools/testing/selftests/filesystems/fuse/fuse_readdir_cache_test.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_syncfs.c
