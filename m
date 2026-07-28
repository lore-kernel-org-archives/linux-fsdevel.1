Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22A3B2FCA
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216275; cv=none; b=HidiN2zIApjE34DXFmcF3qC4xUagVaOv6cJmeenYQYZcEPuJsA423beSZHFOe74UsdSLE6/RI8+MwjT4dRHFyy5w1XPB021tiKujqTx16uBs5ffx5iq1f29L1TCtwPvuR0BE7zePvr9CUNN0xu2oaaSPdut1qiuUBGCS+XzWP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216275; c=relaxed/simple;
	bh=0TCr9DTmYv1uI8WVYyHvYyk0lI0kGpXMf8BLGRUvttk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=VmZANs+AAk2wcROkAiJlgzXoHOG0IXuPUqM25aH4A2/OIFtXfud72+DeZ5gWNICuCl+LoPT9QfZNTIG6C3qi7lvFhBnFgEuTKZRwxKSfeWkbZJpwLQlg4SuWa4DTD3i8RVcCijvnsSKj5R5pvZq91bU/YxqeyDj0YRxceCSoXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jrr5R6Tv; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jrr5R6Tv"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66893db7bccso4557366d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 22:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785216269; x=1785821069; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+dP2n6X89PfagInpqwKnt0atKqO22OfQKc1DqTtxeCs=;
        b=Jrr5R6Tv+E8Dee+VWfh018cTPyOvLtBE7tRTh3KESitfrYHzQ8YFXRpE24FMgl99oh
         hHiFBu3NrOuRqVWzi3hzOE3nABaRrxZ2A0VbrJeRqG1RFo3FASp7RPWq7so3NOLgPyqD
         6nCqS/0fFHknGC/p/gVv45T5sGhCGlqFB6kqC/+gjv1OWV+Z2SNjRXOX6wraua4QCTlp
         0tpTXCBzZn9MS0yC3i61sqKBDDcrAEtfsYVCqjtNWJmxm1mXdEeAmnUyS0YmWY0IPrXp
         kilDKZyfaf2D+ZclIeIGEaetuJ/aXioPOyotqH0UEaA6Ybc7eiazp7SmD5dc587Kz9CJ
         Icig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785216269; x=1785821069;
        h=content-type:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+dP2n6X89PfagInpqwKnt0atKqO22OfQKc1DqTtxeCs=;
        b=mozymY6FyoBTEpJFPm6LcLLOSlZadLjHJqUOW/FlKTmlo/qgWqpkqwXaxwtJSC3de4
         WFb1cBQAi1YdECQhhrIXgwpX5eYxSp42JRwONfDkKGjNoVBtGgtGKoFYk211VnkK5+wp
         y6qJid414DjKUkEWKXb1VvwVXvVWvXAKThH323Z1ZjqutT4pPQNQlGwiPsd9Im7PVTf+
         xVuWF78VL6KJqf7nNOaPCzNSQmX1jqY1h8ffbejAS48rJhwU03wSxuIeV6JFDp5qUk+L
         jnOEBTUERX3yvn2OxHdJRG9JReLGhh/KrJ+IGmV4kBoiF5wR2D2fYesY7ccPD9OUnSKV
         kGTg==
X-Forwarded-Encrypted: i=1; AHgh+RoMEbF/NgDU5+w28j5nNBPUYIWWqBZFHNRMmOpvk0aJszyVqIk+wloPlnGLwpOnVRoEw++BA3Chc0iOc5Cj@vger.kernel.org
X-Gm-Message-State: AOJu0Yybhbh8Yw1zGulvk6qQ9CoSwF04rNUkMSJ1aBMiuUXCShOR53GI
	X8ko1IsQamtBmO3U+CakJnY14fRs+khes7l7GGnsEevuAtN8sxyiYn+hwU/DP3Co6Q==
X-Gm-Gg: AR+sD13yMVpzjK9BxDnPDJtgAeod3tnObBrvPDtnZJZUrPkmXBMNYflK21lNED8z7dB
	HeJ2QSaKdC+7RLjSkjlG4Zz/c3rzFzVYMRHWkYz8p8lgATkMHBUqltIE/O/6woZNK7i4njVNbt5
	mVNuOkUYoyotGZnn5tN82Dq//ahYGve9sMVbXqi40mSP2p85sYIFrvEW1fJpm9vlvtU2bKbllqm
	4X3QPuCQLeVt7VkTC8YQ3sR65pSsN6YV7rS256MYRh1aJngwYLpo1KDgv96ySi48Kgm1EI4gs5P
	JapnmJmP4Walwo66sq23aIsYPBoEOEg3tFXaPp1IxrrjsQDU+DIdqlCw+NlGVB5OM9SFJGxSn9s
	bElSCBir9ylRkCya/Pr0qLIch4v//oJhIzuco1rXAm0oeF1FOFMgng94yPNjcmi4BK/F7lxQTi4
	U+fagVSEdWZaBNSczDq4kQSffgQcVxi9N64X85isiHjhnlXmPGIvlGpm8lsqHI3Q==
X-Received: by 2002:a05:690e:4088:b0:662:f28b:7c63 with SMTP id 956f58d0204a3-669057a7895mr344755d50.63.1785216268371;
        Mon, 27 Jul 2026 22:24:28 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6d2f9e0sm4496668d50.2.2026.07.27.22.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 22:24:27 -0700 (PDT)
Date: Mon, 27 Jul 2026 22:24:14 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Zi Yan <ziy@nvidia.com>, Kairui Song <ryncsn@gmail.com>, 
    Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
    David Hildenbrand <david@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, 
    Chris Arges <carges@cloudflare.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/filemap: __filemap_add_folio() restore index before
 retrying
Message-ID: <562fbfa6-dd6d-0b6a-2461-ed2ff1173bc8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

In __filemap_add_folio()'s split-a-conflict loop, xas_set_order() is
applied repeatedly: each application modifies xas.xa_index, rounding it
down according to the split_order attempted at that stage: and if all
goes as intended, it eventually (or immediately) converges on an
xas_try_split() to the required folio_order, with xas.xa_index now the
same as index: then xas_store() puts the new folio into the xarray there.

But if a new node was needed, and GFP_NOWAIT allocation did not get one,
the lock is dropped, xas_nomem() used to allocate, and sequence retried.
If (that part of) the xarray is unchanged when the lock is reacquired,
no problem. But what if the conflict was meanwhile resolved by another
thread (perhaps even doing the same thing, inserting a folio at that same
index)? Isn't there a danger of now putting our folio into the xarray at
an intermediate rounded-down index? With !folio_contains() bug to follow,
when CONFIG_DEBUG_VM=y is checking for that.

Fix this with an xas_set_order() to restore the original xas.xa_index at
the bottom of the loop, so the retry does a full re-evaluation after
reacquiring the lock, and cannot reach xas_store() with the wrong index.

Production was suffering from rare SIGILLs and SIGSEGVs, executable text
found a page away from where it belonged, !folio_contains() bug hit when
debug enabled: symptoms not seen since this patch went in.

Fixes: 200a89c159a7 ("mm/filemap: use xas_try_split() in __filemap_add_folio()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: stable@vger.kernel.org
---
 mm/filemap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 58eb9d240643..d721986d5f46 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -931,6 +931,12 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 
 		if (!xas_nomem(&xas, gfp))
 			break;
+
+		/*
+		 * Lock has been dropped: start again with the original index
+		 * and order (but now with the memory reserved by xas_nomem()).
+		 */
+		xas_set_order(&xas, index, forder);
 	}
 
 	if (xas_error(&xas))
