Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CEF36B046
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970673; cv=none; b=Rzxzt3fAj9sne1Hb52LX/64iM3AGK5Idueb87C1YpgeoH3Man8pK/FQSprpmelkk2mFyhxPfy+yqA8VxK51At8TYJV+0HlTnIJUQoBQ05/xg+rROz57EWNr274DVndsJWiwWzRRu1REYu7Xq5+uPs0AnIYnLp771sj8RShAHojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970673; c=relaxed/simple;
	bh=ldSTm4EWaCOx+pwbIQI8ZcZgJB7UuIot9wRDbRrsEVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c5QztHriEHnWW+RbHk1dgWyiU0RVrr+fTDXpM9tarG9a8kWmGjpGwpqvWuNysaOn1xuLGZlGzM81XA869kTbcgG5Z2slCiXsTtwj/tn0vw4aEmvI1P7q0i1G6QH2TmUQdXWM/KFBMoLqunb1x4iEo9yrf901Nwb0XqyyymLEufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QMY1/BbE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QMY1/BbE"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7e565c877so2838277a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774970671; x=1775575471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NKPrNSDcQjGjdl2sN+7+/jouhXcRgam12FF4jGlIj3Q=;
        b=QMY1/BbEPjWKzbJNoRxdHsYowhSNI6nfD4sqrYj+YUt2JRoxnth/LHjpUbY8iBc0mh
         Cq9VdsWK8hrDST7u3zNtMpVCNevvGuUwmzh/WazI/m+6WsBC+/7JXPw4Cn2XW+RRkCD+
         3I+CJYwr1lMpqcCqq+0DjQ0IdcPDeL4bMJILdcBmqWjDuN/p7qnPUnNWzIXP2o6kVE/x
         h9E5LBkCIHREFzZFuniZUT4HQQvQxV4jNqcDGkjMHwgYkjHtmVF4JWnJyjdDupCz/FNM
         scQCmN2/LJQF59Y+P37kC0a6/BA8g6XeDcAWmxbFNuG4nNnFNlPM1t5VVnut78ofFwQR
         mpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774970671; x=1775575471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKPrNSDcQjGjdl2sN+7+/jouhXcRgam12FF4jGlIj3Q=;
        b=pFsFpPx+oiHYYiFZfc8WyF6KfB8fg2vKBdFgzcUkZ8OAKpw/zM4YkmVVv3NfJchF2q
         OzJR/nDxDZB2lKFN5HswudZHdxmqcoPIzhPBYjnR4sIzoAgVmt/vwnCFEHyfaWKR2swm
         9OPQPQptM5lMDP9Vsg1adK2aHKWpcxCwGcDPJmBU+dTEx5F4EpN0erKK0T9cqFuHZL0z
         8ZfySYnQWX/sOaiB3tuDgth+VNILpEEoqIffZmONOlCtNObg6cxAzlKLPlnS/fqsgbVL
         d7Uv7BXSUhYuJoyCnX58mpQnybnUBx3vlfx9kEmWDM+l8E6tflgmqYDBW03cB8zmIEVd
         R96g==
X-Forwarded-Encrypted: i=1; AJvYcCWS3A6sxMrqPPv2Ll9+IvIVuB623zuzbvnT7l8NE/QWlSUyg8sr3DOCIPQdYy37ko9HGaQvCAajbXSLg3VK@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlmZmYQ3Ff1cpp8P1J9jhjo7C4IKVZ6YRzYUBjkY9FhCTpyPF
	1CYDlNnf7gtA/ZwiZ1MwtWS1i1o582iPYDx+C370/GSR1J8xuOJbP6QkflIgshYjdjs=
X-Gm-Gg: ATEYQzwsTtz5lHMpLyfpSynpsFHbKz0XGiuZmogve1TK/5I1f9aIVd5VHenI+M7JvjP
	NpV94jYeF4ragdPtgPwZ9Smi9vv7lkFxOKGab4/vTmhy7ut/xr0/GFzfO/djAIJdwzgPIKsFyKE
	fCJPptDfO89Y835ktqcxTGnPgEc1f92D0l3u+T0g2ElJ3VZeiIQsXPO1VqhS983dRBLytTbJnVp
	XynkU4YCQB12aBsGXQ6u3381btyQ/3EuQJwbodIB7TYOvT1OsZnUdaaRChP4rqKW76prULbDFdS
	DuLMfF9qdY8d2tzicNyp+M6G2XCwWA0xJMCAO4csE7mbEwioGmF1vgRLQpj84ZGNVO+a1cF2n6O
	2dx/Jm1bGbMs1JxglQh3BSAx/JYIt+IZPmQOXGpLSN7qXPQC9yt61s7ldAcSs5rYmZ3yp9LLAtU
	5MuBGLlYsG0QQqn7sRS9dR+zl2nZv6W7crdgZzs2bLfnQNnyh1pVQ3qpjVmv3QiAiXihNVM7BYh
	Uj8Y2XaVeuBAu5cuWGF
X-Received: by 2002:a05:6820:c85:b0:67e:3bed:5b7c with SMTP id 006d021491bc7-67e3bed5cbemr2787017eaf.38.1774970671007;
        Tue, 31 Mar 2026 08:24:31 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67e2302f591sm6995602eaf.1.2026.03.31.08.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 08:24:30 -0700 (PDT)
Message-ID: <26d2e8f0-8b82-4192-9edb-e31f3975bb82@kernel.dk>
Date: Tue, 31 Mar 2026 09:24:29 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
To: Christoph Hellwig <hch@infradead.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
References: <20260320130615.1109449-1-kartikey406@gmail.com>
 <acvkAuq4_cWmegC7@infradead.org>
 <fa551c4c-7e9b-47b4-9011-92adc880ed1a@kernel.dk>
 <acvmXDBm1xOak_Uq@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <acvmXDBm1xOak_Uq@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/31/26 9:21 AM, Christoph Hellwig wrote:
> On Tue, Mar 31, 2026 at 09:15:07AM -0600, Jens Axboe wrote:
>> On 3/31/26 9:10 AM, Christoph Hellwig wrote:
>>> On Fri, Mar 20, 2026 at 06:36:15PM +0530, Deepanshu Kartikey wrote:
>>>> Fix this by checking if the input and output files share the
>>>> same inode before proceeding, returning -EINVAL if they do.
>>>> This mirrors the existing check in do_splice() for the
>>>> pipe-to-pipe case where ipipe == opipe.
>>>
>>> While restricting splice to be between difference inodes sounds like a
>>> nice simplification, I'm not sure we can add it 20 years after the
>>> syscall was added.
>>
>> Well if we could break splice all over with:
>>
>> 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> 
> Well, that had an easy way out by converting instances people actually
> used to the iter ops.  Which we ended up doing for a few.

Sure, and it was the right thing to do, but you still end up with a
broken kernel for that user. Until it gets reported, fixed, and bubbles
back to a kernel that they can use.

IOW, no different than this one.

>> then surely this one would be OK too?
> 
> While this has no way out.  Not that I would complain if it worked,
> but splicing into the same file doesn't seem like a too outlandish
> idea.  OTOH it probably already didn't work for file systems that
> take i_rwsem in the read path like XFS or these days the block
> device node.

There is a way out, it's reverting it. I'd be surprised if this didn't
trigger issues already, like the flagged one.

Thing is, I don't really see an alternative fix to this...

-- 
Jens Axboe
