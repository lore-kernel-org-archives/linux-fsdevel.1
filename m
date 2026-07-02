Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB26390600;
	Thu,  2 Jul 2026 07:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977263; cv=none; b=NVkw3YdRTqtptejg3pRrI2PBFdPN2YDfu80gGFXY1r66PKerPEsdUbSgvmkOfpjqfWneLtUaaWi+Ql9PsJQLWNUdiT4Bi41KlZMusbh+De0xD4IRHIT9cQWUbkuuqCzXLHRP6XL7clDEL/B24mzAh+OKdxeX+9lu8LpblNIbAZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977263; c=relaxed/simple;
	bh=DA1vxYDqpJTKOe3M3xJotRu292TxBD4Vc7QyJm9Ju7k=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=GXfoJ4KZ7M27FAzEwkzWytUfl40ZnG6k94VAtJ2ma/32zUHmFXmODHImI7hs45bbeEZi2zekiNa+SCWhjFKIYT9I1MjGn342a7Nszde8N4FWsB5VHCBNxpPxiBEehVATduaOblYbT6mUimBfUqXAHGuLO7+AXrWo7YznMS0VhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv7yc3Ug; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv7yc3Ug"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5169D1F000E9;
	Thu,  2 Jul 2026 07:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782977261;
	bh=Hahu6uEOu+lPpYEQPa4OkiCsLxdHg+fC8a9y4XvWy20=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Lv7yc3Ugjx23saln4ZBOmM5SOogATFWWKKt/X4xMe09XWbfpTkw/5K5DU1OQiymXQ
	 ifAoC9MkzUQEeZmCaj0JNOX3zNexYrpw/b5m8koqjipewzrRru3jZar3z1GyfScKPP
	 mBBQAOyH9gDjJBerIyy7GudLmCd3qeoy1V/wYCHj31NJyDIyBlcGO5TPV6uX+g0sq0
	 Y5p5XHv373XhsIbC/HjR5Izivn/Kq3e3lh4YSLrIZGiluUhCVEfzzZMx3Plh/byc68
	 5U1c0xPi54T+aJiXYyPl/sMdcHZtF1N+y3q/Vr5U1t+tTZP203wvaygsbYBT4SZ3tR
	 WlASBnT7hmxbQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
From: Christian Brauner <brauner@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
 Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
Date: Thu, 02 Jul 2026 09:27:37 +0200
Message-Id: <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DA1vxYDqpJTKOe3M3xJotRu292TxBD4Vc7QyJm9Ju7k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5Cb16IzGZ98mGqcaRSUtLp5uvPcLausu98ha3qmHWU
 rZ0zfrSjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm0z2Bk2Pfe1c9un6S/hPYS
 A7E1NZp3y4ytH9btcU2aLsqh/t0gnuF/SIyi3Vypo3Ifkqa+Ozf9sj1HsnTi9GOd88RVZu14Wbi
 aBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> What would be much more relevant to know is to which degree LLMs were used.
> 
> Assisted-by: LLM # translate commit message
> Assisted-by: LLM # generate some test cases
> Assisted-by: LLM # cleanup logic
> Assisted-by: LLM # everything and I have no clue what any in here does

I think we should just drop any attribution as a general kernel-wide
rule and let subsystems require them as needed. Then you can have all
the complexity in mm for this that you think is needed for your
workflow to function. This is precisely what the subsystem profiles are
for. So maybe just add:

Documentation/process/maintainer-mm.rst

alongside

Documentation/process/maintainer-{tip,netdev,x86}.rst

and lay down the rules that you require for LLM based submissions in
whatever detail you need.

I don't see how this additional commentary you want would ever be
enforced consistently across the kernel or who would even enforce it. I
don't need more beaurocracy to chase after people in my subsystems tbh.

The other thing is that I think this Assisted-by annotation is just
noise in the changelog. If you want to know in detail what an LLM was
used for when generating the patch it's mostly a signal for how
"intense" of a review this will get afaict (already questionable imho
but sure that's just something to disagree on).

If the information is mostly useful during review then I still would
question why it has to end up in our git logs. It's completely
irrelevant information imho.

> I thought we ask for that in some document, but couldn't immediately find it
> (and nobody does that).

