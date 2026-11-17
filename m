Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794884479;
	b=b750x1lBXbYEE2FJhtxaM29y3dZhQtF/rlBpj/uEFTkahb+xhIAX8+TuK6LoLYKXmkBP
	 0IQmvhN2Mcz54kqKvu4BbdPIC+G2he8EZCReB6YyfNoCdOvWGYeJZ+Ar3p12td5rxa7D4
	 sR+TiVXc6wYPBkWUxjCdY5zuGr6RprWuvGQOFlL5hD4Fl7gpzqzOALwrkyDgjuxHWQ7n0
	 573mSqkzmEjITueeTp8CnJ6JJG0VC5oBo6l+HRflvMdoTi/eimrVoS7eg6gqbSOuxCNM2
	 5iRN6iMeXLj4iy9HNnDvWqmhLkrkPMlI3C//4z92NAU/pphaxyLfk49zTRnUsHpT01w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884479;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=rxu4C+D4IFtlQQXxGEHNwNvtWVbx7dC0E7mSZshpwlE=;
	b=e2Rq81cXQ1cGj2qoSv5lI6H1U2PqLS4TxQmZtnmZvpDb1A34I8RHaYX/k+ZVubzXa966
	 xjQ+zT+1ZWTlmuEJbSxeN8TfGa4A+cOqjn4ILNXaGijCW71jYcv+OL6g0NC4qOLlp1mey
	 ywUJrH1gO3lJx5/4/Z65FXN7XSVDaTE116+LSRtFeSazpN8klhGgrBJ1k0kkd8twXvXt2
	 nNEv72rrIuZ4jjRfykD8EEh1ZMVv32TRlz8CZKJVWPstLdFarQVdeY7BjYYp7CNwcVdVA
	 hBFk4PsU59GLT7oKwtm1crPV7zl8eqsWHtjcTX22h82lfQeK76otICzlYbyW9LR7+5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1QhM67D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA61606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 03:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DA61606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N1QhM67D
Received: by mail-lr2-f8.google.com with SMTP id 38308e7fff4ca-3ad8a138a11so22521141fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 19:01:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794884477; cv=none;
        d=google.com; s=arc-20260327;
        b=FDijwHLZBjzeisAWFwm02RHPZXRDq/JMWCp09XjmLbb+5M8njhbmhIrHfCvPvi+K9H
         879gKcaOSyhzCVB5BN2xvvg7WDfbky5ayZ9v4dGhvlLrRIjH7BAJR4Is66wFM448sOaR
         6wbakTHGAxaMfasEokrsNFPRacrShPxDiANN74hYMX9GF8way0OsRJl3XpeNopwZ7qDE
         OYvmH//orhWqenI+4oR4sNC7hUPOWOyIbUE6Nhd9nEWV1d6RQHbWL0KWP5QXTX+EnI1C
         hGEZC87qe2ic5aVWoD5dKWhv6QzXZDdGpXZ2A0VOrAi4sGgyM9Wdxrbmi0n/DxC1j0uD
         rdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=rxu4C+D4IFtlQQXxGEHNwNvtWVbx7dC0E7mSZshpwlE=;
        fh=wIZBulq57N4S2pn3Ey8afBxZhUxIrTeXsuTAQn327ow=;
        b=P6VqONAGWFPsP0A5GuV3BftFG7Vg+oYx32ZZcUJ6S0N+9eaE3Eyv24ghpm4BzqP60N
         d8T2QSUfwfNzSqD9iDoScWst+5KtQ58wo/8froi7R//IMBVzzZE4zMMX25oSNdm3EvZZ
         Hmc2iSkOlMRkHdL4md8ax/rFoiwoOvnHt/6tc0Vcxch/UBXbCiLoYKBJ9vO+9XZZT+RJ
         llDS4AsPfgdUWOZeXl9mXq4Mp2HRkU41T4bwMpHtiOatuJyinz3bZvKvW0RQDvZiwmuZ
         /cZl7671xHjWfGWAyOYz7BcVzm8Suhe5j4tI3hZ6d6oTB9XZ/rNT0H2pV8hFYSzlXvsF
         sbsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794884477; x=1795489277; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rxu4C+D4IFtlQQXxGEHNwNvtWVbx7dC0E7mSZshpwlE=;
        b=N1QhM67DV+KItdZzSHIydtjJrH9Bc/bfjj1i4+zIcjMjcm5tftNElc+p1Tq0xEqLwE
         Ljou7jWP2BagD5W1rQQsr2fFgdZ+ZF+yc/lqemCB38x+yKdAhuaQ8woia8IJA7oXCGsV
         mLjgT+e3x3rBF4Wmpo4C3GTh+Q5ffavHeNDL3/F3yyKJcuU++9aymFLYE0kKhrXlsj+E
         zIdQLz75EIqEEphsoB48/hkipZW3/7U8ieO5VUHck2jRs7D4Bg171EW3EPNMgallfe7b
         GCJcsI4OwTv8tj04iPAPEkbBGp3xyZkFUjt1gXCE9Jq4MdWoiK0+8Bg9+1juXMYh+YBo
         2l+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794884477; x=1795489277;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rxu4C+D4IFtlQQXxGEHNwNvtWVbx7dC0E7mSZshpwlE=;
        b=VAFco70Yg9n3bOuMnvLv6lYpHTZvfDlVPGNEN9P0c2rnhO9xvA5pJGVptva8kxORud
         OxUtvUS32GzaUiwpotOzFSITKgbG+1viPV/+IFi7fu7DL8Lg8vY+urTZmp4kdlFHUnrx
         kwdmf4J/6MRYjepf5eDNsHArozAL9ObZyU9uePo9+rpf6xUaITFkS8dOjcs/FlQetEom
         qCtSBaumm1JJ2vAjKNextspFzEMP9tpWUkXFU8NDIdgYiARBTl1Gk47vuyHT3GABdJMZ
         5qbMekHBwlUf893CWENgprvOc6f42EMMm7oQEirovemf7dPyzj0Kr/S4JF5sch08ApnJ
         rc/w==
