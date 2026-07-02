Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4DC3C108A;
	Thu,  2 Jul 2026 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978403; cv=none; b=sXTvFFSF0TaJsneyrsY7+aF0ojt3LHtH5+oF8ObLmFGGnMS///6JeW4OLN/auS1JYsOz9ntPRuEvgw/i4fvdIpQgWRcMN+WXMKbpStngcdUSl0B4gu8kLPOLVO3HHJy5mvhRlfx+djXS8nY4UCNk6Pxw7IgdRsjpAOggjZ7xaQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978403; c=relaxed/simple;
	bh=n2Sb/jpJFu7KE/OVw/brntK90T4lV4Wikk2rP88gDL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvdBjEkqaczmOPUZgSyo93BX1xwi+FDCTTCKA/z4YZA0LlA7jdPcOq0GVZNOg6w/vna14RuIwoZixH4xADxxLe0THdwV3nsD0jNqUuGoGIj1wLiTttCqyC3cGbJ8rsgkkIG/ymdkKUKPxN1BYm9dztTrfNswYnVB85d/FFrE+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkNJCoWy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkNJCoWy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B371F000E9;
	Thu,  2 Jul 2026 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782978401;
	bh=8TXZc2LPVOTWBJ3IyxPKZeTAolK17YkqlPe/3z5ZnA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gkNJCoWytBreb6/yrsGcvcLFOk1ikNOlyMnFK8yPtvj8RsFRvGBJ4qcwyufwFEKkM
	 eGI8q1U1/An3R4OxapmTBSXF+m+fdgT2/ptPQwdivozNukD3pcOEEmjADjYbFcyU/D
	 sVgnM6pyeldnd1+1BcPpqBsLy3KEeCPYz/q4wVTWOq7HBC1lonXRQh8ncFF6IuTaRF
	 ROX11xxkQkeYlYF1kOtsnzI9qVs9hvg7bLhxMmLNo/GTslfD2mvwhMFsDNqexkfr5F
	 pKDRVBB8Sbc+SbmSzyr7dZZjRxAO3LnW2qPqdirAlujlAemIgeTFG+4+uHxvJNhH1M
	 9ki62OB0mKrAw==
Message-ID: <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>
Date: Thu, 2 Jul 2026 09:46:37 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 09:27, Christian Brauner wrote:
>> What would be much more relevant to know is to which degree LLMs were used.
>>
>> Assisted-by: LLM # translate commit message
>> Assisted-by: LLM # generate some test cases
>> Assisted-by: LLM # cleanup logic
>> Assisted-by: LLM # everything and I have no clue what any in here does
> 
> I think we should just drop any attribution as a general kernel-wide
> rule and let subsystems require them as needed. Then you can have all
> the complexity in mm for this that you think is needed for your
> workflow to function. This is precisely what the subsystem profiles are
> for. So maybe just add:
> 
> Documentation/process/maintainer-mm.rst
> 
> alongside
> 
> Documentation/process/maintainer-{tip,netdev,x86}.rst
> 
> and lay down the rules that you require for LLM based submissions in
> whatever detail you need.

I'm not really sure if having (more?) subsystem-specific tags is the way to go.
(below)

So either we find a very simple, kernel-wide rule for such tags, or we drop them
entirely.

> 
> I don't see how this additional commentary you want would ever be
> enforced consistently across the kernel or who would even enforce it. I
> don't need more beaurocracy to chase after people in my subsystems tbh.

That's certainly a good thing to discuss. (below)

> 
> The other thing is that I think this Assisted-by annotation is just
> noise in the changelog. If you want to know in detail what an LLM was
> used for when generating the patch it's mostly a signal for how
> "intense" of a review this will get afaict (already questionable imho
> but sure that's just something to disagree on).

I'd be happy to just have such information in the cover letter. Without any
tags. Having subsystem-specific rules on the disclosure on that might be more
reasonable.

I agree on the "enforce" aspect. It's impossible, but it's still easy to catch
people using AI irresponsibly today ... and that's what we care about. Not
people that know what they are doing using AI responsibly.

> 
> If the information is mostly useful during review then I still would
> question why it has to end up in our git logs. It's completely
> irrelevant information imho.

Fully agreed. In the tree it's irrelevant.

-- 
Cheers,

David
