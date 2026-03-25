Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF73296BBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774477823; cv=none; b=KZn65XlWrPjjqqIzeoPw7AI24GSULZZGlln39txfgY01GctBGGFaOajC04l/0TGcEPgNAxtJQVa4XS5gmCd6BOexaaBF2g06ugzhAzbJvGOsVif6un2iz0tBxJfxIbe/n8ZW+VheuWc6vhAo3ejbr8boMSt+PBhspLyQcr8mOAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774477823; c=relaxed/simple;
	bh=aVsJnN7w8bGYA++sn11zM0enc+DQ6LpFZuNiTAz/6SE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XZmVE4FDQyyrcBiw2qwVXsdZe+XIfrcms0NaxjoeuKDsaXAipI4650lMZJ4gTiZTktSQVoqQzUabcd0YtruBXw1g+oamN56sP1r68Labr5y1Vlaby+V7s0Wm5gQUqR5XXD2bDfWbEnc/bYmJFYGmVRlAVVs7pE1kd3bw1q/az1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lJoyitPq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lJoyitPq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso3605075e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1774477821; x=1775082621; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDxNd9ffxWopSnwz8xRnL4Pi1cvcdDlFkiCHaQSotPc=;
        b=lJoyitPqr0jm+6Is7StsaQbHmWD08GsP9Z4N7pbXFJCqCL2BGo83GklESY05U9S2N1
         M7xi/jU9DFtowXxUofDtkMPRVjtY1Xa3sVwUE/kkgDSdOrkkAI7bUnt/mJGQL4QR7K04
         Cd3FH7uqQMp1+CqccxR2rp67DZqTDWZ+HrwzXq/1DmYTRRfGfbQOywEqXOgn/zTVP+7U
         vMGx2wwmulqPz+jDdO5TDbLDNWOOqXKwGOK/z6QT9RIxZXL3UebjILYqDnLIrzMcGC7d
         4AeQWhVFWKvAACK5x0SfyTpzPBAzq7qH2fXKBir3XM4dlHg9A/jKHA20DkKO4rhg7Uuw
         yjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774477821; x=1775082621;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDxNd9ffxWopSnwz8xRnL4Pi1cvcdDlFkiCHaQSotPc=;
        b=kJ97OOK2fZ3DoDBNj7VACkRRvS5IlRR5gtHgMpkoOMb/LX7+k/hHqc/CZdu40RjoP4
         LkABbudyYW4lLyNdEPmtwvb1qDtZkqcjAAZYamZWB0yOh5zXI0b6x0ViFZFr0Rfe2nH/
         t4Nf2rQxUxnq/k5Ns0gXp8lpxRsr33kcT/PVILP7uysM4idzwGlQAK7YOUE9N2UkI5w2
         fDYd2+7pnapKSNV71XDaDtD6lV5zraD1v3CYrE7h/IQI7j8wxwlwVkRF4pSD1gw/5gDO
         P3rg+WC2iT9q0ekp4r+esSeTQ1m6E1UiRaB5GYwxaLkZMSVrh5to+qgNZRsAhcu6n+vr
         fQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCW5S6ilPrLUG+JRVS2fKnx6VpN/Ob8YOFb6X3fh3Gma/gMsWoD8uugNOvTHo3Tsy7kxCFSecBQKfvZGeOzM@vger.kernel.org
X-Gm-Message-State: AOJu0YyVuOIimWT3K/AdjkqHoIfwAPOigd+hlEiEP25sF10jp2CepILu
	YJo3cfi5DhZ1cQgQlzPX4M0c71VwkkcFTl+Btj6b9coeB3qHE47GOp4Y
X-Gm-Gg: ATEYQzxwE8RwF9aiikFECKsOdz30ug4NNM4CGvsx13PTqs+uUMGT6XmfcOsv66XOOKb
	FD9PPdZraYQKSs+p79TJEA7EG9NJjbliYIdvwsUJtOdsbXG1KGDRL5e7N2ndgJcxhEHxqMPa7mR
	LebXUdGqgTIzq9Kjzhq1oEYF9gY0h3REpSRDLbd0yW4wg9kaq0F5vaQIjHHSZcbu1DgQNkubQ0E
	JGcUd9VSNLrYlxaDnnqd4k5vc6XD6CERX+lFINwz6ZBIR7kWdHmJPACCIKp5MtJr54W3u0EUcKu
	KbqqlXtcp3qyQAjPntsrmHxsHqhs2tbvSvsMEtJBK5RwkDqIkJtDLwuwfeGlfD7k1vxegQrEfAF
	Rtdw30NfM938wqeQRxAJquxgPRaQPZzwh2yVS3e60boEKh7vXiLR48NIzBp0NFMC/4rCfdiNQq4
	gH8OLznrIwoPQlOqDh1/c=
X-Received: by 2002:a05:600d:16:b0:485:3a27:a961 with SMTP id 5b1f17b1804b1-48715f03047mr57886105e9.0.1774477820260;
        Wed, 25 Mar 2026 15:30:20 -0700 (PDT)
