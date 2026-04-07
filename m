Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A0D25A321;
	Tue,  7 Apr 2026 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775588338; cv=none; b=UoV4+Dd2MkOePb0c4k0J2hSwvSNAP9evtIQGWBPgM2YWb3Agd05BpVJr+im5VNeAkFlAwE/gyc5hQLhkqDSUWkzYLrxAaxQ8Zwq73f+OTIrccybzIfTnu9UKGfiHVq9DQjJqaMFKYd/Vo1ePQyoO5QvLz1ejkkPiaOX0fTwznao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775588338; c=relaxed/simple;
	bh=H8SjYEUoxd1atGVgkYJjKuGs+vTKbWOATK1xKl4o3qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUngG6RFyvVMHru13MKMeY9Zu8NpvvBWALIEp8y70kOToeMV2ReJZJIZzq3NEt/3D/vEpAH8WOGdc9vmqQ5QgRaBeFr3sXSQVkXDXWL7PVviQuqLs4lBmyS3zGUfJKk2dYahoxJTn9sKRkmh7OJA0uvSTEJAYyFb6I/rt0r5b/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eVY9/VRu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eVY9/VRu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=SQSxQSEOHiVkC2HemnN/5qYkqBP2dOqmPajTu5+oxsw=; b=eVY9/VRugfr6vnIaqRJqhFI5HN
	9Kb6vigVz4U4mvZnmzfRVBXNX4+J/lxvZlSEGUNNp5MchlZSnQSrG6OZ9Pio+A+tO/Nj4OERv2YNh
	HUc5zDfcUnEyaytHUfK8y4l1a3JLSoVhP/9ygHNM7fRGzrPrqx9Qg7AyMV0SQZtIR7rKq8xAxDjzc
	OLG0QWC13ApBCL+oXo6RvABHhfnhQ53elFVhKCEp8OwO0mqToK1lzm9VeYIQlujNiheEdyGgyhuP2
	bBhWYxtyqW18Zuicg7ygu6QMM8MysFZLEBmsj6gzQasYuXJrs5xC2hyzUYHHIutuHdGsCKhFyG8JU
	OPG/OyyA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wABdU-000000079Wf-16wb;
	Tue, 07 Apr 2026 18:58:52 +0000
Message-ID: <18e2042c-d414-40fb-8819-5e930d5b1584@infradead.org>
Date: Tue, 7 Apr 2026 11:58:51 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: proc: document ProtectionKey in smaps
To: Kevin Brodsky <kevin.brodsky@arm.com>, Dave Hansen
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
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2d2aac86-2780-4a29-9eef-116c26485812@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/26 8:12 AM, Kevin Brodsky wrote:
> On 07/04/2026 16:42, Dave Hansen wrote:
>> On 4/7/26 05:51, Kevin Brodsky wrote:
>>> +If both the kernel and the system support protection keys (pkeys),
>>> +"ProtectionKey" indicates the memory protection key associated with the
>>> +virtual memory area.
>> I think you're trying to get across the point here that the kernel needs
>> to know about protection keys, have it enabled, and be running on a CPU
>> with pkey support.
> 
> Indeed.
> 
>> To me "system" is a bit ambiguous here but _can_ refer to the whole
>> hardware/software system as a whole. To avoid redundancy, I'd say either:
>>
>> 	If both the kernel and the processor support protection keys...
>>
>> or
>>
>> 	If the system supports protection keys...
> 
> I see your point. By "system" I essentially mean the hardware (the SoC).
> In general I would tend to avoid "processor" because not all CPUs in a
> system necessarily have the same features, and some features require
> hardware support beyond the CPU itself. Terminology is hard...
> 
> Happy to replace "system" with "hardware" if that's clearer :)

I think that "system" is too nebulous there, so I would prefer to see
"hardware" instead.

thanks.
-- 
~Randy

