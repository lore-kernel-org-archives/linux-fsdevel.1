Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BFF31AA8F;
	Wed, 22 Jul 2026 20:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784752722; cv=none; b=n9P3Gtu/92e4TZSZsTiFBFgxQNimUiFhxdaxEkMDHWdWblOHF4xqkmmew0tsYUwwcTHaEm9dN6Rc1hf3+6SVJRLM0X7wqud2/kUxlnMtI3bcfA/+i/8BOoRVL+NvOrGSHLwt8KkOOJE8ddB2eDgXKA2HeidA7e/aTPb36xEBPZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784752722; c=relaxed/simple;
	bh=+nThf52Avm3/Tb3sglbmL8K+cZPpJ5Pq2kgJKX028Lg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mXlEpLsRISjT0Gply2MQH/fV2YI8u5HNV5tK2XCglRLJuIz7jbhfvaSg9m/Q3DYviMDrJ+8Sy5qL71qMRsNoTlblfEHeV7loVSNcBrx457hOy+6UPbzIijV3jFV6vUITaLeBe3jX5XSYnpHFkdR7pNMbmqJjHfQrH1eP8Bya42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CmkpMHqQ; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CmkpMHqQ"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BB9EB408BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1784752719; bh=d+uzLJLSXew5J0Iu7JkEniDE/a3cAS9EOkP6LgOz9nU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CmkpMHqQKNH3FJHRLSFFXnrHg4FFQC5mkVz8qG129bXnFSzmkUYW7k/CpnJBundMu
	 wMhKi3doIW2pZkxHQ/BYvm1HYALU//dor5FFP8AW9GKefAeUrVFn++EUo1h0k0XUTu
	 cMnUwRPgc3qhbdKqr+4ugBlOPpjQOGr3aAX6UxgDueaMDcKMXd9dX+lFoCn7RRtRVM
	 XLHScrGGlfmp47ywCRwroonBEVucwM6hILjRbLyO1HvO0K4zzf+RdhlIvLKlY/Z9N+
	 tfiF6xunFq0C6hF1+/ZRPfxJ/A0Aw9LC2WvSaxzR6lrjf0oJPt2D0ZuAOALqbMdR7U
	 3h26XS8VzBiDQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BB9EB408BB;
	Wed, 22 Jul 2026 20:38:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Justin Stitt
 <justinstitt@google.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Carlos Maiolino <cem@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>,
 Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>,
 Christoph Hellwig <hch@infradead.org>, David Disseldorp <ddiss@suse.de>,
 Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, Jens
 Axboe <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>, Vlastimil
 Babka <vbabka@kernel.org>, Christian Brauner <brauner@kernel.org>, Jeff
 Layton <jlayton@kernel.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] docs: link AI coding assistants and tool-generated
 content pages
In-Reply-To: <20260702164901.121128-1-ljs@kernel.org>
References: <20260702164901.121128-1-ljs@kernel.org>
Date: Wed, 22 Jul 2026 14:38:38 -0600
Message-ID: <87mrviahf5.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Stoakes <ljs@kernel.org> writes:

> Both of these guidelines are complimentary to one another - one specifying
> guidelines on AI coding assistants, and the other specifying those for
> tool-generated content.
>
> Since they are complimentary to one another, provide a link to each in the
> other.
>
> Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> ---
>  Documentation/process/coding-assistants.rst | 4 ++++
>  Documentation/process/generated-content.rst | 7 +++++++
>  2 files changed, 11 insertions(+)

Applied (finally), thanks.

jon
