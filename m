Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605197;
	b=guNmbd0UjnJYvyxUjXP7JklJgiQEGTAu50AXBu6TAq7nvJJm85cYzRoTMx3Sa68k8d23
	 RCjVPMOhYrhTYh8u8xGdlGe8afukYobHLAtfmzDsuNzPGvngoMrd/xGgNs8C+MlPhFsKc
	 dM0/Z7M9z3z90+dxvxV5anSutTBCAxe+AHMp3fDCP7JZ7h/37rI2h6JUXwqQToPsfe7e7
	 7Dzt0l9AxxXjy8iK+hD7xN2ZdumXdklTpOvsO4lBktndXpIYDddGTkQA2ZGm/GPbPIRXn
	 aPJajWluZOVDXlwVF3SCJv/2UKvRhJY3jc8vQU1TXXWxD7ayATYZCUQa5QSpXZyLhsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Nkow2WxsbwgbBb3PRtxAKEX5ZOJS6u8PKRX/NW/T3IU=;
	b=pzMB510r5qwnxI2Zg5cZxykbpx3i+ZRfht+5x2EbVKouxBTmvhh6QAdskDGTrcOXvggz
	 cOSngDFZXbWxjFKW/kMrr/jlqfLvTHjcyrqSjwcRuEnTY1FNeUqJntlj7i/GxNbQMOH6B
	 654jOrlGkJG1quoyMeouLvRLRTb698S+HIgGsd7TYCThFk54MKQwlwJzpBeFSj1BBukj9
	 2iJIOFmlaQgz53LxEXjIwkXIYUmH+eUibHQZ5G71gXSfWEqFFsupGZHA6SUec5BXRXgMQ
	 5ZLEp2DeZitzf7B978iGbCchcNJME650lramADX+32kfWwi91NKBfPUd53ogPYaxhIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=apSsoOej;
	arc=none smtp.remote-ip=74.125.230.198
