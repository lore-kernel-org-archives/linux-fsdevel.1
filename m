Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51932E12E
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600892; cv=none; b=J3p675Lc8K0jYi2h69ESawkSTfhjAvumUssgDIwD+Fzfs9zsGXddQv8d6G3kbQ2qszTpIxkHqgIlFJYHxEHnuOGpAt1fBXZEjc7cm1tuqUZmb82rtPP6yldCX1eVB3iMWDJySbquHGCYz5ZtguxajBRnPfRA/j1VtitKOgBGiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600892; c=relaxed/simple;
	bh=RXozA/gR0fE2TcrbGJcWa2WvzWIJ6gIbKhyeaCdATy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T77zoobiOuEL3NjjPy2VcC0y3k3iSVMjbdEScxxCOc9dIoCiukXVrdz8H+lQeqS3XliMTXjjtTkfk0djZBXidM8yqcuhvZvGsZ6nbeq5WPUXnqgxgON11VIc44q3WmOuvHbs8FosbbTYsG4SJnUwofx48xCMznfv1mNgJmEUbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeIsgPmH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeIsgPmH"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c207cb16cf5so622726166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 12:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787600889; x=1788205689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXozA/gR0fE2TcrbGJcWa2WvzWIJ6gIbKhyeaCdATy8=;
        b=oeIsgPmHxEdil63TcjR6u6TYNIXvbu2/jPJC82TJCyon8PhrqLuEMgfIXrmmhzYYP7
         F3BBgRRa4EhgzjyClquF2vVrihr/MvTVDKmC4LMmhnQ+Tmyg/l/wLOtsd7tDpGSDj1nE
         wVEKywpJFn/uHF6k1GFX2dusktywUyC6d8w01r1MxH4r2ezBfl3XQR6v4s116WbJAUf3
         tOHExNAmcAKNNNOrztD8doji0iT5YuoXfHTayRSeZkbT/notafnmI8eDrRuA4h0zdQO/
         5+6JFTHQEb8RH7Ghr0xdEaNz9DPLiAOP7VwA/J6qNGb7dtu3qUZYLfEDR6a8ZG8ye+Lu
         Rztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787600889; x=1788205689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXozA/gR0fE2TcrbGJcWa2WvzWIJ6gIbKhyeaCdATy8=;
        b=kqw54tEgSJgq2ir1H7mIS/K3GABf926e77i0in61cLLnHVOhX4Zs69dn9CZpZaU+xW
         YlFvuuiDXOJPqKoaBBhoKMuDnn8shDiTrlddUCemX+zIRmF8b0JIvEE/0G3WeOB0f5m+
         UQrymBH1eRvqCeiuFJnRQCm1abkrbk9U8LSDw8eF0XRbYQymTMpWEso+c99D8nfC2L3W
         6aScqVQVvwMn/LxDIb0Ru+4BwcLIWT2jK4+rUlNoo3Zq/j/eApFkN7lFti/Tm72CgOBy
         5rBnz4CMxEjCo1TQnX7YUKhQ+RL17f9TIsdtiQl9eLTpMe+NmE7XQ0xPgghfQt4IMh44
         8NlQ==
X-Forwarded-Encrypted: i=1; AHgh+RrdgvcvayQGoj7vJbTHuy0Yw72Gj7fUq0Fg3BMRaEjfkSlx88bE9if4yvg9enkJq+5Ywirk7x+0NkVz35a1@vger.kernel.org
X-Gm-Message-State: AFuF++nTkuf8fw42Coc/f9lle70PaW33YZ7VSt6i+vZSDL5iWVN/ERuR
	6BluxZ0m9wDeZ/aM35RCb9iB60t8VswPy0sn+Q5Wmpba/u2BSoePqKff
