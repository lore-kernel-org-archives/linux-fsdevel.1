Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFC2E8DEA;
	Thu,  2 Jul 2026 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996002; cv=none; b=b343JbCO5QvsoaLihcjUagGKNamt9pH7stPiEONHC5DAuwwlUol6/fksnEsjOtUITRnDyAxElqlRQA0jcoc+/HDorZHtqErXFx251WJXzEfos9HQyEeSVzR2VCd4HHICS2nkNfQPa9jzjVtYOIxNe9m4rg/o32lUq/Hzgj0Sc74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996002; c=relaxed/simple;
	bh=3axNtMZZ6hvzc94Ke4W+1ty9JZ3i1hGJEWsAAGEua0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5B/hHuo3o4kUtCJT3mQWjl/vkEMiuJhXFYr2QcJm3z4md32nfcwGVOb0Vy7Wboyv7l3kwYBajbc0+C42hEWMj88WSjeKbjbPGgqQ5DrOsZKVWUUOmJCb/cp7PF1B/g4/wYhazwisg0Xff9kf/mnrZ8J0ubNHIvcxRoxEWsS1tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZWeFBgG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZWeFBgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E381F000E9;
	Thu,  2 Jul 2026 12:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996001;
	bh=LzlB2TISOANdddexIz6jlk85wGYRGJOEKANaM3zy/p0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CZWeFBgGPLQXMyJJ/PESA1qwRFh4t4fMPo63pBqk+wvmm9Zi/WshKYTdHJ8ZB6Tmx
	 1vcOiJ9n1F18TZNIOMeDv8pkM7PrLV031LuNhKG8hNl33ijGkxtQjevEii/Z445vvO
	 8zbUICU8PRRk0zgsIfyUu/xUOnjnIPy0fU9SAO3WP8vB7nqvFt6cJGgPUGcSXeaQh5
	 9YjUk9JJ271XtQGxR3oxBfIXsmLUGLy3p8fybTQmB456UiccDF3xHE6MqdD7YtHndV
	 1TU0j/wejrJzbu+al/4dpR8IHAXjL+N5kXWgbkWeUh/IsQDNURstwRa+ukndWLMpx2
	 SAi9qW2Ej8f7g==
Message-ID: <a4406124-2d0c-4703-9ee6-174af94d6fd9@kernel.org>
Date: Thu, 2 Jul 2026 14:39:53 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Jori Koolstra <jkoolstra@xs4all.nl>, Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <afd0635c-1903-4c7b-8023-cbcd1823e081@kernel.org> <akZXGJSy0FA3kQ3-@lucifer>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <akZXGJSy0FA3kQ3-@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2026 14:23, Lorenzo Stoakes wrote:
> On Thu, Jul 02, 2026 at 12:34:34PM +0200, Krzysztof Kozlowski wrote:
>> On 02/07/2026 10:44, Vlastimil Babka (SUSE) wrote:
>>> On 7/2/26 10:12, Jori Koolstra wrote:
>>>> Ah, I still reigniting this discussion again :)
>>>>
>>>> What about a combination of what David and Jeff say? The whole point
>>>> seems to me that the salient information is not that an LLM was used (or
>>>> are we going to tag Sashiko as well or any other LLM-based code review
>>>> tool?), but what is was used to do. This information may be relevant for
>>>> how the review is approached. The latter should perhaps only be in the
>>>> cover letter and then we can drop the assisted-by tags altogether.
>>>>
>>>> The question about enforcement remains.
>>>
>>> It's not possible to enforce it. People can deny it if the tag is missing
>>> and you confront them and even though the submission has many signs of being
>>> obviously LLM, there is no definite proof. We've seen (likely, as there's no
>>> proof!) that happen in mm.
>>>
>>> Such situation then penalizes those who disclose so obviously they won't. We
>>> should drop the tag and instead think how we can empower maintainers to be
>>> able to use their own judgment and deprioritize dealing with what they
>>> perceive as LLM slop, without fearing consequences of not being properly
>>> responsible etc, and not rely on any non-enforceable tags for that.
>>
>> +1
>>
>> I see no benefits of enforcing the tag for these exact reasons. Every
>> LLM slop will miss the tag. OTOH, seeing reasonable contribution with
>> the tag makes my spider-senses tingling and causing unnecessary
>> prejudice. If the contribution is reasonable, how does the tag
>> information helps me? I trust (or not) the person, regardless what tool
>> they use.
>>
>> And if we think about any future possible copyright issues with LLM
>> contributions (like if there is ever a ruling that model trained on BSD
>> data creates BSD-derivative work etc), does that tag anyhow solve it?
>> Like if that ruling appear we will go through the history and revert the
>> commits?
> 
> Why would you take information _away_ from maintainers?
> 
> You're making every LLM 'accusation' a risk for a maintainer because you might
> get the 'how dare you accuse me of using an LLM rah rah rah' response.
> 
> Why not eliminate that in at least some cases?

Because I don't think we will be able to enforce that information,
therefore it is close to pointless.

And if you ask about future copyright issues, I simply do not believe
the tags will matter based on argument (repeating): what are you going
to do with that information that commit was involving LLM tool which now
received some copyright-related verdict?

> 
> I continue to be baffled at people's opposition adding a single line to emails,
> or a single little comment on the end of it.
> 
> I do agree with Vlasta that we need to have a clearer way to just say no (TM) if
> we strongly suspect an LLM.

This part is not being discussed by me and I think the thread itself is
not about it.

> 
> I had a very unpleasant experience dealing with blowback for doing that in a
> _very_ blatant case and I'd rather not repeat it if it's at all possible.

Well, I made here the point already - that blatant blowback and any
future similar slop will not use any tags, thus the tags do not solve
that problem.

Basically having the tag solves no problems we experience. The tags are
worthless in problem solving...

Best regards,
Krzysztof
