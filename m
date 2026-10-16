Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB0836DA1A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159296; cv=none; b=tcPUXvf0wwA/KzXghQN/v50LAJORbAkRBMWsMdmcgSv+/lxafjp/8F35nW8wI+X+NhgNodj/qWWJnFzoQimcATT3XNrvjgXQ0wZ1UbMehKc+1kW59D3cxrIaqzUqd15uh4zG0jrWu/Sn7GR2k/wmmU1NAd8u4rxeCTVxC5TsFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159296; c=relaxed/simple;
	bh=qMGCJljRHNHuiGAwwogk7MJwQxMZGKK+z87yiVyWXZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChnIzhnTgVEX8Bi99PZ04LJSus6FCnyRjOu1jJobAS2RBJS93HdcsoVN13TDZS2n5Jps3YSKIx0wW6lxUK7oOe4oD+cXcwUIjeambExey8i6ytch4aLr2vlOpF3JrVIVELLR6nJ4P0VrrmE6/cXUlZrIUEa+Z4x0z4GsNhrgcIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6OjQxpV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6OjQxpV"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c3fd91337baso229022566b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 07:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792159294; x=1792764094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wxGWmSdkmPud9BnnFVh7MsFjXmV1Yjo8qVCjPSX+tEE=;
        b=b6OjQxpVoOOMmBaOMZ0q+N8cKTPhxm8JfQHxg0ltKH2zuTLmfSTKh4KdnNTHSMGOth
         NgZ++G7TKFNU4wE+JzvG1RjBYjOnVRI0Uoh8IY8WQ4UFKrG7t8WaQp3zOML13BnEYr3B
         L21oBcQgm5DNx5bLXg/4xCt4F76SN1/fe5FGvg+xNFrxOI11Gda08vU6HgVctz2kpBc8
         +hpFTqzoK+zJeR0ONh9II96a23ULHvL1AhWfxZEZ7a8mhrhbDgoKhQV2ipetp/nyfwuY
         vQ7K7W96vLWvL3qXlikwr8t93pdrm7o34gLyNwcULmw19b01pR2uGeoNe7ktse4rgnam
         myHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792159294; x=1792764094;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxGWmSdkmPud9BnnFVh7MsFjXmV1Yjo8qVCjPSX+tEE=;
        b=o6aNWW3DV7aPGDLaW46muzdSO7upIwyf2yWlIjVZPUI+R8BmgAPD5ug5qM/ARVNZ2Q
         3rzaTzQ192Uoel7vNjfwLVPJNseu6iXlTc5ikVL6eWeZqDzG4bjOXkhteYi9BsKdFRxV
         /BtWqtVuqd7AWNTYlvm5r/neZCHHd/QguVjGJXyEcZx+B844Kj5ZDG8j6E4WAZn4VbFh
         lIUeicMQG+bCFW+O3RegyEB3/G3bd3qPT4BiUF+IpBM1FQIKCFiaLzvA7bpipzXgpjIP
         2MMJlfCQxNEvUYgzNuN9Sek7f9dG8dI4LF41G6LS26OTDfdi8M9de2KIt9XC6QXIedJI
         Wy1A==
X-Forwarded-Encrypted: i=1; AKwUvBzhub/tSKj5QrOPUcCNQCl5OSVWyh9mdJuB7D/8tDIxPMmbm54jQy1hMy0YNV+tCQrN1nYlEzN4KXmQceTV@vger.kernel.org
X-Gm-Message-State: AFq9FYKjpocbL927mt7H2gZ4maJ7of+EnV4b3t/gdkNVdud/3OIt+y1e
	Oys8U6HuhSTR3kHmeuyvEtVvECk8Du+JoHAiyHqBEalLdeJSJkH0gGnSFGMnZtRHr6Rz5w==
