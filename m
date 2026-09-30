Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389E0395D8C
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790768326; cv=none; b=dpb2iVbTgU93yxhSXDr/jE9afeeK/3R51y/PbPYYVpxHe4rcGYdg+m5pB6qSZJNELntEXSh1QI89eH4VSyqoROhjs+vqmZ1aldDCB9aK6uucYJ9NwfaiyPnRr2XqOEthn2B0eaut4lMx89RGIXj8JHh/+VkXzAZFLROYGkLByKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790768326; c=relaxed/simple;
	bh=FtyBlYU0Iun6AaTM0MlovxblsuxQWFSHOtj3pghFRq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+0RykoO+hPwNDbMeW5LAcKDCD/Aw1psAWYLY7qcclN8lfTDXfSEc1NdT4jP2ENyLUBVLd0DZlPyQ+sCKJSK68h/+TfDGKgQa1ciht7kiPF5EPLO8P/BX3kpo7El6cgNgWyqmqRlKDe0HwpSoXhAH37qVYl11yZDp75inDsBTmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlXqgclW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlXqgclW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D321F000FF;
	Wed, 30 Sep 2026 11:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790768324;
	bh=Wz/bhxjtBi7K7HV8B4o74LbjtU5sEbHi12rmGSrEnCo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hlXqgclWy+RKfo1IVb2/Lhnu8JTiq/kzASCVvfz+5uw2hJoEuS+yzXluIarqaXv0l
	 Tfh2Y9vvfC38nBPizbuXgNfVgBkbKCtg4rBPAAkvrfNYYqEdAzUMx+WgWijY2jw5f0
	 SkEL5tePsyaJMBG9alVE2MokNkkd683JUEgy1eCiCnqakNhyCZ5TkkDgolpBTQWMG4
	 P8WxUFHSS45NEIsTQS9U6Rdnt/14/iaq6kYsi4dwHs+PD2Mjo8c4FUAFcJsZC88i/c
	 /GzlVOokskwUvLEALhYyAt5dUSp0WAEYx0hELPCjB9Zea9+O996J5Gov0AzAvObyqH
	 D5wobrpPTONqA==
Message-ID: <de323c38-4719-45fa-b4ac-6dae1b51b086@kernel.org>
Date: Wed, 30 Sep 2026 13:38:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
To: =?UTF-8?B?5aSp54u8?= <rockeet@gmail.com>,
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>,
 Jan Kara <jack@suse.cz>
References: <CAAE3jtcL_CZJdcattCwe0RraKnHcZO=UknxEUQVG858ouZCUQA@mail.gmail.com>
 <7ebe4591-2306-4b5c-b83e-6a2e34b52bd8@kernel.org>
 <CAAE3jtfeKJLSypScqRAEEgvO8En5kJfpbcFn5X+LQ2YL+xz_vA@mail.gmail.com>
 <85aff663-2131-47da-ac04-8f0799a49b91@kernel.org>
 <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org> <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/30/26 12:27, 天狼 wrote:
> Hi David, Lorenzo,
>

Hi,

>> You really need an actual file on disk. Shared memory / shmem / memfd is
>> not sufficient?
> 
> Yes, an ordinary disk-backed file is the intended output, and subsequent
> consumers access it through mmap.
> 
> Shared memory can preserve state across a process crash if the shared
> object remains alive. However, using shmem/memfd would introduce a separate
> staging and transfer step to put the data into the final file. Building
> directly in a file-backed MAP_SHARED mapping lets us preserve the latest
> userspace writes across process crashes and retain the same file-cache
> pages for subsequent consumers.

Why do you really need the data on a file in disk?

What you could do is, load it once from the file into shmem, then let everybody
work on shmem, and have some background thread that periodically writes the
shmem content out to the real file on disk.

Then, you could completely control when I/O would happen.

[...]

>> It'd be problematic to effectively corrupt the page cache by saying "hey
>> this is dirty but just clear dirty state and pretend this is what the
>> disk has".
> 
> To clarify, the proposal does not involve clearing dirty state or
> pretending that memory and disk contents match. The pages would remain
> dirty and continue to count toward the existing dirty-page limits.
> 

IIUC, vmscan would still write out the folio if dirty, so I'd assume that at
least memory reclaim would not be affected, only background writeback.

> The requested hint only expresses that the application expects to modify
> the data again soon and would prefer background writeback to happen later.
> 
>> Delaying writeback could interfere with the writeback balancing logic.
> 
> I understand that concern. The hint should not exempt the application from
> dirty-page limits or throttling. If writeback is needed for balancing,
> memory pressure, or explicit synchronization, the kernel should override
> the hint.
> 
> The intended benefit is to avoid writing intermediate versions when the
> kernel has room to defer that work. There is no requirement to prevent
> writeback until construction finishes.
> 
> madvise is not the only option, deferring writeback for the entire file
> would also be acceptable.
> 
> Could such an advisory preference be accommodated within the existing
> writeback balancing policy while retaining its limits and fairness?
When using MAP_SHARED with disk-based files for VM memory, people ran into
similar problems: the VM will constantly dirty many folios and background
writeback will just permanently write these out and wear storage. For VMs you
really only want the memory persisted in the file once you e.g., migrate the VM.
Essentially, once the VM is paused.

One of the reasons why we tell people to not use that combination and use
shmem/hugetlb instead. I do wonder whether there is some similarity ... we don't
want brackground writeback as long as there is heavy activity on these files.

-- 
Cheers,

David
