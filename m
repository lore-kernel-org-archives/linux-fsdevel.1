Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC314779A4
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788524197; cv=none; b=RsvqPMZBCgS5QGWa0p/Cd06YG++BHkiYVqcWNni9VsZMKITRsB8mwjIlZ+JDjyLss/Z+1pWyEhDYkXQyeg45HOsyoTzyASc1Hhht0Rc9tso7BZF8rnKRyMsnBx39FfUbog3CEqFkwyVig6syZzRCRP4koAfZaSOKPjGobDCVd6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788524197; c=relaxed/simple;
	bh=Mih/s/iaTNQ3AYU6LlfwTYiHV7v9uAhhnX40xc6A7xI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=RrjbZFtIrUpIwmgSdYLl1A/pRBsh/n5sv5etBmIaTpY0R5tLh5vJzX4gIMV0IdP3vxc5dI4rMrhl1XwLOCogIAxScJvKH2oyInoO82T65LlhA4L/OCA0dmAzMsMkYZxTy6ZHCSl61WfAAmCYQmFmEE4tVxriYXHC16j/xXAjOCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qCBmfqt0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCBmfqt0"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a65e66555cso1036602a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788524193; x=1789128993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bmyMOpfaX4h3t7GBum5n74Kd1I2b9Qp+ODDo5tAvT2c=;
        b=qCBmfqt0B/sKDrrtbfSlwO20B/3vhHc0kzEMLY9OLkVHve5+kT/mUMfD50s+JZD9Fo
         rFd0AqsfsD1NbhMPeNffZUH5+xGlqdtE1TVTWXy/RvFcimX+5W7to7r5o9y6ZpuTWo+p
         8pAh6CPh8QZOWIHWtG/BXcI4PR4pLdMqub61PTnYYzLmP1H0buo3+KTIpEfhzhWNr2Av
         yKTmLiP1oDxH4/m0RRbYlxEeJ3nI4ceyQ6wFQq6iJPtm1BmwnepQNgT4LOHA6YeSZOBe
         ekbbsFirfhnDeZYsahJrTxwtRo0ujLGSZoZzRGZQrxKutGsAQp9xAOZz35CzwP8jpg0A
         x+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788524193; x=1789128993;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bmyMOpfaX4h3t7GBum5n74Kd1I2b9Qp+ODDo5tAvT2c=;
        b=UZfZQTnEtQ/n6K1w0bT+PQqjFSp7CtO2k1YiITtw8t/Wviz9XivEPtZDGu5iSuS+Z7
         sSzMt+ldhJZ3fZLmOW/fgHuRMNkXSkdbuLIJrXTxFBMjz0Dt2NttIZlkFN997GPB+DJl
         NefL1/s/Qred9dbU3o7z2sKZyJVaNX3qXw2/iH9oNfR9hao48wIHDoTJkV8u4CoX5T3U
         Zb6RQCzygh8LBxEacMgkDdxNWov0SBd6j5Q41eY+imvFIW7tGiuqKewA1dTNEE4Dsteu
         QaYHrmjawl92GSf451IS0VDg6mXbGzm1fHVOns5wO65xGMDJnhhMvk0Nwhzi5eNwmjG8
         ZHkA==
X-Forwarded-Encrypted: i=1; AKwUvBz2nyac/NpBhaRIZj6mS4Tz463AdG3+SEa/IBCROWXbV6lXZs1oYKx7P7GuGbYi8fCYdCKVihTLDV5S2IGG@vger.kernel.org
X-Gm-Message-State: AFuF++nRv4t3+Q6NidJfw3UUD2yWFkpuH05yPRy0LXuIJ47DYHI5XrHq
	shFoYtB9GZCA9e4jlA8TNpZ0fTEidl4HXdCGbRXV9uy4PzIO4wvNbENb
X-Gm-Gg: AYBFou1LMa0Lpwt3Fd2M7ACjM/LV3eEyXo8vS51nmbtP1bIjAAYSpSdSdNA+oGj/Z8A
	OePo1mHDwaT1vSfCcFZdtXuVc4AVg7HfQroxV+KBJeiS+TSx8+EDEz7pLWH+L0XVeActQdURItg
	qNo7Ur38o2dCZ2PCWrm9V5n6m6kJDVNP8uKaS56Y30Wpaof0fzxobVqKn6Os2sAWgh5d2paQ2IJ
	CXn44OTota+V+i1pKUSrbgOKjYzO1xgblUl1uS6KX6SehkGGWgUD+H0EC+9OWUL11GKzpTLqUe/
	RJxxwn+ZtHy5g+iWdR+SEQviIBqnSF5+PzjqS5nWkKS1HuIfcYhGfafQ11ghmJoRlqkPEN8BGhy
	Y4qC3kmypxtc9Zx2Q0ZSJ5ZldPz7V3AjiNlr5TEtgFeuBcLA93slHzVqmwSxPKTqX+OJ/f2iRQB
	xMBYTwUrX3pBfHsDeACJIwQ4LF3F/G38LJHD+FupueBA09slR1JFal8k/1bFwV7mytYBqeL69mY
	IYBbSS4qcKZl2nvSzpUW3goVdglYGDD+ZtWOdR4R6UqoctlA4O7+XlsK6sD2aRR8IfgDhAEeZbo
	0OdXqwFC886BJvKVFyHn8R84CPKIFYVI3jIR+tkz3dSRk6RJJi/9vPCQZgphvBu0vgIcft2YnmP
	/s9kW7xav1gS0qDVoeR5CU1gAsqXzHR4EswJxsj/L1SvGnQ==