X-Gm-Gg: AR+sD12OyqBV/kG9n4ehD/HmOLsk5J5GZvx2YJ+3sNMV/0sdvNNmOvgDeywP+jb2UeP
	sdtDSpPvj9jm2zyKtrNPecjFktjWM4kk+k639Vb/mHrXu6RS2aWCf+1U2RZ8eURt0TfCql8STAP
	tqJLfp2KjsQ8C6MzaaPneoPxsItvUBCAO44sjNishrMA03Ar/dsqjIh6AZAaqRNwHbbNEWvK5oa
	+DCoV5t5vSLjRrl2NAihF9lreQ8JcTsGURMF46Xpj/mszPfOx4S4OBxDSgLib3DzJ26HZIdvU16
	BiUMBAgUtb0HUNmm2MOQ5g2Awk1doCC1VQ+FQsmRYR6BPDkiIRhJ8eXuwZ6mKpyOhAoiPXmOSaE
	w+BA001I0Pab6oB8UxLptG7L8nQz6mpLvklWbzObcYFvXbJBuYfg5EcBzGo1PHlHGn+g9SOv+fy
	TlbXqWLJUCJh9uL6Sl0LfH46cdLjEUEWk6ZBzEG+GPccOwKGfXsrB68Hg8F8uS53wTAGkdeKRiA
	gXu0n4hnvvK+N0QP/xhUqRZ1+BKQm83k0zSxJUJt0R8/I0XV13BbzKXGtzIx5I=
X-Received: by 2002:a17:906:a353:10b0:c1c:5c90:1bb0 with SMTP id a640c23a62f3a-c246a353d2emr2248385766b.8.1787600888761;
        Mon, 24 Aug 2026 12:48:08 -0700 (PDT)
Received: from localhost.localdomain (46-138-191-2.dynamic.spd-mgts.ru. [46.138.191.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629929dsm1432835866b.23.2026.08.24.12.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 12:48:08 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Extend xas_split* to support splitting arbitrarily large entries
Date: Mon, 24 Aug 2026 22:47:55 +0300
Message-ID: <20260824194755.216000-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117224701.1279139-1-ackerleytng@google.com>
References: <20251117224701.1279139-1-ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Nov 17, 2025 at 02:46:57PM -0800, Ackerley Tng wrote:
> This patch series extends xas_split_alloc() to allocate enough nodes
> for splitting an XArray node beyond 2 levels, and extends xas_split()
> to use the allocated nodes in a split beyond 2 levels.

Ackerley, are you still planning a v2 of this?

I'm asking because there is a second user for it that has nothing to do
with guest_memfd. On arm64 with 64K pages HPAGE_PMD_ORDER is 13 and
MAX_XAS_ORDER is 11, so MAX_PAGECACHE_ORDER clamps to 11 and shmem never
offers a PMD order. MADV_COLLAPSE on tmpfs returns -EINVAL there, and
huge=always hands out order-11 folios at best, so ShmemPmdMapped never
leaves zero. Every other page cache file system tops out at order 11 as
well, which is 128M and not PMD-mappable. pagemap.h admits it outright:
"xas_split_alloc() does not support arbitrary orders. This implies no
512MB THP on ARM64 with 64KB base page size." Kiryl's khugepaged
selftest series skips the shmem and file cases altogether for exactly
this reason, and on 6 August he confirmed in that thread that uniform
splits still go through xas_split_alloc(), so xas_try_split() on its
own does not lift the cap.

That case needs two new levels of nodes rather than one: 130 nodes,
73 KiB, a long way from the 1G to 4K split Matthew was worried about.
Raising MAX_XAS_ORDER to 3 * XA_CHUNK_SHIFT - 1 covers it, and
MAX_PAGECACHE_ORDER stays min()'d with HPAGE_PMD_ORDER, so no page cache
caller can ask for the order-17 worst case that cap admits.

If you would rather not carry the series further, I'd like to pick it
up: rebase on current xarray (2/4 collides with the XA_FLAGS_ACCOUNT
fix, 88f0adba8aa1c, and 3/4 falls over behind it), keep your authorship
on what survives, extend check_split() past order 11, and post it with
the arm64 motivation. Happy either way, I just don't want two of us
rebasing the same patches.

Artem
