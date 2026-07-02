Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349084229AF;
	Thu,  2 Jul 2026 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998617; cv=none; b=VLJZWTVRp7JvbPdAR0G96PASPdWZim7g5+wtdFkBCA4Ux/K8rotDPqklrTV8hUdapWjuHv8dE7PUchoDW5TR5hgWFEvmVN9fIu9WuiEIoEbaXV78wYbtGN2CFU031hI/Ydp1oGTLuSE09p+ASA1bS2SeTN36+sOy7WHs55E/jk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998617; c=relaxed/simple;
	bh=srJfFpeJLJJMkWxEGH/KQX8NpxQ+aQ6Ou7pVGBy0L9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R15BHVJCYgn2/zrdrp7s/r4QKkYuIAIJ8K6Brscxh+gmb6adGr+gFgVWen1LVoPzXvGlGEL9zHwptWkjeCC9am4QtiJh+P8ylyQ07gJy5vhZu8g8KIuTEc6LFzcQCzOR2Qa02g5noKv/34Pl5UzE2rRzu1wZZsi43RvTNcKeTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dM1Yo28u; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dM1Yo28u"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A9DDA8FA;
	Thu,  2 Jul 2026 15:22:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782998568;
	bh=srJfFpeJLJJMkWxEGH/KQX8NpxQ+aQ6Ou7pVGBy0L9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dM1Yo28uTBkgyU6E88ogluXVhCUPNTC6Zf2WMoqyDegYfFy6Bh2GVDCoGVbneHB+b
	 RupfVuCvuCZ3gxGN4anqlTArQESF6ikt3z06tv3zDlHE1PRwYTNrtJiZro0I8d5QVY
	 5nPWIwZzYIMNQKWcFQWw282lDyOHelV94E+6F8HM=
Date: Thu, 2 Jul 2026 16:23:32 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <20260702132332.GD3534761@killaraus.ideasonboard.com>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <afd0635c-1903-4c7b-8023-cbcd1823e081@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afd0635c-1903-4c7b-8023-cbcd1823e081@kernel.org>

On Thu, Jul 02, 2026 at 12:34:34PM +0200, Krzysztof Kozlowski wrote:
> On 02/07/2026 10:44, Vlastimil Babka (SUSE) wrote:
> > On 7/2/26 10:12, Jori Koolstra wrote:
> >> Ah, I still reigniting this discussion again :)
> >>
> >> What about a combination of what David and Jeff say? The whole point
> >> seems to me that the salient information is not that an LLM was used (or
> >> are we going to tag Sashiko as well or any other LLM-based code review
> >> tool?), but what is was used to do. This information may be relevant for
> >> how the review is approached. The latter should perhaps only be in the
> >> cover letter and then we can drop the assisted-by tags altogether.
> >>
> >> The question about enforcement remains.
> > 
> > It's not possible to enforce it. People can deny it if the tag is missing
> > and you confront them and even though the submission has many signs of being
> > obviously LLM, there is no definite proof. We've seen (likely, as there's no
> > proof!) that happen in mm.
> > 
> > Such situation then penalizes those who disclose so obviously they won't. We
> > should drop the tag and instead think how we can empower maintainers to be
> > able to use their own judgment and deprioritize dealing with what they
> > perceive as LLM slop, without fearing consequences of not being properly
> > responsible etc, and not rely on any non-enforceable tags for that.
> 
> +1
> 
> I see no benefits of enforcing the tag for these exact reasons. Every
> LLM slop will miss the tag. OTOH, seeing reasonable contribution with
> the tag makes my spider-senses tingling and causing unnecessary
> prejudice.

I'm not even sure the prejudice is unnecessary, given how studies point
to the cognitive decline impact of generative AI usage.

I have previously heard long-term, experienced developers saying they
handle review feedback by "doing whatever the reviewer asks" without
"really trying to understand" in order to get their code merged. That
doesn't lead to very good long term results. When such developers turn
to LLMs to write code, I'm pretty sure the prejudice is warranted.

> If the contribution is reasonable, how does the tag
> information helps me? I trust (or not) the person, regardless what tool
> they use.
> 
> And if we think about any future possible copyright issues with LLM
> contributions (like if there is ever a ruling that model trained on BSD
> data creates BSD-derivative work etc), does that tag anyhow solve it?
> Like if that ruling appear we will go through the history and revert the
> commits?

-- 
Regards,

Laurent Pinchart
