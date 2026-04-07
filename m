Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EFE349AE0;
	Tue,  7 Apr 2026 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574776; cv=none; b=aIVI5XbB1nY+xyMj6caa0uxl9LT/m0+TPuk/TNjiq4nfAlGct9uBQOniSEf8ht7JJuId7CKX6EvD7wZwrd8n4YxRdvnEETtTZa4XhR/m3Wzwxmzno24+h+eJQ/qaRES2HqVubE8jl4g43iWcHylWFTJaUlBpBR3twX2ulml7EbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574776; c=relaxed/simple;
	bh=eN18IrONevsoo58gEUdDHXiEgoDM2LKGg0S0uh2Re5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiOLjHs06Qs1Kl3EGlqYacAuPiZjtCkvu3DLzbgWVH4dAEakBwPXCRxbusRXrUr4edA2A0NNmTn70GdeSjuqEPj+usXy0GRRUyDzV8muZuLBgl3LVFP8IfiRN7Nmj5LW7nJ/oVpMJR5KP/0E1O//kDq+/FL/xxDKZdzj3VLhYtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WfxbU98J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WfxbU98J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFB623293;
	Tue,  7 Apr 2026 08:12:47 -0700 (PDT)
Received: from [10.57.62.47] (unknown [10.57.62.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 322143F7D8;
	Tue,  7 Apr 2026 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775574773; bh=eN18IrONevsoo58gEUdDHXiEgoDM2LKGg0S0uh2Re5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WfxbU98JLhxx24PyPN7oX1VXAEQLQ6QcE8Vg6D5u/gaffXdgZeCi06wkdKW/utfk+
	 kokY0lqImfvFUceZ40JU4ui5cLu74Pn57bZ8IZB4pMS4A+8oeHdwgL0dbLP8YJgnQt
	 0mTS6c1gtdFIdg8gXhskpAs1ikGD0tuxSxwByk8A=
Message-ID: <2d2aac86-2780-4a29-9eef-116c26485812@arm.com>
Date: Tue, 7 Apr 2026 17:12:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: proc: document ProtectionKey in smaps
To: Dave Hansen <dave.hansen@intel.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yury Khrustalev <yury.khrustalev@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
References: <20260407125133.564182-1-kevin.brodsky@arm.com>
 <98880cc2-09be-4bd8-b8f4-f0f0845f939e@intel.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <98880cc2-09be-4bd8-b8f4-f0f0845f939e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/04/2026 16:42, Dave Hansen wrote:
> On 4/7/26 05:51, Kevin Brodsky wrote:
>> +If both the kernel and the system support protection keys (pkeys),
>> +"ProtectionKey" indicates the memory protection key associated with the
>> +virtual memory area.
> I think you're trying to get across the point here that the kernel needs
> to know about protection keys, have it enabled, and be running on a CPU
> with pkey support.

Indeed.

> To me "system" is a bit ambiguous here but _can_ refer to the whole
> hardware/software system as a whole. To avoid redundancy, I'd say either:
>
> 	If both the kernel and the processor support protection keys...
>
> or
>
> 	If the system supports protection keys...

I see your point. By "system" I essentially mean the hardware (the SoC).
In general I would tend to avoid "processor" because not all CPUs in a
system necessarily have the same features, and some features require
hardware support beyond the CPU itself. Terminology is hard...

Happy to replace "system" with "hardware" if that's clearer :)

> But I'm ok with what you have in any case. Folks will understand what
> you're saying:

Hopefully!

- Kevin

> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
