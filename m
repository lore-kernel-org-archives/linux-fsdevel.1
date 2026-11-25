Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628242;
	b=GMNPoESvdg9jj3UkCMdf0b0M8bYS+U/HSGNy05ozovTysGB2+Kyh9EMydmIJHsIi4zz/
	 8Wvu82C5QzGOfasmu33hXgvReU9dSP9F9cBF5pl3lUmnHZihhcJEETwvypv3DWw6hQuWe
	 zOflqA6XBwhmbFrYztoDdaQD4oIRQsgNONyp5wRFnkZ481MO1/5mJ88nPhsirN59/nhDe
	 VcnigD/6erk5w15O6c1X+w/2vnILDlPU8Rcg4JaUxbBqnatrBP8fz0Dcfi9YoFtrqOAtk
	 xn5hsVUCU2IvLfnv+h1SZY4hRr+W9sQJMaLkQg1YR5srMpO1thRaCJO9w6CP/ia7SKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628242;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=eUjleOgflz/ScxaPG+1fyZoxmF8lmCs5aDsYINdEiyc=;
	b=v1l5GvTLv4/UnxcxCkrNPC2VBhs+Pta3uzRVrdiaRSt1/SP7aG3zspZzV2oMwJXdvBT/
	 zcz3oIdmShAdUfhI7UMtvNAGTwKvovQnDIDhc0XLUlRrN/QoG9t9w/x0oJ+syCbZR53HH
	 2v6xYdbP8rykb8APNfbhApBPcdzNEFbft6Z1IhbP0YvrAtC0WNnm9i2rq0EHgZiSuuKmj
	 651zCALiSOT55kMin4APPrapfAxfF86DMc7NVl/0okClgyYlPClLPego3HJStFMdkwLST
	 qeMQDX1iGAFvh8TaAglFtAy6C/Pmzk3fnEO26Qhplugu/vuMB6VvMeYxTG88NqwpwVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ozwLdpOy;
	arc=none smtp.remote-ip=95.215.58.64
Received: from mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5468606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 17:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5468606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ozwLdpOy
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SmxBiFQPGWVl7pVf8yZNdnfsf5ZI1BrL6QFbajuc6Mo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795628238; v=1; x=1796233038;
 b=ozwLdpOyruHqXV5oLW8yx0fOMZ2MqLP9HUr7yafMJ0FlLIP0eJQF1d1a/Cs9tAYVEKYzslYb
 aO+qRSacdHHnZYub3k2fEo9osQga0zjVtM4J0Pi76Z82FK8T7Vc89/8zJvsvB46g/uVEaYIwG9h
 Qm2RM19Q/UytCGuYJJFppObg=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dd5769ca4d57c53f;
	Wed, 25 Nov 2026 17:37:18 +0000
X-Mizu-Trace-ID: dd5769ca4d57c53f
X-Migadu-Flow: FLOW_OUT
Message-ID: <0e4be7f5-8704-4d2c-8e63-d578fad13774@linux.dev>
Date: Thu, 26 Nov 2026 01:37:12 +0800
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
Subject: Re: [RFC PATCH v2 0/6] sysctl: replace overloaded extra pointers with
 typed bounds and core stride
To: Joel Granados <joel.granados@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1794844686.git.wen.yang@linux.dev>
 <awV04op6IxD2NWQA@hobbes>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <awV04op6IxD2NWQA@hobbes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/24/26 21:26, Joel Granados wrote:
> On Tue, Nov 17, 2026 at 12:07:32AM +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
> Thx for taking the time to put this out. This gives perspective and adds
> to the discussion of how best to move forward with "struct ctl_table".
> 
>>
>> struct ctl_table has long relied on extra1 and extra2 pointers to serve
>> multiple unrelated duties, including range limits and caller-specific
>> context.  This series addresses both:
>>
>> 1. Replace bound pointers with plain unsigned long min and max fields
>>     directly in struct ctl_table.
>>
>> 2. Replace per-entry context pointers with a core stride mechanism,
>>     allowing callers to register arrays of structures embedding struct
>>     ctl_table and recover enclosing context via standard container_of().
> I think having these two at the same time is not the way to go. We need
> to figure out where to put the non-bound context pointers first. And
> after that is settled, we address the bound pointers.
> 
> Yes, we are doing the first to get to the later, but mixing them just
> adds to the confusion. One thing at a time!
> 
>>
>> This RFC focuses on the core stride infrastructure and two representative
>> complex users (netfilter nf_log and IPv4 devinet), as suggested by Joel
>> Granados.  The remaining treewide callers are converted in a single
> My suggestion was **not** for this implementation specifically. I
> suggested you create an RFC to clearly understand your idea. Apologies
> if that was not clear.
> 
>> squashed commit to ensure the tree builds and tests pass cleanly.
>>
>> Changes from v1:
>> =================
>> v1: https://lore.kernel.org/all/cover.1793204511.git.wen.yang@linux.dev/
>>
>> 1. Abandoned per-entry 'void *priv' (David Laight):
> Though not adding yet another entry in ctl_table is commendable, I
> prefer adding a priv entry over the stride mechanism in this series.
> Here are my thoughts:
> 
> 1. The type should set the stride in sysctl core. The situation where
>     the stride of a type might be different from its size should be avoided.
>     In these cases I would prefer a whole new type.
> 
> 2. Having ctl_table as the grounding entry inside another struct and, at
>     the same time, it be a regular (non-grounding) entry is asking for
>     trouble.
>     - A proc_handler assumes there is a containing entry around only to
>       realize that it was passed just a pointer.
>     - The core might start overlaying clt_table entries to deal with
>       namespaces [1], [2], [3]
> 
>>     - v1 added 'priv' to struct ctl_table, incurring 8 bytes on 64-bit and
>>       4 bytes on 32-bit for all ~1,000 entries across thousands of dynamic
>>       instances, even though <7% of entries need context.
> Just a quick comment here: If you want to get rid of 8/4 bytes with the
> ctl_table struct, you might want to look at struct ctl_table_poll, which
> (to my knowledge) is only used in one ctl_table array. Finding a way to
> service utsname while at the same time removing that entry is much more
> of a low hanging fruit IMO.
> 

Hi Joel,

Thanks for the detailed feedback and the namespace overlay pointers.

Our main motivation for prototyping the stride approach (and the v3 we
have been testing) was to avoid growing struct ctl_table while still
eliminating the per-entry wrapper functions. However, the upcoming
namespace table overlay work is a compelling reason to keep ctl_table
arrays homogeneous and  self-contained.

Following your advice, we will set the stride series aside and split the
work into focused steps:

1, first, prepare a small, standalone series (based on the lastest -rc)
    focused on migrating the non-bound context callers of extra1/extar2
    to a dedicated void *priv, field in struct ctl_table, without
    touching any min/max bounds yet.

2, Once the context pointer migration is settled, follow up with the
    typed min/max bound conversion as a separate series.

Regarding struct ctl_table_poll in utsname: is someone already working
on removing it from struct ctl_table, or would you like us to look into
that as a separate cleanup as well?

We expect to have the context-pointer series ready in about 1 week.
Please let me know if you have any preferences or suggestions on this plan.

Thanks,
Wen

