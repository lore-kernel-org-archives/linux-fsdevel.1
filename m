Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E438839D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334899; cv=none; b=QxwA5KvA/OnABZW8Oia1G/wLs8WNsZWw80btEhaXCjvDKmCPVdxpLe/tOhNcqf58nnzeG3kQukfp5eh2EHC/1ZKvWjmlA7E79TSSIWbB1MGK6Q6y0IuI2TVMi7xJG2RJ3Gux/lkkrbWosqKVgaB4ynmfHPCBP6ZbJkO3TfbhfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334899; c=relaxed/simple;
	bh=5yYxKmqJEJDXBOmZi9+ExZf0XmeW6PGf9vMlGL3Ygxg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fgZkziBf5xOxXl2Qx/kKRhGBcvq4T/hcqPdDqSyxMYLnjQA2cp5RN/cqPD7RpaKcrk5GfeM38jqXhahO9HVXZ7iNAE2rXN06dWU0LaZxIGa0DozCQpPMsiIARns6Pv0yg5JWayTBWLPlRj3FWfLXH19pX37cMcM/WzudyrCrDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVpbCsKd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVpbCsKd"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59dea72099eso1298922e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 10:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773334896; x=1773939696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FPLZLK/ARK3Chp/HwAUNJLe5P0+HW9eu31GldakyAM=;
        b=MVpbCsKdn/yjddtOzeLi009c/kEQNGekvcdtd7oD03DV19ZiHFqO+kojRCn5AH6mfz
         TI8l1oYvQuCVuxo5V1KGSMazxw9QkQiTClHzldnllgP+8c2091G0Nn6BGlWMBNtGcKdR
         Zh+8uuRB3v5FQNXI+3lp9xwvW4pZ1tjaxIW1+ABYBxoKi30tvcMpF+FRKFak2VKmV6Ea
         atYVANCIu20BY+LnyM11X0JmcbrZ9/DW/vEnHuQLi+EQBzicuC22dHxTaVfFYHnmLvdQ
         EYcV+hgEarBl3eflkIO2mF2kJZ+0LpkQVUk3BqjdlPnHrPlLBmwFisBneHlQKZhgDJSq
         qtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773334896; x=1773939696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FPLZLK/ARK3Chp/HwAUNJLe5P0+HW9eu31GldakyAM=;
        b=jdm9a3GPxFDJhvW7D9/sCZt2rg5lmBVw7q8VE92BLBhIvRahxFK1KKzWbbj3lNFjD1
         J0xTUoaAvw+OzYBLfp0h9SpjjK2X1onbeDkCWqrYITk5ZVN3YagrkAQpMvTiJCPhEszB
         9wKcGKOHawnlX6DaQh9/+SHsXp300HSDsFesvZ6G+RLi5EWd2XneFF3jMexWj3mUmJEA
         2NBnAT+QacyTBp37Gn/6GCB4OQmOyXOKFQzX0jYq3CB1Qr4Ol1bZAWH19xGD4L+aT+le
         cWHh8wiZVWEIUGDLN+xKmpwuBtSF3BXR2d5pCVZ1ZuyvquF03ZNpwwQhyMZR8zzvNkX2
         q0uA==
X-Gm-Message-State: AOJu0YzFyd6eLBckmKpRzcQ1U/9xjX6bFD4CYkfWuPVjr6c6NiQkDKww
	Qeg552lmUsXBT3Oehc3IxgULH7tI6pjW0ahiRLfP8ohVJN2YTSAh9v8G
X-Gm-Gg: ATEYQzy0UmOCnniw987qM/D0vVqgXT18d8ZjOgK5Zcie5GPSOl7mZCdYvaex/xiDeHG
	iLPea2m1B+MJNEVbmUfmrVyfo+0inU/2iibaGEaNcIadCPXzELShbjOJxinh5JuTtTaobyLxO8p
	W+PVwqzP3uDLus7bj+1m4Q6/X59Hm2m+mgSUf9NQDU4/ZmgGOMjTC+RZAlghZyeM6lwrNEdyGzk
	zFghwsqCBvTOYMfnz8BJ2QKluwTwCbw7puSjK1nSyDKQa2MVr5zWzgSgNPN/Z4MMoGietPQMKqU
	NI+wJRgfaH3n5dURfidUZg7X7t+5w/AZuPKyGYZpVNKo0Qp7lDj1C/jHb1q4ED4bTzG+kylrORC
	V4ucG0EPsyH8SRRdgF83AAW5UBU36LL6I6r+BZ8kY8LbGPUx3yVut2d8oyo7MjIbLT0YfjPNWvZ
	qoerokdHw4KqgBh/X2NYivedhwU4PKKaLYfNkxiKQwG/bmT2p3MLdngv7lCHiWIEUxXBUjlxU=
X-Received: by 2002:ac2:592b:0:b0:5a1:26f7:85f5 with SMTP id 2adb3069b0e04-5a16270f30fmr65268e87.15.1773334894619;
        Thu, 12 Mar 2026 10:01:34 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ecedsm9710711fa.21.2026.03.12.10.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:01:34 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <hlcj1234567@gmail.com>,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] lib/idr: fix infinite loop in idr_get_next()
Date: Thu, 12 Mar 2026 17:01:33 +0000
Message-Id: <20260312170133.6488-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josh Law <hlcj1234567@gmail.com>

From: Josh Law <objecting@objecting.org>

In idr_get_next(), if the returned id from idr_get_next_ul() is greater
than INT_MAX, the function issues a warning and returns NULL without
updating the *nextid pointer. This causes a soft lockup for any caller
iterating over an IDR (e.g. via idr_for_each_entry) because they will
receive NULL, fail to advance their index, and repeatedly query the same
state forever.

Fix this by setting *nextid to INT_MAX when the bounds check fails,
ensuring the caller's iteration will terminate.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/idr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/idr.c b/lib/idr.c
index f25bd2b9e9a4..07098eb4ddc3 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -268,8 +268,10 @@ void *idr_get_next(struct idr *idr, int *nextid)
 	unsigned long id = *nextid;
 	void *entry = idr_get_next_ul(idr, &id);
 
-	if (WARN_ON_ONCE(id > INT_MAX))
+	if (WARN_ON_ONCE(id > INT_MAX)) {
+		*nextid = INT_MAX;
 		return NULL;
+	}
 	*nextid = id;
 	return entry;
 }
-- 
2.34.1

