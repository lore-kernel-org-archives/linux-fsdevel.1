Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01723C455F
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617955; cv=none; b=On4BydEDHon0eo1by94zYuBVfdb8doHr241NWUjSsIIZ33D2GX1FGTMoGaXw1KG/x3MILoTG694XbmPPiWKd6MUlpsups3kXrNNPWSNuHiBEYkrNU4Y7yX98C/dM7U5QDJSZdfkoTh/oY4Uy1ylMwyPQgS3SmyoZF6QMbmS0T74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617955; c=relaxed/simple;
	bh=+8jlEft9WNgvjqTEBfN6erytdcvw5sxxN4Zw4GFtOJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=dn9fJO47NbH/oLa3Dw7koeby1uZah3kL+souau5mvGQNo5uKtZUgOVOVI6q0FEYPcyAs2LaM7LiIfjNKTt+atKFfvYdkeOQ5tpCX0LKryEs1bglYFxMFcVlmbx1sJgv8I03+BGnOoR+bepN5LQY4GTggjN0gIlyathCkLoMEXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ilBtKnwb; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--fmayle.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilBtKnwb"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso7607820b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778617953; x=1779222753; darn=vger.kernel.org;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6bLlWzsZHxTKwI8h2tfKnH8AsKS+KM39iZ5XG/RwLQ=;
        b=ilBtKnwbb70SE2XSDWEkVSFrLqlAbZb3i++/7g9LaboTX5vj11ODtjuTSMbtVfZ2yI
         c4t/vrPLLfdaOj79qGZTCTgU6J44NuaKC+ScUjYRA9SLH2Bx1Q2838p5tAfCUxgRHiYr
         dtgOPWhT8AMUIhuFNq4BiWUu1YG//0MXHoD7a6EAh34r+uSXuBElB4L42LggBEdcWitL
         8VU9hp3NS/EdYFqNHHjOOwny7xTqb/dByoBJS3umTPq5JzF4jsEwf8/FdRZ68583V3b9
         JfZ3kKCgEZF5C5SDwhI2dVWqh3cWnbBZF8779Emt6mEFXST6aXvMPrzO78clrcWFVz4H
         EkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778617953; x=1779222753;
        h=cc:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6bLlWzsZHxTKwI8h2tfKnH8AsKS+KM39iZ5XG/RwLQ=;
        b=AOONRNJIXmo9Z6WZRH/WOWZH1IqQWFF9I53Yi0cljGpH91n3oYeDwojiCbepre2SQk
         3FcZyF4+2mUV0mZMF6XtSk5vgkyvnHwWY3vrh/sAdvIpgqQ1XPYFUteOxSIwupIF2aoQ
         eKbmwe+XZBAfZFTMjeCXohBOfnEPpMyQOx7NhFrnCgCCxH89wEAwBRQHVT3PR5q5LH/y
         f2jIKXE9uDYAEGkS+2fSub3eulCCZIqB9/DFpjYh0Fyc0vLboeMuod3nrukLoivDfDAG
         Jb9fmnvqJbdvIPz1iBxwNu/15y1oVLcmthDW9hzNndScNN+l2EoReekc+0ieNKkbtEoo
         xmMA==
X-Forwarded-Encrypted: i=1; AFNElJ9AJMAgiK9F/qURM22m714JJiDR8HTREuxNeeHT/hit6H7HVB8H26tvqEbl/VBXRXk1GSQw0P/IEcjDfR6K@vger.kernel.org
X-Gm-Message-State: AOJu0YwxBx2nDyEKlN2AkOQ4CPNVgOez3ztN1UF/TiRhUVllyiwBdqQC
	wx7XFCUACfzR9zFrlNvyYXn1LdRmN7kez+7r61RkoyGQ7y0GXA7fObIxht8kDUHNuZnHNNt8arH
	v7mYVVQ==
X-Received: from pfbg7.prod.google.com ([2002:a05:6a00:ae07:b0:837:c09c:9cce])
 (user=fmayle job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:328c:b0:82f:2a78:6302
 with SMTP id d2e1a72fcca58-83f042789d4mr222577b3a.26.1778617952888; Tue, 12
 May 2026 13:32:32 -0700 (PDT)
Date: Tue, 12 May 2026 13:31:36 -0700
In-Reply-To: <20260512203154.754075-1-fmayle@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512203154.754075-1-fmayle@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512203154.754075-3-fmayle@google.com>
Subject: [PATCH 2/2] mm/readahead: simplify page_cache_ra_unbounded loop
 counter reset
From: Frederick Mayle <fmayle@google.com>
Cc: android-mm@google.com, kernel-team@android.com, 
	Frederick Mayle <fmayle@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
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
index 23bec5497308..42f2f20633b0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -281,7 +281,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 			 */
 			read_pages(ractl);
 			ractl->_index += min_nrpages;
-			i = ractl->_index + ractl->_nr_pages - index;
+			i = ractl->_index - index;
 			continue;
 		}
 
@@ -297,7 +297,7 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 				break;
 			read_pages(ractl);
 			ractl->_index += min_nrpages;
-			i = ractl->_index + ractl->_nr_pages - index;
+			i = ractl->_index - index;
 			continue;
 		}
 		if (i == mark)
-- 
2.54.0.563.g4f69b47b94-goog

