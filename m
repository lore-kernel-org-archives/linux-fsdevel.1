Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794505265;
	b=HIalQW5zK1Ur5dUbtPWKdV/QbTVFAy1Voykgj6P4nbBv5s4Pkx32LCpx8qrQG0pmsc/2
	 G29bvX0E9n1jxUPIq80IIlASZE3sKUbdul6Agas0DZybKq/jJdYPl1Ldq3T/SbTNWwS8W
	 2ksyYlW88mpSANLyfr21aQZBw7ljEtgz9RpLpoojA3azqN2IFl+ZxXOordyjUepUQAkzZ
	 tFwe9ilkP3p+OMqpEu2prIuDjzwtLiqZP+aAOWzinYielS0b8n/l3E8KBakzy8GWk9U9Y
	 izXiSa99/qBI96dLN8JIZKctR6JHxb1mhlyfFKwXoCfjnIDiHx2MkH1jB0DrFrx4qig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=gulIbZCmS0C3qCKYVEzdG6nvB054k2W20/UwIzcuJw8=;
	b=SBA1cig4iGjCfaAXzSVi2A8V7hD9Mo/O1rPpFJgb6VarQgcEnlxa6PyDsZ/pI16IbHrR
	 htZMH+7OJ8VIzaK8ihXM3Nj2w2bXI7kCUK9YFUl+S3hOFA+bBYwSILmkHTGva1rXxipWA
	 GhyR+hOU4K4b1tJUzCPPdZqt+++6I22Eq7I2JU/2XfjCBaGr/88Cp9FyVEv87HN7g10cg
	 n56US8jJw+eckTRYz07/GD3QailPxh2wb9iNphVl3kSwWpe0tw8OhXcfH3mwbRRTq+dZy
	 QwpWIiionu6uWbFzUjMEUiSAiKh5PzlY6RoNgmo+zp+nnZzwYIINSjKGLvNPruvtSjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sc7BXgws;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09A606A220
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 17:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C09A606A220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sc7BXgws
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b7bffb5b8fso73681a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:41:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794505264; cv=none;
        d=google.com; s=arc-20260327;
        b=F/34MgNvRRJzigFbfTvgGb+9Kp+LZmpUyRJfGVzR7dinosuSOTenggFflzfsFBMJOB
         bRlVVodsFNCjKHFK95rrYdro5Pdm1RNy0sr8SKN8X3lQZnjCirE79C6vQYUJUDbxUbEp
         zErs5WOfOhPUZ9x48oyHkVTUYsRXBBaVhSczx2lnMhGH9r5yx2NIdIrQPGXsxkl3/Abr
         mTxkcSu/ThR8QV6pE4fTE4S5kZL2+h7nxDbg4hLywcAWh40+7Mr7xvgPpKTZA6B5y0Cx
         6A9qx1W+iqaJheUWt6L0oEM6qC7hzTVLqkUABMrUxgKRMnZsMxqK3+5yUkl6TvJXsXts
         6EQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gulIbZCmS0C3qCKYVEzdG6nvB054k2W20/UwIzcuJw8=;
        fh=R6Th/FU61XvohfnTX7ZpZglwiV6AOSksxkFvbqGt0UY=;
        b=ByfXWjkYtUYGjfhYTYVkhya3DrDJqLQIsYDEV9jbBsFtGaHVQNos00c4AAkmoNUU6C
         6YmUj0GCsdHHpwSZxEqp95+Koaa2QpX3Fk8EX9TaHpkYx/IlrbwHDLEQeMi80kzlzxPe
         7u6nAAtTFFuW/z8nYGjzOpHEYOarchoRYMoCjymEL/SiKxSj55FvCHmONdgjfIQLya87
         6lTBfP9GPBNtf/9BTJfS/8tUXwNxWX+IjrpXX+qarCXhAW3BwIQ0bIB0iOKZsAofwnoF
         wSA2o+9YL+OlVIbCpCbTdzf9QOZPLrZ8U5gWQcJOuSK6olVr7E+2Zu5k68orEu8/lpQW
         JK4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794505264; x=1795110064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gulIbZCmS0C3qCKYVEzdG6nvB054k2W20/UwIzcuJw8=;
        b=sc7BXgwsB5JZBO86kgULdAnyoeKRHiO1bT0dST06bJxLHTE1zKiyi0diPhAoS76dPH
         Xfdwx1EYriLeCp+wgu6fTHPhnJK7FPUC2LWtlecK5u+c1aepeVCT1DQMdNr/0qPlRw4i
         YcTJOw26JAxt7QO3cXUj3jm07IERGMmilxTPNTs/6HkAPhdk6Q4MD62uoKmtQH2QEQHQ
         9UO7Hl4ZwnV7mAbX0mDG6TLKCgcnw5CkaQwXlrI8A6CnLp4uFsnqzPZiUix6N501VP4j
         Qvm9+ZHAtb+oc+E4joACDNBKoOwGTpp2mfMwucnh6PRh+J64qU6WBmYCZyavrVEFu6dE
         wF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794505264; x=1795110064;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gulIbZCmS0C3qCKYVEzdG6nvB054k2W20/UwIzcuJw8=;
        b=PqqEvg41TGGcwlTHx058jmRQREn2eDrmfkqTyWld+9UD87mC44c+Vx4Ox1ocOHy3t0
         +QnZJsKUjhAHOlP4WJjtCc4v9OAD5111JAU/QIKStYyPXfBHnqRMVV3vQaKcH3/T6YM+
         b/XTxBlmEbJ6xIcfj1U/XSWGuq4eqxuqLUu4QGU2kbKsBVGuGnwSP5TcL3zeHmXDa0fu
         et1ZUrpc0qyFep2/2Y5s5MJKC+i5Tz2+ARJS0XU6DgJn2IlT+72wuimygc+2Rj5kEzmc
         5/coqKoBuWFgLbG13t3wMWKqi5jqAwTQpbVZj89ETwQpsmrDpzz3lIqfCiQiehZ6AIUx
         sq3g==
