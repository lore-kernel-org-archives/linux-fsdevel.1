Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691437267D;
	Wed,  8 Apr 2026 07:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775632021; cv=none; b=UK8SRWmP1k7s5EBcqhJ8yHXpOCAIgYv7T2xWYHQ3jRZgPARZLrqhkMUHE6bSPIcLJec/H1qLNtpc/YS664QzPOynAJombHIW2c61/QIzsRHdnppZGBp1CjB0dNkVKTRrY0T4iunfyp0YBrHyuywMPela6u0ec0A8ovm5f+Eps7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775632021; c=relaxed/simple;
	bh=qqisiRUcKsMuNGTzUMZDCYf0m8fM5jcWRywKXvtz4n0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s61RGpe2XqHIWFi7UcPQcUo3xPRTSBlePTghPScQbEbW/Sa+EOOBQo/DnUiRjYy3m0hyuDBGbhMs6CyzzJe1TUiEeJKXzsNBLA07MFkD0AK1g/K7JOjbeNK78ynmU4xn1RMJ5W0mSokTWzrHlUlmbofM7/1O/QRh6VmfjGvy6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sx6e6ko/; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sx6e6ko/"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AB043594;
	Wed,  8 Apr 2026 00:06:52 -0700 (PDT)
Received: from [10.57.32.84] (unknown [10.57.32.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA7133F641;
	Wed,  8 Apr 2026 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775632017; bh=qqisiRUcKsMuNGTzUMZDCYf0m8fM5jcWRywKXvtz4n0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sx6e6ko/WUnzOYbXo1ZC0/5e5AA2IwgEuKQo3JEUYcjIEamA9ixSNn9Xfz/DBAyLw
	 vag9fx+ghULspg/VmqWSthCJHfB/gmxyEPG5nJquVQOpSn7WWZeFyM8FzjIDOpMqa9
	 MpVFyu/mW7VcEqY5b3rm+0Si6ukgOEcK+muUDH5I=
Message-ID: <c898363b-2b24-4fe7-a567-190946ee0490@arm.com>
Date: Wed, 8 Apr 2026 09:06:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: proc: document ProtectionKey in smaps
To: Randy Dunlap <rdunlap@infradead.org>, Dave Hansen
 <dave.hansen@intel.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20260407125133.564182-1-kevin.brodsky@arm.com>
 <98880cc2-09be-4bd8-b8f4-f0f0845f939e@intel.com>
 <2d2aac86-2780-4a29-9eef-116c26485812@arm.com>
 <18e2042c-d414-40fb-8819-5e930d5b1584@infradead.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <18e2042c-d414-40fb-8819-5e930d5b1584@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/04/2026 20:58, Randy Dunlap wrote:
>>> To me "system" is a bit ambiguous here but _can_ refer to the whole
>>> hardware/software system as a whole. To avoid redundancy, I'd say either:
>>>
>>> 	If both the kernel and the processor support protection keys...
>>>
>>> or
>>>
>>> 	If the system supports protection keys...
>> I see your point. By "system" I essentially mean the hardware (the SoC).
>> In general I would tend to avoid "processor" because not all CPUs in a
>> system necessarily have the same features, and some features require
>> hardware support beyond the CPU itself. Terminology is hard...
>>
>> Happy to replace "system" with "hardware" if that's clearer 🙂
> I think that "system" is too nebulous there, so I would prefer to see
> "hardware" instead.

Ack, will send a v2.

- Kevin
