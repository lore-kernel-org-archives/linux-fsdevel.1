Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794898305;
	b=NK9AXFVpy060RIRO/4ugSWlgLamcEKfY0tGdeKbadT1kFuQmfn4nFT9EYHZ5aX3ORu7t
	 IK+TdDSs9kozhhkU1IJ9Ij9t/9LbA0mAJ8OUWG7cQDlMjZmoLXoDpnFC3PuuOMyz6Cvfi
	 meuTLmTdSq0V2Ylj/Ps6D9gQFfYzHNVShsdmuyVJxNflW5AKGK6wKNyjrXbkWTK5WHi5b
	 uEt0a4h23D8JYW8D0jqOJ6xTRbRF2ybkY2WmH0rELaO1Wcqjt4fE0uZ5siOopVq9Xk748
	 y2zurDqcfl3Yb/ElK1bwKCmZvNnsfj5vHU6bZcGA3y/A4/aeQF4F97Shlt+U14DB4PA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794898305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=hPSUk+irIwnxGrE8T/ciuKFUm1SYddVzk8aA64/IVHM=;
	b=4KEsYsBMJ2RoyhoZQAfcFqnBGcatgcZHIE22t1Kyaf5wkmKlJbAyz8xLSWgE3iJN35ma
	 1eoXiCJTBjJnGff+LNmDLfwzOEtNWx7IC10Dz3B4qHMWMh1tQ6ri5hzzEz2DIzsQgSHW+
	 mRZ5i4B7DUi1AfObkibt8u4vjKIo7yl9cN0IP/utRnp1QWIHn4l/kd61Ioag4tL/sHkRT
	 lm54h5M/Wc5zm7ydACyQXVcT+9p4OeTdY7NGQ+UDKSTNSUGQbB30EWJEnb2356uDU58UC
	 wYTJNTbQ3USPTSUYdihdsnkwzRJjHHsenUGu1N6q9RKoEyymf1X4dufuj+h4ktArO1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nsA4o4w9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.69
