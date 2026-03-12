Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B39D3537F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330150; cv=none; b=eugEQPKUTtq1LdJg536OaLmQIL8p/RvNsq+EvY5mzMwhwVG0b3u+3Xo6dujuem7nmFzsoyeYZuV9ELTFgx3aoCNNXHkasJyc6E5d/GNURF/I9cq6X1uPTi/ym0zWuxHA57oBNkcA70gz0GlWrw+iZ8S47rcSZqHFXRTgLPgd7Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330150; c=relaxed/simple;
	bh=4PzX/2BcEMYN6bus1PXJ1eWTdsO2FXz36Sheli+4r/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RDLhOVAfKPtrsit51KSxbppG6hblCsQo0Jwz2DfaXPrRwQVJJE34SOmXhA+OqUw+AKnvITDa6su1pG3uHOK/pPGyXbfCbx3Y5jrtw0FqrgJuQ1tcdVXrvfyl+v9Pn4drqmOaXqfK+m5kmszatPwGVJtOxn2NAYHytK4PsargrlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=nMiNRzpq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nMiNRzpq"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439c5b40f60so1074678f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 08:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773330148; x=1773934948; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XIFxCq7ikd000RdSw5JxwXtTNKqwm1bQP1nyQMPePDA=;
        b=nMiNRzpq2p+rrHQqIp0JMOM+lsSzwPzmD9bh1X/ZP/A6xCy3DyTtlJlm6AXp2nF35h
         KsHbg8J6ronKlwpjSEtKTgch46wv7yVVsxokS7XP5Q8gLPR0IV6YC39Uf4wgzlZrzMtb
         wLfo1yy6g3I3uhPCIuvEJWIB/ErvSinvDjpptSFGT9jSgB/9XM5O5D6OJ6SZtHmRDKxI
         Y9ceRHJsZtPSNI29XfP49Ous2ZXtrjiRwvSEswcAdGYybL8Z8GKxN5il/aegNYKi1/c+
         ds9N9XWEpv9XNA0j3dvl6Dikgl8tE2e8iu//t4DjVfesdJuRKqR484dGLxDbL0yw9rBi
         n2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773330148; x=1773934948;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIFxCq7ikd000RdSw5JxwXtTNKqwm1bQP1nyQMPePDA=;
        b=mocvAZTFrH0eaB0iIor4Gs77uMKy7ac7NVaTVENTnukzIOyi4NBnDEV1iZDbjlzxy8
         pzdDGeuHlzQEmt3eFXbbpUXAdZyxQFN/8zD8R0m1kna7OiDqhRldjQalGQHQB9uif7LQ
         boU1UQG0TVO4Lu6LPK61MQw2yl4iWwnU4LmA8iNHMnmRf7A4NTAbKgRWX1MdLaKO/QTY
         weybq7vXgcblpL+SKp+uBDumzHLWJuwsLCVIpDZK2BK2dr9VcGgMya0HFSI6+hlz3Kkh
         gqLlHiJ/N7gPI/GkTL6maiC9Bc/Z3hIVylyv9SK3QmnGi4N0bgQlp7IcX6Hj5yDfB+Qp
         1bZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2S1+1FNBDD6F2oxUvSnd1eHzvogYlsTbEq1+bGTIreFunIbLM41whS+25WGVJrH27sUr59uQPfVbiOyvg@vger.kernel.org
X-Gm-Message-State: AOJu0YwCPMuIv9bSB3iWbHYoc9N5OyGt1zLcyZmVpqHlqqHGJexDa2Cc
	b0MP1yz/HNOAm5Tu6xveya0JGWXjpDuEkhEfSux28V3GpFOiVIEpcAaI
X-Gm-Gg: ATEYQzx4LrE0ZI2nQ1TSmdoSMi9+Dw7CcMN1Hamyx6KbzhGsECDPex5i9T9u8T9ihR7
	Zb7zjvT8njYAJY03F9sEq1c50hjlIeaz9TtpMbhI57LzBVkSspr6KT+m/INc4luSwru1wUU8DcS
	auSqWLXmK3rl4zC5F8p0D4SvjsoIFwm2QuchROLA44Ccy8Id5ytQP9GTpFfvUrSowZNasH6tJrE
	eIvG3Vu+h9gG+R1OqMgH0ocG3YOz8lw11vfO39JTuwe6Vb9jyPL1uqVUZj6hfg395fttuUCFU5T
	O0lx8bwgJ0Ukq56seb/6QT8GGys/VgMA/R0N1/9TzQ6wtK4hM9iSiFCAMqbvL0K80hj28fXhfJl
	It2EOhEeqePgmgb4XxdpK7Oam3ATGlg1s4VEFLMSFiN4beD0x8mWZsTRV3+tEYf881ltcQrSp+h
	44tVVfmA1oXFJqbfMw2sYR69KdBfu2lcSCtqqem0ircCOk3Q==
X-Received: by 2002:a05:600c:4710:b0:485:34b3:858a with SMTP id 5b1f17b1804b1-4854b0bb3bbmr113297805e9.11.1773330147379;
        Thu, 12 Mar 2026 08:42:27 -0700 (PDT)
Received: from ccde1gl2920.devint.net.sap ([130.214.226.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541acea11sm269359615e9.7.2026.03.12.08.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:42:26 -0700 (PDT)
From: Marc Buerg <buermarc@googlemail.com>
Date: Thu, 12 Mar 2026 16:42:19 +0100
Subject: [PATCH] sysctl: fix uninitialized variable in proc_do_large_bitmap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NQQqDMBAAvyJ77kISWw/9SilhTVa7kCayUSkV/
 97Q48Awc0BlFa5w7w5Q3qVKyQ3spYPwojwzSmwMzrjB9NbhJB/csmRZhZJ8OeJOKjSmZmZctAQ
 fi0+kM/tR1jct2Jsw8HSlYMMNWnhRbpX/9PE8zx+xyS/5hAAAAA==
X-Change-ID: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30c6ef4ac1c5
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Elias Oezcan <elias.rw2@gmail.com>, 
 Marc Buerg <buermarc@googlemail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773330146; l=3076;
 i=buermarc@googlemail.com; s=20260312; h=from:subject:message-id;
 bh=4PzX/2BcEMYN6bus1PXJ1eWTdsO2FXz36Sheli+4r/8=;
 b=jREgJ67/0Ad7cnev4wVPe9MLshX0zf4fyPwS70dVonHWj6g5mIcCY8ZALOllSiTbgn0rr78kb
 pg+WIR0Gz3ADvkLbbdYNsGbJBy/7Ooaxa/zP/RBy1RjSlqvb0yznUrQ
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

Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
Signed-off-by: Marc Buerg <buermarc@googlemail.com>
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