X-Forwarded-Encrypted: i=1; AL+hErFdIxtYbYbkNkIopeLU/o1i3hcL9iIsEVXlPgfRprlYxBmNgM8/WWKDA6s8sMZyWamxSFv2PRKh5pCxnGFM@vger.kernel.org
X-Gm-Message-State: APuU4Z98LIZvZluNsFqk9eMxaytzEzJb3N6Y+rbrlB8ydCbJx7JccRBT
	ZjsPBxYN1XvEbjF7sl7tx/A8HVXenrHmJdfx56VNbPmG8lqv/KOv+vz2OL9DbVy7OhD1HcQ5ai2
	7gfXi37wjYDyowMq1/MR7BctQ6lb+4K39V4Q/
X-Gm-Gg: AYBFou2kCvnZvkm/+KZs/eUxQPzlmcF0mI+c1vbuBMlXgfCqeyY+QppLUwebhHL98c1
	+R4iwc4B+LPr+MkeWooWSuqRZM0IEKQmNPvQDskqJh3FMACDaiVEluER+tLCuwN25bI2IHSobg3
	crRkoGngblDeA8cj9BM4cYfuxViguR93jH5ht6nN4jU1NIcF/ookPrfdCAC9evwFD9tH7+ZXVPZ
	aKeH9G7uEAzX1upShABMr2fSIdwbIH1bJU297x83LOz5SCoXru6Z2EZOXunqhm41YWVWW1SDEhm
	O2dON6xnAmgixDzfsi3+XmZ4/75AcIXw3g8AWEQlfwVQaooMq5vzozqlxLPW1imtKecziQp6AAA
	eSWJfYt9dVE/RFZzZPrn9I2mVGI8t8VItitFpLAAT39BZ11vzLfTDCwGKOOvWoQWEaGy9y4N+DV
	1Vv71/d02NpA==
X-Received: by 2002:aa7:cb59:0:b0:6b5:767e:f030 with SMTP id
 4fb4d7f45d1cf-6b7c088f8b8mr247576a12.2.1794505263516; Thu, 12 Nov 2026
 09:41:03 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 12 Nov 2026 12:41:02 -0500
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Matt Salsamendi <matthewsalsamendi@gmail.com>
Date: Thu, 12 Nov 2026 12:41:02 -0500
X-Gm-Features: AclHuK-rzhfZstrK9oYTveQMuv2rKMtHi1eKCo_ucxE8NDs7sn-o7nsC2VQ7AeE
Message-ID: <CAMPWk9NE_epOdOCbs1PGh8OQP4wjTObvjU-1Wopmu7SSNAMXhw@mail.gmail.com>
Subject: [PATCH] fs/proc/task_mmu: fix stale walk_end after a completed scan
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Muhammad Usama Anjum <usama.anjum@arm.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Matthew Salsamendi <matthewsalsamendi@gmail.com>

After PAGEMAP_SCAN fills its internal buffer, a successful final walk can
leave walk_end at the earlier stopping point. On x86-64, 513 disjoint
written pages return 513 ranges with the last range beyond walk_end.
This trips a bounds assertion in a userspace dirty-page tracker.

Update walk_end on successful completion before replacing ret with the
range count. Preserve the stopping address for partial scans.

Codex assisted with diagnosis, code, validation and this message.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
optionally clear info about PTEs")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Salsamendi <matthewsalsamendi@gmail.com>
---
Validated on x86-64 v7.4-rc2 in KVM: all 12 scan cases and all 119
pagemap_ioctl selftests pass. The unpatched kernel reproduces the bug.

 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b87d3e864..14996d0ba 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3176,13 +3176,14 @@ static long do_pagemap_scan(struct mm_struct
*mm, unsigned long uarg)
 			break;
 	}

+	/* A completed walk may follow an earlier full bounce buffer. */
+	if (!ret || !p.arg.walk_end)
+		p.arg.walk_end = p.arg.end;
+
 	/* ENOSPC signifies early stop (buffer full) from the walk. */
 	if (!ret || ret == -ENOSPC)
 		ret = n_ranges_out;

-	/* The walk_end isn't set when ret is zero */
-	if (!p.arg.walk_end)
-		p.arg.walk_end = p.arg.end;
 	if (pagemap_scan_writeback_args(&p.arg, uarg))
 		ret = -EFAULT;


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