Received: from mail-lr2-f5.google.com (mail-lr2-f5.google.com [74.125.230.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A2606A323
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A72A2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nsA4o4w9
Received: by mail-lr2-f5.google.com with SMTP id 38308e7fff4ca-3ab461daab0so20718951fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 22:51:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794898303; cv=none;
        d=google.com; s=arc-20260327;
        b=FN2JrRm7Vi8j39HHxgxAMWcAtbpUb92xCORnlXZfWVGGKzbhuOS+iufNMWJmSo8BKe
         wMKTBYrxJ2k1L75z2tK2pDVsbRyEOS4UOUtZ3GBfDMlDkOsClmKr+LeETERZuuKydegE
         2uR9l98TEYDo/1q5Ta742RjydILEIpo8wi0j8jh2Nvc7yvV6ak9UjSPJhUECYi/r2Ev+
         mFtRQIs2I68sKjfC0IRBBCsnf5ncmD2Lig7ZaDP1jnTPJWiB9t+iOUUc0U6IwE9JiLWB
         f3upsWe6Ez3WwVbDmrezMR0UG/5u9Q1MnwFQZPn0otz77AChtFdNSX0O0TZ1EJoiIxZ5
         5Nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hPSUk+irIwnxGrE8T/ciuKFUm1SYddVzk8aA64/IVHM=;
        fh=WfQC4zyk2dl2GMIiYEXDIGOBLqajnq9KlgvQkg0GFQs=;
        b=hsVFv2u8EwOiFZUvDt0+MzEZuoQHlQiFHMKChZ08GaUGalDor3xXlhVkn0ovbxxkFe
         ElwK7QsaKe3tRYgIhNkNo5hjmTmCQSahaBrlwhfr/pyJWQySjqC+9zTj4YnN+106xbW2
         MKJg0p5HBYqR73GCNGfyIBOLzg0FuUkbdlFCg43kspYRJoqw0f2/ewKiTZ3YYZCW/MLM
         FwAhL7Z1prxYT95Jjnlh03w4SwLMd9psUEMbX0H88H2IrtlqyAwGuQt75UIa0yEzhLTl
         pkuZFNSZ2ogTwUAHCa4ySLOTApHVQdSwdDNXvd904g+7+yggqGpxotf4IPZHU31ZhIJl
         SO7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794898303; x=1795503103; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hPSUk+irIwnxGrE8T/ciuKFUm1SYddVzk8aA64/IVHM=;
        b=nsA4o4w92e0aUonTEC1ZL/ygwT5O2ipxn6vw5wAfWOQg8vmfOb3XZSawHGzGejTPjc
         al1o+ws7Vi1K1SKR2plFuEdY1VXokZB7r7CXoOunW3H2qM/ndFFeGLbubj3VV98X2jqh
         orbcp+9yUtocQ3laHTa1B3lqjcODGDiRC4fym59zlN+7aEyea9kJTMbDzQY8kC6KseUw
         BCKdUtCbzpV7Yua8Mmcu8xbM8b5roOyRmeSBd/vuBl5Hk4GOJ6aVDD0xC5pWQSemzxOG
         G9Q+oCaA1EjtrYk8SGqFrL8XqVfXLvE8GWYbYi2s4eTginx1S72j3UEFweAYKI6kNdhC
         SP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794898303; x=1795503103;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hPSUk+irIwnxGrE8T/ciuKFUm1SYddVzk8aA64/IVHM=;
        b=tPXTCSd1fFaChJHtzVOo4hJIdVxzcn9uS3DnySmGOsI9MpJ9R+5z6wXZLMWcD5HI0G
         NU5z7YK5YdCaklKZLHf9F7nBwfVvx4BQyGTKzp6f1zm9TodN4vl5yGUgbv7NHegI/k8c
         yDoLzOREBzJRCHhg82R+uj9c3q0JTatgoqwF2VvWol37ODFxFk6Nr4xI0abKcS0xbFXT
         edReiRbDw1U7YqPYwcZGEZ1Y8pE4QfEQe6q8jO6+1p7hGvPpYxG43dTZq26nI4c8WGkY
         s3TpeH1NBfJAMupqJvikjf0o8lDkTt5OsypXTmMMJ4t50LPkrr07byqKASq3GTNtSO6L
         Ormg==
X-Gm-Message-State: APuU4Z84uWzN6jdhR2qTCHXn2+3Z6tjfoaTb2uypa+tH9oyNaV8zn9tQ
	5YaJkuTTU3Vj3yjh3hTiBdK0WjHJb3s1PriqTN1g1FOdozadeJR+lgKDt+sqzuUhUqCRoButFDP
	RaB+pG42fBV10TQ7zSdZe55dh9Q2rg7I=
X-Gm-Gg: AYBFou1xocsuMmqqYkO6LayHt1LSPKFbWX3hcEqWs4dkBNXcDC/a6A59qAjiblKWSXT
	DgVjdSmliT/YIZDa28mQTqSVKc2OaOZW0/QAkv9Bw+kYuVCfLHXo4BxMlXWlaW5XNy//zNL58q8
	vEeoiEyFZVHl6BAXBPqNki2+nI+IqO67+78bALFJrk+WbLP2y3DHRXFdA9XWrePL+fmjP6NFIbP
	aXmFDhp2CD3r85j951l2pjwin2TaUXZCxuozniJxdEoH0Fz9rueoEH68uRy2IEnTjxl0eJDQJkv
	cwjLsPGDs8cDgqBcX0wIehzNFJtBzJRRVXwVpxYgFXcYaf4h6ep3ZhKgpvs3ufAZvd/zbJWQxT5
	H0+yYbnmsCpfiiaHwcKBiMefSP7BMUnUThsDeUAZYVoibDLWvT03i0vz25qBOBueEwhBsgw==
X-Received: by 2002:a05:651c:199f:b0:3ae:25fc:66ee with SMTP id
 38308e7fff4ca-3ae2b4bc376mr40394291fa.14.1794898302442; Mon, 16 Nov 2026
 22:51:42 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Zheng Zheng <fengaojigui88@gmail.com>
Date: Tue, 17 Nov 2026 14:51:28 +0800
X-Gm-Features: AclHuK9-LoUVdHftMYHvIyHY9bPKBGHQL9OF4RgvrHt7I3K2GXOVwkZQ5H2k4aE
Message-ID: <CAO-4RZ3n2NFZkVDdOW7o5WvsZ=g7b=8mPrq5jLkKL1Fw2P+cxA@mail.gmail.com>
Subject: [BUG] WARNING: bad unlock balance in ntfs_readdir (fs/ntfs3/dir.c:625,
 v7.4-rc3)
To: almaz.alexandrovich@paragon-software.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Konstantin,

We found a reproducible lockdep bad-unlock-balance in ntfs3 on v7.4-rc3
with syzkaller.

Warning:

  WARNING: bad unlock balance detected!
  7.4.0-rc3-kernsight-kasan #1
  -------------------------------------
  syz-executor/10086 is trying to release lock (&ni->ni_lock) at:
  [<ffffffff833e9657>] ni_unlock fs/ntfs3/ntfs_fs.h:1267 [inline]
  [<ffffffff833e9657>] ntfs_readdir+0x7e7/0x1170 fs/ntfs3/dir.c:625
  but there are no more locks to release!

Call trace:

  __dump_stack
   dump_stack_lvl
    print_unlock_imbalance_bug
     __lock_release
      lock_release
       __mutex_unlock_slowpath
        ni_unlock                 fs/ntfs3/ntfs_fs.h:1267
         ntfs_readdir             fs/ntfs3/dir.c:625
          iterate_dir
           __do_sys_getdents64
            __x64_sys_getdents64
             do_syscall_64

The reproducer mounts a crafted NTFS3 image. The log also shows a sector
size mismatch:

  ntfs3(loop4): Different NTFS sector size (4096) and media sector size (512).

That mismatch is an observed reproduction detail; we have not established it
as the cause of the double unlock.

Analysis: in ntfs_readdir(), the code drops ni->ni_lock before
ntfs_read_hdr()/dir_emit() and reacquires it afterwards. If
ntfs_read_hdr() returns a non-zero value, the `goto out` path skips the
re-lock, and `out` calls ni_unlock() again. This includes negative errors
and the `+1` "directory buffer is full" return value:

  ni_unlock(ni);
  err = ntfs_read_hdr(...);
  if (err)
      goto out;          /* ni_lock is not held here */
  ni_lock(ni);

  out:
  ni_unlock(ni);         /* double unlock on this error path */

A reasonable fix is to distinguish the two cleanup paths instead of
unconditionally re-locking: after the explicit ni_unlock(), a non-zero
return from ntfs_read_hdr() should jump to a cleanup label that does not
call ni_unlock(); the normal out path should still unlock. A bool lock_held
flag or a separate out_unlocked label can express this clearly.

How to reproduce stably:

1. Build vanilla v7.4-rc3 with:
     CONFIG_KASAN=y
     CONFIG_PROVE_LOCKING=y
     CONFIG_NTFS3_FS=y
     CONFIG_DEBUG_INFO=y
   The bzImage used here has sha256
   0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882.

2. Boot a Debian trixie x86_64 guest (6 GiB RAM, 4 vCPU, KVM) with at least:
     root=/dev/sda console=ttyS0 oops=panic panic_on_warn=1
   The full QEMU command line is in environment.txt.

3. Copy syz-execprog and syz-executor built from syzkaller commit
   853b104bb454141a5b0fc0e4218ec78e9f34ffb1, plus
   reproducer/repro.kernsight.prog, into the guest.

4. In the guest, as root, run:

     syz-execprog -procs=8 -threaded -repeat=1 \
         -executor ./syz-executor repro.kernsight.prog

Expected result: "bad unlock balance detected" with
ntfs_readdir+0x7e7/0x1170 after roughly 120-145 seconds. This is a lockdep
report, not a panic; panic_on_warn=1 did not escalate this particular
lockdep path in our runs, so serial/dmesg is the success signal. We observed
the hit 4/4 on fresh VMs (runs 1-2 with -repeat=0; runs 3-4 with a single
ordered -repeat=1 pass):

  Run 1: 138.18 s
  Run 2: 144.69 s
  Run 3: 119.98 s
  Run 4: 141.08 s

Source/line-number check: the unlock is at fs/ntfs3/dir.c:625 in the
v7.4-rc3 tree used here. The file is identical to the torvalds v7.4-rc3 tag
(sha256 86fa0e100b32c38980b72767cfb905acacebe8b7c7eb26c39bf13b6bde5cd768);
addr2line maps ntfs_readdir+0x7e7 to line 627 (adjacent/inlined unlock),
consistent with the reported line 625.

The reproducer is a 177-entry state-reconstruction recipe (168 replay
entries + 8 priming programs + the triggering testcase) and is
self-contained. The old 1131-program external program set is not needed.

Repository contents (all v7.4-rc3):

  https://github.com/Zheng-zheng-codes/ntfs-readdir-bad-unlock-balance

- README.md: phenomenon, root-cause analysis, stable reproduction steps
  and verification results.
- MINIMIZATION.md: notes on reducing the old 1131-program set to the
  current 177-entry rc3 recipe.
- environment.txt: rc3 kernel/guest image hashes, QEMU command line and
  syzkaller revision.
- kernel.config: v7.4-rc3 kernel configuration.
- reproducer/repro.kernsight.prog: 177-entry self-contained state recipe.
- reproducer/repro.priming.prog: state-priming portion.
- reproducer/repro.prog: triggering testcase.
- reproducer/repro.report, repro.stats, repro.outcomes.jsonl,
  repro.context.json: pipeline verification evidence.
- logs/log-0.txt, logs/report-0.txt: original rc3 syzkaller log and crash
  report.
- logs/machineInfo-0.txt, logs/title-stat.json: guest environment and title
  statistics.
- logs/external-verification/: full serial consoles and run records for
  all four fresh-VM reproductions listed above.
- logs/external-verification/verification-summary.txt: concise reproduction
  summary and hashes.
- SHA256SUMS: checksums for the inputs and logs.

Is this error path the intended one to fix, or am I missing another place
that should hold ni_lock before reaching out?

Best regards,
Zheng Zheng
