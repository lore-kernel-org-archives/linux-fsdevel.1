Received: from mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226FC3CF673
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144237; cv=none; b=i2MPIHLHjS99yl8fkvrvj04piREo1CBoBaD2xpMQe1IjWry7dzWQgSgOYU2PyfyYYTkNf/yHEce2VegOxxyJwXOtK4cEAhi84TXuCedbsTsf3MOiKgAMnt70AJN7kubzTgSPrKFRg8NDTfhz12k6sT+hb84zCk68MqMAWzu6ASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144237; c=relaxed/simple;
	bh=6etTptRp+LrfSLSHwwV/0Uxy/guPz+lham75CQKW3uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmTTh2t0aJkCRO+R9WWq5Ojnnkyy0uEMuZlK7Tg4qe28ptlKg9R1nAygwAV+KJzFT6w7QooGT1kilzAdj3p10wfMWphePfI7PTKC5MYa2LX+zN5YLkbKGIVJXZJrN3avEptZ8ZlzExjSsgTXIHtngYjLsOkA1mCElUXrs43kX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JL0N5Wr3; arc=none smtp.client-ip=95.215.58.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JL0N5Wr3"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6etTptRp+LrfSLSHwwV/0Uxy/guPz+lham75CQKW3uU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792144233; v=1; x=1792749033;
 b=JL0N5Wr3sz2OcO1RheLqCjnnHDYPVUhRaFfA3KsDXrWNrnzSi04s6//9v+EIatPrSe7MOVyT
 iG0lYLJoYp3/bdFeGqyrpwsZatGMfGB3E5WneFj3pC5wMGdRpYZUYz2w9h8NgFb8wCy2iEi6y/R
 YjZXxmr0yF0pHS2ZGa4FwcYA=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1b3b6dc6d678a515;
	Fri, 16 Oct 2026 09:50:32 +0000
X-Mizu-Trace-ID: 1b3b6dc6d678a515
X-Migadu-Flow: FLOW_OUT
Message-ID: <ce35f31f-3805-47b6-a953-ba55637b4181@linux.dev>
Date: Fri, 16 Oct 2026 17:50:16 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] proc: Move OOM-related procfs code to fs/proc/oom.c
To: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Ye Liu <liuye@kylinos.cn>
References: <20261014-oom_procfs-v1-1-f2d75e73571e@linux.dev>
 <as9MG_BtepLV6DsC@tiehlicka> <e51c14e9-5559-4ff7-8a38-de815a8f8230@linux.dev>
 <atCw0gk77fF5ISQV@tiehlicka>
Content-Language: en-US
From: Ye Liu <ye.liu@linux.dev>
In-Reply-To: <atCw0gk77fF5ISQV@tiehlicka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/10/15 18:54, Michal Hocko 写道:
> On Thu 15-10-26 09:32:53, Ye Liu wrote:
>>
>>
>> 在 2026/10/14 17:32, Michal Hocko 写道:
>>> On Wed 14-10-26 16:54:12, Ye Liu wrote:
>>>> From: Ye Liu <liuye@kylinos.cn>
>>>>
>>>> fs/proc/base.c is a large file (~3700 lines) handling all per-process
>>>> procfs entries. The OOM score, oom_adj, and oom_score_adj interface
>>>> code is self-contained and has no dependencies on other parts of
>>>> base.c, so move it into a dedicated fs/proc/oom.c following the same
>>>> pattern as fs/proc/fd.c and fs/proc/task_mmu.c.
>>>>
>>>> This makes both files easier to read and keeps OOM-related procfs
>>>> entries together in one place.
>>>
>>> Are there plans to separate other functionality or is this one off
>>> thing?
>>> In general I am not against of moving stuff to more specialized files.
>>> An obvious downside is a review as it is quite easy to overlook a subtle
>>> change when moving so much code. Something worth undertaking if there
>>> is a bigger goal. Not so sure if this is just a one of and fs/proc/base.c
>>> still keeps other random stuff in.
>>>
>>
>> Hi Michal,
>>
>> This is a one-off move specifically for the OOM-related procfs code.
>> I don't have a broader plan to split up fs/proc/base.c at this time.
>>
>> I understand the concern about subtle changes during code moves.
>> To address that, the patch is a pure relocation with no functional
>> modifications — all function bodies are moved verbatim. 
> 
> But you do understand that I effectivelly need to redo the patch to
> confirm this is the case, right?
> 
> This is something I am not particularly thrilled to do for a single
> isolated patch without a larger plan. taks_mmu.c will remain a huge pile
> of code after this change. So what's the point for all that effort?
> 
My familiarity with fs/proc/base.c is currently limited to the OOM-related
code. Meaningfully splitting other parts of base.c would require time to
study those modules first, which I don't have available in the near term.
I may revisit a broader cleanup when I have the bandwidth to do it properly.

For now, I'd like to withdraw this patch rather than leave it hanging.

Appreciate the review.

-- 
Thanks,
Ye Liu

