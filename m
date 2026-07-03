Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6804530D41B;
	Fri,  3 Jul 2026 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103186; cv=none; b=K2ry5cRAUfJQ6O1RhFOBF8sGe3zhlmUZVeCOOfEEZ9/Uybpnag01hQ+JDxEqbrebTIs+YfZtvmLrfzPxpWnrHpyoxiKNLsug7iKSUb7Kuvsog/3h40UWv4ktPp5V7oTRwf7HU01g0iblvGC/N7WwiACwmfKThSSPQuaKHj5kvf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103186; c=relaxed/simple;
	bh=3sG+6pM28FcEmThoROo3anbCHNtoBGLXKQK5HQKLP6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFVQDSjVpNZ0nI8SSkfOieVMT+5hp78Ki/AfCMBeXYcyI7qc45qV7FI3Keb5JMRj7hnAF8FQZevX9RQxSbhd+dhXQU0jVr3HNz/IVWsgKJ+R2l6uXl3cabbJo/8gQRiu5TwE6nJeUZtBUCdSf0ZjjIXIbYVvpeZsX/A1koAo4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XObThWRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XObThWRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE2F1F000E9;
	Fri,  3 Jul 2026 18:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783103185;
	bh=iTuTT+001P56g6YbIPoGv9mFzhbzhhXuwGrfVvqwFtk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XObThWRVqp3jIVoAJp5uj/hTedJ+GdsRuj6V/s+/6avmFeflDeBY5fpAtMnpyz951
	 m9dyEIIefIgPjqSFtpBO5HIQ0351WLdVwSI7UwnCbovhSmxKlJzYmqBdvVtXnp+9gs
	 tyQzDsS1Y6yUqMiUDJkqBuKNxT4n15shchTID2bRwBFeLq742Jq+tLDXl7Zzthkm7T
	 8ho4NkiVjyC9eiSCeQyBa1mVBOZMGp2glj2m//wIChQ6UsrPT2rk6tIcR6lRww9z5G
	 vA5kkX+UvFo51q9TzP4vErvoip3b9pKjeApdTXKCmHEMCwylASoUx7bFyGMAf50RKY
	 pT3iL+yxOatUA==
Message-ID: <62c621fb-01b1-473a-9482-34ec4bc9da74@kernel.org>
Date: Fri, 3 Jul 2026 20:26:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
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
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org> <akez23ZhLRSGMFQ1@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <akez23ZhLRSGMFQ1@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>
>> That tag is it stands is pretty useless, really.
> 
> Not to go over it all again but I disagree, even as it stands, it allows us to
> engage in conversation about the LLM usage if admitted, and to point those who
> are misbehaving at the rules if not.

Just to comment on that

When I don't see the tag I am clueless *if and how* LLMs were used, in
particular as some subsystems seem to encourage not using them and we even
document it as a "rather nice to have" -- "should".

And if I see the tag, I am clueless *how* LLMs were used.

So I see your point that the tag as it stands helps a little bit, for my
day-to-day work, however, not much, as I really care about the "how". :(

-- 
Cheers,

David