X-Forwarded-Encrypted: i=1; AL+hErHbLtggIR9UQNJDyGpyemWFTc9NPLomxnozLds7yWAxQ7ixUJXQxsayfxCHXb+X1eLx4NHoLBgsCVSTvmNR@vger.kernel.org
X-Gm-Message-State: APuU4Z8+oPkowxvJrwnFSgl/JYxejVsKbWQYagsPJMRMNG/tc2uz14wD
	RK/cWIY6aI2QtSxbFRbEE2G+HWop4fJ62/inLmf8yMpomhb2jFBUgz4gwqk0woFks8u4j8TwC/c
	QQ1aaPG201y16fUAo9BQbWeO7PdzPGCDjXVZ1hM+31DjN
X-Gm-Gg: AYBFou3LToa5Xdw02o2LczJs5xJeH4pgzR1aFCw9hhIjqXdfoR09bgz10Aubb8I6IA9
	FjHze4RZJ34i1qElax86i9ptUPTBY2l2ZCGdr6DnBnyj0s0lYIeZKJouZVAKRQ4CuPT+xrTr2Wk
	3CTQQKoPlA3AC7bECZN3IS+WNNdw1/vX9hwWoVtmjpQSPML4wlE5R5gjozPanu1TYkrkV4+3dgj
	k1pX0SxiJHoM3i3RlIzaYrHWhoRD40CVHhWcnUCHvrrKcQebRVTdYjeqS2UbgVPpvgjxaunOwOZ
	K7F0ckCwQX1fOFCuFPEZnXPIu8msysyUjUXhBgbVEUkLzh3QgaAca58kYdSwCNEX+9OwwKiz8HQ
	S1xRD8nQwM0vyHbg5P85PQqgok4pNxSRv19pVtCmRbd8vzIq1bTkPGJGBmy38kI6DUUa4Sw==
X-Received: by 2002:a2e:bea4:0:b0:3a6:6d05:7375 with SMTP id
 38308e7fff4ca-3ae2b53711emr40965391fa.8.1794884476943; Mon, 16 Nov 2026
 19:01:16 -0800 (PST)
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
Date: Tue, 17 Nov 2026 11:01:03 +0800
X-Gm-Features: AclHuK8TdYMEcKuub8UUYCj7RSAfjmeEyg8A9aR21g-EKu6aFiCgkApYO0WXhsU
Message-ID: <CAO-4RZ1a46EoJY7x6euiS+7aTOb-T9X62E9nGyToRcyvKU+eHg@mail.gmail.com>
Subject: [BUG] WARNING: possible recursive locking in hfsplus_get_block
 (fs/hfsplus/extents.c:264, v7.4-rc3)
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Viacheslav,

We found a reproducible lockdep recursive-locking warning in hfsplus on
v7.4-rc3 with syzkaller. The same signature is present on v7.4-rc2.

The following is the key excerpt from the rc3 external verification log
(`rc3/logs/external-verification/run1-singleproc-serial.log`, hit at 114.00 s):

  [  114.001303][T10445] WARNING: possible recursive locking detected
  [  114.003629][T10445] 7.4.0-rc3-kernsight-kasan #1 Tainted: G            E
  [  114.005869][T10445] --------------------------------------------
  [  114.008132][T10445] syz-executor/10445 is trying to acquire lock:
  [  114.010406][T10445] ff1100017d7545c0
(&HFSPLUS_I(inode)->extents_lock){+.+.}-{4:4},
                          at: hfsplus_get_block+0x282/0xab0
  [  114.021835][T10445] but task is already holding lock:
  [  114.024125][T10445] ff1100017d753300
