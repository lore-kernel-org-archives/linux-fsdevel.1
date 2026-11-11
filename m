Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794381214;
	b=45Xk/YzOXctU8WHW58hswcKKkcZKqufWWwPevEgAUbQ2TQc3reBsk4afgfTx7igY1eLw
	 G8eOLCjyn2GxUA+QV+MvWi3NiOvNm0lkt7vssi74UDnQ1GQp6ELonPlGYU0mikO+Y/jZJ
	 qKh0Zss2CkILDlPAcwkuUl6Z2IqrA+qeo7mOnoOB0xln09/MrzL+iNfNK9GFxl1eodf4K
	 oPPgTvJ9XTGguJIR0wNjDEVYXPRyBur181rfsbQuwPUjarbU6oQCEBu4RTU3/0FvzcxC0
	 XLpcpjDtkoJN0BQVOw6DHHQnC7K6WjxwtMssXE1NigMWyiLZ2F8yz9DIFqRLvLTR5fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794381214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XODJD59FFZyBHFi1nMxZLbWlyiBiM9n7HI3pze1LCe0=;
	b=0sxkWjfXbGx/aumydJiJtSHfD68vOro1yIqsxScv7UG3X8ZX9GUdMSFVrfTwG29tQadu
	 rjpOmfJiZVO776Ik400Nj8aPMXz3tc+XeSrz2iEMIOctxYBlNnL9kFktQ0m4TLyOfyiEm
	 6IfDEpxCDJ9qSGXr2aSssRB1H7dvru0qw0+UlGStutpryo0B6NUen69yRRYn9e93hzA0q
	 Lc6pSYWFS7E42h6qBCV1nOVGQXy06V5mc/NgA1p2/QdV4lXccbp4T70Sb0jAHNSYJADOy
	 S15kBXOPVdOy+R7Mc9KgAMYpgba0rz/mlIth2UWwmTMxVgwnVVutz0Jj6cBVHpw/ipQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tj17Xqg7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.72
