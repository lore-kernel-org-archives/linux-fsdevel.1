Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E73672A0
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474993; cv=none; b=ByG+R+82iKmdqnLnP3+UVngdVqwNw4O8W7Z9qwhh52dhqYJCq0svwPQetvYXFIPIYMQ+Hd3Ltf02/4UyXG5aCqh4LSCpFF0x4BVTeJOYwlPqtUCThVev4iCRaYZx1bl5KZOfYM5ZvHQlSqUue6xYsqpV6kl03+7cK0qxr6Qkv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474993; c=relaxed/simple;
	bh=jGGWGiwhyd7caBMano85c+rS6ohoaAHv6LjcCC1TOcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7+x12K2Qyh7FYoyRIDnydUgzZiBswxRbGhO5yvW++bFLegBx9QxgtoC2Z26jXWIN1M7cUt0c5U2KvxsyWDosc6+ht0z1V+XsSW6jO5MJyoar4vX7FO/DSfiqDbzbZbG/pH0M6iaZuSMRxQ4ljQ5wggJCnVuI+wXg2Y7Foypge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=gmI4LzXl; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Jm8Sj8rf; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="gmI4LzXl";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Jm8Sj8rf"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683MaPAN760709
	for <linux-fsdevel@vger.kernel.org>; Thu, 3 Sep 2026 18:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=iieI
	Tx8FG+BUBDRFx+zChg7QgLhyCTCz+Chx0VCTWeI=; b=gmI4LzXlug0M+JiQLPMj
	jZ2aYW3ufTCPlNIRBKV80vnH/QUypiaeAkEVqTtzgfVbTGNWgpn4aW1aF27N6AkH
	mgGKulG/o9lYpoTX3M6BGL5hTaQmKFAYkQpkK5GTw/2aWxFdDFrc/yDsIWB2K1Xt
	LqMFplevHWLvDsH8YrbR6/7+SFw+U5s+TNmnTL8WkNanwb8rziHteyxgXwjsWjWw
	BgDzG9/YbqhCAmga3tezaMxVJGEAJThfZAeaCem4HpcvhP28k3dAJzvs1hFrOaY0
	MmGsLOGpirYgQ0dKbO1kQ8lAgb3ZwVM9YW9pRakZWrYTkrlNeXaccWLwC3CjxgHq
	Sw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gfhgug3sc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 18:36:24 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93917f4ccb4so49706185a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788474983; x=1789079783; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iieITx8FG+BUBDRFx+zChg7QgLhyCTCz+Chx0VCTWeI=;
        b=Jm8Sj8rfahYDmJnt7oqqKbRrKCIIxXOZfpPMww23xq8CdEhtDBTvXOyX8zntHWH1Lc
         I/1v8voPHa9aZwtqouCV2cIUw1QOW5ocUDu+nZ79UENB0UWRBpzFx/rTTX3oY0+lx+a+
         Vlxe5ILGaqfEG/+pWz2AHtON8SWc7OI9OtbQTgZnPYoSLCRMgkEudsNwI2YpkAXRkFDB
         5RZU0ZM+8TC2SB1s6Yc08nbx7T79KwY+w204RA4F4TWbRxPYfkb+7JCQMhUqoc5DoO+8
         XEvm3msobSsiI7akZ41L8n2Bgo+i8GKDaCgN2avVEFObdcRFIPwrUEG4SYbiXeMBPQm9
         tAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788474983; x=1789079783;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iieITx8FG+BUBDRFx+zChg7QgLhyCTCz+Chx0VCTWeI=;
        b=Shb0Bv+kc/N0LgDlJWtyf+46xpvEAHCeNc8gQPDEh5vbfTMkz1I9/QVOXQmG/L3uNT
         m0Y3qqHVSFepaP8j0TfSyzqPPg+bOhHaYglwARpsn6d2Fd8KelLAP/iyTLnIqrPd4oQ6
         bivnWwxE0ibNGIdvVOtpjLzn+yPr2XifE8x7m+OTbVsn1WWanb3c8Gq+4wPohizHBwph
         vlItrr271F0ljq7b0AtU31gk7JCRFeqrDYe77zZni7pRqL/W7aub2htRfrNQQpuPrYn9
         DON4/9BnnycGivbdpfUsNmILydcIOxL77sxLOVNCOp1jPsTDN9+2YviJC387rXM8YLHg
         Iuqg==