(&HFSPLUS_I(inode)->extents_lock){+.+.}-{4:4},
                          at: hfsplus_file_truncate+0x20d/0xd70
  [  114.044862][T10445]   lock(&HFSPLUS_I(inode)->extents_lock);
  [  114.058492][T10445]   lock(&HFSPLUS_I(inode)->extents_lock);
  [  114.058944][T10445]  *** DEADLOCK ***
  [  114.058944][T10445]  May be due to missing lock nesting notation
  [  114.060170][T10445] locks held by syz-executor/10445: 6, on CPU#3:
  [  114.063858][T10445]  #4: ff1100017d753300
(&HFSPLUS_I(inode)->extents_lock){+.+.}-{4:4},
                          at: hfsplus_file_truncate+0x20d/0xd70
  [  114.064748][T10445]  #5: ff1100017d26e8f0 (&sbi->alloc_mutex){+.+.}-{4:4},
                          at: hfsplus_block_free+0xf3/0x690
  [  114.068038][T10445] Call Trace:
  [  114.068542][T10445]  dump_stack_lvl+0x116/0x1b0
  [  114.068921][T10445]  print_deadlock_bug+0x293/0x3d0
  [  114.069329][T10445]  __lock_acquire+0x153c/0x2110
  [  114.070151][T10445]  lock_acquire+0x1bf/0x370
  [  114.071749][T10445]  __mutex_lock+0x178/0x1dd0
  [  114.075318][T10445]  hfsplus_get_block+0x282/0xab0
  [  114.075713][T10445]  block_read_full_folio+0x305/0x850
  [  114.076997][T10445]  filemap_read_folio+0xc4/0x2a0
  [  114.077824][T10445]  do_read_cache_folio+0x255/0x5a0
  [  114.078746][T10445]  read_cache_page+0x62/0x150
  [  114.079124][T10445]  hfsplus_block_free+0x156/0x690
  [  114.079520][T10445]  hfsplus_free_extents+0x345/0x4a0
  [  114.079928][T10445]  hfsplus_file_truncate+0x59b/0xd70
  [  114.159730][T10445]  hfsplus_delete_inode+0x196/0x230
  [  114.160139][T10445]  hfsplus_unlink+0x7b5/0x980
  [  114.162948][T10445]  vfs_unlink+0x30d/0xc90
  [  114.169449][T10445]  filename_unlinkat+0x3ee/0x680
  [  114.171418][T10445]  __x64_sys_unlink+0x4c/0xa0
  [  114.171796][T10445]  do_syscall_64+0x132/0x7c0
  [  114.172170][T10445]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

What seems to happen:

1. hfsplus_file_truncate() on the unlinked file holds that file inode's
   extents_lock (extents.c:579).
2. hfsplus_free_extents() -> hfsplus_block_free() reads the allocation
   bitmap through sbi->alloc_file->i_mapping while the file inode's
   extents_lock is still held (bitmap.c:183-185).
3. The bitmap read enters hfsplus_get_block() for the allocation-file inode
   and takes its own extents_lock (extents.c:264).

The two mutexes are different instances (the external-log addresses differ:
ff1100017d7545c0 vs ff1100017d753300) but share the same lockdep class,
because extents_lock is initialized in a common inode-initialization path.
lockdep therefore reports recursive locking.

Is this a lockdep false positive caused by the shared class, or is there a
real lock-ordering issue? If it is a false positive, should the
allocation-file inode use a separate lockdep class (or a nested annotation)
for extents_lock? Alternatively, should hfsplus_block_free() run outside the
file inode's extents_lock?

Reproduction:

  kernel: v7.4-rc3, CONFIG_KASAN=y, CONFIG_PROVE_LOCKING=y,
          CONFIG_HFSPLUS_FS=y, booted with oops=panic panic_on_warn=1
  guest:  Debian trixie x86_64, 6 GiB RAM, 4 vCPU, KVM
  syzkaller: 853b104bb454141a5b0fc0e4218ec78e9f34ffb1

  in the guest, as root:
  syz-execprog -procs=1 -threaded -repeat=1 \
      -executor ./syz-executor repro.kernsight.prog

The reproducer is a 56-entry state-reconstruction recipe. The main fuzzing
pipeline verified it 2/2 on freshly replayed VMs; the crash was reproduced
during crash-log replay at entry 55/55. An external fresh-VM run also
reproduced it 2/2 with -procs=1 -repeat=1 (114.00 s and 110.75 s). Note that
the recipe needs strict single-process ordering; 8 parallel workers did not
reproduce it.

How to reproduce reliably on mainline (v7.4-rc3)
------------------------------------------------
We reproduced this on mainline v7.4-rc3 with the following recipe. No
local HFS+ patches are applied; the source tree is vanilla v7.4-rc3.