Received: from mail-qk2-f6.google.com (mail-qk2-f6.google.com [74.125.230.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A5606A326
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 17:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 744A5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=apSsoOej
Received: by mail-qk2-f6.google.com with SMTP id af79cd13be357-93c56ac78c5so10913285a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792605196; x=1793209996; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nkow2WxsbwgbBb3PRtxAKEX5ZOJS6u8PKRX/NW/T3IU=;
        b=apSsoOejDjjcH5diiC2gbH+Z8kNd1Jauv+MSmpI4UZrUS2NjxhosEOAmgFyWIw1tK8
         +lL2IKClK1IoBMMMjvQOFgoS9EqawBsXTPPTrExACDcEohGG3kebty5hpHgtEy/euVMa
         ZjC8gDd7PKQ6LXTst2U3wP5xFcno9P7NShD2VCFtkqEyRd1hAKPc4wMSaxHZxtKp83hd
         VZB788xsnGmHWOiEL/+bcOQ6dosna5Kvss+/yLjjUhJ0hk3NHjLSeoY85aYgLzKodOq5
         UcOWYNdhwLapdAd44EFDaiinnPBQj/bJumTz5tnw8VcciX/ErEHPF76cIUw9e0N+DVky
         nUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605196; x=1793209996;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nkow2WxsbwgbBb3PRtxAKEX5ZOJS6u8PKRX/NW/T3IU=;
        b=Du1iXxD6uD0si69f1gaw1N8rI82wdoSvCfkePpc24wR17bZV2hQvj2u8F6/tigcOTn
         wij7YmMNrpIdhS/FcLQoYL49LosLxGM8jkqXaeoT0c3mcCNccz4pAcbYjH/JkLQVr+FL
         pMtlU/A7fLApbKMWnrYklA+JbnRf/umqk99BFMSQ0g0miJWqcKYCjRs07b5nlo9M46o9
         HxPuiax+twr7jTLjW888SgCtguTTb1LxYDmWFZLxo8jglTZlLiMJZJUdpq/eMwuItPK8
         n4b2I3/8MPAVWV49OUVetMM+k6TcWj7c6NxNt5VZ+mE/hbETFWZy09dWHoKAfJ5B8QFo
         h2RQ==
X-Gm-Message-State: AFq9FYJNH9LOQWUiPC5K3wNfgvAhNrXx0ch3QvL8g72pbXFdd1n4QTZB
	1xhkwTWnOn/EEE6kTEZXLFuVQbL51i4viOiiiejOVTT5g2W32OB5GwsMARyDKfoM
X-Gm-Gg: AYBFou1orhBE3vYEdIBCH0FhmQTXulwDqqo1IIPuVvn4zjCy/oIejL1BXTe7MlNwtc/
	2sMwXA2UQRbGCE5o4Nep5DOesXTtgN52MzEbmRmmOEb9VR4mPv8Ze3JE8BSqE0lpHQBCebzNLI/
	T2RHowof7RBYCLZDffk8sIFreDhdty6wSDsdxvd3ZGUhiHdntamQ5I7/TR6691KF1VuspxKWUEs
	vZfhzlJmmfKonbtrAghmK/rj2k085q9/izRXufLfdv5VLclDqGG3+hAyhatdOR2KWE/AkQkIB3e
	tqDOXPElQDsfmVKnpi316d8RnqOEOq9c1mnTVMWHLXirH2BjczqQI+g6gJVgShj2nNBtd1QFI5m
	oXuy5z7HCo/OFmFpvepSdphaWqq8+RTAUw6L3LeK4f39LAz5dQpxey4ntUxWHVfAfn3VFkLzC4/
	hrnud3unpjjB9earyRTFp/f77AC1DmszYyNTJaSokvZi77mEtRr0oAlnmvLyic2+jKSqoPjNGXl
	fMB0x0lQViO6L7y4liAbhiHjntvYlk+9mVcWGvD9qSbsBw/7NjYUx7EAjU6qNbE
X-Received: by 2002:a05:620a:2b92:b0:93e:7156:f814 with SMTP id af79cd13be357-93f624d257cmr17959385a.11.1792605196271;
        Wed, 21 Oct 2026 10:53:16 -0700 (PDT)
Received: from Fujo.localdomain ([142.188.41.221])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56d9af50sm305675385a.8.2026.10.21.10.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:53:15 -0700 (PDT)
From: fujo <hooyan2024@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org, shaos <shawnq1@163.com>
Subject:
 [PATCH 1/2] fs: statmount: don't copy strings past the caller's buffer
Date: Wed, 21 Oct 2026 13:51:51 -0400
Message-ID: <179260511193.411.4517720543579678364@gmail.com>
In-Reply-To: <179260511193.411.2849255769062027805@gmail.com>
References: <179260511193.411.2849255769062027805@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

statmount(2) collects all strings in a kernel buffer and copies them to
the user buffer after struct statmount.  copy_statmount_to_user() copies
seq->count bytes at buf + sizeof(struct statmount), but only
statmount_string() checks whether they fit: it returns early when the
producer emitted nothing, before the size check.

If no producer emits anything -- for example STATMOUNT_MNT_UIDMAP on a
mount that is not idmapped -- the reserved empty string is the only
thing left in seq->buf.  statmount(2) then copies that single NUL at
offset 512 even when the caller passed a smaller bufsize, and returns
success with size = 101 for bufsize = 100.  The write is beyond the
buffer the caller declared; if the following page is unmapped the
syscall fails with EFAULT instead.  The same request with a producer
that does emit data correctly returns EOVERFLOW.

Validate that the string area fits into s->bufsize before copying it
and return EOVERFLOW otherwise.

Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/all/20261020110747.959829-1-shawnq1@163.com/
Signed-off-by: fujo <hooyan2024@gmail.com>
---
 fs/namespace.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c30f06374..c8aceeff6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5831,8 +5831,18 @@ static int copy_statmount_to_user(struct kstatmount *s)
 	char __user *str = ((char __user *)s->buf) + sizeof(*sm);
 	size_t copysize = min_t(size_t, s->bufsize, sizeof(*sm));
 
-	if (seq->count && copy_to_user(str, seq->buf, seq->count))
-		return -EFAULT;
+	if (seq->count) {
+		/*
+		 * The string area starts after the struct and must fit into the
+		 * caller-provided buffer.  A request that emitted no strings
+		 * still leaves the reserved empty string in seq->buf.
+		 */
+		if (s->bufsize < sizeof(*sm) ||
+		    seq->count > s->bufsize - sizeof(*sm))
+			return -EOVERFLOW;
+		if (copy_to_user(str, seq->buf, seq->count))
+			return -EFAULT;
+	}
 
 	/* Return the number of bytes copied to the buffer */
 	sm->size = copysize + seq->count;
-- 
2.53.0

