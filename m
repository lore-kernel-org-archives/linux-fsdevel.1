Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2D3914E5;
	Thu,  2 Jul 2026 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977357; cv=none; b=st9aULorckx6uz8LycteWX98rmWtSz+RgyBQhcuwq0zYmFwfIBMYxNJdvBhZjRXMhQSokF99abeVIGyp8yC0gcvYRP8qzC/tOMDxYFomldJq/m1hU8MVqHv598pxU+hCVDMnYsM1HmDBoTGeUTGAV2nQh+Agn0xXRVT+EtmOKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977357; c=relaxed/simple;
	bh=Lawg9YFySEGOgubbh1cOdatE9TtSMuRVqTofSHmUhUI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JShs0i4TmpjoQ5yb/7+BoB8GaKx5kwF+s1CmLwE7KMQcalYUYue+Pff/rvV/EHjQ30XVpOudGEmcHEok24kaEcdRFuW9pW0QQPUvlY/MgjJnywoGp4WdrC199caOH6He5SfTqh0NB5KQ2QVkR3nTroqDhcdtcGwDPG+0TtGHQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIiZmgcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIiZmgcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8128C1F000E9;
	Thu,  2 Jul 2026 07:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782977356;
	bh=RW6SqLELVkDjLMxPpQI8Ty2YK2jLiDbzTAVsATnYajs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GIiZmgcrgeHAeLML2XeNiJwOH+L3j/64WDzDO35aq8yZT/jHxV7m9wHy7ut5AA1et
	 cCwYx3pYwcCNZxgDW3mLKJNly/CD81grA5V3ddM6AFBtbBqqq+8tehx1+L+Ap0csRz
	 +ISDUXz71y5a9zU/BVa/UQw5DyYEJ+vzd+2aiCNFMTAVpQuBL84HV73tcJ0S5P8jOx
	 Y6GHbgw8/EhR+1qtYHWgT2zZEiNhYaSk4S43Ehmxjfr9kM+Z5qGZ0KzhYCh9rgTMN2
	 tYkoavqiVF2bFWFx5IBA15E0Qz4dwzNopzw6XpsGBX03bRSMAAuttwKg3zWlxRHR44
	 HmW+F24oNMflQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
From: Christian Brauner <brauner@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20260701115302.29c66401@kernel.org>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <bffcce9436c47e8762e6f4fa4cae9f7ddd183b8f.camel@kernel.org>
 <20260701115302.29c66401@kernel.org>
Date: Thu, 02 Jul 2026 09:29:11 +0200
Message-Id: <20260702-sucht-bauabschnitt-rausspringen-577b7b7be2c7@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Lawg9YFySEGOgubbh1cOdatE9TtSMuRVqTofSHmUhUI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5CXv2c35Y2mapEp9sFbBZldcizv0N2+nSrAJ3cUez2
 cGCt951lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATCTHhZHhhtJF/VtHXetO7btg
 2X2hOmDzoZAjk1ylu4q3J7x2UG8+yPDPvuvuVyuPzOLC2cI9PZ3/1OITwueWpIXvfen8KonvLRM
 jAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-01 11:53 -0700, Jakub Kicinski wrote:
> On Wed, 01 Jul 2026 14:35:08 -0400 Jeff Layton wrote:
> > On Wed, 2026-07-01 at 17:54 +0200, Christian Brauner wrote:
> > > I remain very confused by our coding assistant contribution guidelines.
> > > I'm going to be a bit polemic now but this seriously in good faith.
> > > 
> > > Why precisely do we require all this detailed information about what
> > > specific coding assistant was used?
> > > 
> > > I find it very irritating that our git history has effectively started
> > > to function a bit like a free advertising platform for a bunch of AI
> > > companies and their proprietary agents and models.
> 
> FWIW, this is exactly how I feel. I added a regex to strip these in
> my git hooks. So at least the net/ history should be ads-free 🤷️

Ah, that's good to know. I've been rewriting them to "LLM" but I might
just start doing what netdev is.

> > In general, collecting data for nebulous purposes usually turns out to
> > be a bad idea. If we're not 100% clear on why we want this data, then
> > we're probably better off not collecting it at all.
> > 
> > With that in mind: if we're going to water down the tag, then I say
> > just remove the requirement altogether. If we later decide that we want
> > to start collecting more detailed info for some (clear) purpose then we
> > can revisit the idea.
> 
> +1
> 
> Honestly even tool attribution feels increasingly moot.
> People vibe code tools and AI-in-the-loop pipelines which they never
> publish. Open source tools are (hopefully?) used in pre-commit
> pipelines, so they have the "kbuild bot problem" of problems getting
> fixed before the code is merged. And we have the same free advertising
> problem for the rest.

Agreed.

