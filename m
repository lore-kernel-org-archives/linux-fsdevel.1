Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B072F2FD7DA
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Jan 2026 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818551; cv=none; b=UWCCVYPm9RIHuiFjQ0ldWMFREkgQWSWgLCtckcgxzCgg6yqa7YFjk5ZbEhngpsZJv7Qxb6SRzcsZe46Y6RdD3ytwW/0nWaG1UyG0AYzIxH2DmVNGEG5Ac/VSn1PwbAn1zXG/u2l0vJehQGwW4Ux1z8MSDjEm+2t1XUd6BQ2Wn6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818551; c=relaxed/simple;
	bh=Q8Y+tcP14cPGX6nVnrUC5A0/e39HqBX0TIbiYWHDZtg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qkCHaTZwqbWqU1GCQp7KljjTx5V3C5SpTuEc8mWtZJS0WJxsdsZKzcI5VHAX7OQlgJsmyMNv5a6A8yMwJMTYv+aPwetbGtw+2JkJfHL9n8FiRYEKqTEOTYvuvoBvUuUcB2I4T4K/PK2dRQT/4+LlJ1aag6bcYEOGavk+pnEayWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZZJQ9dA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZZJQ9dA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a773db3803so30287165ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 16:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769818549; x=1770423349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0zRl8ckmsYXJA9hzzqbqYRhq63sxmBlwiujRl/vITs=;
        b=UZZJQ9dAcXGoeuD3dwu0ovCYyTSWwDUwtrQi73gWo6F3V2lZ3zk81gs7T8lqgAufUJ
         DJOcopcFstdAQbHwbuSaWZgbHKKp00qYnqGvPHo+5hAYoJqKx8iw2bHveUKpwCfT+mL9
         uVbHtM1L+5Ud4g3MeG0Q2xXyZa6f8S8t1TUk0WDjromp1FoICIlVU7YhyZRUbyBBMYS0
         sa//lEeajyX/XQC7O3MLbc+vG9paCRR68cuvmwKMTtAKq8Nf5LOKNAg+TSwKeMz8Ehwl
         nU7GCKu2YVVykvUMV6oZ46l9d4fQ8x2TmNrGV/X5CXHFlFJJk/ghZUgcigdhcZcRcz6T
         QdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818549; x=1770423349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0zRl8ckmsYXJA9hzzqbqYRhq63sxmBlwiujRl/vITs=;
        b=g614v5zPvje/h9/kayH6nsotqvm62EDwZlKqPqkcwaJg1YQZX6eKHLsPVvo6Hic0CV
         XrBziHqTLRHpXgHS+7l7+Z/nazxUIyQCk8gWCiecmy88iJhaxhqzHIApjPmDFPHt5UbK
         V2GFXbnPa/elJfTDJ8V8u49KSmixom0Xoxhq0eeTEaWC3RMcLPhv3umxZV6V9HkJxocd
         Gdwrn5cKG1p8aN80IDtrqkoTFzyQtYGd34QlC3BDQNmYKNfH2OOEAdLp8JE7GKQZ56xi
         WdaiomLC1OmauH2v1xFHTomYhq3j+Vo7lvHeOiHrjzcnZRahGhctvyJpgj79Hpt2n6Bx
         xxrw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Uhfhof6BosxP2DncVFRxSqcbW2xUPkzJB7gmTYLwy2J625HAu3Dkg0egcElHXy3qH/l9NBm8vMq9v2uo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1ISDbGmQs+mkWVKOAofEvMVydCtdxQxen3g/k3H6DJOfwUaU
	Fzcze5El5YY6+r+tkmOjkBjrzorYTucObek1w4CI6rYqd0s1u3qkzUiFI3hLerHwkwF6NLyOFgh
	QPJ0ruW5OGKsqySdeDSz4oFdtwg==
X-Received: from plsm24.prod.google.com ([2002:a17:902:bb98:b0:2a0:974c:2e6e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2442:b0:267:a95d:7164 with SMTP id d9443c01a7336-2a8d9a7e152mr44013535ad.60.1769818548948;
 Fri, 30 Jan 2026 16:15:48 -0800 (PST)
Date: Fri, 30 Jan 2026 16:15:38 -0800
In-Reply-To: <cover.1769818406.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1769818406.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <bed4d2436a0660cc406ef7f331e7ed5b7cce9896.1769818406.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 2/2] XArray tests: Verify xa_erase behavior in check_split
From: Ackerley Tng <ackerleytng@google.com>
To: willy@infradead.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Cc: david@redhat.com, michael.roth@amd.com, dev.jain@arm.com, 
	vannapurve@google.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Both __xa_store() and xa_erase() use xas_store() under the hood, but when
the entry being stored is NULL (as in the case of xa_erase()),
xas->xa_sibs (and max) is only checked if the next entry is not a sibling,
hence allowing xas_store() to keep iterating, hence updating
node->nr_values correctly.

Add xa_erase() to check_split tests that verify functionality, with the
added intent to illustrate the usage differences between __xa_store(),
xas_store() and xa_erase() with regard to multi-index XArrays.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 lib/test_xarray.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index e71e8ff76900..bb9471a3df65 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -1874,6 +1874,10 @@ static void check_split_1(struct xarray *xa, unsigned long index,
 	rcu_read_unlock();
 	XA_BUG_ON(xa, found != 1 << (order - new_order));
 
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		xa_erase(xa, index + i);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
 	xa_destroy(xa);
 }
 
@@ -1926,6 +1930,10 @@ static void check_split_2(struct xarray *xa, unsigned long index,
 	}
 	rcu_read_unlock();
 	XA_BUG_ON(xa, found != 1 << (order - new_order));
+
+	for (i = 0; i < (1 << order); i += (1 << new_order))
+		xa_erase(xa, index + i);
+	XA_BUG_ON(xa, !xa_empty(xa));
 out:
 	xas_destroy(&xas);
 	xa_destroy(xa);
-- 
2.53.0.rc1.225.gd81095ad13-goog

