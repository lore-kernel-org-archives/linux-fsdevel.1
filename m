Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176063EC836
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523913; cv=none; b=TxV4qzTFV0+vsE2xAMnsEVKw2IpW5yIeNlhe2fljYi07PkqZ7UGACH3KpDta4JCnl3W2yHRXCwpDg7ZDPTREV8PCFnLW53gYjNaG3+0i7h6a7Zj/qtda9frbI3lBvXfj2zo/sjEtVKnjqUU6OBpMkefHcrDqIJ1QQP6Yty0iOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523913; c=relaxed/simple;
	bh=Grw9uqZlXGgzby8RCh8JScm64L8gk59CwDh+Ww28rQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DoIfLT3QYNO1jcMaj1kdp49crX446APf3YyXreavu91HOgO9s/f49KitHMvvUPM+FhmpWuVay+7kKo7fVAlvGx9XFFMu4cj+iASZRclLKavN1FOxn5QJ4ITMFi2zapJ9q9h4RnrvX3Ky2tW9Op9ezUzpslxDl6Z5uSDjRIipdz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1lEvEZe; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1lEvEZe"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398a4dcf289so1078869a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788523911; x=1789128711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BlOje1kzCqhXo3NcDvPWOXV90zYWAyengT9V/NQtF+k=;
        b=p1lEvEZesuTFCA8PzeUScPFP2F1gU6n4kGDXK3h0xy/tZULuxXghvc/FPh+XEx6smN
         r5dDWSk9iP6AhqybRKv8x6PobpM8QmCoeBxiL0MyAua2GMQT9x3XB8shgZaljyNNUAxb
         jsloDN302qBq6SLAUBm4h9kF3JLsOvQ6nDScDYTXJ2gkIQBMtfu60xMU17HAHoTpEBU+
         yZC6HIM5WzfFG+wRVw9kYNbmdIWlFjhOg7jNCKDmjRVxVQq4lyrrou5ICAqOU0SF7kli
         EJwTyOqmUBLq63AKg4vo+/2AZxG6kO5QICEN6/aNedVs9VahfWuDaSNkHKDWNSHmKtcL
         zBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788523911; x=1789128711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BlOje1kzCqhXo3NcDvPWOXV90zYWAyengT9V/NQtF+k=;
        b=TVHdFTor2uL0hB4KF366uCLwca03KZx0g+SZKKY9NME2YyIVo070W/yUM0XMaiJpvD
         ErE0o0lJcxSA4Z+fcT2FH0IHwgxIR0tTMx4kkQztik48TwxKXHN9iuVM1wXbhT9bE+VB
         IiUEzwg7hvE5t9gn1SGltnRpfmTwmcoUtusR+UaUagqnhvFnvVSPZz0ppfGgs9XP3dfI
         g8RXduyZkzMSLyRklWL/DR8CrhwFUoYLMpnjCkWRcnB4y9SWU0VA98/Jtxf9ue8+bcVQ
         +w/n94sMqNmg6IlwS8XUlpoHwBwe7SByUIXBXgNj3e3qBARJLPCXXH5gDtIDtxhxYNkW
         UyFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhLhfDkcsHcv/OhdMVzzpTkuHAQaU7zJAK+cbh2nQJlONyCBA2lZcYECYayMtfgLDNR8mhulPW7zt3yyli@vger.kernel.org
X-Gm-Message-State: AFuF++n1cDFi8z4GfF4mOOtePAxKkOv/u5pwwo6wvpXSxOxTzh9PWR4I
	SrMZYHpGxaOWlA1QQrodAQSb5WNdrB06CREVyKwA4ZsHG6MALUrVN9oE
X-Gm-Gg: AYBFou1HlADOfMPrKPP0kmBvOKnKuVBP2BW6JZ4uZxLzCRthmm5DyJVwLRLZWkPMWrA
	NWhHmhrAzbUFAfq9zdz0sW3/JfXDSZfSZzYyMRDVr0tHTQzMu6xmEiVYK3dlG0tQiz4RdrLmWYy
	NgyWE4qAjBN/qnwUF5xmmiPfNWqG81oMbB+8wM5LDOnxCVM5Kftp6vGirLnZhYvK+6oWYx2tWP2
	9pgmRGJ8yhYdcg73XNphUKgnL9Qs1Hzou99JLnrucJW9bHrUNMxqSasIGVYk8/x4edYNVXAQW5r
	izzvWk83pAW99zm3QQoyNDmFavLNLTCC+sPWSdk84Y0rh4X/KWANc2OKaGm0/2GFLdnit/zOoAi
	myOeyquipGEw8zhQ7EvHAZY1KOU5vwZl4GwrbMqKSfpPbGsP/R4jHJ9zDpvYdVJZFzmb2o/MNVX
	1+gi4gVfXnn2RKwRwIKBs508GQNb+QZX8kYwN8IzaMOkVi8zHI9ZCPtuRUkwFqUlT7mii+vq+ne
	2kpC7iVi8CsWfo=
X-Received: by 2002:a17:90b:3a50:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39b26101576mr9886088a91.11.1788523911388;
        Fri, 04 Sep 2026 05:11:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm2885111eec.4.2026.09.04.05.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:11:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fsnotify: fix typo "anonynous" in comment
Date: Fri,  4 Sep 2026 17:41:45 +0530
Message-ID: <20260904121146.22419-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "anonynous" to "anonymous", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a32c6634d592..63c9759fc3b0 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1837,7 +1837,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	/*
 	 * mount and sb marks are not allowed on kernel internal pseudo fs,
 	 * like pipe_mnt, because that would subscribe to events on all the
-	 * anonynous pipes in the system.
+	 * anonymous pipes in the system.
 	 *
 	 * SB_NOUSER covers all of the internal pseudo fs whose objects are not
 	 * exposed to user's mount namespace, but there are other SB_KERNMOUNT
-- 
2.48.1

