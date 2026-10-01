Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6463C0637
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843732; cv=none; b=tgYbq9n2i0Dr9oqnyxWySwiCimxxMrIK9fcVCDDk+Aja5vL27PTuStd/LC81ih2rZ3by+ItfRb+P2GURcvwXvRF44gN86C9f4E1dKjuI3FMebxT/l1BbPgnk5Qdu76+YSmI+LpuMBSvo1qIIGMrR45YRnfS2MwXbUH96CZ8pOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843732; c=relaxed/simple;
	bh=suCKWCuc1bnOWffxzPTwdfuwNnlJqXA+qy0aAkoGCSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sseQ68z7emcO1I4DZS5h8buNxxMLe/4a+qBZizVn3O6oEIdkkCW/uPdzUIDL6pKv07oowqKPBe/YlhGxzZ1rSWNSTyZs2HWqpc9horg9xH0oAa3HB2u5vGvpkNphjgSp4MQC9TSXrxPpNhTHPW14ecYL+yOXwrVmdpoaagXYU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcEusJM/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcEusJM/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA601F000FF;
	Thu,  1 Oct 2026 08:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790843730;
	bh=suCKWCuc1bnOWffxzPTwdfuwNnlJqXA+qy0aAkoGCSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BcEusJM/janBADkvh00+H9aJtMWGPHTnd9wKQ2NmwFAtRA5DZCwhibfkEfdQ0cy2U
	 eWNDs9yOYDdzF8gWtVO8naGpWDV+SeKHnMAcWZ28+A5JQSWAnNua+fZTS4wL5SH/kt
	 0JMsNRvWdfUUQV+TGlMorXeHabbjIvNZiMruYNjbBUkUd4IDa8K+2kIZw5MXy9PuZE
	 zYoaVF2MLGHOjMXsyjq61OmQ+NDvdp45Yu6X7ckZ6vNeDqJV2qtXl5kbdaH5LAiS7/
	 mw+kOSyyNtYJWh7rXmjIdHR7AhuIaFqbTFyH8MzputxAHbYqZWfta0xvo9IAVEDpYn
	 B3WzwGT1PmRIw==
Date: Thu, 1 Oct 2026 09:35:25 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: =?utf-8?B?5aSp54u8?= <rockeet@gmail.com>
Cc: Jan Kara <jack@suse.cz>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] madvise: best-effort deferred writeback for shared file
 mappings
Message-ID: <ar4WSaLYBs1db1-3@gremlin>
References: <CAAE3jtcRQ407P9LTbg=JOwhABQRViSaq2XBefnDdNWiD7PxvUg@mail.gmail.com>
 <1ce9cf3a-15dc-4815-ba29-2e22b05206fb@kernel.org>
 <art8EKRKMdwSDCkr@gremlin>
 <CAAE3jtftxMkCfWJ77W-xvV2x7jdAN8C8kyofYC3fEivM-Cq6UQ@mail.gmail.com>
 <arz0auULA33fqoWu@gremlin>
 <arz8Plu6J4YOTi0a@gremlin>
 <CAAE3jtcanTUrV3xfofwrvYGCFe5o=Vn7gS66bDzuxzeGg6c5=Q@mail.gmail.com>
 <CAAE3jtdHi7aSsJ62TpEjkxvwA-3TBLvr5i1ohCNg2aupND+_XQ@mail.gmail.com>
 <xhrorb6wn2j2j57ydnt226khnu6gv4ut3crrmjwjr4iwj7d6yo@43lugxdthgyi>
 <CAAE3jtexTRdqzAodzCkAy5NtH_s3VhtutXbxMjangf8BtB+-dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAE3jtexTRdqzAodzCkAy5NtH_s3VhtutXbxMjangf8BtB+-dQ@mail.gmail.com>

Hi Peng,

(Point of etiquette - and you are perhaps not aware - in general in the
 kernel we reply inline to people rather than sending big lists in
 reply.)

>1. With buffered I/O, the data already resides in shmem, and writing
>it to the regular file allocates another set of page-cache pages. When
>both copies are resident, this roughly doubles the memory occupied by
>the data. Traditional LSM MemTables are usually small, so duplicating
>one is relatively inexpensive (they waste so much elsewhere that they
>never even reach the scale where this becomes a concern). Our
>MemTables can be very large, making duplication a substantial waste of
>memory that significantly undermines the advantages of our design.

Then use O_DIRECT :)

>
>2. During the MemTable-to-SST transition, existing readers still
>access the data through the MemTable, while new readers access it
>through the SST. We therefore cannot immediately release the shmem
>copy. Our current ConvertToSST instead renames the existing file and
>appends metadata. The inode remains the same, so the existing MemTable
>mapping and the new SST mapping share the same page-cache pages
>throughout this overlap period.

That's your choice, not a requirement. The SST is the MemTable plus
metadata, so append the metadata in shmem and serve new readers from there
too.

>
>3. AIO or io_uring with direct I/O avoids allocating the destination
>page cache during the write, but it does not turn the source shmem
>pages into page-cache pages of the SST file. Subsequent SST mmap reads
>populate a separate page cache, while existing MemTable readers still
>need the shmem pages. The duplicate memory therefore remains a problem
>during the overlap period.

It doesn't need to. Serve everyone from shmem until existing readers drain,
then drop it and switch to the SST. Only one copy is ever resident.

>
>4. Temporary files are a much broader use case. Periodic automatic
>writeback is unnecessary for temporary data; writeback for memory
>reclaim is what serves a practical purpose. A per-file exemption from
>age-based periodic writeback would benefit these workloads as well.

Temporary data that doesn't need to reach disk belongs in shmem :)

Overall - each objection so far has been to the cost of changing your
design rather than to the userspace approaches not working.

I agree with Jan that the inode hint is viable in shape, but we'd need a
good reason to add it, and avoiding a design change isn't one :)

David, Jan and I have all suggested a shmem-based userspace
approach. Please explore that properly first.

I took the time to write up the approach, in detail, at
https://lore.kernel.org/linux-mm/ar0mdJKLC0cHBoKM@gremlin/ hopefully that's
helpful.

--
Cheers, Lorenzo
