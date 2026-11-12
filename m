Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794476445;
	b=oQ8azUS3O6OcX2UDtkNU7GbGG4ZNjO4o6GOdu3S1S7D8lPm1oB6m6UJ1HTUEBv5mC8Tu
	 kbUDovbnaBE4LWBLPZxsOwXgqg2u5UjerPl7uB7Ht63wdQ/HHGY9RJIi4NGnEGCqJPHrC
	 Ybotcz8OMMIBpS863vf0PQ4BrPYHCDx5Y9wZyW6fU/zEBE+hh8944ojj03v8V7lDCU0W0
	 hdLqYj+RizsC/+k8OJOfvFet7NAN3L3nKrd2YCM6oStVOXFlfN14OusqPbdDmTvU1Bvnr
	 2x4gRZr4LxKUfZtPHaE7srq6og4uVfSAxS3R4ABOhS9lc+FTq2T/pEeN0QjtyYyd+Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794476445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hf+uCs+VHDQDVs3psYlyxaAnFaCOs7LnZX6+jXmv1vI=;
	b=E9PhGdji7ImbKxdNsnOkqyru+54UdpGtJSVh91qdW0RE6FrtaCZx+9FiPvugzNXqrw1K
	 yNrfbc+JgLNt8puJGNtr/ldgpM3VTiVITwq/vw+XVJfGXoliN8VmXbVV65F2O4RXKPfRf
	 S16+SCbPwUTtZiv1iuutCGBkTELAk+xiW4U4LwJjRwOhdjh+1dWKEN4h+xMPb0nxYzl0g
	 7AXpN8jtoociQ9rXeogTYhtArIA5rD25m3s4pu+rs2bt3Ku3LZgAXHiWeRCMiwtrT6egr
	 Ft3KYO22auFsZXlnfMPwmp9b8zCBLNSM7KIlioa0Ov0zc9bimO5i525vrhysdwY0LGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJbOhjAb;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBC606A32E
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 09:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05EBC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BJbOhjAb
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e3b22e971so2167524f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 01:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794476443; x=1795081243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hf+uCs+VHDQDVs3psYlyxaAnFaCOs7LnZX6+jXmv1vI=;
        b=BJbOhjAbyHoUEoyh3KeGfUaafSU2O52r4CAsPQ5s6Ww0aw/Noeiloy3kxL391sJ2HK
         pfhm/Fj31A+egDJsjB/IAfjGbP5gP2mFt43WUaFWFKzTd9AkLEJtI87r6A9E3AfMnqn5
         vyHPwF5SKymu5mEe1AynP/P4Kg0o+o1y80vafiQZ1t1YmVbhrX2g/OlSvmVq75pgwN1G
         PWa3+wkFp5gEf1Ax3dkB4TIbS8FWE+ktQavOWD6JoekME2D5Ash1MAuMJJEyhim/k6Y3
         f8mlezsr030nsedCruWVxUiRrsDdFYg2MpHisD3EJ8qpl5UGlGgqC0+Xxv9nc9wYptod
         BBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794476443; x=1795081243;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hf+uCs+VHDQDVs3psYlyxaAnFaCOs7LnZX6+jXmv1vI=;
        b=Rip5E7P4+mIPSiYAfvv8tsTO9BzGuFBWce+KeKI8dEOeRekCbkqGpk47DbN5VJlOwQ
         nOXj5eDbGsmymm7jyEdBck+yp9ZGXxwpnVqjIHi57vU7kMHkq8UOYh4b0oI6rXHRfyEd
         C4ROxNYEu6VSAX3V0IOo6GpznvuVDopT4+iLgDnkEF43DqhsP36XlcwlUM1CuFZFC4yG
         j/1imW64l8KlSlq20fHHGDh+JtXpKcYy+nth7/A7orVDTibVn837g83vvRa6Z1PDtL5b
         W2gf8twMoQ4J2uTfbg08wgk3f+5lWkUyIIaWTXLRI2ZCV2GW4cw1sHaVMPhZRcdPBCI+
         lVyQ==
X-Forwarded-Encrypted: i=1; AL+hErHCAru7SKPPXFVBW4a49RgJIceBOvkCuhmEQaU+ZCDr5lcI89eQDUgSOJXqAE7gzaPsAWWsmFqmuG7PxRoz@vger.kernel.org
X-Gm-Message-State: APuU4Z+fd7vaDKpSOYo6kBkhS348US1DHm+JKY3iFreyjym6yB27sVqc
	aYqzBqoJXuTDa3J3XJqM9Ik4Azo/6zkdFubRrc6z4E+vPnSDOsmdV/BX