X-Received: by 2002:a05:6402:4592:b0:6a6:35ca:af8f with SMTP id 4fb4d7f45d1cf-6a7e8e92b23mr2244160a12.16.1788524193458;
        Fri, 04 Sep 2026 05:16:33 -0700 (PDT)
Received: from [192.168.100.51] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a7e6bf337bsm1063392a12.26.2026.09.04.05.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 05:16:32 -0700 (PDT)
Message-ID: <493efefa-308b-4d3d-a6e9-841a3b118283@gmail.com>
Date: Fri, 4 Sep 2026 14:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xarray: fix index jumping backwards in xas_find()
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, syzbot <syzbot@kernel.org>,
 syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
 linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
References: <2992424b-2120-489e-9010-f45f46ed52c8@mail.kernel.org>
 <20260903112251.6114f91af953412d2355e5b3@linux-foundation.org>
 <app_o87YogZExbwm@kernel.org>
 <CAGJbn0f+s3U0G=1yUx7a10-buHgA_yu0REG01M8hgFo=t+3Y1g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGJbn0f+s3U0G=1yUx7a10-buHgA_yu0REG01M8hgFo=t+3Y1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I have fixed the test issue and submitted patch as v2. I'm sorry about 
issue v1 caused, hopefully v2 is going to be fully correct now.

On 9/4/2026 10:41 AM, Krystian Kaniewski wrote:
> Hello,
>
> Thanks for running tests on my patch. I've quickly looked into the test
> result and the problem seems to be related to check_multi_find_4() test and
> not the fix itself. I'll send a v2 patch once I get the test fixed.
>
> pt., 4 wrz 2026 o 10:22 Mike Rapoport <rppt@kernel.org> napisał(a):
>
>> On Thu, Sep 03, 2026 at 11:22:51AM -0700, Andrew Morton wrote:
>>> On Thu,  3 Sep 2026 13:48:55 +0000 (UTC) "syzbot" <syzbot@kernel.org>
>> wrote:
>>>> From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
>>>>
>>>> A bug in the XArray iterator xas_find() causes the iterator's index
>>>> (xas->xa_index) to jump backwards when iterating over a multi-index
>> entry
>>>> (like a THP) that resides in a non-leaf node and is concurrently split.
>>>>
>>>> When iterating over a multi-index entry in a non-leaf node, xas_load()
>> sets
>>>> xas->xa_offset to the base offset of the entry, but leaves
>> xas->xa_index at
>>>> the requested index. When the caller subsequently wants to advance to
>> the
>>>> next entry, xas_find() is called. xas_find() attempts to synchronize
>>>> xas->xa_offset with xas->xa_index before advancing. However, the fixup
>>>> logic was incorrectly restricted to leaf nodes (!xas->xa_node->shift).
>>>> Because the THP resides in a non-leaf node, the fixup is skipped.
>>>>
>>>> As a result, xas_find() simply increments xas->xa_offset and
>> recalculates
>>>> xas->xa_index based on this new offset. This causes xas->xa_index to
>> jump
>>>> backwards. If the THP was concurrently split, the entry at the new
>> offset
>>>> is a node pointer, so xas_find() descends into it and returns the
>> folio at
>>>> the backwards index. The caller (filemap_map_pages()) then calculates
>> the
>>>> PTE pointer based on this backwards index, resulting in an invalid
>> memory
>>>> access such as an out-of-bounds read or use-after-free on a page-table
>> page
>>>> freed via tlb_remove_table_rcu().
>>>>
>>>> To fix this, check if xas->xa_offset matches get_offset(xas->xa_index,
>>>> xas->xa_node). If it does not and the node is a non-leaf node, set
>>>> xas->xa_offset to get_offset(xas->xa_index, xas->xa_node) before
>> advancing.
>>>> Also add test cases in test_xarray to verify xas_find() behavior when
>>>> iterating over and splitting multi-index entries.
>>> Thanks.  But the changelog omits vital information: a description of
>>> the userspace-visible runtime effects of the bug.
>>>
>>>> Fixes: b803b42823d0 ("xarray: Add XArray iterators")
>>>> Assisted-by: Gemini:gemini-3.7-flash syzbot
>>>> Reported-by: syzbot+b72767277f29b6407083@syzkaller.appspotmail.com
>>>> Closes: https://syzkaller.appspot.com/bug?extid=b72767277f29b6407083
>>> I see from there that it was a use-after-free, detected by KASAN.  I'll
>>> update the changelog and I'll add cc:stable.
>>>
>>> I'll queue the patch for testing while awaiting review input.
>> The testing shows there are issues with this patch:
>>
>>
>> https://github.com/linux-mm/linux-mm/actions/runs/33815757662/job/100847425973
>>
>> And since it's in mm-unstable now it breaks all CI jobs :(
>>
>>>> Link:
>> https://syzkaller.appspot.com/ai_job?id=a01c56bd-74d0-411c-afb4-ee6f0cb6cb61
>>>
>> --
>> Sincerely yours,
>> Mike.
>>
