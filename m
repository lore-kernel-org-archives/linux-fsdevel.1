Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765704963B5;
	Wed,  1 Jul 2026 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922254; cv=none; b=jDB5kvTDLrhrXycu+Ymqyl3mf22QKux4bOD5KudLMpR0dyA+V5XI9Y6vryPj8Aa5T43QwVeitopWUQBbbviCp1Ox3PkKvwK9i5+hEIww11jWLnc5p6cbp7deSjLoYeDKVENP6Sd3t1SCQcDbVQ4I5m7PXIXlmPOiT2QBmaSpr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922254; c=relaxed/simple;
	bh=0oKdR1fL0GKv6uWyuerTNaIMjIHrzUjebGm5glZ9XME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAd2IXhoEIIYvWNwO9kFy6iI+M5/OAtq9ca6P4KE3212XbV2rTVVMBf9v8Z8AIt2dmyoGipwAehhNIfUeAIlM6mVBzAGZ8z4Eg8zta1u5EM5V1Se2vi39akWSUV5nAQzyC+67ACqW6ZsvgBL5zes8sFZ0s2YL/X6B510h4mTp64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1fS5nse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1fS5nse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097EE1F000E9;
	Wed,  1 Jul 2026 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922253;
	bh=PN+aYp1+EmpVX1ltAn0MkZsIr9z6Inx4GfdjM92k1o8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y1fS5nsev6ZwpGQdbaIvSGI92n2XA+5GBi/c1PjbAmjlfxhwCWMrapLREHlyiGGtO
	 ycSr3hpvtS7ir9sg89nCkbnisn3c3hbKRkRJ+0c+YI4RyUCWz8IIk722i7txOjPnb0
	 vajJsfiLA+W0tS3pIDYNECqThY8e3V4NvkT/zP40Wc6KzTJB2QEa8V+hloTLA1QiKH
	 w+kxQpIhM/1kFdL/WixOew+Guq2DL6v3FqiZnHoryyyBhzD5n6N/5Wfu9gYZRzRdDD
	 WP1YNzRJSXBDod0oYapB2c87Zdmcjq1qhKDNfhi8WnPpVURELxXpdS/aax9Svg1H3C
	 CaxIYtarmMj8w==
Message-ID: <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
Date: Wed, 1 Jul 2026 18:10:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
To: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/1/26 17:54, Christian Brauner wrote:
> I remain very confused by our coding assistant contribution guidelines.
> I'm going to be a bit polemic now but this seriously in good faith.
> 
> Why precisely do we require all this detailed information about what
> specific coding assistant was used?
> 
> I find it very irritating that our git history has effectively started
> to function a bit like a free advertising platform for a bunch of AI
> companies and their proprietary agents and models.
> 
> And it reamins unclear to me what exactly we do get out of this detailed
> information: Do we want to run statistical analysis on what agent and
> model is used the most and publish that on LWN at some point?
> 
> I acknowledge that my stance is even more radical: imho we would just
> stop it with any disclosure requirements completely. It's useless imho.
> We already see that other than core contributors most people don't care
> and will just not disclose their usage of AI. I think this is entirely
> pointless and worse it brings in undefined legal status as well. It's
> not like recent events of pulling certain models from the face of the
> earth have made this any less concerning.
> 
> But fine, if we want to do this can we please just dumb it down to
> 
> Assisted-by: LLM
> 
> or
> 
> Assisted-by: Coding Assistant

I'd prefer this.

The doc states "proper attribution helps track the evolving role of AI in the
development process". If there is another reason why we need the free
advertisement, we should document it.

Side note: if someone instructs an LLM exactly what to do, and would have
achieved the same thing just typing it in, the use of the tag is not any helpful
to me. (similar to "Assisted-by: vim" would not be helpful).

What would be much more relevant to know is to which degree LLMs were used.

Assisted-by: LLM # translate commit message
Assisted-by: LLM # generate some test cases
Assisted-by: LLM # cleanup logic
Assisted-by: LLM # everything and I have no clue what any in here does

I thought we ask for that in some document, but couldn't immediately find it
(and nobody does that).

-- 
Cheers,

David
