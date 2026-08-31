Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC333A9E8;
	Mon, 31 Aug 2026 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212062; cv=none; b=U2oN/S7UiT30+EWua2XIxbTrIIspjlx2H4wxZU9vbswmp37c55e4esPJs4NaQuLxywxoX3dfpOkKYkSGHTvkDlOD08NuBKPj4wtXRuyeZWWxOemOusz08+M++KzNgd0NlvJ/GvD1ReUYFdSCkC8MaX0o9pVbqYkn3AkdgTO+FXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212062; c=relaxed/simple;
	bh=3rm6nEGUS8PCQQIjGhfmZW/wnn1hWIKT56jQ59nmm4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PbZeRewDBg/Giltg2PsiZAumNaf/eRic9BRcgIKI8zW+IIaHLbiKsJ4PxWPkOWJVEnvoTua6FJWHLAK8G5wsmVVQOEeuDsP3fwYH5Q8nkpK4ErRX5rbFxZ3jQvLPDwxGNnICuUixFO0q6cGbNI3RwGdd2F/+ArlTkqtYmyyIx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MMrdVUqr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MMrdVUqr"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E2CF8408DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1788212060; bh=tiLQdS9VqOVY2M+173eU2VxYzYbYQ00f8q6FKkHANzU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MMrdVUqrZlPWTO3lMIJF6yDsyfP4fy3aExJyS4RPKowLTKwyUXCy+jkiZRQml70vj
	 ZT6UgfKxuWWZV2jhIACuSAafjsqCYqRIuoaLttYCJncgBdi2UWrvw8fPOj0ndL5Vj2
	 B9Hak/pWhn7we9oxVc9PfUWPEdwMVPKLmHzrnJ68Jja5byWqKX50fqaclc9xwDx8gB
	 stY/xAXa6umDeoexXdnmcVMB6EVGbGEWYEaiVeE7bogpsC5TUM9bgeuqtrWUpj7tQp
	 CHu7pfJvgeaQPE3/at+mso8wqlx8D6EqO0suJ4gdWEvDYn1mRoDjH/H1DdZ70cPRBf
	 zfau6hqecKTcw==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E2CF8408DB;
	Mon, 31 Aug 2026 21:34:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner
 <tglx@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Petr
 Tesarik <petr@tesarici.cz>, Bagas Sanjaya <bagasdotme@gmail.com>, Michael
 Kelley <mhklinux@outlook.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Matthew Wilcox <willy@infradead.org>, Zi
 Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/7] docs: core-api: Fix stale function names and a
 broken example
In-Reply-To: <20260822121651.1559-1-kmehltretter@gmail.com>
References: <20260822121651.1559-1-kmehltretter@gmail.com>
Date: Mon, 31 Aug 2026 15:34:17 -0600
Message-ID: <87a4q2gejq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karl Mehltretter <kmehltretter@gmail.com> writes:

> A review of Documentation/core-api turned up a handful of places where
> the text names a function that does not exist, or an example command
> that cannot work as written.  Each one is a plain typo from the day the
> text was written rather than an API rename: for every patch the wrong
> name was checked against the tree at the time of the Fixes: commit, and
> the correct name exists in current mainline.
>
> The changes are independent of each other and only touch prose and
> examples, so each can be applied on its own.
>
> Karl Mehltretter (7):
>   docs: cpu_hotplug: Fix multi-instance removal calls
>   docs: irq-affinity: Restore grep in example
>   docs: dma-attributes: Fix dma_alloc_attrs() name
>   docs: swiotlb: Fix maximum mapping size helper
>   docs: this_cpu_ops: Fix SRCU helper names
>   docs: xarray: Fix xas_try_split() name
>   docs: debugobjects: Fix debug_object_init() name
>
>  Documentation/core-api/cpu_hotplug.rst | 4 ++--
>  Documentation/core-api/irq/irq-affinity.rst | 2 +-
>  Documentation/core-api/dma-attributes.rst | 2 +-
>  Documentation/core-api/swiotlb.rst | 2 +-
>  Documentation/core-api/this_cpu_ops.rst | 6 +++---
>  Documentation/core-api/xarray.rst | 2 +-
>  Documentation/core-api/debug-objects.rst | 2 +-
>  7 files changed, 10 insertions(+), 10 deletions(-)

I've applied the set, thanks.

jon
