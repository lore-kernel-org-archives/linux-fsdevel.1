Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792582282;
	b=1OJEBucS/r7r+U5/nhUW6R/Hn+TwQusyC/zoWaJxp8ZAQv/f8N8LTZGEOroGOqFQ9fay
	 oos2zWjxsdgUGWi56L1eqvsgCJlmXpLzszVSDPFZ4WncYZUkBs0lPY2GRi+VDfuGdLu3f
	 rcNa46K0EFEXXjhNfO6rZCh/II5B2/02B7Mr1yID9PYrjGhcuMc+W32rQwjgW2SL7Y5aK
	 Kl6PcVjpLyWSfzjivXAjN8jbUp8rhFn8rPvnUAmSx85lEpZ1iyJjuBHpemqWl0y7xJLF5
	 NKNePgvLprpWEVlTPnV9pqF8tbXyclMiHXvs7ofLvnoF2bUb02mGARN6iww/PKDO9nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582282;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zzXLUvvYElCIwzO2oJqrs76hOODnjOjJTUE9c+S1f2s=;
	b=ECrqwNv3pmVPwly9nenU3y+s/5kSNZ+HLpQ9SLKLQCaY0dYClFd2gW0rl8y7WacZuJuM
	 6cZIFocwVLksv/97J9mZascihhkWsuF/wWLDsm5px7pym5mXW0EML9o8O/XQdyAAwuvjp
	 76dvbYoj0OVv2oojUeORwo+x9nT2IUDu3vztLu8H6jayzWn4Wd79w3Wl6hZCUwTWIxZwE
	 vESl/iT7ISAKoXCMDWGhjRSlBYhYL6Foo5r5y53r5UHo/Z6FB78vFKndduaugLBhEzhjy
	 AZb5A+HPKL05gdBneuP5G8ZkNdmSZbKreHLFHFM2/EHQ3o63Zur5wQn5UCo54oCcAlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUTMIgoS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322B606A319
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUTMIgoS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5BA1F000C4;
	Wed, 21 Oct 2026 11:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792582281;
	bh=zzXLUvvYElCIwzO2oJqrs76hOODnjOjJTUE9c+S1f2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FUTMIgoS+aBlqZ30wPqkpHMjxDoOzCNQP8AcmN02c/Vui2ZVKWu2TV6G7w1MVgmzF
	 g2CbnmaghbylXozWCMrwomnqsEcQfOjjkjEbOja3V4oOgXmyifUY1QfMvMZvGkEo/B
	 ganuKIbPE/Y2IJjKKUs6SUbBwDo2UFk6E8M6FD4IGbBGc86Z8UXghsEowXbqHWAXqi
	 qefm14eZ+bogHps6bDrZRSEVYZ0OybF2UHjAoLGqO0ZR6oOS9kfsfmfQR6j6FW/E1I
	 a55BbfxniS4mY1gkuGZntZwf6dZSLF4xZOD7ZfNdxmpT4Hysdu7kze5yZe8TcJPQBo
	 z5xxQAMWyMRAQ==
Date: Wed, 21 Oct 2026 13:31:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Christoph Hellwig <hch@infradead.org>, Mikhail Rudenko <xyzzy@yandex-team.ru>, 
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH 0/7 v3] fs: Deferred inode reclaim
Message-ID: <20261021-korallen-hochzeit-jargon-5142e8e15fa7@brauner>
References: <20261009133253.20102-1-jack@suse.cz>
 <tsjar7j52anyxrtfdqfhmp6enu4e32hsvtitk5gy3bpxvagsjx@5exi7yidgf66>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <tsjar7j52anyxrtfdqfhmp6enu4e32hsvtitk5gy3bpxvagsjx@5exi7yidgf66>

On Mon, Oct 19, 2026 at 11:43:58AM +0200, Jan Kara wrote:
> Hi!
> 
> FWIW Sashiko still found some stupid mistakes I've made so I'll have to respin
> this. However none of the issues Sashiko found are fundamental (just some
> memory leaks, wrong memory ordering, ...) so the overall design should
> stay so if someone has any comment to that, they will be still valid.

I do like the direction of this design!
