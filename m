Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B081E98EF
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Sep 2026 23:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788651507; cv=none; b=OGppH4ybNkfq5hp0aVcpvgpf3q8pRV9cA7wQsEZW4frDQ3GU7Og6ZTVf/DnUyt9tB/qkJHLxGOQzBJ8WX7i02EkA4yzQ7D57j+woqR0kAG4dBxi/HyfnkcCMcR/BqXhmcj6r1edANukw7BAsWybdsYPHQ0IhWSTJmDZ/0zpx/ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788651507; c=relaxed/simple;
	bh=pxEFJ0SzeajJ4oXnf7+xiiJKR2kUJMldh08pATwL2Pg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=op5YiPSKvZK7PVMU/3YRe153pQRe00e7vl1K4Bv5WwxyPHcb9GfFe7m/UfiUqBPGgOgLtXpxHmsnlsnqruKRAD7D2h/ixvGQZiyjP6V73ekgSWiW5bH28tFwUPrjg1u95qB9nEu1NdA8hhkL1ZmkyCwJ6r2Cgv5amW+8lKAaQG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSxOdu7A; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSxOdu7A"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso3951529a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Sep 2026 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788651505; x=1789256305; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkvHpDl5ZMFwWYlxckJTNL0qsEuk+B17N0SjI8tRm60=;
        b=bSxOdu7AKuS+OY/0xNLKxby16mKevpjoVo4gBpjWVhiZk69VzY1eXQQkkYjCj7Uuqx
         1whnbcDsXseROD30jGVnnyL3cirZt4+6JiOuergs7m1e7RQdKlFlnOSzuq6Sa+ObeVgW
         Rp3kYnewByl63ZTsjweKQWu1/RQWbafuCKLoxYzuwysU/KuUz4AJtUa41B+P4D0kx9oN
         WPVOUp3lCrkv5zxxs5fOrtw7upagMokorE8q7HuDEhNuAo5oBZYEsL14aXUsm3EC1Gzf
         XyEANC4A7zuwg0xxFq6F1krj1gv1rLEkxChjF10LA31EyfVkbzQC3rTHixC+kHhqveiz
         KFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788651505; x=1789256305;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkvHpDl5ZMFwWYlxckJTNL0qsEuk+B17N0SjI8tRm60=;
        b=VqQ4ONALcryE8WeX6Ndqq/nXvVRz0uI/XjLUFVlRfwTDJrwcahnWoeeH+MHmzWIyII
         Tzv1KXFZXybE8SpLcDXFbYSv8dYeYwBJoquxtGrfttTT8Xt2VdsGdCXo6lXBZWqnEtlu
         aKMUGLPaPErgpW0Z3hDIuqC6Al5Y4lj++aYnTnMlXgQr5urgGlhU+7cxVdH4bpbhwyQR
         eqUJppqc9Bn4RM+ascIUFRHv15j0P4lCWdfbDtxCZA0bACc7JII3xu/QA+7Ae5xMXdOV
         BnBFSFk/7qz8wqI/2MV9D8+rLRVyj5v09o7cJ7yITxXVB+5ilcvnE971PMTETwMe3/l1
         hYsw==
X-Forwarded-Encrypted: i=1; AKwUvBxMkrKxQb+0Mflsg5LTpQME5otZkx2HclRoUN5nkjzI3nSGbYCKQWlERMjqrv1SunIg4i6iMdGziABox0kn@vger.kernel.org
X-Gm-Message-State: AFuF++kXaKrA/AOWxKTHVsMwJecloXzJqYlkGWUdFtWYLgt2/k1wAL28
	ZAG8wQ23XS5eEuZuyOLfKd3+3wazWzQFPofrjsF6QaanRR63j1akKV7kM5LFVIYmJH3nFO5N1h9
	puo4K2Q==
X-Received: from pjbmj19.prod.google.com ([2002:a17:90b:3693:b0:39b:3cf0:cd0f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5844:b0:398:e436:370
 with SMTP id 98e67ed59e1d1-39b260ff0e9mr23955312a91.2.1788651505211; Sat, 05
 Sep 2026 16:38:25 -0700 (PDT)
Date: Sat,  5 Sep 2026 23:36:29 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260905233819.1064529-1-kuniyu@google.com>
Subject: [PATCH 0/2] sysctl: Restore minmax check for proc_do{int,ulong}vec_ms_jiffies_minmax().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The recent refactoring accidentally removed the minmax
check from proc_dointvec_ms_jiffies_minmax() and
proc_doulongvec_ms_jiffies_minmax().

The series restores the validation, and patch 2 adds
the INT_MAX limit for proc_doulongvec_ms_jiffies_minmax()
to avoid silent truncation.


Kuniyuki Iwashima (2):
  sysctl: Make proc_dointvec_ms_jiffies_minmax() enforce minmax again.
  sysctl: Make proc_doulongvec_ms_jiffies_minmax() enforce minmax again.

 kernel/time/jiffies.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

-- 
2.55.0.1003.g10538fe699-goog