1. Build the mainline v7.4-rc3 kernel with the configuration in
   rc3/kernel.config. The essential options are CONFIG_KASAN=y,
   CONFIG_PROVE_LOCKING=y, CONFIG_HFSPLUS_FS=y and CONFIG_DEBUG_INFO=y.
   The bzImage used here has sha256
   0c16409f8aec508ac44a63e631c2bd352536401f3fd0856df1d839fb953a1882.

2. Boot a Debian trixie x86_64 guest (6 GiB RAM, 4 vCPU, KVM) with the QEMU
   command line in rc3/environment.txt. Keep the serial console; the lockdep
   report appears there (and in dmesg). panic_on_warn=1 is not required to
   observe this lockdep report.

3. Copy syz-execprog and syz-executor built from syzkaller commit
   853b104bb454141a5b0fc0e4218ec78e9f34ffb1, plus
   rc3/reproducer/repro.kernsight.prog, into the guest.

4. In the guest, as root, run:

     syz-execprog -procs=1 -threaded -repeat=1 \
         -executor ./syz-executor repro.kernsight.prog

5. Expect "WARNING: possible recursive locking detected" after roughly
   110-115 seconds, with:

     hfsplus_get_block+0x282/0xab0
      hfsplus_file_truncate+0x20d/0xd70

   We observed this 2/2 on fresh VMs at 114.00 s and 110.75 s.

Important details for stable reproduction:

- Use -procs=1. With -procs=8 (or -repeat=0) the 56-program state recipe is
  interleaved and did not reproduce in a 20-minute run.
- Use the full repro.kernsight.prog recipe. The minimal repro.prog alone is
  state-dependent and does not reproduce by itself.
- The report is a lockdep recursive-locking warning, so serial/dmesg is the
  reliable success signal; it is not a KASAN panic.

A repository with the syzkaller programs, kernel configs and full logs is
available at:

  https://github.com/Zheng-zheng-codes/hfsplus-extents-lock-deadlock

The repository keeps the v7.4-rc2 and v7.4-rc3 results in separate `rc2/`
and `rc3/` directories so the two kernels are not mixed.

Repository layout:

- `README.md` at the repository root
  Overview of the report and an explicit rc2/rc3 split.

- `rc2/` -- original v7.4-rc2 results
  - `README.md`: v7.4-rc2 report and reproduction notes.
  - `environment.txt`: rc2 kernel image/hash, QEMU command line and
    syzkaller revision.
  - `kernel.config`: v7.4-rc2 kernel configuration.
  - `reproducer/repro.kernsight.prog`: rc2 pipeline-verified state recipe.
  - `reproducer/repro.priming.prog`: rc2 priming portion.
  - `reproducer/repro.prog`: rc2 triggering testcase.
  - `logs/log0..log3`, `logs/report0..report3`: original rc2 syzkaller
    execution logs and crash reports.
  - `logs/machineInfo0..machineInfo3`, `logs/title-stat.json`: guest
    environment and title statistics.
  - `logs/crash-excerpt.txt`: rc2 crash excerpt.

- `rc3/` -- new v7.4-rc3 results (the results in this report)
  - `README.md`: v7.4-rc3 report, locking analysis and reproduction notes.
  - `environment.txt`: rc3 kernel image/hash, guest image/hash, QEMU command
    line and syzkaller revision.
  - `kernel.config`: v7.4-rc3 kernel configuration.
  - `reproducer/repro.kernsight.prog`: rc3 56-entry state recipe.
  - `reproducer/repro.priming.prog`: rc3 priming portion.
  - `reproducer/repro.prog`: rc3 triggering testcase.
  - `reproducer/repro.report`, `repro.stats`, `repro.outcomes.jsonl`,
    `repro.context.json`: pipeline verification evidence, including the
    2/2 fresh-VM result.
  - `logs/log-0.txt`, `logs/report-0.txt`: original rc3 syzkaller log and
    crash report.
  - `logs/machineInfo-0.txt`, `logs/title-stat.json`: rc3 guest environment
    and title statistics.
  - `logs/external-verification/run1-singleproc-serial.log` and
    `run2-singleproc-serial.log`: full serial consoles of the two
    independent rc3 fresh-VM reproductions (114.00 s and 110.75 s).
  - `logs/external-verification/*-run.log` and `*-execprog-out.log`: the
    corresponding run records and syz-execprog output.
  - `SHA256SUMS`: checksums for the rc3 inputs and logs.

When reproducing, note the difference:
- rc2 reproduces from its own recipe in `rc2/reproducer/` (see
  `rc2/README.md` for the exact command used in that testing round).
- rc3 must be run with strict single-process ordering:
    syz-execprog -procs=1 -threaded -repeat=1 \
        -executor ./syz-executor repro.kernsight.prog

Best regards,
Zheng Zheng
