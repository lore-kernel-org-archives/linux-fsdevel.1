Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE44D38B158
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Sep 2026 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788651509; cv=none; b=F51QkkSjaB3AIaUVgDPrEljKc9TrGeKMRwIVR1fYc1IPk3ad8rAObkq2RMhu/aD2okIf0aUivP8N0yCywCzJT6KOKdruV76gso1z79Z0TonBLMIjqH3mu3djBdQ6nknWWdFmKK/DQjJoBhzxRnc6/pauXM9vPMCuLUaSogVNyWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788651509; c=relaxed/simple;
	bh=9ZfFIWzseapJ4UAdXpbGXoJpc6X/0hXsk4k5rUtPDoI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=awVWv2pucaP8pkbzKOmJUjMn1/t/OVTtAnVBx2qT8GKb2kE/+/CMW8MSSWnWtDhGwu5ny6eNdgvux3yAZUavUr56ZJ+NHvdlz/3WEyacxmtShCijahDipgr+NZhBaVAnDs0hGv/OEbmPGoYIL2+3kQk3KeOexqyyCjAGS0N0xKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EejDytXk; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EejDytXk"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63bad3d09so33788445ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Sep 2026 16:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788651507; x=1789256307; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Frntbal32WlMg10huQQliOlhpQlU/2JMUB7os5CGbss=;
        b=EejDytXkRno4Jn3EoGukB4l1ulCssAcGt5qr1ku2iTYyoQZwcVp1d7YvxsYnJ1uMAt
         qeSzAARHyLsLTzrEEq8tmOVY4BA9o/nmL4k/XCW3Clry21htic9kDPL59T+azzuQn3cQ
         8S98hK6hBkyrdFjaP4nQeJcIp14OJ+1Dtk2Uc8n8ZGt1y368ula/g0BZmPplFDjUqjj4
         l/hjR26PV9Bfo5tPIwVnBrBW4hv463tqr3RPPdXzlI41DUxbn5HES74IC7c3SRayUhwU
         CldS5ve9ID8fRVwUM7fU19vf6sek0oZxV2dlOBy43DgNfXRRDNjKgpLGzQ3oohnMn65w
         zDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788651507; x=1789256307;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Frntbal32WlMg10huQQliOlhpQlU/2JMUB7os5CGbss=;
        b=Nx1Y3CqzEkQdDR+T0pR90F7s/tNqZHM0SZJRX5c3ftjkHnvhTmASJwwE2jQ7iv18rH
         wchV9VHp82T6x1RfQ7oHUbWEOS3I4ObUklRn1ArQS7bTOS7nmF3aLSXziQZRCR4iNzdf
         GbUScrN8gaz3SX64nBwhBezJfOOa6BjKCgDsR+SR2A38JOcDHi9w5eOCm84lM/M8FD6l
         fx3g46F2KUPag0Gx2GILyyQjxt0yxBUVFFgsAjW81OKSkYgszVS4NKRhPYm+vKK7UM64
         wUl3WH1zr56S7d6quZgyGVYXYzFXZzPl7iw4+IhEs9MhuRhJrnSTHoh+28frt1aXe0+b
         W3/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzm9HCg9f15m24sXImPE8OzBW1obY34RRRjre+1TDHPVPbn2IxNSpWnDoq3+olo6WaIYPqATJc4QInXoJy7@vger.kernel.org
X-Gm-Message-State: AFuF++nwnWTDA1XHuZwgrG4nmI5CzpmPurJKo81vbvhiBLnGMOaaV0oJ
	4MvqshLETcHEM7XA+eY844tzpspPuLX5tsJGH4MUsRXoRL3k03dNvtfOi5YKRuAY2G3eZbsWVGT
	U/O7FKg==
X-Received: from plhz2.prod.google.com ([2002:a17:902:d9c2:b0:2d6:eed7:9d44])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c24:b0:2db:479a:5127
 with SMTP id d9443c01a7336-2db479a55c8mr3012495ad.19.1788651506893; Sat, 05
 Sep 2026 16:38:26 -0700 (PDT)
Date: Sat,  5 Sep 2026 23:36:31 +0000
In-Reply-To: <20260905233819.1064529-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260905233819.1064529-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260905233819.1064529-3-kuniyu@google.com>
Subject: [PATCH 2/2] sysctl: Make proc_doulongvec_ms_jiffies_minmax() enforce
 minmax again.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Since the cited commit changed proc_doulongvec_ms_jiffies_minmax()
to use proc_ulong_conv(), proc_doulongvec_ms_jiffies_minmax() no
longer applies the range check.

It happened probably because do_proc_ulong_conv_ms_jiffies() does
not have the _minmax suffix.

In addition, sysctl_msecs_to_jiffies() casts u64 user input to u32,
and a truncated value could bypass the max check.

Let's rename do_proc_ulong_conv_ms_jiffies(), pass true to
k_ptr_range_check, and limit the max user input to INT_MAX in
sysctl_u2k_ulong_conv_ms() to avoid truncation and clamping to
MAX_JIFFY_OFFSET. (INT_MAX ms ~= 24 days is more than enough)

Fixes: b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec with do_proc_vec")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 kernel/time/jiffies.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 70926b73905a..4737431fdb16 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -187,6 +187,9 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr,
 
 static int sysctl_u2k_ulong_conv_ms(const ulong *u_ptr, ulong *k_ptr)
 {
+	if (*u_ptr > INT_MAX)
+		return -EINVAL;
+
 	return proc_ulong_u2k_conv_uop(u_ptr, k_ptr, sysctl_msecs_to_jiffies);
 }
 
@@ -195,10 +198,10 @@ static int sysctl_k2u_ulong_conv_ms(ulong *u_ptr, const ulong *k_ptr)
 	return proc_ulong_k2u_conv_kop(u_ptr, k_ptr, sysctl_jiffies_to_msecs);
 }
 
-static int do_proc_ulong_conv_ms_jiffies(bool *negp, ulong *u_ptr, ulong *k_ptr,
-					 int dir, const struct ctl_table *tbl)
+static int do_proc_ulong_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr, ulong *k_ptr,
+						int dir, const struct ctl_table *tbl)
 {
-	return proc_ulong_conv(u_ptr, k_ptr, dir, tbl, false,
+	return proc_ulong_conv(u_ptr, k_ptr, dir, tbl, true,
 			       sysctl_u2k_ulong_conv_ms, sysctl_k2u_ulong_conv_ms);
 }
 
@@ -229,8 +232,8 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr,
 	return -ENOSYS;
 }
 
-static int do_proc_ulong_conv_ms_jiffies(bool *negp, ulong *u_ptr, ulong *k_ptr,
-					 int dir, const struct ctl_table *tbl)
+static int do_proc_ulong_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr, ulong *k_ptr,
+						int dir, const struct ctl_table *tbl)
 {
 	return -ENOSYS;
 }
@@ -333,7 +336,7 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ctl_table *table, int dir,
 				      void *buffer, size_t *lenp, loff_t *ppos)
 {
 	return proc_doulongvec_conv(table, dir, buffer, lenp, ppos,
-				    do_proc_ulong_conv_ms_jiffies);
+				    do_proc_ulong_conv_ms_jiffies_minmax);
 }
 EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);
 
-- 
2.55.0.1003.g10538fe699-goog

