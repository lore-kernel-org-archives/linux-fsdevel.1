Received: from mail.ekdawn.com (mail.ekdawn.com [46.225.164.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2859438474;
	Wed, 15 Jul 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.225.164.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118115; cv=none; b=EOXb09aS8OqznYiiJTCgtpr/MdFdAog7YuFadvNMs3Ebmj5OWefdEbBvkeNjZZPfUuUAPYxjaACpuYmU7+s1/Gzz+lkvGshiEbpdjJG9NsTH0exlOdejDZZcMW/+PW5yWulaSwyxid0GUsoX6uy+sLw4U0jgRPJperhozz8t8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118115; c=relaxed/simple;
	bh=frnFpfxg0py7n3r68A6LBhJ7ml3UYK76x5RXqSZ8rUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSi8nLS8EYkNd1bRJ0WRORY7NNSTHv40e7iYgHqe8dhmbwVJ2h5zZuPWP3RD46Ozq5W1LqbyF0+enS9EDR7CvhnWBvjIwK/aIXX9h4cQbA+edX9NDsgmnULBzEtQHbW1f64vbjyAYwJDdO9c+AiBIxYH5BxWdTqm+4y0o+gDKcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org; spf=pass smtp.mailfrom=horse64.org; dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b=ozGPntWf; arc=none smtp.client-ip=46.225.164.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=horse64.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horse64.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=horse64.org header.i=@horse64.org header.b="ozGPntWf"
Received: by mail.ekdawn.com (Postfix) id 9C2721E017C;
	Wed, 15 Jul 2026 12:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=horse64.org; s=dkim1;
	t=1784117503; bh=frnFpfxg0py7n3r68A6LBhJ7ml3UYK76x5RXqSZ8rUE=;
	h=Message-ID:Date:Subject:To:Cc:From:From:Sender:To:CC:Subject:
	 Message-Id:Date;
	b=ozGPntWfNc+prPlor9O4RxXZ/2AgbH4VHrBuOdXdW6qa5V3KNjDj3R9eNnxiUSRyP
	 TRzrOau6cs3nKzHw+VjUvllL8hnwgJou6rBUo4QPzQq7FS3XEsrK9NvG3PxmGPDrFV
	 VC4hNg6WnckA0hEtAJrtWUNSc9EGt5FRfEOe6GqVhaZjkBaBtKVMi7+FamSv3tTGTe
	 2LNfSMGt2jzzVkHXi6cgvVGLqRHy3iFp9jUNB2tIsO00YMNDp5elED0rbTSMExPM93
	 kRW9JO5edyxK6sVTstkZ9b4DVaRnppah170uxFQWTYa8bV+J6+/krJSKfQ4cJ8sZsX
	 dK3ubexa8G7u6iFJV9zp/m53pqcLywLp8MgKMaQ1fHIxNkCiCFj0RD6V1RAThVA7A/
	 JNV2iM5U6lH8NWvh2gdwdRlVLErF/veC9g8jaabLWa2GO+fFqz86pQCfWoSt5tRCvg
	 viJFXWLG3NFtR6fdx13tTVVflWNygW0xGbHPn98upX3RlTKC3tdTNdHIIv6p53WzJ5
	 Y97yJAsIi5xGZsfo4mM6e6Ce5VmZ2FDkXJzYen8pwix/i3YabqOlDQcV8BWZYSFwrM
	 kP+qOYRcNRrLI3g4mCUICwGXoz2V49J/KO8Uv7l+3xUoWmuBRXnJpsm03wgWCSXTnX
	 QIqft9MH8joxOz0OlgA0zMv0=
Message-ID: <fd7dcb35-037c-4e0a-9dfb-5e3d444749d6@horse64.org>
Date: Wed, 15 Jul 2026 14:11:40 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution - WIPO
 recommendations also seem kind of worrying
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <53942438-a44d-4578-b1c6-d45c2af1767d@horse64.org>
 <20260703115852.GC3659451@killaraus.ideasonboard.com>
Content-Language: en-US
From: Ellie <el@horse64.org>
In-Reply-To: <20260703115852.GC3659451@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/26 1:58 PM, Laurent Pinchart wrote:
> Your messages got completely ignored for a month and a half. Most
> developers (including myself) don't read LKML due to the high traffic,
> but I'm still surprised by the complete lack of reply. Maybe CC'ing the
> workflows@vger.kernel.org mailing list would have helped ?

Given the ongoing discussion I'm kind of wondering if it has been 
noticed by now, I apologize if it has and I just missed it.

Sadly, my concerning finds keep piling up, e.g. here's the WIPO, World 
Intellectual Property Organization, on what they recommend for AI:

https://www.wipo.int/publications/en/details.jsp?id=4713

Quote: "Consider using generative AI tools that have trained solely on 
licensed, public domain, or a user's own training data. [...] Thoroughly 
vet datasets when training or fine-tuning generative AI. Verify IP 
ownership, license coverage for AI training, [...]"

I'm not a lawyer, so I could be wrong and this isn't legal advice:

But it seems to me like neither do the Linux Foundations guidelines seem 
to be aware of this or adhere to this, nor does there seem to be a 
single coding LLM available anywhere that fulfills these.

(Since wouldn't that require training data that is both GPL-relicensing 
compatible and also doesn't require attribution? The latter I've never 
seen with any coding LLM out there.)

I wonder if the Linux Foundation would find it interesting what the WIPO 
says here, given how important the kernel is?

The angle of it just being a tool doesn't fully seem aware of such 
concerns. At least when actual LLM code is added into the kernel.

(And at the same time, it's probably possible to make such a vetted LLM 
if anybody wanted to. But that might require policies that enforce it.)

Regards,

Ellie