Received: from mail-lr2-f8.google.com (mail-lr2-f8.google.com [74.125.230.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A7606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 07:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 104A7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tj17Xqg7
Received: by mail-lr2-f8.google.com with SMTP id 38308e7fff4ca-3adf0220e61so19587421fa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 23:13:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794381212; cv=none;
        d=google.com; s=arc-20260327;
        b=RBXr/Jwc3ckD5pq6QjJ/V5horRYEC5qmdz/lrNcetV32IUL2XdQ658M60k0nev81ay
         IzzVhb6Yu81HqRVUg47pRxFgdFJuQ0imx3U2E7OEajHDAOKUT5c6MBnU9nSn3IzOVpmG
         0JgxvzDJhCa2fE03Sd31lGzDA6J7AE6wtdeNVbZ0F9CQzNOukQSIWLvBGBTEP8pE/dU+
         XIXsO6h/V20rgk+1rB7ABt7stU8NzOmdpV8N5010Wu/QA4RG+UkZKSnFSbDsrgp2zc+Q
         8NP5AtzQFzHnAArI+1enudB9YaEb3Jr6tSBEBFAql9m3NwlEEoz2D69RCwnEuNSI3VcZ
         3JIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=XODJD59FFZyBHFi1nMxZLbWlyiBiM9n7HI3pze1LCe0=;
        fh=x7ep320xvO8LrCRNal3Ndd4jFewMdQ3ch36Faii7yLQ=;
        b=bguLysbuKuETpbBmxBP6QlIJj3ydQrujPGv/OmrPBUvbeG7Cvhi1lx99jDyGxWsKaB
         jcJv8Bd3e3Xy3nx2NYcmtBOZqj9C/SpZk1NOP+tYkoKZZZv3cMeuEScX12DxHB6fB9z+
         6BOv1WaNUcKFUnef6itSmymURF3wKZ30cD6xqjZ5zt1ASC1Me9Rpjmfxs/IEZeCdoQq4
         /69DDCFqShiQZueJXh6Q58ek47R34kSH97e1nySeJ6g5tNpmffuIFtJT/gBwXI/+k0rd
         eDurJ/vePMigLYH+FyKOhuRoOrcAD6vUrld8fWqn8nRvAs4HURW6MHYHU2oAnDHvKO5h
         Xtaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794381212; x=1794986012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XODJD59FFZyBHFi1nMxZLbWlyiBiM9n7HI3pze1LCe0=;
        b=tj17Xqg7eru0Be2RCQJMzkbTr6FV8I9PKryQ473/vSYhLN1pzuJZq/1r3FkN3PtSit
         MaNNHoAxnHyzzUpieTgW7NZNt1+Oz3zVeecSnMh/HfENVlB4yre48aRiWsYKGARKfpQx
         bo4PYrbvC+x2tCG+GLo/yrkKLR6bOL1WZucoaYVq/PqqC+LlnDrZkeHJFJMh3KNuFPrj
         LtgixFU2WZS2j8lp/87ZGZt+ZlibonBKm9fhwpL3/VIT7pccIW/bzl7G16Q8kpOXNyQh
         SpHhkw1r9eWAFLF1XNOhpi9NSOSNEzJbJ2pOU4+Cvav+gtSXEQGYNicuNiPCvRkz3tV7
         n1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794381212; x=1794986012;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XODJD59FFZyBHFi1nMxZLbWlyiBiM9n7HI3pze1LCe0=;
        b=zSwTs7WZDxoJ6Y139YN0JqrKFPuy5JMGpHJajXl7DCDtWaFJSdaH1BvFyI9u0uvMbk
         i0gRIylpqOWWz/7fpBkqKxHDm0tU6CHbT1KNhzW7roBzapbygoVUpDcRWH6emYCQr7oN
         PeP5i+V8BbRSuSC2juHPsVWWoaQqDXhXH6robPrJPaeHCshOqeUoyo4N5iJDvLpZG7uU
         FpmKHk45yYf7lpc5AVeCMnkIzeiLie8anv8QZPtgbq3E76fugpi6+/iTCSb83GKl7orZ
         b3ZrMp9E4hHSjFll94onMCC7PusStk4WOoV+WQn/UxQDiEEMp1rrgxTNRWH4ONJp0iP/
         Amvg==
X-Forwarded-Encrypted: i=1; AL+hErHRIfcoEdrfky02yFIB7IWMDv7F6qOvys+g9QpKfv/VYY106qoBVg2DLZqw4/S+yVFfYho7BVQ+sNDOVDIy@vger.kernel.org
X-Gm-Message-State: APuU4Z8D0pgutuTI6UE7Si9cL6v4jhKJOo1btrkbVB+WE3EFkfLc8dMV
	whdzLV0Fq+pazzMTld8qt3+rCHFspuNnrDZO0rxNdw2g4q66W6xdx81g4xQHZrs2GeN/9qrd29y
	c+TXHe1NtG/PnG+3gNnTFv7gXtR6lluSFWxFpeFj4PmXc
X-Gm-Gg: AYBFou0WqEbJsZ5pFOomPJ6ZgFNL2tdJD+TPF4CQsClDkzq9vcYKe/FF8shGrJ8fdqu
	z3mupkcpd1kSdDXWumwu+R3tndWkLUpqgBct5n1mEMwg3XyIRq9oNtQmfid7kWDJRdEaHTXvzNs
	nyjhiukEPXovU4uWsPa+E1SaBjX/zjUNH5rmki8ZLT/YaIj7XYeI/fzbnVQZnvMrd5svxFPkkfQ
	V2V19x2LIHC/FOUEPox+7lF8CCKEgufRc68hdVX1Mey5FBqZLkdiAHalkJk//92T7tDHaHlQFrM
	GKMruaO5Stv4GTszjnX5EHfHm7F+lM1Dy6Ska++gGt13dyzS1vZKUPoZqRFgAWqza9lzAU+F++6
	FeMJXlECX2nac+q3gYr3BK41Zk79dDlshCXYxpgr/E25PmJxNO8X5xdldW2G+027ixsiZCzD3Fi
	JgDZF1mokb8VvXwuI=
X-Received: by 2002:a05:651c:41c6:b0:3ab:2bd8:41b6 with SMTP id
 38308e7fff4ca-3ae125cd6e2mr2801391fa.2.1794381211882; Tue, 10 Nov 2026
 23:13:31 -0800 (PST)
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
Date: Wed, 11 Nov 2026 15:13:18 +0800
X-Gm-Features: AclHuK-f2eMwfErEfJLrseJEG_i5om0J7gq83OoLHQsn1r11Xlpkbi31zgpwVC0
Message-ID: <CAO-4RZ2=4okHYZ-xCkpV-ekj-aSqKLnYGOsRM9A2dD8R4Ozzeg@mail.gmail.com>
Subject: [BUG] nilfs2: "VFS: Busy inodes after unmount" -> kernel BUG at
 fs/super.c:731 (v7.4-rc2)
To: konishi.ryusuke@gmail.com
Cc: slava@dubeyko.com, linux-nilfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryusuke, Slava,

We found a reproducible nilfs2 unmount failure on v7.4-rc2 with syzkaller:

  NILFS (loop5): disposed unprocessed dirty file(s) when stopping log write=
r
  VFS: Busy inodes after unmount of loop5 (nilfs2)
  ------------[ cut here ]------------
  kernel BUG at fs/super.c:731!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 3 UID: 0 PID: 10340 Comm: syz-executor Not tainted
7.4.0-rc2-kernsight-kasan #1 PREEMPT(full)
  RIP: 0010:generic_shutdown_super+0x305/0x3a0 fs/super.c:731
  Call Trace:
   kill_block_super+0x49/0x130 fs/super.c:1852
   deactivate_locked_super+0xc0/0x130 fs/super.c:558
   deactivate_super+0xb9/0xd0 fs/super.c:582
   cleanup_mnt+0xbc/0x160 fs/namespace.c:1396

The CHECK_DATA_CORRUPTION() "VFS: Busy inodes after unmount of %s (%s)"
check in generic_shutdown_super() fires. In the original syzkaller  crash l=
og,
it is immediately preceded by the nilfs2 log writer reporting it disposed
unprocessed dirty files while stopping ("NILFS (loop5): disposed
unprocessed dirty file(s) when stopping log writer"); the two messages
appear in this order, but the causal relation between them is not yet
confirmed. Inodes are still on sb->s_inodes at unmount time =E2=80=94 a pot=
ential
use-after-free risk for the subsequently freed superblock/inodes (which is
why syzkaller titles the report with "(use-after-free)"); a use-after-free
itself has not been observed in these runs.

Kernel/config: 7.4.0-rc2-kernsight-kasan #1, built from v7.4-rc2 with
CONFIG_KASAN=3Dy, CONFIG_PROVE_LOCKING=3Dy, CONFIG_BUG_ON_DATA_CORRUPTION=
=3Dy,
CONFIG_NILFS2_FS=3Dy, booted with oops=3Dpanic (and panic_on_warn=3D1).

Two verified reproducers are provided (timings below are seconds after
guest boot; each was verified with a single fresh-VM attempt, 1/1
successes; the stable success rate over multiple runs has not been
measured yet):

C reproducer (verified):

  # on a suitable Linux build host:
  gcc -x c -O1 -static -o repro reproducer/repro.cprog
  # copy the `repro` binary into the guest, then run as root:
  ./repro

Verified on a fresh VM: kernel BUG at fs/super.c:731 fires 113.9 s after
guest boot. The syzkaller reproducer pipeline independently confirmed the
C reproducer as well.

syz reproducer:

  # in the guest, as root:
  syz-execprog -procs=3D1 -threaded -repeat=3D0 -executor ./syz-executor re=
pro.prog

Verified on a fresh VM: kernel BUG at fs/super.c:731 fires 244.6 s after
guest boot.

The syzkaller build used is commit 853b104bb454141a5b0fc0e4218ec78e9f34ffb1
(see environment.txt in the repository). The two reproducers trigger the
same crash but their call sequences are not identical.

A full write-up, both reproducers and the verified console logs are
available at:

  https://github.com/Zheng-zheng-codes/nilfs2-busy-inodes-after-unmount

Repository contents:
  - README.md                      full bug report: phenomenon, stack trace=
,
                                   mechanism status, reproduction steps, ti=
mings
  - reproducer/repro.cprog         C reproducer (verified; compile with
                                   `gcc -x c -O1 -static -o repro
                                   reproducer/repro.cprog` in a Linux build
                                   environment, copy the binary into the
                                   guest and run it as root)
  - reproducer/repro.prog          syzkaller reproducer (minimised, 5 calls=
)
  - reproducer/repro.kernsight.prog
                                   full state-reconstruction program set fr=
om
                                   our fuzzing pipeline (ordered)
  - reproducer/repro.priming.prog  state-priming program set (pipeline reci=
pe)
  - kernel.config                  kernel configuration used
  - environment.txt                kernel image info (sha256), QEMU command
                                   line, syzkaller commit, reproducer comma=
nds
  - logs/log-*.txt, logs/report-*.txt
                                   original syzkaller execution logs and cr=
ash
                                   reports from the fuzzing pipeline
  - logs/machineInfo-*.txt, logs/title-stat.json
                                   guest environment info and title statist=
ics
  - logs/crash-serial-excerpt.txt  console tail of a verified crash
  - logs/verification-serial.log   full serial console of an independent
                                   verification run on a fresh VM
  - logs/c-verification/           C reproducer verification artifacts
                                   (serial console of the C-run crash and
                                   pipeline reproducer report/statistics)

Happy to provide the kernel image, extra crash instances or anything else
if useful.

Best regards,
Zheng Zheng
