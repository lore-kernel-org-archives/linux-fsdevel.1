Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618123;
	b=fODZNqOaBBGoSnVW6MwKtk8A3NQ0drs+K+Lnw2b0723DaVQk5bU0InDe7Fxtlax+zVq4
	 9qKIkQJrzrDiYeOpHOuTCo6d9uev56pUh10WFg74HQhUqNTx1vkkuBEVUa9xFcD0lbkxY
	 PNk5Y8DcUxihS6iTH0M+LvDqqtHm1orSMSCT7Phr4XmmW0pw7uoNhHB0cCTT2hyImRzoY
	 bJYQ4BlcSi+E9PfNgOahc0za8JCsLRpWzATymPXkX+AQ3mA0iXamOH1OXNwkd4A9z22g2
	 WmVOQGmIE31WvkD1BMF7WDgwxOV9VnyvZDlklB8RcS1qoedgmg7mWe5aj8SmUbtt0bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cTvnOBZflM2IscRsh4AbyC1GaHTZfi0eh+Zi2CPUvg4=;
	b=EH9XCeQLgW9bJVAnhJm650b7QMH1RHLviZClIzH1fhs3BMMam6oJHwensDqPWP/zg3pJ
	 rZbS80v9MTbDkrsqhAGF9MnOG6qhyduFAwzfOWhvsWzh6P85moA7AvG08aTlzNT0TI1F0
	 +Qidiyfoge1ho/bg8VBKCe/I5HOe0kMpmC3iYccQULQ0mChJS74UvjPgvX75vwIZlNPr8
	 bjastKTWuVpWipDHGWlomZRVMtwe4JYPLWXjm8yWUbW+cZ/M856ZyAvyFP8FmYBZzO5+s
	 +MI4mHsHLeBUNJcRpc61nsdFmRAcuWwTainOgEvlQKViOQKLnRze+crazaShCPpszbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6lut2YY;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F5606A32F
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 11:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B5F5606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c6lut2YY
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so18557195e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 03:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618122; x=1794222922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTvnOBZflM2IscRsh4AbyC1GaHTZfi0eh+Zi2CPUvg4=;
        b=c6lut2YYBn3JoXf5AmrM/9BdoOXbtXfjXWLIpzGzxvplmG+mqS3PCXx6TYlLmUmGDv
         GdQ/JuT1ddGrZJ/lmbbi8z+IgCROSReJ3Kcof+RsLVnoz7m3lks0Cv43LWC/ognTA7Pc
         fYzFzdctPGwwajrlhv7s2owwE4+Ga+rp+iFcVDTcOX3CyiSj0gEzHSoUYTWX3zc0nyYh
         UPvSMdJ1Wm1S8+rarV104pXryM2+tnQcYRc9XQWmi015eGlkAbYOvJ8QwHbB1Ojgy0cM
         OdNaryzyHUhzLKaLp8DOg8J1w7bwA5lxTJnva9POWtZ4SbwYQGA36f2T23896HiDn//D
         Gg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618122; x=1794222922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTvnOBZflM2IscRsh4AbyC1GaHTZfi0eh+Zi2CPUvg4=;
        b=E2j1feDDO1b8Vq+vcWdfGoGI7hx08Iecgv6w2SZ7Ity7rlbLiBwCu7FJwopaMsLSnA
         4BrE7beAhagUDtcvr2qHwuEa1q4j4Qt1Xi6QLEga8VZ9OSOdoaDErLb9FYcZXx8/0yZF
         k0ZizKCGyd1Nu+EN19D2EcOBHnyElegIym5f4Ft/qpsnGJD2m/m8ntIUQx7WfkjRWUff
         lS5OG17mpgKOt9ID/b2uqarOTbVbpkAU1pMEsYNGYyfvieRzFFjZrjHFuw9jfPq+1n5s
         ub4SA9BCYRf92ARoKRJrgtVTYDwbQp55+rngOYOCW7CbyfOMUR1X5ijGQToMHPIa2R3p
         JRrA==
X-Forwarded-Encrypted: i=1; AKwUvByFQEK4LJfHqnyzekqXPbjtoeSY1M6bP6cYxEb8nqCY+h0fn975wWZGBzh956AC+lvWBsTiDXTw/4LM6hS4@vger.kernel.org
X-Gm-Message-State: APuU4Z+KAeywj1RAyGbCA5mRXqIAAfOKUQl7xv9v0j02S86wyXhC/3AS
	XiCdQYaSkgrSSzcoHfrrEH8KOPdIOXwpwkwhUA/ORVRi21qfPPl434gZ0XGsjYeP
