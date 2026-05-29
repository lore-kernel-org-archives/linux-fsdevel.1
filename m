Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C5355049
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 01:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017691; cv=pass; b=sGxyhgofEsPXg7tV3H9vYijD6agCODT+SPd9bjCtlavM/4KmCVFCbkcHBBzW77shned2jhc7GPMS3BhKLTgToEYaJn61pHmgPEbzYTHcMDPkoNpX81tXqMqMFBdQ1cegeldib74OlYD4irnCrg11VX5iVjBkaaPwlFGJn0FPO4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017691; c=relaxed/simple;
	bh=fb305mPoGdl91MiyVMO/vwOrMJtSmTAe2ZfE1RPu50w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DgkbE/t8sM7DMX3oDDLXwTKtgZIrodE9UNvGKY253uuijQwMH/IT1kGLPNud3ZAH3dNybv7pfm4uDTPPrPjTV7s+0kBxpE2If4n0YDqNtRdMEtDaSXrZj0snQxCx0dlwAEFL6PqH5zRQ89zXD9Csni5ZvjyNgQ4R9ECLTxLLn24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=I15zEwWd; arc=pass smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="I15zEwWd"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7bdc947aaa3so140295117b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 18:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780017688; cv=none;
        d=google.com; s=arc-20240605;
        b=hP8mGxeGjqHgUJD1ovaMk1qLEA3dHZCPdmHloknJGJgWf6PV5lRTO83Xr4N8h7HnQQ
         vTfrFIabRihs2J/XU9gvdLLJfIUH5s4+/x/alyvUPzYHRol3/L9HSO3TYPBIghQQxixt
         N0Gfg34hVgPwl9GswIcOO6mICXN4FYR1yYXTim1gdx5igVnH+b3RyPcgH4iohWvjU2gp
         Wj/4kuhfCTtF7KBfTZYkTn/67kk4CPJk2nl+Xar6gX0DhacXEk7rCMU8H82xt5z8Xm6u
         IuBDfeS+YCqwpsWHmGsnuuuqrTZRPTTczwiWb7mOT6SC/TDPgpwRxG7csjMLdJOPm6f1
         uiNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Fe8zE+dpPh29YAG5M8eMRic0J7+vQkzE5mM+7P3zS84=;
        fh=9x/jmppqx8/YdQvvPck5ov7q/+duRHcrWxUfTfpLQz4=;
        b=IsMfhvbxbzxiGy8smIaHaA064OCyas7z0AFQ6eLCKRMgJkPo655m4U/y4iWWs8ODdG
         U2zZ1FBYbuDJhL7YP9itcR1pbI6JXM5rQnCKK7ed3s2jFgywQgWqjdVJr+sRrc87BQni
         aE1VFXMeA3aEwMlxKhnPPE7ZlG5I1N9iNSClLXlJjrOM+toK25t38tY7S1LjUBRX0Cna
         VAoT2BIAymP18RvFMbrgYW/6BWS4Yb38ejp8v6NyKGeFNXs0uCcp9oHexoZDhwolrYLG
         FXJvZCaCoIm2dEc0D+v72tP8HcAMPZjJrvN2hm5cF/1WGgKVpLH/asvwdlf6N6Djygh1
         HvuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1780017688; x=1780622488; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fe8zE+dpPh29YAG5M8eMRic0J7+vQkzE5mM+7P3zS84=;
        b=I15zEwWdEPvkYhl/DaPwRRRT/oECLD4XcUVKaCAbD+thoEEq38nXg2iuz8bEfWVPyr
         Wz+gVk+8xzwsVBvO4Wl8hN9rI4z6Z8ZbUTVb7YxkWezZoPBLyuXMJfszs8/wTU9cPGCa
         9Abp0jfmHj586MKHkx2L/xopSanz+ViWNiqM95F0dyk82Gn9ZPDK3GLNmjXsT5U5pP9P
         VuS7Onb3qs/PDyL9ZH8qhm+qyFmbFTEtThx6Z2vFrfLX2+e9bvDbIrUVsbTwAHuvmJjD
         9c8q+gGwrpi0OFL7nfSrN89JcwJgFfO4HDq1D5QKRgFk9hXTPv3EbJWdtiRpgoyHiPbD
         O06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780017688; x=1780622488;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe8zE+dpPh29YAG5M8eMRic0J7+vQkzE5mM+7P3zS84=;
        b=GUwLVf/EnHv0Vuk/zYA5Jb6BVWTbI2Bjt/CUz+aDxKSZfeUgKfesbR71bRw6tuAi79
         Dz1+HnoPvv1gSynHlkuPKnN2czLRfjwRESg6iRTcqLHJ40KnzEMZ6tCLw45cDvfoFU+s
         ui27Dzx5h+H91u9nmB1nDvuSnMjjjCEJ90t+rsHNyRn7qGobooPldc0vXiGYtvQMcJjC
         eQ+t+zksEEf95sY5Nxz37Hghp+2IkcrnAgpSMpMo/WZPqOdViQXk7I8gr8ZemhREtaJc
         8tIxComvmWaG/siqdJoSn74oePPjB1x6caMq4KMN358YM5836+WvXvUrGGv/S2IZ5EGJ
         vxDg==
