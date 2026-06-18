Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BD23D4119
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796301; cv=none; b=l84PJQVEon33hnubIw4u6WDmaS3//KMJMelu2U7QUI6DoV3RqmNqXbcPlOZxEVIYMcjo6Q6+si0nDPjqJnSwj7LXO6GwsFWAx6GM+y0/YeSqI0E5EeBx4uWXn85cnk/BjaDIxA8jeNROwPdDvhYy3Escd7P2HBIMAXeCzRy+iek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796301; c=relaxed/simple;
	bh=ZfPLf442w3sL0RwDvNRk/yFGjnO35Q+6suC1CWmYzDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/Umg5KXvip5tejLpS3RAorXmWcC6eIDq51t79BbEje3XZuHDUyLsPXK34HKkNrDrcRpXfxcnJ/kHxd7nAInH/VFasJF6sTzBNSvYMCgM5LSqHrDiNNEZ1lwh1NkE4dzH1XtGrHoBc/XgRyRVEs91fIxmfQsAKHfPzcA1Dx7nQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hE/VNCs2; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hE/VNCs2"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69e8aa31e9fso571690eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 08:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1781796299; x=1782401099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBx2MJdHGb6d75Q1J7l/vf2fQDboake9HxhnnU/k+eg=;
        b=hE/VNCs2VydPoKqwaY0f9fOjiBb+Hf/9lINSfRojO12P5ZGpCjc2nCzC4V1oIj7uy+
         VLhPXhy60a49UvRzLjcTZmmX5fXOhVs4cvr3mQetqIA39rubyfMpha6W6Ofb5gwAJRk3
         W0cI8USeulj5OZpjQF07FA8Xzg6TD9BfOvfAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781796299; x=1782401099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBx2MJdHGb6d75Q1J7l/vf2fQDboake9HxhnnU/k+eg=;
        b=VGZ2iD59UdBgIS9bXpvSGMy0pflkUh/sXHMAsSoP79Xu6/rRCksEIQqEoKiVqWSU7A
         GOx2oWqbGZtFwF85V1IWIXedbjM6+4pNULxcxOvo0/yz7f0yVGJvhIcjth/PV7vukTGx
         k1FnQI6PynS7AuaAyHkk70oTYtYLMwBjmlbBHUiAGtyJBMZ15RViW2D5F/VGobCdC1GK
         ipD69XUTDqXmQD9+MOi95+GciKtTyecub+NVOT+lw0W39oAIcLCsS2TAeXppKOyPY4Iv
         TvX1MYDwP26L2Q6HKLKv721MmV2RO0JYI5bMP1/Z17Bdq3WqVEBJppKuvAwvJYhO+Jie
         f0Pw==
X-Forwarded-Encrypted: i=1; AFNElJ+InHmzdxyUCrX2bQvV27uMZaAvPjzIHF4LDTlaUEK8XAxI9uu5InzpnEJww4Rd5bUWkbtm+/m1xa+kBmN5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbplvpa7reljxTwDEh1J5d3vcLEfCr741tLyM6yoJwz7m05Shp
	3vgRVgnMSjhHgy+6gmtxvvMITZczXoY8v9xRcqk9bcvW7t65OwebLEzVUkrZ39lMnhQ=
X-Gm-Gg: AfdE7clSw9YFTBAfAnwZ8OKeCH88WE5XLNSY8KpdJwIrtyIhDNYipk1ZRX2y3MaJrZU
	h9JwnsOqT7vwitjkgxWe986CbYHVzUiVibBU3Z/g8P+cRwfEJ+pBUXsPTW0YYkgDdbR4uTXubxm
	QC8w0td7hy1iq+x/NEuqAJ1npTl5TYFsZ760SqSDBOZTPtFfIHhIl9cFfy3klBVEZMBlbvYWnFA
	TeM9Jn2WSbKo39gkB+kNyq574M7qz7bso+FQNXv4trce1XdyaNQDEboDr1U3cW9ZNEhln/R5L3w
	aSfbFnskYRaVFeSqDIhiTLXQGKNgH3KduNTgs/GKHn01gnsPo5B3DEF5rsICzeFVWjVCPx/GUfQ
	APsb1c4JCbYKLi7144dzj5E7TC09HoHvXQdqepFRP2mHE89O2umGW4DipZCdxNPXnvS/M5zrdwC
	AWHaPAB9pTvhh9SRrG4j83
X-Received: by 2002:a05:6820:174a:b0:69e:2e0a:58dd with SMTP id 006d021491bc7-6a0b618d9demr7357214eaf.38.1781796298724;
        Thu, 18 Jun 2026 08:24:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00b41ed1sm9150146eaf.0.2026.06.18.08.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2026 08:24:57 -0700 (PDT)
Message-ID: <16ef9ff1-4c98-4c89-aefa-734a9e775df2@linuxfoundation.org>
Date: Thu, 18 Jun 2026 09:24:55 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: proc: include fcntl.h in proc-pidns
To: Amin Vakil <info@aminvakil.com>, Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260618151444.124739-1-info@aminvakil.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260618151444.124739-1-info@aminvakil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/26 09:14, Amin Vakil wrote:
> proc-pidns.c uses open() and O_* flags, but does not include
> <fcntl.h>. This breaks the proc selftests build with errors such as:
> 
>    error: implicit declaration of function 'open'
>    error: 'O_WRONLY' undeclared
>    error: 'O_CREAT' undeclared
>    error: 'O_RDONLY' undeclared
> 
> Include <fcntl.h> to provide the declaration and flag definitions.

Did you install headers before compiling the test?

> 
> Fixes: 5554d820f71c ("selftests/proc: add tests for new pidns APIs")
> Tested with:
>    make -C tools/testing/selftests TARGETS=proc
> 
> Signed-off-by: Amin Vakil <info@aminvakil.com>
> ---
>   tools/testing/selftests/proc/proc-pidns.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/proc/proc-pidns.c b/tools/testing/selftests/proc/proc-pidns.c
> index 25b9a2933c45..6f7c10fe97b3 100644
> --- a/tools/testing/selftests/proc/proc-pidns.c
> +++ b/tools/testing/selftests/proc/proc-pidns.c
> @@ -6,6 +6,7 @@
>   
>   #include <assert.h>
>   #include <errno.h>
> +#include <fcntl.h>
>   #include <sched.h>
>   #include <stdbool.h>
>   #include <stdlib.h>

thanks,
-- Shuah
