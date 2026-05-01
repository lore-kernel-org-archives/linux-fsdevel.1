Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8D1CDFCA
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598378; cv=none; b=oigrzctZS9PtZGlU/ddCFEulaaI3RSnMVG0v0d14VZ01zfgSkoaekrhMk4B8kFYMWaQUpAaScbvKe8NNybQYqRDfLb/S0X6fX4NVTQjU6x67xP2Njq73E2vAP9P0FToezBl+7oiyisw3kUWP1saH0UwDaSsl3w8wM86BNjE+gzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598378; c=relaxed/simple;
	bh=IjjQsgkkjACz5DQCM/CJUHDbtQvVrxf2QYzMnKJCAjM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=i53xLSHEGmCgwvglyrKXClkstz7TubUykUlvzcGAOByg1zMfkp6XZ/3loVYjld73YqFd/8nppjqFQ22nwX77P/iljL5ku9w8mkolrqhiX3lfwK5gNgV980u18xOXtllmWBxIEb8ANLMdefcZpKItEzDGKr3jDg/YrIi2Pp4J7vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjOSum3l; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjOSum3l"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12df0af4cdaso3399504c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 18:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777598376; x=1778203176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxBa4eZL8AzEIKHbrJYGdhnLoHOErJvUxGit6YEswu4=;
        b=wjOSum3lhDVz8Xnw8EKk6tiYod1lUt7KBs+mSeO2sX+6ysYBBVCL8+wfM7K+abpVZV
         a31dFXVCJrACsu1qupv+gXRNQPm58jq7NEj8qBPQ5FXAuKssAFt+Ker68XpzNzGewq4/
         0lEfIcwNPa1hQ/+FkgOOjYcTJTGaZvOLABPc8taIWkkDharjG0NVRZfxsS03sQ+kesqK
         duHPJCOP31zdL175uymLBp8vwN7v6nUvVIyn/IgI8MxxwGOxOiytokANpTcZoB91HHTa
         WTSPKQknVqbF0EPm/zJ9A7/amqztDY4/5Mt97yydxTYjFJNqxRWTpjKY8iclJZ5yCaJh
         WKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598376; x=1778203176;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxBa4eZL8AzEIKHbrJYGdhnLoHOErJvUxGit6YEswu4=;
        b=hTOR5csKKRoSuFPD8eavxb4N7Cv0n/1ZCKUesOQqkPaghETIMfqd6q9ohIZAZJwIo+
         gGmF0zbaN5FQHpm21H7AyYLJfXOLIXqHgNhkwXsq1eO17ms8L+qG5ls89394ww3xR7gH
         4fmdH+Dhbmd5ifdHdoTFPJuneqoQyT1fjt1U1018kmaeef2/WvorK4sGOsUjcK89ETsY
         rV4DmYzzqOiHmmonBio0aAzvyqSePUrmZRPSlCuHthw5jmyJDjHy4vK3wcAhI1+bwDEr
         SGbfbJev/HOExMktC/Sdu4qrs2ZokTTZMYs1CniTXpoz8hOl6b1DwzXOXAFt2eCVGI4M
         r6jA==
X-Forwarded-Encrypted: i=1; AFNElJ9C14LbRwH2TAuJgTtU7Ylyh6+LKxjDmo57Q0UdL24/KmoyFmc5W9dcCzAJwsMNvO8cFoO+Numz4XPoWuOM@vger.kernel.org
X-Gm-Message-State: AOJu0YwbvOuK8u1zicZSbZGqaAIlECeJ8kfrLfTv97JfYq+GGywujNl3
	NJIsXhnN+slOTpx0ROg0zmjpYCkFZgvuO4zhp4dpxwaT9vniDruAhN1sCCleaEiHIObHQTgVeHL
	cm8qnhA==
X-Received: from dlbqs4.prod.google.com ([2002:a05:7023:d04:b0:12c:8bfc:84e3])
 (user=fmayle job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2510:b0:11b:f056:a19b
 with SMTP id a92af1059eb24-12deac72761mr3014031c88.18.1777598376170; Thu, 30
 Apr 2026 18:19:36 -0700 (PDT)
Date: Thu, 30 Apr 2026 18:19:07 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501011908.3630802-1-fmayle@google.com>
Subject: [PATCH 1/1] mm/readahead: simplify page_cache_ra_unbounded loop
 counter reset
From: Frederick Mayle <fmayle@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: android-mm@google.com, kernel-team@android.com, 
	Frederick Mayle <fmayle@google.com>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Minor cleanup, no behavior change intended.

`read_pages` ensures that `ractl->_nr_pages` is zero before it returns,
so the `ractl->_nr_pages` term in these expressions contributes nothing.
This seems to have been true since the statements were introduced in
commit f615bd5c4725f ("mm/readahead: Handle ractl nr_pages being
modified").

The new expression has an intuitive explanation. When filesystems
perform readahead, they increment `ractl->_index` by the number of pages
processed, so, after `read_pages` returns, `ractl->_index` points to the
first page after those already processed. `index` points to the first
page considered in the loop. So, `ractl->_index - index` is the number
of pages processed by the loop so far.

Signed-off-by: Frederick Mayle <fmayle@google.com>
---
 mm/readahead.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 7b05082c89ea..b44f13ce5935 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -270,7 +270,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 */
 			read_pages(ractl);
 			ractl->_index += min_nrpages;
-			i = ractl->_index + ractl->_nr_pages - index;
+			i = ractl->_index - index;
 			continue;
 		}
 
@@ -286,7 +286,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 				break;
 			read_pages(ractl);
 			ractl->_index += min_nrpages;
-			i = ractl->_index + ractl->_nr_pages - index;
+			i = ractl->_index - index;
 			continue;
 		}
 		if (i == mark)

base-commit: 88ca94c8849696985b1b70ebec4b01c4b58cafdd
-- 
2.54.0.545.g6539524ca2-goog

