Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B51A37F726;
	Wed,  8 Apr 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632518; cv=none; b=FRK6N1B47Lj6Z1pS7/YJx63vkt2ENauUp00F3pUGm5VE0AJbEjakd7N0oD89nHxqwcR5GUiOHonicATFYEP2wPCGYvXdAa9wtM3Y+HSyYq010P0YInXyrRfw8D5u1Y07aGl20VEUMCvNXdHkr7S8Scn/NiTwL0UHIFXmLm1iZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632518; c=relaxed/simple;
	bh=QI2zxAR8L98eyxVZKjXwqx85OyENRBPtMCzaOaSjTdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxAKC0hAYSO9L1vjU7OUgTjh2ROWrro7yyV211xPY5fzOUtoPeGgB/M+m57NCP6JmqXjQp31HNhTNe0YA/VOCKNLPTPJzO35glPbO1IdjbD9lnhT3KuBzOnU3R7VYFoFq6rzM9yt5Vig1YUWkNY2lwFHWe3AMVYyAczYCTXWfjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=A5U8Din0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="A5U8Din0"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF65E3594;
	Wed,  8 Apr 2026 00:15:10 -0700 (PDT)
Received: from [10.57.32.84] (unknown [10.57.32.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F1CB3F641;
	Wed,  8 Apr 2026 00:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775632516; bh=QI2zxAR8L98eyxVZKjXwqx85OyENRBPtMCzaOaSjTdY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A5U8Din0dHoR9dyDDWxTSu3B/nuzykbKGu4AkV4oHkxqO2Gh1t8RUUdC4Jl4dlIiS
	 ds8GzhzuGE6SiVyZ9dA7c8fn5AiLn3eXXQFIRsGxCMDRD8xMB8IKlNq9Oedqa7vtpB
	 0CjNOP6SsXkauLqkiizN1HV7zBaLJCgdO7lwXxPg=
Message-ID: <fee59f61-cf62-4a60-9d8a-4543a02a9c48@arm.com>
Date: Wed, 8 Apr 2026 09:15:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: proc: document ProtectionKey in smaps
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Dave Hansen <dave.hansen@intel.com>,
 linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260407125133.564182-1-kevin.brodsky@arm.com>
 <98880cc2-09be-4bd8-b8f4-f0f0845f939e@intel.com>
 <2d2aac86-2780-4a29-9eef-116c26485812@arm.com>
 <18e2042c-d414-40fb-8819-5e930d5b1584@infradead.org>
 <8a5e4afd-cd0a-400a-8624-79c1dc9e3ff3@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <8a5e4afd-cd0a-400a-8624-79c1dc9e3ff3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2026 09:05, David Hildenbrand (Arm) wrote:
>>>> To me "system" is a bit ambiguous here but _can_ refer to the whole
>>>> hardware/software system as a whole. To avoid redundancy, I'd say either:
>>>>
>>>> 	If both the kernel and the processor support protection keys...
>>>>
>>>> or
>>>>
>>>> 	If the system supports protection keys...
>>> I see your point. By "system" I essentially mean the hardware (the SoC).
>>> In general I would tend to avoid "processor" because not all CPUs in a
>>> system necessarily have the same features, and some features require
>>> hardware support beyond the CPU itself. Terminology is hard...
>>>
>>> Happy to replace "system" with "hardware" if that's clearer 🙂
>> I think that "system" is too nebulous there, so I would prefer to see
>> "hardware" instead.
> What if you're running in a VM where the feature is hidden ... ?

Of course that's also possible, "hardware" has to be interpreted in the
context of virtualisation... But granted it is possible to hide features
even on the host with the right kernel parameter, on arm64 at least.

"If the kernel supports protection keys (pkeys) and the hardware feature
is detected"? Still vague but a little more accurate.

- Kevin