X-Gm-Gg: AYBFou2jlMMtnGjT/le0Ncc7bkPC5aie016sC9UzIwpyIswT8RaYViBRsvxTg+QsJle
	IdRp1krPaNRzOhgwBd6KQHD22gAUPckWF/GsEmSAapChWHMTt2z717NkbZ0n8adSxqLXrh3EbGm
	5Ryl0Pcb8TfqzUI5W/enx+YixMTN8XK/IU5KfCgrg9givWxHf9jwyv1/cYtg5L4i5Ob7zCy5tUm
	/5AOXItDrLyn8Mk/qMpdG5Jpcjn4QXFScFlKK3li50hitQdQ4ZR4UfdL+AQA9BOSBVTdG+ch9YY
	/D865p/yk4EDgMElSUFvM65s/p4agmU0evt+3z/BPk25sTTXYl7IUKgIg1ptdj+ZDSHQ8Kj2uNH
	7XLw8Z9GgESlUy895UdKmbNS/H1+HC4xXELBUbpB4E7zd4xPTZWQVeUqCI2nwk+f0AVXu8V67bN
	F5TpooW8anpNB3EpkKzYzVeCoMN8PqJFxJCngEQ8zebyc/lZSRe9IIDHgRweBh5KMEpXKFDv3t4
	M/3v7nrNez+Q9v0BpggawRHRxxegKqwdFWMwYVD0tYeBTwn/xlo9EwNE9ShapkBT4XVNVpn/ksc
	KgkTgc9WyrqffjBNhIU9rufg0+4w78JuLHv7ZQibAJ7Mfg==
X-Received: by 2002:a05:6000:2085:b0:48e:7a41:d78e with SMTP id ffacd0b85a97d-48e7a41d798mr11829527f8f.19.1793618121511;
        Mon, 02 Nov 2026 03:15:21 -0800 (PST)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:f970:5a5f:bc55:da4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8a5a7sm20525955f8f.37.2026.11.02.03.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:15:20 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Joel Granados <joel.granados@kernel.org>,
	Kees Cook <kees@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Zhan Xusheng <zhanxusheng1024@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] sysctl: Fix large millisecond-to-jiffies conversions
Date: Mon,  2 Nov 2026 13:15:17 +0200
Message-ID: <20261102111516.1398262-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysctl_msecs_to_jiffies() compares the input against
jiffies_to_msecs(MAX_JIFFY_OFFSET), which returns an unsigned int.
When the converted limit exceeds UINT_MAX, it is truncated, causing
valid timeouts to be incorrectly saturated to MAX_JIFFY_OFFSET.
For example, on 32-bit systems with HZ=100, writing 2147483647 ms
stores 1073741822 jiffies instead of 214748365.

For unsigned long sysctls, values between INT_MAX and UINT_MAX
are passed to msecs_to_jiffies(), which interprets them as negative
timeouts. On 64-bit systems with HZ=1000, writing 2147483648 ms
stores MAX_JIFFY_OFFSET instead of 2147483648 jiffies.

Keep the existing conversion for values up to INT_MAX, and use
overflow-safe, full-width arithmetic for larger values. Clamp
the result to MAX_JIFFY_OFFSET.

Fixes: afdf35cfae0d ("sysctl: Fix type truncation in sysctl_msec_to_jiffies")
Fixes: b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec with do_proc_vec")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/time/jiffies.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index af1c69bf0c23..7b02cc7de15e 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -139,9 +139,20 @@ static int sysctl_k2u_int_conv_userhz(bool *negp, ulong *u_ptr, const int *k_ptr
 
 static ulong sysctl_msecs_to_jiffies(const ulong val)
 {
-	if (val > jiffies_to_msecs(MAX_JIFFY_OFFSET))
-		return MAX_JIFFY_OFFSET;
-	return msecs_to_jiffies(val);
+	ulong secs, jif;
+
+	if (val <= INT_MAX) {
+		jif = msecs_to_jiffies(val);
+	} else {
+		secs = val / MSEC_PER_SEC;
+		if (secs > MAX_JIFFY_OFFSET / HZ)
+			return MAX_JIFFY_OFFSET;
+
+		jif = secs * HZ +
+		      DIV_ROUND_UP((val % MSEC_PER_SEC) * HZ, MSEC_PER_SEC);
+	}
+
+	return min_t(ulong, jif, MAX_JIFFY_OFFSET);
 }
 
 static int sysctl_u2k_int_conv_ms(const bool *negp, const ulong *u_ptr, int *k_ptr)

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0