X-Forwarded-Encrypted: i=1; AFNElJ8KkpyTDraDMOh6LmArPLruAK9cJ95UuMvQ6IE3cYqyjiAMXGBBSNiVlxt0QE2E9UFQP8bhLGKzp61SJvQ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7mjirdTpyoV5DpRfO3sVRGf9ed5S9YPiVUmhzY2fO1cBd8z+
	tLVS93sKcNyGI3Ho/rwIQQOr+B4jQFj47pXK0rlXRylr9ijRBgkA4akkPMUJbA1ybk5AXDzPr4V
	ADcDjs9OEs08wL7Yr0FtchCc3EdS8S+990hj//5DE
X-Gm-Gg: Acq92OFikSpJi4kWyBrawKcpGusaUoQ3+oYbMmyX44y9UYieLEBUsMbA7LU2nev+E1T
	ow8dP8pHhuIWecygdMIBxqEzwYMse2eXkkWEm1QnzOLnCtxVN6vf2Ymm2xaO+7RpXrHlZZl3E7P
	MgZyuNm023tufu6peJ6GHzUb5vfyQPJ/hkPpl7q7St1qkJ8qVGIRykx/mXb9BRhSEhnE78uR9gz
	KoWkwN0Fguc2P2Spau6diflClsYzR94uPUsHtaieYZoHdQ8mqszsuq7b2FMXRErTWrK+wkNjX8M
	jYjcV1CTKaR/M19+Tg==
X-Received: by 2002:a05:690c:6ac3:b0:7bb:712:a74f with SMTP id
 00721157ae682-7de466e677bmr6656097b3.17.1780017687137; Thu, 28 May 2026
 18:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Thu, 28 May 2026 18:21:16 -0700
X-Gm-Features: AVHnY4LIbRQLFr81rNrT85a9zdMYwUVGuWhgvdOEvcWQuyighA9jlyxnEpIh3wE
Message-ID: <CA+0ovCjz41uwDy6qDE73=bg3tTuEqiHMZ2xFnHC8+TiXDPR0YQ@mail.gmail.com>
Subject: [BUG] ntfs3: KASAN null-ptr-deref in ntfs_iget5 (fs/ntfs3/inode.c:543)
 on mount
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: falemi@asu.edu, Tiffany Bao <tbao@asu.edu>, =?UTF-8?Q?Adam_Doup=C3=A9?= <doupe@asu.edu>, 
	Fish Wang <fishw@asu.edu>, Yan Shoshitaishvili <yans@asu.edu>, ntfs3@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f099050652eaa936"

--000000000000f099050652eaa936
Content-Type: text/plain; charset="UTF-8"

Hello Konstantin and the ntfs3 team,

I am reporting a mount-time KASAN null-ptr-deref in ntfs_iget5() found
by syzkaller while mounting a crafted NTFS image, as part of research
at the SEFCOM Lab at ASU.

