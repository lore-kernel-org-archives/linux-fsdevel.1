Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FA7396B97;
	Wed,  8 Apr 2026 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634649; cv=none; b=kXDf7G1o3MJxaAJHiwvdnKvpWwJsi6p+xDMxnbBpw69ZOsxMwOU41ehsn+e1ZX0DZUh5vdqwVeGrSrh7wZAdjZ1oSyLMwa8uGT+qO46UteTyVBs3wrBRiNRFBZAEFYvdmAsxTGSxOwXdquP2BUoFkjxhdiH+66gwWBhisIsG86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634649; c=relaxed/simple;
	bh=kwaAVCJ9AgzuJi8JKla1pDfqyqywMetty9XDV1vrBxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdAiUhKVdUtpyYzHlkDwHgMsFgYWLWJxNc4rQHoR1sy4CRcHyPQI3K56xhnZVvWSB6AQLwx/EFkueufYOK48BuTse9/xUbdiGUhI+V+vJLnJbvxhJATAxBs5Kyg+RX0HrFBldzXNTSmQDLz8zIQTcJsUeCkGPCHoWcfjLT9cu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KcGl9cWd; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KcGl9cWd"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3711D35A2;
	Wed,  8 Apr 2026 00:50:41 -0700 (PDT)
Received: from [10.57.32.84] (unknown [10.57.32.84])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09EEC3F641;
	Wed,  8 Apr 2026 00:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775634646; bh=kwaAVCJ9AgzuJi8JKla1pDfqyqywMetty9XDV1vrBxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KcGl9cWdEz8NMLMr0LTrT5hctHk/wUjL97oObHOKqRa02PevVRf/7Q0lJ5aEosm+t
	 4Be1ayY+7O2/0bhgMjr6+2U4GRm1WquugB/on5ug5x3FJrFbp2zYu4FROvwPP0Za13
	 XyWipQskCaCloqJ3Rw4atIe3QOTr2pgndsR8wuKw=
Message-ID: <971a511a-f311-4e2f-8b10-85d11e07bb0a@arm.com>
Date: Wed, 8 Apr 2026 09:50:41 +0200
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
 <fee59f61-cf62-4a60-9d8a-4543a02a9c48@arm.com>
 <efb2dda7-144c-4e00-bd5c-0b57a1244fb1@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <efb2dda7-144c-4e00-bd5c-0b57a1244fb1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2026 09:39, David Hildenbrand (Arm) wrote:
> On 4/8/26 09:15, Kevin Brodsky wrote:
>> On 08/04/2026 09:05, David Hildenbrand (Arm) wrote:
>>>> I think that "system" is too nebulous there, so I would prefer to see
>>>> "hardware" instead.
>>> What if you're running in a VM where the feature is hidden ... ?
>> Of course that's also possible, "hardware" has to be interpreted in the
>> context of virtualisation... But granted it is possible to hide features
>> even on the host with the right kernel parameter, on arm64 at least.
>>
>> "If the kernel supports protection keys (pkeys) and the hardware feature
>> is detected"? Still vague but a little more accurate.
> Can we just talk about CPU support, to avoid using "system" or "hardware" ?

I'm not sure how this addresses your concern with virtualisation though,
unless "CPU" is understood as whatever CPU is virtualised? But then the
same logic could apply to "hardware"...

Either way, I'm really not all that picky about it, I don't mind: "If
both the kernel and the CPU support protection keys"

- Kevin