X-Forwarded-Encrypted: i=1; AKwUvBwNJAZST3bS/eR+4NRCI88q8kQw0XJHIFeHVtpoF84IACIiF0S3TIS5TCO7OV6tnBcE4LIqlLe2AFjCC8Kf@vger.kernel.org
X-Gm-Message-State: AFuF++l8yYyyfkZAG6h8GDmOWQgHAzg0MFN9dnMRVf9PpF6Zgt033/YV
	uFhOiwVWWjT456ptQcjWFasTUMqOYqLj5vTRe9etxIdO4UflGxejeC9thJM6MP3AX6QWOWVwIos
	pxDXiWYl5w6GwlgMYSGOnF1+5leIl4BWpBybY7ixwGgPwRqXf/McoCEG0FhaT3eM=
X-Gm-Gg: AYBFou1qlSmdRJqxKIUjqKCRFiTpqlFvtGSpxzGvkImoIYuZZ9J3iXpY5xiLgu0WwNz
	mTwrmNvtVwFnIdYGTCcarxzja3QiplXCdLNTjCZhiBB2Cv3Ba4AXJK/KOGvc9sYgBHW3jgLRyB0
	2/8eXS7/CcvGs/HF2vh5NdTxrUu4sRTqSBxzlRPUNyngxvuUKnpqXFmlMIvpxYndMjSgbdS2UEx
	SJRUALdOJHemMprG501ZFGc/c3ST2yFw6DTunrflWMuO80a2mT2S31cDH1fZzxBer0eJIY7Hv9C
	S2aX722dXvfNPWST8zHE/mk6GwMd65MuyigXo9noAE5UMNnTalQoweVLe9y01JNakjDLkfkjK/l
	XvOnSbykrj8ZEjSxie7AjYawmGZMU8sCCiQHK+55VhMmXlf5Olg==
X-Received: by 2002:a05:620a:8016:b0:930:a635:a782 with SMTP id af79cd13be357-939802f7476mr224864585a.11.1788474982774;
        Thu, 03 Sep 2026 15:36:22 -0700 (PDT)
X-Received: by 2002:a05:620a:8016:b0:930:a635:a782 with SMTP id af79cd13be357-939802f7476mr224859485a.11.1788474982194;
        Thu, 03 Sep 2026 15:36:22 -0700 (PDT)
Received: from [192.168.1.62] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb90d6csm71746785a.33.2026.09.03.15.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 15:36:21 -0700 (PDT)
Message-ID: <1e5118a5-6b61-49d0-85e1-825e22059241@columbia.edu>
Date: Thu, 3 Sep 2026 18:36:20 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: filemap: retain mapped dropbehind folios
To: Barry Song <baohua@kernel.org>
Cc: Wenjie Qi <qwjhust@gmail.com>, willy@infradead.org, jack@suse.cz,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, axboe@kernel.dk,
        trond.myklebust@hammerspace.com, jaegeuk@kernel.org, chao@kernel.org,
        qiwenjie@xiaomi.com
References: <20260820142956.1414337-1-qiwenjie@xiaomi.com>
 <3fa43eaca792bc0bbde4b82a6c1fcdd3f528b398.1787999152.git.qiwenjie@xiaomi.com>
 <4aba05e1a2c3b61cb337d373eb9b7a8db4ddd822.1788024049.git.qiwenjie@xiaomi.com>
 <20260829111621.41ed2bc9a0e99e3367eb96c3@linux-foundation.org>
 <ef160933595c365f2c47597b260bc7ecd98ed7ce.1788029516.git.qiwenjie@xiaomi.com>
 <076bb01b-6fcf-4691-be8c-0e8507c9fe64@columbia.edu>
 <CAGsJ_4xMK=rPXCH5OiCOYHKRQp-w+xDJQusJ_ykbuAuLZr+8bA@mail.gmail.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <CAGsJ_4xMK=rPXCH5OiCOYHKRQp-w+xDJQusJ_ykbuAuLZr+8bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ThbTh_rqsVQAFB7jT1eSp-TB2XMaTAwJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE5OCBTYWx0ZWRfX4VRQObSF8gOe
 eViJHY5TDUIKXwHc9J2ycI7FIFwFrXwDbwWuYHjn2z4ExoSNjD+2CJOTbYRW+dKaR+J8XR0wAzq
 4ndNLHZpT8u24VMqWVYlO2qWkSNQGyDb4eelJxExXq6+vjfQC2XpUtIgreDBvtSJIAkOAg2WZh3
 F4ZCGwLFo1Dvs/oIpVcRtmd76ylaC1S6WQuPUbhVRHwHwjkzr3B3qER3fuSlc9PlDQ3Ead5S+Hm
 eBDd5TcNcFhAZl9vn8cBAcjkpnNJtjes1ytzvR//jHChe3L6WzAae/u1rRsU1mZTCsJRNrTo9GK
 GqpK/SvoZIoxEWjB3BxIdQhqx8BbJq2Iq3emYZnsbnPjWZK0jQ/ZKaTGR5+JWFguDRLee5AaFFe
 1mdL+gqlQRPzof/C0CLZ4NWtfFkwdlwnPEYXef7nGT5VKjai0EtSBN+TMDjj0RzCrByDXNd60sI
 LELvT6vTwW5vH3gYgYA==
