Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA03783B2
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784272; cv=none; b=I6aa/cF1Z74xYhwVXcweZBtyk97kE4r6c29UDIxbv7JdR5uQIIG7nybnydiTqMXNodFbiG8sHMj2J198T7XKCyNB3tls4Le4Qha0l/yKWTdqnXhxL4k+VtJdkYAGIOSO3kvKjZj/aBEd+rEgWLht/oLlhTQQlX/nFQKVRBbwhLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784272; c=relaxed/simple;
	bh=4WYdU2QhyXqU+J/LQCVn7X+IxtDxdQ46YOVOYQ3wx4c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SQ1mLU601Jp4ccVU7hgE93vBI5qtNsS0sEXX+XA37OLhlUAo5aaPUvrI2Gp/J2bi1S2PB1iWmqghqcXlqFD56eBqWJELpmsVCfbQFTgII+LhB6XcRJr2RdjZClcnfDiARrG3gIs4NSEU0diqtu13buqYmOlwUq2GpQFtlL/c31M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrMIMd16; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrMIMd16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF945C19422;
	Fri,  6 Mar 2026 08:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772784272;
	bh=4WYdU2QhyXqU+J/LQCVn7X+IxtDxdQ46YOVOYQ3wx4c=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=KrMIMd165ybmkiKdddDSfICK3ILtiUxMoX1pfdggCmYoIassRhyrunuu/9Kxr5eC9
	 DTQ6fAvZtRQuT4vv5S+Zzkyw2EP9M29XZn3s2jrioa4jS+sXsUMDUp4Hq+GDGr/0g7
	 riy6PbiV+94LnsJUo+dYQ2l3NUFH1lsLw/c+80XdH29p4QI+1zFFodusolI0ShyCmO
	 IapfGSeeM+76Z1rst8ec2Ru7qL7DCBMq0i53dKLO1zRelCXYak3yNPWwfAc0j/u7UH
	 pyuADR9r3H9ajmJS2+6j5dYwynnVgvJrFrv0VlhJRi6FPO3NKhxZaj/Af6gV2gnMcL
	 6gpCIZtivuf0g==
Message-ID: <dd9794d9-fa88-4020-95ad-bb8fefa4e2d1@kernel.org>
Date: Fri, 6 Mar 2026 09:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add mm-related procfs files to MM sections
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <ljs@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260306013453.90906-1-sj@kernel.org>
Content-Language: en-US
In-Reply-To: <20260306013453.90906-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 02:34, SeongJae Park wrote:
> On Thu, 05 Mar 2026 09:26:29 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> 
>> Some procfs files are very much related to memory management so let's
>> have MAINTAINERS reflect that.
>> 
>> Add fs/proc/meminfo.c to MEMORY MANAGEMENT - CORE.
>> 
>> Add fs/proc/task_[no]mmu.c to MEMORY MAPPING.
>> 
>> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> 
> I have a few trivial comments below.  Regardless of those,
> 
> Acked-by: SeongJae Park <sj@kernel.org>

Thanks!

>> ---
>>  MAINTAINERS | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3553554019e8..39987895bcfc 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16683,6 +16683,7 @@ F:	include/linux/ptdump.h
>>  F:	include/linux/vmpressure.h
>>  F:	include/linux/vmstat.h
>>  F:	include/trace/events/zone_lock.h
>> +F:	fs/proc/meminfo.c
> 
> Should we sort files alphabetically, and hence put this before 'include/...' ?

Hm I mentally sorted include/headers above all .c files :)

> I see a few other MAINTAINERS sections including 'MEMORY MANGEMENT -
> USERFAULTFD' are doing so.  I have no strong opinion, though.

The get_maintainers.pl script doesn't care about that so I don't care much
either. Unless someone does.

>>  F:	kernel/fork.c
>>  F:	mm/Kconfig
>>  F:	mm/debug.c
>> @@ -16998,6 +16999,8 @@ S:	Maintained
>>  W:	http://www.linux-mm.org
>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>>  F:	include/trace/events/mmap.h
>> +F:	fs/proc/task_mmu.c
>> +F:	fs/proc/task_nommu.c
> 
> Ditto.
> 
> 
> Thanks,
> SJ
> 
> [...]

