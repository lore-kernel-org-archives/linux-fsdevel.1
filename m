Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E94948BD3F;
	Wed,  1 Jul 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922094; cv=none; b=M8f6gR8IAwgDBcTkDiDFJwXuKhlsWwl1DQ3NEbOFPD4iPh2eXfVJiNRo0VS+n69Cq8uKcHaSecC+EQ/wZavo+O6wqntrZAnn7g7WHEgkHgLbaKtIkv4UvUdYtMjfeZxQdQDvG4M0RLTwfO/Z+UQD4c6Ihv2Jez+6h78qk9ZDRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922094; c=relaxed/simple;
	bh=xat0S/7hhqd/pGIHTCtDuUUbp6Tj4fuNwpwliP/9u8o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qyWf7hs707p4oj03iUV3x/GTeUytOpN1kj7UOm3CswY8lvN6SovlQa058wzdF2COLM7DJhtsJ0eF0q/LIYPg83oo4ceOjAcm1aKdR383dYP3UT/z2WvUNnwbPzr9UxY4hwvqMzbpRZfM5qoRTcSXJLMJpvdvu6HhVPpohaXlnqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=R3unUPoW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="R3unUPoW"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 695B841599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1782922092; bh=32P2g6yBGgImUvn7wpL6P00mVW8ED72vfqoB2ujBsag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=R3unUPoWerSGDmsBFQ8SLsl1L+fZ1NdJXYUbgzj+VM9Jnr/U/13Da3ySRDlf2JFhJ
	 l69LtblfKO8TKZ57Vz2al1CEwJ4vZhkztl4jFHAh+GjVsTqMjoIYYRNpJM8cVl6ava
	 Mos3h11NXCVF6tYscP/3HhApL8gjwu7q1ARlzYFNKqa4IFsE4URL22cdD/q1pzJlC7
	 V1SbNLwZl/EE6TJIKzlHN9I+iL5BwYF4dXKudFMLhMw1Dlk3D1PX0Wq0I2a9F95djM
	 BFoce6HldvfHIcuUvGm7349GzFimtsyR5ulTFkze988P+mt01ZxF99qkpsAV7sQkJ1
	 phoafNFU39WyQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 695B841599;
	Wed,  1 Jul 2026 16:08:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Christian Brauner <brauner@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>, Jeff
 Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Christian
 Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
In-Reply-To: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
Date: Wed, 01 Jul 2026 10:08:11 -0600
Message-ID: <87jyreofpw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Brauner <brauner@kernel.org> writes:

> I remain very confused by our coding assistant contribution guidelines.
> I'm going to be a bit polemic now but this seriously in good faith.
>
> Why precisely do we require all this detailed information about what
> specific coding assistant was used?

From my memory of the discussions:

- If a specific LLM turns out to be in a bad position with regard to
  some copyright ruling, we can identify the commits that might have
  been tainted by it.

- Similarly should an LLM prove to have an inclination toward specific
  types of security issues.

Whether either of these would ever actually prove useful is not
something I can hazard a guess for.

> I find it very irritating that our git history has effectively started
> to function a bit like a free advertising platform for a bunch of AI
> companies and their proprietary agents and models.
>
> And it reamins unclear to me what exactly we do get out of this detailed
> information: Do we want to run statistical analysis on what agent and
> model is used the most and publish that on LWN at some point?

...wasn't in my plans ...

> I acknowledge that my stance is even more radical: imho we would just
> stop it with any disclosure requirements completely. It's useless imho.
> We already see that other than core contributors most people don't care
> and will just not disclose their usage of AI.

The widespread ignoring of the disclosure rule is, IMO, something we
need to address somehow; were I still on the TAB, I'd be raising the
issue there.  Either we find a way to be serious about enforcing the
disclosure rule, or we should just drop it.  A rule that everybody
ignores is less than useful.

(That said, 706 commits in 7.2-rc1 include Assisted-by tags, so *some*
people are complying.  That's about 5% of the total.  What do we think
is the actual use of LLMs for the creation of kernel patches?)

jon