X-Authority-Analysis: v=2.4 cv=Up1T8ewB c=1 sm=1 tr=0 ts=6a99f668 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=IeNN-m2dAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=kgJaSMB93tmHpg8ys4gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE5OCBTYWx0ZWRfX81+eIdZVcOnS
 jps5HQc3IRJjNarR8+zVCR9m6qH3gAHBTUMJKTKeo+bLkkKY8BzhGXerxvHp6xQAc76L0N7vYC/
 FMNOwYMfe1UpzVNJSZ9EThryDRTwkmvVw4nIKsolDi1BWS6GgLHr
X-Proofpoint-GUID: ThbTh_rqsVQAFB7jT1eSp-TB2XMaTAwJ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11895
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 spamscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=10 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030198

On 9/4/26 12:28 AM, Barry Song wrote:
> On Sun, Aug 30, 2026 at 7:59 PM Tal Zussman <tz2294@columbia.edu> wrote:
>>
>> On 8/30/26 6:25 AM, Wenjie Qi wrote:
>> > From: Wenjie Qi <qiwenjie@xiaomi.com>
>> >
>> > Fault-around can map ready dropbehind folios without going through the
>> > normal page-cache lookup that clears dropbehind. A mapping represents a
>> > competing cached user, but writeback completion can currently unmap that
>> > folio. A later mmap access must then fault it back in.
>> >
>> > Retain mapped folios instead. For a mapped folio,
>> > folio_unmap_invalidate() can call unmap_mapping_folio(), which takes
>> > i_mmap_rwsem and may sleep. Retaining the folio also avoids this path when
>> > folio_end_dropbehind() runs in non-preemptible task context.
>> >
>> > Unmapped dropbehind folios continue through the existing invalidation path.
>> >
>> > Fixes: fb7d3bc41493 ("mm/filemap: drop streaming/uncached pages when writeback completes")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
>> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> > Reviewed-by: Tal Zussman <tz2294@columbia.edu>
>> > ---
>> > The mapped-plus-dropbehind state was reproduced in QEMU. The patched
>> > kernel retained the mapped folio and continued to evict the unmapped
>> > dontcache folio. I did not reproduce the sleeping-in-atomic warning and
>> > am not aware of an existing report.
>> >
>>
>> I was able to trigger the sleeping-while-atomic BUG on current mainline with
>> some help from Claude. The reproducer itself is straightforward enough, but the
>> configuration was a little finicky. The atomic context comes from using
>> threadirqs so that virtblk_done() completes requests from the irq thread under
>> local_bh_disable() and the vq spinlock with irqs off, so in_task() is true but
>> the i_mmap_rwsem down_read() sleeps. It also needed 1 vCPU (so completion stays
>> in the irq thread rather than softirq) and ext4 -o dioread_lock (so end_io runs
>> inline instead of on a workqueue). With v4 applied the bug is gone, so:
>>
> 
> Thanks, Tal. Then I'm getting quite confused. Since with Wenjie's
> patch, we are no longer going to sleep for dropbehind in `filemap.c`,
> do we still need all the complex logic in the block device and file
> system layers to move dropbehind to a workqueue task context?
> 

Hi Barry,

Let me clarify. Wenjie's patch prevents sleeping in a very specific case.
The existing in_task() check covered most other cases, in that it just
doesn't do dropbehind invalidation if we're not executing in task context
(for example, block device writeback completing in interrupt context).

However, dropping the invalidation defeats the point of dropbehind, as it
leaves the pages in the page cache. If we get rid of the task-context
deferral mechanism, we wouldn't sleep, but we also wouldn't invalidate.
Wenjie's change is largely unrelated to this.

Thanks,
Tal

