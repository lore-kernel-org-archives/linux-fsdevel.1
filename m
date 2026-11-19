Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795072776;
	b=wfVAjlpl45U1dOiqYqc8Uwfi2TPNQcPQLdFOJz5PZ8HWiXJXaUcXfjfRxtuxcyalRguV
	 fFC6oLHpFILVskSbY3zmhfwRp16g/HHMrFgvvDE+UhIcs9Mj8HCmp65GGg66TkI7nrh5d
	 1JjJbIpUCG+iSf0+8DH0yvmtI2RJHKMIxd1uggK8IIS1AfAZkvz3kCoAOmPke1+GLJqYc
	 NXxsnDgPHn79BH2vZQ69yovagmV1zDgaLuGE/X55MkLbMxPQg/NRJntCOYgLJnNyLaRyc
	 phKsh/HrFJXdMy1mb64/zI8O8uQ7TmYKpJ4LP8axFqBAyBfMF1I82Z9ywKvrO0fEGNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072776;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
	b=OQUzrsLjIrbs37AwU22mRr6B5DVpe+JG4E5kcNqFciXesyJT1lwgA7YjbScvhOwVLltl
	 r8a+f+YW6k+9AjumBnn1NM+JHGAi+i6Ti4Dxy4L8LHD63RfkNxaCgdnwIFa9p/9Onbhxe
	 myRvTc65rpHKd+8yF5eGLKpT1/7kx1DiY1Bj0Kh3dA9sv5Sm/s3ju9hAOu3vuuKnLZn/B
	 D9K3WX8LTMZLlLCiz0zTGh3Z09sDopWGZdh174Mwg2zWfN6aYvViLl2ArTAxvHaHuIJ3K
	 DZkP30VTo8Jj+KNl1yQAOZxKQRLJ4uwB0BdO+XFZY5K/FqG8H2CuhBrFWav5OH03yZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipgbtKzO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674860A2602
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 07:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8674860A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ipgbtKzO
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9211bbce3abso10836816d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 23:19:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795072775; cv=none;
        d=google.com; s=arc-20260327;
        b=MIG46tI4oBI+ozGam8o4gr7VMCWhlPjDG+7IODxyINNTloP9v9lqGlh+upOY/PekJN
         WSUD4+YcU4q5y6g0pvMjx/v7kZI3JNCHCb4Jdrwzf5HDdUFx6CVIAEDBpjcG9TmKU1gR
         c0qfDxRlmeDGo/7FwqKG8SxNHWA6O9mX6W7WrwvFa+OhEQLKPwS2+qQve26B/LUQw6YA
         PBkphb4uf0r3sy+2vaRbsdeP/MaYOqzrkwvJVX86WSduzEqSwJp44gkF5j3AdqoXieNy
         a/7UIoLrVnmYf09t0nzGfLcZ9Z09QTWYUgxDiVi7mq56ZIOm6pDGytEk6Ohw/cAok94j
         TfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
        fh=0lQzMOk8QheIR9RGx7RV81FG+UJ/ZcH5G5NDnoFimlo=;
        b=W46/ONwYB3LAN3AcbiBnEP4MdxfWszYX3GcIBngc+IiOWz/TjYxezlOGmQdl2QlC0z
         HJAn8zcNS3DlZ3JvjoM8o1CZlnbGADZ9ZfOO5woVYYS/2XcH9ID0RhCtyNY9ut15m0hr
         1wTtE64ypgJVZk4HTmI5vmmtrdzL00LqTDIgiDcOjvMQhJkyPqQNZyUB6y1vaGKVZW1c
         sqHV7bBMshYBkN2JDUHxQm5KryKwWdJ9h6bWwCk/3UeyglKnRw4suBkNEffGCQsEUp05
         6IEDiEzFF4/hDLdacx7pmqTs8tIDymN6qt9wkLpXRPbLoI8RkvoGk6l/pN/egkQ8TA0Z
         lo6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072775; x=1795677575; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
        b=ipgbtKzO47kTqztaxtvQrPaEEJkMqagfg4PklqZem6C5iY8BSrJ1dqhz+10BPSuIoC
         cSZWcWhzzPX8z6eZGM7m4yZ3Foh0d6BcV3IKA74DloeR4YoLXUDaCrV5zP9Wba+hntww
         CP5YsvJMuKXaNeue5C3tkzE8PtSLDRxoENoJXzB9nm9wT7N3FS5PD2eXX55BdR7ShxO5
         dtWLJLhIeZppiht6yOQwd9ySj7byEXFmAJPJYaPsd3/qMm8k/MxhKeI8GNmGaKBHT/Ze
         kIdRNNEpVwRBA1IvUYjU1u4uAuZnf4puMJwAfuZ+kt+p2wPzHbs5cpPKg/Nmk9Ms5pLH
         NIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072775; x=1795677575;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=anpfjOBmsHIUC3TQqXl6CPDDEhejvdqvM3KrtY3UP0Q=;
        b=J5NmQVxCl4HLr894xfofS5j2kTtlGP3o3F+lNz6C9kredlqzWw7dAUiz9uRV0Obl1G
         UG1xTZ6TcSLWCd486HiG4DAeyiVLC7SCFUOCLW/p8SxmQG+f42n9wXM65QS+8Qff5Xga
         6ryCJGqbBvEl4ar4k4hlMdyNfbIJ6RFBWJKj0b8Sfwg/5za28qMYLlCBUPx7qzymF5sZ
         XQ2bwY4xsx+ZHUOHwsYejVk24o9pfip9e107Xws210Oy2Dpa+G4CsrAYBFzfhzb7CT99
         tgRqx6bO2E9bGC/bqMPnVAWsMpFem9h9ESOP9ysCbuyDouNjNjrw1JL7cXzmHnwBWfBB
         kFMg==