Summary:
The crash trips at fs/ntfs3/inode.c:543, which is the second branch of
the iget5_locked() result handling in ntfs_iget5():

  struct inode *ntfs_iget5(struct super_block *sb, const struct MFT_REF *ref,
                           const struct cpu_str *name)
  {
          struct inode *inode;

          inode = iget5_locked(sb, ino_get(ref), ntfs_test_inode,
ntfs_set_inode,
                               (void *)ref);
          if (unlikely(!inode))
                  return ERR_PTR(-ENOMEM);

          /* If this is a freshly allocated inode, need to read it now. */
          if (inode_state_read_once(inode) & I_NEW)
                  inode = ntfs_read_mft(inode, name, ref);
          else if (ref->seq != ntfs_i(inode)->mi.mrec->seq) {   <-- :543
                  ...
          }

The dereference chain at line 543 is ntfs_i(inode)->mi.mrec->seq.
KASAN reports a null-ptr-deref in range
[0x0000000000000210-0x0000000000000217] (see crash-report.txt).

The call chain to this site in the observed crash is:

  __se_sys_mount               fs/namespace.c:4360
  do_new_mount                 fs/namespace.c:3834
  vfs_get_tree                 fs/super.c:1754
  get_tree_bdev_flags          fs/super.c:1694
  ntfs_fill_super              fs/ntfs3/super.c:1686
  ntfs_iget5                   fs/ntfs3/inode.c:543

Observed on:
- Linux 7.1.0-rc3-00200-g70eda68668d1-dirty, x86_64, QEMU Q35
- KASAN enabled (SMP KASAN NOPTI per crash header)
- The only local dirty file in my tree is drivers/tty/serial/serial_core.c,
  containing a local ttyS0 console guard for the fuzzing harness. It is
  unrelated to fs/ntfs3/.
- Image trigger: just before the crash the kernel prints
  "ntfs3(loop6): Different NTFS sector size (4096) and media sector size
  (512)." -- i.e. the mounted image declares a 4 KiB NTFS sector while
  the loop device has 512-byte sectors.
- Source inspection of linus/master at commit e8c2f9fdadee
  (v7.1-rc4-754-ge8c2f9fdadee) shows the buggy line is unchanged:
  fs/ntfs3/inode.c:543 still does `else if (ref->seq !=
  ntfs_i(inode)->mi.mrec->seq)` with no NULL/IS_ERR check on
  ntfs_i(inode)->mi.mrec before the load. As no reproducer is available
  for this seed, I have not re-run the against e8c2f9fdadee.

Impact:
A mount(2) of the crafted image kills the kernel with a general
protection fault; the trapping RIP is
ntfs_iget5+0x161/0x38e0 at fs/ntfs3/inode.c:543.

Expected behavior:
Either the chain `ntfs_i(inode)->mi.mrec->seq` at line 543 needs to be
guarded against the case where any of the intermediate pointers is
NULL/uninitialised, or ntfs_iget5() should not be reached with such an
inode in the cache in the first place. The maintainer is best placed
to choose which side of the contract owns the guard.

Novelty check:
I searched the syzbot dashboard's upstream open and fixed namespaces,
and the ntfs3 subsystem filter, for "ntfs_iget5" and "fs/ntfs3/inode.c:543".
The only existing ntfs_iget5 ticket is extid 4d48dcd9e88d37df77b3,
"KASAN: slab-use-after-free Read in ntfs_iget5", first reported
2026-03-31, still open.

That ticket is a different code path in the same function:

  syzbot 4d48dcd9: ntfs_iget5+0x33a3/0x38f0 fs/ntfs3/inode.c:542
                   post-mount KASAN slab-use-after-free Read
                   reached via ntfs_file_fsync -> ni_write_parents

  This report:     ntfs_iget5+0x161/0x38e0  fs/ntfs3/inode.c:543
                   mount-time KASAN null-ptr-deref in range [0x210,0x217]
                   reached via __se_sys_mount -> ntfs_fill_super

I am sending this as a separate report because the two appear to
be distinct root causes, but please feel free to close as a dup of
4d48dcd9 if you'd prefer them tracked together.

A NULL-pointer dereference at the same condition
`else if (ref->seq != ntfs_i(inode)->mi.mrec->seq)` (then at
fs/ntfs3/inode.c:519, now at :543; the condition line is byte-
identical across both versions) was reported to lkml by Dipanjan
Das on 2023-02-18 for kernel 6.2.0-rc5:

  Subject:    BUG: unable to handle kernel NULL pointer dereference in
ntfs_iget5
  Mirror:     https://lkml.iu.edu/hypermail/linux/kernel/2302.2/02508.html

Per `git log linus/master -L 540,560:fs/ntfs3/inode.c`, no null-guard
on ntfs_i(inode)->mi.mrec at this site has been merged since.


I appreciate your time and consideration, and I'm grateful for your
work on this subsystem. I'd be glad to test any candidate patches.

Regards,

--000000000000f099050652eaa936
Content-Type: text/plain; charset="US-ASCII"; name="crash-report.txt"
Content-Disposition: attachment; filename="crash-report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mpq8jzjw0>
X-Attachment-Id: f_mpq8jzjw0

bG9vcDY6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gODE5MgpudGZzMyhsb29w
Nik6IERpZmZlcmVudCBOVEZTIHNlY3RvciBzaXplICg0MDk2KSBhbmQgbWVkaWEgc2VjdG9yIHNp
emUgKDUxMikuCk9vcHM6IGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCwgcHJvYmFibHkgZm9yIG5v
bi1jYW5vbmljYWwgYWRkcmVzcyAweGRmZmZmYzAwMDAwMDAwNDI6IDAwMDAgWyMxXSBTTVAgS0FT
QU4gTk9QVEkKS0FTQU46IG51bGwtcHRyLWRlcmVmIGluIHJhbmdlIFsweDAwMDAwMDAwMDAwMDAy
MTAtMHgwMDAwMDAwMDAwMDAwMjE3XQpDUFU6IDAgVUlEOiAwIFBJRDogNTI5NjcgQ29tbTogc3l6
LjYuNTY2MCBOb3QgdGFpbnRlZCA3LjEuMC1yYzMtMDAyMDAtZzcwZWRhNjg2NjhkMS1kaXJ0eSAj
MSBQUkVFTVBUKGZ1bGwpIApIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJ
Q0g5LCAyMDA5KSwgQklPUyAxLjE2LjMtZGViaWFuLTEuMTYuMy0yIDA0LzAxLzIwMTQKUklQOiAw
MDEwOm50ZnNfaWdldDUrMHgxNjEvMHgzOGUwIGZzL250ZnMzL2lub2RlLmM6NTQzCkNvZGU6IDgx
IGMzIGUwIGZkIGZmIGZmIDQ4IDg5IGQ4IDQ4IGMxIGU4IDAzIDQyIDgwIDNjIDI4IDAwIDc0IDA4
IDQ4IDg5IGRmIGU4IDBkIDkzIDRkIGZmIDRjIDhiIDNiIDQ5IDgzIGM3IDEwIDRjIDg5IGY4IDQ4
IGMxIGU4IDAzIDw0Mj4gMGYgYjYgMDQgMjggODQgYzAgMGYgODUgZDQgMzEgMDAgMDAgNDEgMGYg
YjcgMWYgNDUgMGYgYjcgZmMgNDQKUlNQOiAwMDE4OmZmZmZjOTAwMDFiZGY2NjAgRUZMQUdTOiAw
MDAxMDIwNgpSQVg6IDAwMDAwMDAwMDAwMDAwNDIgUkJYOiBmZmZmODg4MTJiYmRlODQwIFJDWDog
MDAwMDAwMDAwMDAwMDAwMgpSRFg6IGZmZmY4ODgxNjhkZjRhMDAgUlNJOiAwMDAwMDAwMDAwMDAw
MDAwIFJESTogMDAwMDAwMDAwMDAwMDAwMApSQlA6IGZmZmZjOTAwMDFiZGY4YjAgUjA4OiBmZmZm
ZmZmZjg3YzE0OTAzIFIwOTogMWZmZmZmZmZmMGY4MjkyMApSMTA6IGRmZmZmYzAwMDAwMDAwMDAg
UjExOiBmZmZmZmJmZmYwZjgyOTIxIFIxMjogMDAwMDAwMDAwMDAwMDAwNQpSMTM6IGRmZmZmYzAw
MDAwMDAwMDAgUjE0OiAxZmZmZjkyMDAwMzdiZWZjIFIxNTogMDAwMDAwMDAwMDAwMDIxMApGUzog
IDAwMDA3ZjExOTRkMzc2YzAoMDAwMCkgR1M6ZmZmZjg4ODJhYjZiNjAwMCgwMDAwKSBrbmxHUzow
MDAwMDAwMDAwMDAwMDAwCkNTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAw
ODAwNTAwMzMKQ1IyOiAwMDAwN2Y5N2U3ZTc4Njg0IENSMzogMDAwMDAwMDExYjE3NzAwMCBDUjQ6
IDAwMDAwMDAwMDA3NTBlZjAKRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAw
MDAwMCBEUjI6IDAwMDAwMDAwMDAwMDAwMDAKRFIzOiAwMDAwMDAwMDAwMDAwMDAwIERSNjogMDAw
MDAwMDBmZmZmMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA2MDAKUEtSVTogODAwMDAwMDAKQ2FsbCBU
cmFjZToKIDxUQVNLPgogbnRmc19maWxsX3N1cGVyKzB4NDI5OS8weDQ1OTAgZnMvbnRmczMvc3Vw
ZXIuYzoxNjg2CiBnZXRfdHJlZV9iZGV2X2ZsYWdzKzB4NDM2LzB4NTAwIGZzL3N1cGVyLmM6MTY5
NAogdmZzX2dldF90cmVlKzB4OTcvMHgyYjAgZnMvc3VwZXIuYzoxNzU0CiBmY19tb3VudCBmcy9u
YW1lc3BhY2UuYzoxMTkzIFtpbmxpbmVdCiBkb19uZXdfbW91bnRfZmMgZnMvbmFtZXNwYWNlLmM6
Mzc1OCBbaW5saW5lXQogZG9fbmV3X21vdW50KzB4MzQ2LzB4ZDMwIGZzL25hbWVzcGFjZS5jOjM4
MzQKIGRvX21vdW50IGZzL25hbWVzcGFjZS5jOjQxNjcgW2lubGluZV0KIF9fZG9fc3lzX21vdW50
IGZzL25hbWVzcGFjZS5jOjQzODMgW2lubGluZV0KIF9fc2Vfc3lzX21vdW50KzB4MzIyLzB4NDIw
IGZzL25hbWVzcGFjZS5jOjQzNjAKIGRvX3N5c2NhbGxfeDY0IGFyY2gveDg2L2VudHJ5L3N5c2Nh
bGxfNjQuYzo2MyBbaW5saW5lXQogZG9fc3lzY2FsbF82NCsweDE1Zi8weDU2MCBhcmNoL3g4Ni9l
bnRyeS9zeXNjYWxsXzY0LmM6OTQKIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc3
LzB4N2YKUklQOiAwMDMzOjB4N2YxMTk2MmU5MWJlCkNvZGU6IDBmIDFmIDQwIDAwIDQ4IGM3IGMy
IGIwIGZmIGZmIGZmIGY3IGQ4IDY0IDg5IDAyIGI4IGZmIGZmIGZmIGZmIGMzIDY2IDBmIDFmIDQ0
IDAwIDAwIGYzIDBmIDFlIGZhIDQ5IDg5IGNhIGI4IGE1IDAwIDAwIDAwIDBmIDA1IDw0OD4gM2Qg
MDEgZjAgZmYgZmYgNzMgMDEgYzMgNDggYzcgYzEgYjAgZmYgZmYgZmYgZjcgZDggNjQgODkgMDEg
NDgKUlNQOiAwMDJiOjAwMDA3ZjExOTRkMzZlMjggRUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDog
MDAwMDAwMDAwMDAwMDBhNQpSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwN2YxMTk0ZDM2
ZWMwIFJDWDogMDAwMDdmMTE5NjJlOTFiZQpSRFg6IDAwMDAyMDAwMDAwMjBiYzAgUlNJOiAwMDAw
MjAwMDAwMDIwYzAwIFJESTogMDAwMDdmMTE5NGQzNmU4MApSQlA6IDAwMDAyMDAwMDAwMjBiYzAg
UjA4OiAwMDAwN2YxMTk0ZDM2ZWMwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApSMTA6IDAwMDAwMDAw
MDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjQ2IFIxMjogMDAwMDIwMDAwMDAyMGMwMApSMTM6
IDAwMDA3ZjExOTRkMzZlODAgUjE0OiAwMDAwMDAwMDAwMDIwYjhjIFIxNTogMDAwMDIwMDAwMDAy
MGM0MAogPC9UQVNLPgpNb2R1bGVzIGxpbmtlZCBpbjoKLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAw
MDAwMDAwMCBdLS0tClJJUDogMDAxMDpudGZzX2lnZXQ1KzB4MTYxLzB4MzhlMCBmcy9udGZzMy9p
bm9kZS5jOjU0MwpDb2RlOiA4MSBjMyBlMCBmZCBmZiBmZiA0OCA4OSBkOCA0OCBjMSBlOCAwMyA0
MiA4MCAzYyAyOCAwMCA3NCAwOCA0OCA4OSBkZiBlOCAwZCA5MyA0ZCBmZiA0YyA4YiAzYiA0OSA4
MyBjNyAxMCA0YyA4OSBmOCA0OCBjMSBlOCAwMyA8NDI+IDBmIGI2IDA0IDI4IDg0IGMwIDBmIDg1
IGQ0IDMxIDAwIDAwIDQxIDBmIGI3IDFmIDQ1IDBmIGI3IGZjIDQ0ClJTUDogMDAxODpmZmZmYzkw
MDAxYmRmNjYwIEVGTEFHUzogMDAwMTAyMDYKUkFYOiAwMDAwMDAwMDAwMDAwMDQyIFJCWDogZmZm
Zjg4ODEyYmJkZTg0MCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDIKUkRYOiBmZmZmODg4MTY4ZGY0YTAw
IFJTSTogMDAwMDAwMDAwMDAwMDAwMCBSREk6IDAwMDAwMDAwMDAwMDAwMDAKUkJQOiBmZmZmYzkw
MDAxYmRmOGIwIFIwODogZmZmZmZmZmY4N2MxNDkwMyBSMDk6IDFmZmZmZmZmZjBmODI5MjAKUjEw
OiBkZmZmZmMwMDAwMDAwMDAwIFIxMTogZmZmZmZiZmZmMGY4MjkyMSBSMTI6IDAwMDAwMDAwMDAw
MDAwMDUKUjEzOiBkZmZmZmMwMDAwMDAwMDAwIFIxNDogMWZmZmY5MjAwMDM3YmVmYyBSMTU6IDAw
MDAwMDAwMDAwMDAyMTAKRlM6ICAwMDAwN2YxMTk0ZDM3NmMwKDAwMDApIEdTOmZmZmY4ODgyYWI2
YjYwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApDUzogIDAwMTAgRFM6IDAwMDAgRVM6
IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzCkNSMjogMDAwMDdmNzU2YWI4MTAwMCBDUjM6IDAw
MDAwMDAxMWIxNzcwMDAgQ1I0OiAwMDAwMDAwMDAwNzUwZWYwCkRSMDogMDAwMDAwMDAwMDAwMDAw
MCBEUjE6IDAwMDAwMDAwMDAwMDAwMDAgRFIyOiAwMDAwMDAwMDAwMDAwMDAwCkRSMzogMDAwMDAw
MDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZjBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNjAwClBL
UlU6IDgwMDAwMDAwCi0tLS0tLS0tLS0tLS0tLS0KQ29kZSBkaXNhc3NlbWJseSAoYmVzdCBndWVz
cyk6CiAgIDA6CTgxIGMzIGUwIGZkIGZmIGZmICAgIAlhZGQgICAgJDB4ZmZmZmZkZTAsJWVieAog
ICA2Ogk0OCA4OSBkOCAgICAgICAgICAgICAJbW92ICAgICVyYngsJXJheAogICA5Ogk0OCBjMSBl
OCAwMyAgICAgICAgICAJc2hyICAgICQweDMsJXJheAogICBkOgk0MiA4MCAzYyAyOCAwMCAgICAg
ICAJY21wYiAgICQweDAsKCVyYXgsJXIxMywxKQogIDEyOgk3NCAwOCAgICAgICAgICAgICAgICAJ
amUgICAgIDB4MWMKICAxNDoJNDggODkgZGYgICAgICAgICAgICAgCW1vdiAgICAlcmJ4LCVyZGkK
ICAxNzoJZTggMGQgOTMgNGQgZmYgICAgICAgCWNhbGwgICAweGZmNGQ5MzI5CiAgMWM6CTRjIDhi
IDNiICAgICAgICAgICAgIAltb3YgICAgKCVyYngpLCVyMTUKICAxZjoJNDkgODMgYzcgMTAgICAg
ICAgICAgCWFkZCAgICAkMHgxMCwlcjE1CiAgMjM6CTRjIDg5IGY4ICAgICAgICAgICAgIAltb3Yg
ICAgJXIxNSwlcmF4CiAgMjY6CTQ4IGMxIGU4IDAzICAgICAgICAgIAlzaHIgICAgJDB4MywlcmF4
CiogMmE6CTQyIDBmIGI2IDA0IDI4ICAgICAgIAltb3Z6YmwgKCVyYXgsJXIxMywxKSwlZWF4IDwt
LSB0cmFwcGluZyBpbnN0cnVjdGlvbgogIDJmOgk4NCBjMCAgICAgICAgICAgICAgICAJdGVzdCAg
ICVhbCwlYWwKICAzMToJMGYgODUgZDQgMzEgMDAgMDAgICAgCWpuZSAgICAweDMyMGIKICAzNzoJ
NDEgMGYgYjcgMWYgICAgICAgICAgCW1vdnp3bCAoJXIxNSksJWVieAogIDNiOgk0NSAwZiBiNyBm
YyAgICAgICAgICAJbW92endsICVyMTJ3LCVyMTVkCiAgM2Y6CTQ0ICAgICAgICAgICAgICAgICAg
IAlyZXguUgoKPDw8PDw8PDw8PDw8PDw8IHRhaWwgcmVwb3J0ID4+Pj4+Pj4+Pj4+Pj4+PgoK
--000000000000f099050652eaa936--