X-Gm-Gg: AYBFou3G1ZFVs3MFiy93BwSRSi1NldZgUVYo42YUD55tLOR1cJ2NeKZ8lkbhKnemQi7
	8JmFydtA68dnMFGf0FdCgq6yjrbPq72GiwfyuDCR0Q2e8UEQADoyBidXgPDMLSVW8H1V0uORxHY
	gkkeSk89xJTT5QHQPuTsZ3n4qSWrm5nSMkndsftS6/jzMi87E1Aeavfl7GL2CYPu7jU+CQqbMyc
	uxyVaLJ36/H4QMU+XiEPCTh+BTQ7+U9LzN7QO4jkdMaoVyBDp2QK2a41fo1T1iXWPd1y/sNXm06
	DEud5UjjLZGXiOYxjJjAQcIrSlBv5tdmF4FTiaAXzA0V/olZ5xUoMP7Uvv9V05ejvNGi7pYUAQz
	fJY7lsivrRe2LuN5w8Fe0JexIoQhG99hxLsqoKjbXTxY22RbvRMe5ThtZcms/XfiVhatNT0Bsje
	A29Da6okAtO5MNhSeI6c6j9Ic16CPyziqpA/kB65i8VNDQ1kRK101IHLig9mh3KPw7OcOu9HCpe
	ZcUjTAiCsGCclxNZbD8wndsGqZMweAWl9rOMoNhUmSNUc+wcW7bMfJi90Hu40pJp1ESVMDzrr0s
	rcP9ZQSZuyY2z0VLyGR60IBM
X-Received: by 2002:a05:6000:25ec:b0:498:1d72:106c with SMTP id ffacd0b85a97d-499c764c9eemr7954310f8f.55.1794476443061;
        Thu, 12 Nov 2026 01:40:43 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983284c990sm14867834f8f.3.2026.11.12.01.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 01:40:42 -0800 (PST)
Message-ID: <db9ed03f-0b85-4360-a2e9-f6719773c7eb@gmail.com>
Date: Thu, 12 Nov 2026 10:40:38 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] mm/madvise: send UFFD_EVENT_REMOVE when installing
 guard regions
To: Tal Zussman <tz2294@columbia.edu>, Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
 <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
 James Houghton <jthoughton@google.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
 <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Chris Down <chris@chrisdown.name>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>
 <avTA58zlxJZ69TB8@thinkstation>
 <e19f1fff-f1a7-4c2b-8908-2d3ee6a49069@columbia.edu>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <e19f1fff-f1a7-4c2b-8908-2d3ee6a49069@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 12:21 AM, Tal Zussman wrote:
> + Jose
> 
> On 11/11/26 2:25 PM, Kiryl Shutsemau wrote:
>> On Wed, Nov 11, 2026 at 12:55:19PM -0500, Tal Zussman wrote:
>>> On an anonymous VMA, the zap drops uffd-wp and RWP protection along with
>>> the pages. Writes and accesses to the range after the guard is removed
>>> are then not reported, and the manager cannot know that it has to
>>> protect the range again.
>>
>> For RWP this only holds if the range is registered without MISSING.
>>
>> The zap frees the pages, so with MISSING the first access after the
>> guard is removed is reported as a missing fault. And there is nothing to
>> protect again: RWP only covers present PTEs, and a page faulted back in
>> shows up as accessed in PAGEMAP_SCAN.
>>
> So this makes sense, but I think this gets at the documentation point
> raised in the other thread. It seems that to use sync RWP "properly" it
> needs to be combined with MINOR for shmem and hugetlb (and MISSING for
> holes) and with MISSING for anonymous memory. Is that accurate? If so,
> this should be stated much more explicitly in the documentation + man
> page. I see that co-registering with MISSING is mentioned, but not the
> rest of the points (reclaim, collapse, etc.) The example in
> userfaultfd.rst also registers a MAP_SHARED mapping only with RWP and
> MISSING, no MINOR, so that should be clarified too. Hopefully this will
> make it into Jose's documentation patch.

okay, if Kiryl is okay with that I will add it to my upcoming patch.

-- 
cheers,
jose a. p-a