X-Gm-Gg: AYBFou2mEk48DH9dIoNGsKa03P0qkWnRUpylrlYkMguSYoyU8xHbCfC92Kyk9/GY/11
	Mq/fAGWGnucrpqA1sqFHhEkt/fdEJgkRmVTm6gUoi/hcOCkJ6U1BUlTv+oTEZl/lBw5KvmFWgXc
	DK9PlAEayFtnqlilKgIfI2EQD14sXk5SggbA+iXNtkDO4P2gmoqXHCpf54hlG04YDhBBt4Q0umu
	8266xnTbDyqFjpA22cf1OmPoQZGYiEwXt6crXFBoOraB6aecauEelh9Q5T+PvEqjKDEDhbAiGHF
	JX36J62OSGvOJUlZ9teJ0LylEsPhUJ+F92rUpoTu1qo8vTVmYnizVPU5lAFM+xvblCbDPKZgqs0
	le0v3oukmn0PHEiTzyxVDQKoIPfCfK47EqbdpY2CoITfSpdVacRJrltUaxzqVoytdbXfAc71ICo
	TOh8H2GL36onXagKYKYg1f0vjixHrTjJjRiy+rmU6CfmE83B9sf5GWC+tOhIOjCYWelpLVWh90p
	UVD3R6z2Nmzb8wkUYfp3LpA1mYHLayxwYgcHl5twcSG/G/6nwj7y9CJv/Nulvd7ER72CeVGa4R3
	zSpRmhDtFfXC0m6/hotYtLI12XeWRRjhkrT9g/5bPuH42I1QP4U/xQMwXVmVN6e1sZyiX+XP8Fv
	Q3VYKQX9qGkoBv4T3W69ld3qWXOsZFL3BYQ==
X-Received: by 2002:a17:907:6b0a:b0:c41:8e21:4d5a with SMTP id a640c23a62f3a-c418e2156bemr5228466b.5.1792159293084;
        Fri, 16 Oct 2026 07:01:33 -0700 (PDT)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dd124csm74417366b.28.2026.10.16.07.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 07:01:32 -0700 (PDT)
Message-ID: <f9b27432-4104-4323-8cd7-e2cda73db2f9@gmail.com>
Date: Fri, 16 Oct 2026 16:01:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fat: make rename recovery safe after metadata write
 errors
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com
References: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
 <20260929090029.742579-1-krystianmkaniewski@gmail.com>
 <87ld8j4161.fsf@mail.parknet.co.jp>
 <1f18819d20c92960b8b2d6ccc8bc4506d346150e.1790779353.git.krystianmkaniewski@gmail.com>
 <87bj90m6dq.fsf@mail.parknet.co.jp>
 <20261014082315.190262-1-krystianmkaniewski@gmail.com>
 <87qzhqvloo.fsf@mail.parknet.co.jp>
 <55a1f016-a7a2-469f-b481-37223d695f29@gmail.com>
 <87cxt921rc.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <87cxt921rc.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/26 15:50, OGAWA Hirofumi wrote:
> Krystian Kaniewski <krystianmkaniewski@gmail.com> writes:
> 
>> On 10/15/26 20:54, OGAWA Hirofumi wrote:
>>
>>>> +	} else if (!rollback_err) {
>>>> +		/* Read the entry block again if a failed write invalidated it. */
>>>> +		rollback_err = bh_read(sinfo.bh, 0);
>>>
>>> Why do this read the bh from on disk?
>>>
>>
>> The bh_read(sinfo.bh, 0) is needed because a failed inode-position write clears BH_Uptodate. fat_remove_entries() modifies and dirties that retained buffer directly, which otherwise triggers the warning. Reading it first refreshes the whole block. If the read fails, the buffer is left untouched.
>>
>> The same reasoning applies to both the VFAT and MS-DOS paths.
> 
> If sinfo.bh is required to read because of failure of I/O error, I guess
> the bh will fail to write again. I think we should give up to rollback
> in that case.
> 
> Thanks.

Thanks. I was trying to handle transient errors here. The old entry still exists at this point, so if the read and removal succeed, the rename can be fully rolled back.

In my tests with a single injected write error, giving up left the new entry pointing at the root directory, and fsck.fat wanted to remove it. Retrying the cleanup left the filesystem clean. If either the read or the cleanup write fails, we stop and report corruption anyway.

Do you still think we should give up here? If you prefer not to retry the new-entry block after its failed write, should we also avoid rereading and rewriting dotdot_bh after a failed .. update?

-- 
Krystian Kaniewski
