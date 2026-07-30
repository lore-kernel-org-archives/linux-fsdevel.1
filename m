Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0879E43E49A
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429166; cv=none; b=mIXcbYUXI1rbp1lrALPIod3Ee40XDp5AepwupX0vPt4ItLKFd4RjQxj6U3+JMIwuZzgsfnO9T/ZeMhV8FasjiPK+VbHYA6IYN1oK5zsvAdLfPHWggPniWJlqOINsFyFtZKd8VU+Ov4hZj9M7EXvJNu9J9vZVYRjUM6mHGy0zOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429166; c=relaxed/simple;
	bh=9btGk5f2a/DceEfPaKkNA5+Plv7jzRhDTY3TO4vi+kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JmI/Q3gkQWy1VQh1AwTKeK3melaSmsh/LvZy0Uo6PzpsVXgITOsoVD6iIbEaUXEJffF6VscTDrfwhIhwjBHqZd4xQvhnTbSrfczxaHo7B7fbqEw9ROeSSBOZLSuvFwDPDSpdQV/iLmET8/WBRRn/UNerp2yCUvfJ1v4Pc6NXg5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LupAejho; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LupAejho"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb64085c45so25891a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785429164; x=1786033964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5C1EvvuLAlRHXA30Xxb4HI1T4XzyQlMzu71fYbXEDfw=;
        b=LupAejhoSWQSMcTguID4LkXupjL8lz8kU6zgSQXLMlpQ/6mSg35/KNvzn76jnPyTNg
         +C+qViZ7AtLW5Jhw3FjrFXUhe3GGVc4bsgrGEsy1edhrMTWTjoQDN3Vq+dlFuo8n6lKb
         +swwtcA+idGA5OpZfKzfzIlW0iyGbhxkt1hmPxLSThELq76uovoTt5ny1qEfknUWcJr7
         IesC2xFsOs1e2VLIcHOA7AcIk32KWOBGL6Kym/0Mbt4HJaYkGbrGxYrpXl38k0pVZxH8
         na5VqEQbz/vNCPheI8MufSCVUtRcyyWGhT8uwVvTqZ6exYCeuR+B/BjAoFBaWSLpddIg
         T/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429164; x=1786033964;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5C1EvvuLAlRHXA30Xxb4HI1T4XzyQlMzu71fYbXEDfw=;
        b=ptRs3FfXY+boCNH5KL6i3Vpp78dH51Ns7p26pn6+2HyItv6D8YFrBcgQzROLfFrMCH
         xUxguZhLWA8aDhzkCMOSYnpOvkjdDxKQrgF4nfLz+f71ye75rCsOa4mm5jbyQjgFRA5b
         582sYkbJ4C/aMGz5HTc08nakuCOeIJX1m8z4H1Dz+A6V9MiOsbVPQixReAY1lMWD0HIl
         rjYCJaqBZL2/lwbcoZOmnJgxETBRN7P9zkID2dULKetpjAyLmFbf/qRUzo4lz51wkf4N
         4KfI15bFp7Jn5hTPnAbvCNsILuoUYSun0DT6zftJVv8kpsF5MyMYSB+Ur+7ak+Sxwbea
         Jekw==
X-Forwarded-Encrypted: i=1; AHgh+Rp+euDm+5CwUKi79bdidBScdZ7kJTdL4Rzfbr39Oj8QVzojLiGdZm0DG6vWnugiYzlBfFgZ7Eoahxbg6r9L@vger.kernel.org
X-Gm-Message-State: AOJu0YyJfnU+WaneCZmqYBUCjl2+MfA2NDolnTCeWEbUe5GMUDXjXeRF
	QWFLp3M0SFWCXDys2QwjFQCtt9znA1+icyeW9vuCEGS+O5snT+0vBZhf2Oy86RtsLi8=
X-Gm-Gg: AR+sD10UE3MOMIKL5ng9d0a9mie+m2fdX12suX7Co7/Dn0F7cCT7zy6xoY4LhSjeE1d
	z+Wc02cXfxBWxo5PDlQYfgiCWVb3IB6bJgJGVxVg8ePDckp7djIvsBiOkUuww3kKSqSmEZ9UDzD
	ME2Q2hL7iMesefAJXXA1BtYMGRypYu2ZzQZXDRFILtxkL+PbZ9721wY/zCEsolA9aSyETTQ4FQU
	d8VJ7crUG5mNAkICWexRrn78RLp/ASKC4ORM4I6Vei5QJEjO7iUX12umrvAxITz2ElJZLvj/Fol
	SXJkyuJD79J/FF2Ji3AGb+aYbgX6rha+ZwE623t82AFSaWmGjzTzaJz/+nWe3SiqRK5ZvCNp501
	nwSEx3o+quw+YDLvKS66a341p9xoDBOni6Wty3iRTf1+Eo1tAJeG684r6LQMKnJM0zPF6E2kNaf
	qPDmg5BmeC4zVXTE5IpfWeTEY+6rIvHIOKVhVZ2XbWL7EMmihlqdv9fK1ryW4PjN6YESE4tgTKv
	rgpiBpWv9Y0s7Gj9UBVpADZO9cIOOedeC36euXYGLLNtVuK8/FnXf2uiA==
X-Received: by 2002:a05:6820:3091:b0:6aa:4f21:dd20 with SMTP id 006d021491bc7-6acbc1db6cemr1962089eaf.64.1785429163783;
        Thu, 30 Jul 2026 09:32:43 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f00d8df72asm5110588a34.13.2026.07.30.09.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:32:43 -0700 (PDT)
Message-ID: <3766c1e2-bfb7-4c62-85d1-3cd4afbe289b@kernel.dk>
Date: Thu, 30 Jul 2026 10:32:42 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] io_uring/epoll: disallow adding an epoll file to an
 epoll context
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Xi Ruoyao <xry111@xry111.site>, io-uring@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, brauner@kernel.org,
 =?UTF-8?Q?Juan_Jos=C3=A9?= <soyjuanarbol@gmail.com>
References: <20260514140817.623026-1-axboe@kernel.dk>
 <20260514140817.623026-7-axboe@kernel.dk>
 <605939add4dfb674bd7ab39ef8dbd3fd22e754e4.camel@xry111.site>
 <427b15c8-c168-4e2a-ac38-b00dc00400d3@kernel.dk>
 <CAHk-=wjeSgFEr3WSO1C1sPP+fy+Mt5_EL9WXW-s11BOhD_S5Ag@mail.gmail.com>
 <a50c6a4d-5c25-4cbb-baac-f622728f2693@kernel.dk>
 <CAHk-=wjr6LoL+k1J076cSvRHVOdR5Wvh2J1HbwZUQ-BY5vxLKQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjr6LoL+k1J076cSvRHVOdR5Wvh2J1HbwZUQ-BY5vxLKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/26 10:29 AM, Linus Torvalds wrote:
> On Thu, 30 Jul 2026 at 09:25, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Exactly, no other recourse here than to just revert it. Unfortunately
>> my io_uring-7.2 branch is from pre merging of the epoll changes, as those
>> went in separately. Hence I can either prep a revert for you separately,
>> or you can just revert cfa1539b24af yourself since you have the context
>> as well. Let me know what you prefer!
> 
> If you have other things pending for the next rc, let's do it in your
> tree and I'll get it through the normal channels.
> 
> And if the answer is "no pending pulls for rc6", I'll do the revert here.

I've got a few patches I'll ship tomorrow, so yeah let's just do it that
way then - I'll revert it locally.

-- 
Jens Axboe