Received: from [192.168.0.108] ([2a02:8071:5392:3220::bcad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871fb382cbsm11033625e9.5.2026.03.25.15.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 15:30:19 -0700 (PDT)
From: Marc Buerg <buermarc@googlemail.com>
Date: Wed, 25 Mar 2026 23:29:50 +0100
Subject: [PATCH v4] sysctl: fix uninitialized variable in
 proc_do_large_bitmap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-fix-uninitialized-variable-in-proc_do_large_bitmap-v4-1-6fbdc832d9ba@googlemail.com>
X-B4-Tracking: v=1; b=H4sIAN1hxGkC/6XOTW7CMBAF4Ksgr+vKPxAaVtwDVdFkPA4jOXbkp
 FYLyt0xrJDaFV2+p9H75ipmykyzOGyuIlPhmVOsYfu2EXiGOJBkV7MwyjTKaiM9f8uvyJEXhsA
 XcrJAZuhDvYxyygk7l7oAeaCu52WESVqFDfktoMadqMNTprryQE+fNZ95XlL+efxQ9L39F1e01
 NLuwBnnHHijj0NKQ6AROLxjGsXdLObZ2b/kmOo0zvcayIP52P/p2Genfcmx1WnRo/W+UajaX86
 6rjfb7RW+yQEAAA==
X-Change-ID: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30c6ef4ac1c5
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Octavian Purdila <opurdila@ixiacom.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Elias Oezcan <elias.rw2@gmail.com>, Peter Seiderer <ps.report@gmx.net>, 
 Marc Buerg <buermarc@googlemail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774477818; l=3861;
 i=buermarc@googlemail.com; s=20260312; h=from:subject:message-id;
 bh=aVsJnN7w8bGYA++sn11zM0enc+DQ6LpFZuNiTAz/6SE=;
 b=/Ja3bMOgnnvq78cfu0Z01cSImLl9icRmmXeyQQ+jNmjt8nqD0RK7o2W8wM+zODqgWUnT6/vt/
 1V3e8gfRfztCGaWSbyFiGpEL7RSCFW8kxF83T4gnlQH1B613nteeA8K
X-Developer-Key: i=buermarc@googlemail.com; a=ed25519;
 pk=kBZIEGh9yNUzqCz87kygF7XqwPxTWvwm4+HUrOuckyM=

proc_do_large_bitmap() does not initialize variable c, which is expected
to be set to a trailing character by proc_get_long().

However, proc_get_long() only sets c when the input buffer contains a
trailing character after the parsed value.

If c is not initialized it may happen to contain a '-'. If this is the
case proc_do_large_bitmap() expects to be able to parse a second part of
the input buffer. If there is no second part an unjustified -EINVAL will
be returned.

Initialize c to 0 to prevent returning -EINVAL on valid input.

Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
Signed-off-by: Marc Buerg <buermarc@googlemail.com>
---
When writing to /proc/sys/net/ipv4/ip_local_reserved_ports it is
possible to receive an -EINVAL for a valid value.

This happens due to an uninitialized variable in the
proc_do_large_bitmap() function, namely char c. To trigger this behavior
the variable has to contain the later explicitly checked '-' char by
chance.

In proc_do_large_bitmap() it is expected that the variable might be
filled by the proc_get_long() function with the trailing character of
the given input. But only if a trailing character exists within the
passed size of the buffer.

The proc_get_long() function can set c if the length of the parsed long
is smaller than the given size of the buffer containing the user input.
This is not the case if the buffer only contains the port value (e.g.
"123") and sets the size exactly to that (3). Meaning if there is no
trailing character, c will not be set.

If no trailing character is present we still do a c == '-' check. If the
uninitialized variable contains this char the function continues
parsing. It will now set err to -EINVAL in the next proc_get_long()
call, as there is nothing more to parse.

Initializing c to 0 will solve the problem.

The problem will only arise sporadically, as the variable must contain
'-' by chance. On the affected system CONFIG_INIT_STACK_NONE=y was
enabled. Further, when enabling eBPF tracing to dump contents of the
stack the issue disappears, which would fit the current explanation as a
root cause for the observed behavior.
---
Changes in v4:
- Re-include set c to 0
- Drop check against left
- Move trailers
- Removed Reviewed-by: Peter Seiderer <ps.report@gmx.net>
- Link to v3: https://lore.kernel.org/r/20260319-fix-uninitialized-variable-in-proc_do_large_bitmap-v3-1-9cfc3ff60c09@googlemail.com

Changes in v3:
- Add Reviewed-by: Peter Seiderer <ps.report@gmx.net>
- Re-include bug context into cover letter
- Link to v2: https://lore.kernel.org/r/20260317-fix-uninitialized-variable-in-proc_do_large_bitmap-v2-1-6dfb1aefa287@googlemail.com

Changes in v2:
- Drop initialization of c to 0
- Include checking that left is non-zero before checking against c
- Link to v1: https://lore.kernel.org/r/20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9d3a666ffde1..c9efb17cc255 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1118,7 +1118,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 	unsigned long bitmap_len = table->maxlen;
 	unsigned long *bitmap = *(unsigned long **) table->data;
 	unsigned long *tmp_bitmap = NULL;
-	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c;
+	char tr_a[] = { '-', ',', '\n' }, tr_b[] = { ',', '\n', 0 }, c = 0;
 
 	if (!bitmap || !bitmap_len || !left || (*ppos && SYSCTL_KERN_TO_USER(dir))) {
 		*lenp = 0;

---
base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
change-id: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30c6ef4ac1c5

Best regards,
-- 
Marc Buerg <buermarc@googlemail.com>