X-Forwarded-Encrypted: i=1; AL+hErF8AxazRfxC1BloG0CRnGVysgOmi6qBy2cCwDkCzIyQ8ofN5MDPW9wUVyzbaLxu3aY+mm7QvAp+B5A1CvqG@vger.kernel.org
X-Gm-Message-State: APuU4Z9dOs3UUp/3ld6vm7HQAshDhPPWhQE6mQCkwS/MiQ9nl8M5+QIl
	vV+i32cK7qujKU+KI79w9qSGYDShUdvUew3co7wb31UJ7s93XB6gy/9qXcc9xulWiApAI8/UGK2
	Fgns6kRROMZzM7ZHPlBNab6ofLVRZJq4=
X-Gm-Gg: AZFdTZcFDYft4nwJ0n8vcPAtVuNPjGUxBaNn5+ucjDusHJryHwPEyEpP9KzgmPg6NHs
	3rLD5f3OOsosIon78vUi6jQg+I6Wp0tv8fHxwAClWALATzt0wr4n5HZ9r/0IsGa7DLaLwD3TWOP
	wHcu33KpocjB7YdFb8O3mz1KELIUd2zwcYYQ8w5oLFKG+owJio+0c+UoUm8nj6iRjj7tK7a1LXM
	HpIDbJgOJR4ZAL/hKPf6VwM1Ln+xlFiuqBMERNr7JlJg5rwS/OxqX96L5xc4yV2dTebxGWYIlDR
	dq672QdtGxNhM+rgpMrUYg+cMArXUqfmJTsFCdE2iQU2yLIYMB+L/TstrTUMsHIzTKcj38k7tl+
	OPfPar7guw/eGO769ss172R6dZT1V/ZNw95eYhPtmN6JbFQ6AhnK47OgPS/Qu6a/ch91XJg9ykP
	fcE15SpwgQvJ55xVyjQQ==
X-Received: by 2002:a05:6214:4784:b0:921:1cc7:80c with SMTP id
 6a1803df08f44-9211cc71c9emr52693146d6.34.1795072775342; Wed, 18 Nov 2026
 23:19:35 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 02:19:24 -0500
X-Gm-Features: Aa3M54qXFrwgtFLlrgRKJFJJgccYJHjtkJLvYiWNUjzb-GPFdVBg-cmr6Ghvh1E
Message-ID: <CAMcAce_827HxqEcwcN9Pp9n1J_vRb15qGaKC-U+ERtQgoKn2Ow@mail.gmail.com>
Subject: [PATCH bpf v2 3/3] bpf: Add missing raw_tp_null_args entries for fs tracepoints
To: bpf@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Multiple VFS and filesystem tracepoints pass NULL pointer arguments
under valid error or uninitialized conditions:

  1. fsnotify_destroy_event (fs/notify/notification.c:82) passes NULL for
     arg 1 (struct fsnotify_group *group) during queue cleanup.
  2. vfs_open (fs/open.c:1012) passes NULL for arg 2 (const struct path *path)
     when opening anonymous files or unnamed sockets.

Add raw_tp_null_args[] entries to enforce null checks on raw tracepoint
BPF programs attaching to these hooks. Verified on x86_64 7.4.0-rc3 and
6.12.118 LTS.

Fixes: c83e2d970bae ("bpf: Add tracepoints with null-able arguments")
Cc: stable@vger.kernel.org # 6.12+
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/btf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c345678..d456789 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6604,6 +6604,8 @@ static const struct bpf_raw_tp_null_args
raw_tp_null_args[] = {
  { "sunrpc_task_run_action", 0x20 },
  { "bcache_journal_entry_close", 0x20 },
  { "bch2_journal_entry_close", 0x20 },
+ { "fsnotify_destroy_event", 0x20 },
+ { "vfs_open", 0x200 },
  { "fsnotify_bump_event_seq", 0x20 },
  { "nfs4_cb_getattr", 0x200 },
  { "nfs4_cb_recall", 0x200 },
-- 
2.43.0
