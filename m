Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236635E948;
	Fri,  3 Jul 2026 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062368; cv=none; b=VcwZFIMZKX+/jMzXnrINtACb4ABpn4Q2hP2WCQeWKgtV67HbMvv2tp1VVVonDoV6NlFoFT9cUBTNRGbnSs0rJ3qPm5SSTH99GL0GQYvOyWyJHTt3A8f6oQ1fca4K1sShF7pjDEfjOjRZ9AR9x2ZQPjSE9cTD/Rxp4t9bH4dMStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062368; c=relaxed/simple;
	bh=bh4y9lDGi6TgXFrenpnlfKtxsha9HOYb8KvB+l6k08Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k7W85pJDzCE/zQ3UnL6ntdU1HT6GoQIUqQri/u/UTxuFeGkq1nJW6dQCnOx7AbtJRd1oSDCccl0mAChGVwF4CEkblydgURz2YWUC4jrUcADDMr9MvfRgv3L5zBZGDAzKRSgGYRn7XgPW0e6h1vOq1cCXDJp/cZZt31suisz2HGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9ef+DLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9ef+DLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D3B1F000E9;
	Fri,  3 Jul 2026 07:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783062367;
	bh=Hg7IJj4ATWwgnTdZiQm5Sopne/isxX9eomdh02JspH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y9ef+DLvPAWqsV+B66oZ0j6jG9zDQBFRzsqyOY/G0D521ktuR6rR7iExHQSfgoWDu
	 0pTvXQCXs8QvLZnWN9Mm9zt7bMtSrsWSKzXnd4WGO2uEa/V8T30cwoBrSKhaYduY5k
	 btZM8x1dJY8s3Svzp2NMlPpjubqTtdnIHMDv02aP2BMQciKM0KhwT/jfNRXWyXIHvk
	 ibRyap318N8fVQGfUhoBDepV7U50+7sYllNvfqhZm/RSMu2tJXlPWrjA/tn9liqPjK
	 NiYJW48KU4FOjVvQDoYfWU8AtLNQYC+YSStQqa2YBgD4gcSVPxQy5di3DArWVuGMi4
	 WoN11RWjbXt6A==
Message-ID: <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
Date: Fri, 3 Jul 2026 09:05:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
To: Boris Burkov <boris@bur.io>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>,
 Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>,
 Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
 Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
 Vlastimil Babka <vbabka@kernel.org>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>
 <akaWnQ5Pkg_676B-@lucifer> <20260702211740.GA639365@zen.localdomain>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260702211740.GA639365@zen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 23:17, Boris Burkov wrote:
> On Thu, Jul 02, 2026 at 05:50:15PM +0100, Lorenzo Stoakes wrote:
>> On Thu, Jul 02, 2026 at 12:48:22PM -0400, Jeff Layton wrote:
>>>
>>> Do we need a tag for this though?
>>>
>>> This seems like the kind of information that we would always require in
>>> the cover letter of a series (or the little place in an individual
>>> patch for comments that don't get merged). That would also allow you to
>>> convey a lot more nuance about how it was used.
>>>
>>> ISTM asking people to disclose LLM usage in a cover letter would give
>>> everyone what they want: Information about whether and possibly how an
>>> LLM was used, and it also wouldn't clutter up the changelogs with these
>>> tags.
>>
>> It's much much clearer and easier to just have a standardised tag for that.
>>
>> You can see that (and grep for that) immediately, vague paragraphs not so much.
>>
> 
> At the risk of being pedantic on a point where I think the document is
> kind of lacking:
> 
> What level of assistance crosses the bar for an "Assisted-by: LLM" tag?
> 
> Some sample levels of assistance to illustrate the point:
> 
> 1. I used an llm to one-shot vibe-code a patch
> 2. I used an llm to write a patch but carefully reviewed every line
> 3. I used an llm to explore the design space for a patch but wrote it
> manually
> 4. I used an llm to debug or reproduce a kernel issue but then wrote the
> fix manually after fully understanding the defect
> 5. I used an llm to review a patch I wrote
> 6. I used an llm to research some chunk of code while writing a patch
> 7. I used Google while writing a patch and learned something valuable
> from the AI overview at the top
> 
> I personally would 100% use the tag for 1 or 2, and have already done
> so. I have not been doing it for 3-5, as I think that will basically
> make every patch llm-assisted to the point of the distinction being
> meaningless. If we should be doing it for 3-5 (or some subset thereof)
> then my mistake and I will certainly start doing so. I would hope most
> people agree 6-7 and similar need no tag.
> 
> Similar questions abound if you use an llm to help with writing the
> English text in the patch or emails.
> 
> I have a feeling that this ambiguity is part of the reason we aren't all
> agreeing on the value of the tag?

Yes, I raised something similar as reply to Christian's RFC [1], where I said
that for me the information *how* it was used is much more important:

"
Assisted-by: LLM # translate commit message
Assisted-by: LLM # generate some test cases
Assisted-by: LLM # cleanup logic
Assisted-by: LLM # everything and I have no clue what any in here does
"

That tag is it stands is pretty useless, really.

I assume most people only really use it for something in-between 1 and 2, but
*who knows*.

[1] https://lore.kernel.org/r/5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org

-- 
Cheers,

David
