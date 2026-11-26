Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657738;
	b=vj49Oodb+gXfNurMW3oW386A7jJcXcW3S/PKUe+BAjWKDjeE4bqy17Sc3YqhibwmiPSw
	 C0keYoiYllQSSMVCXxysBDH5YBVdcSiPgd/9oF/qWVm7giXD0/72uBQibVDAjgPb9Zhjs
	 tlOJxsZxeAzecUjwE3Z3pqE794TeRfnbQ1c+fumrlJqbefgAgghuqsoQGTIBYl8XvcrBa
	 7BpprM4pXmW/np7jbaCIvp14JkpUwvEiYrRc4TxbbNjxCmX58k5jKU8zWbI3BaxYjlvC+
	 DeGTKtc/WUoUpv321pElDWpx/JFAYkXNSa6GdozEWf81q2x8dMSpq6g8BIJKvMcxacQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HJrvEI0w4/nagFajlzLVreq9xJMwT6Dei5ExGu8K1us=;
	b=5WiymNvxnNUEwjnTPcOmlinukZaEeVQ/AFZWZ1cdnfDr2Nirk9D3SewPxJ9eWdx0XeAr
	 3YAlRmPhim+AqNfu54I2jvSkN21xcJUtyNYPbA0utk5ojz/bZJwCiPh1zaMbs0S3ywdhd
	 fjuI9eedDy16z8nNUuf3tdEu+xZ2v0S2Vi7CDtu0mzah93Y+aBKJjo+88rBwIqG9b6FEh
	 x6GPIzmxTsA86J69CLUI2cxx4dIX9lyy5iEq4pYAb0B6Ka9YTEn7TF3lA/SoBd4DivGpE
	 5kLNrSjd1RYrjrLHzAvPUPUYa5eyIc06ZrHpJaSENocXLUiiDbcTC1oUKF+AuUHwjbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=DetbId0m;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58C7606A323
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 01:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C58C7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=DetbId0m
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b5786e099cso4968182c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 17:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795657735; x=1796262535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJrvEI0w4/nagFajlzLVreq9xJMwT6Dei5ExGu8K1us=;
        b=DetbId0mZ31noCX02Hf6XnTXArek3IPwG4PAw2/ENsbzw9OCekMtR1hksjyZC46Asg
         TI5FiTXxbpmaZI6Ih9txi2Pksrhvhdr3bChuBfET+Awcx8eqAGMC1hshjjvxO3TkypTE
         jFE5+RxcZ2XwfK/NqIw24++6K3st72Ng61Y5bg2UsntjzGPiewITtHpgUuHGw4Vb6H/z
         csuc+sKylCVkrmFgrlEObPgstGi9TPpFHkIB/B4gT+V2RfiN8Zc2YXeW9l8sKD4XHjN0
         kzrMtm5r4ZGlrmyr/CdOSmiWjpQ+KKSGCbj37PEQOsJRjZc8sDctwjx5GUSkJndyNLD6
         t2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795657735; x=1796262535;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJrvEI0w4/nagFajlzLVreq9xJMwT6Dei5ExGu8K1us=;
        b=fh5qCz5r7wHggGgTo/jv46GxdR9CPrrVjT/Quqj3su1ApQ7duDPcXAdVxtQeCXr5Er
         s2A85OrEHvOGX56w0Sri21igTpyFqLrFtOn1/+IfuyQSkV2YZJsqz45RDVM3quybvbuh
         9IAaegX9KrNNU2tPtgil0+AKeG1RW0VpGZOl9pmjul+WaKL2RP0VPFfprsqtvITjKaT1
         tH31/4tPSgnBsGKmcBv7SIKwKoVasWXrD07O5nQH97WVb/aaZRXvNrzDkcAUWoozrpDw
         Wdiv8cOlbPReAaT5QdeODNPYYEPn2vTYgtWXB9N7SpZxEtLKz/P7I3rFblpSiEsUf4g4
         rKWQ==
X-Forwarded-Encrypted: i=1; AL+hErEaHV1Fp+3N9DeMNCGYkgxW5fExfCcoJk3eWwYdzD3GkOo5F4G4u9Rrq6hNO8m1jeDz4TQF++yh4u3vtQ6v@vger.kernel.org
X-Gm-Message-State: APuU4Z+joeymtrvNRdwbOKd16WAM9tQJI0LTV17gp4pVrxrErmbkbjrC
	4luhGN1oUm5Zl4DhFi+4CD/80yZ4evs01N4Q+c0F72NaD94Qbi20Rwd5zJEKj1m+2hs=
X-Gm-Gg: AZFdTZdQ3DaxEMj1ZcxWeKG6DvlekE18JvwFdAX6HDMhOModywXS8hGXI4SqhFX9Jzc
	C52McdY8S1qaQjnQOCHjcsSLQe00beIns5DuxRCYX+7TsD1Qsllf8KmISk8KCjFgDRCM3SWa5fu
	0G0z7LzGAR3pQFcoQNW9gls54NrSUHWo5jjbQSpUgkxql9M23HZLA8Pe8+Nx8udeHmgqDCnpWYV
	Xn9pU6YrUw6P6xZ83Y9/K8avPI/QIR2xhu8P8zav7Nblkly6GBNtFKPIdz/Qd4sW++5g4/cO2kC
	Hn9/6vCyCQoRd2Vs23VhKwGoOWcj/MzJU/hWENwT6GHplQAdJSXArhuTfMU0TnA85agUorvuvxr
	vLWEnJ1WiKsW/G4uQQN/dk2a+P+vMYCUxGaLAh9wu916jm1ZSHrmieIJKn4TjmLf2nThaDi4SYc
	fSGJPLKCPvQtUaF+tEOBgEqAmNitq30suJpIELlcIVqBtz/Z4nC+FcV9xJmcKjpOfzeRvk8v/Pz
	QMwn0GCEGKfn7qa7f3OPIkaqutxt5mGsFqqa0ENq1g4fCu65PAHEhSstLtcHtHfsSYobtZknl+M
	PBJwdS569JXlV8BuTK342/5+MoF+hT5kbuX6AGoqQzRdcj6Zpa0rAml/WVuQrRbVLm2GaQSKQdh
	zkg613pdtU37zLne0yYjJguD4Rj53CnuYBOrnSetHTi8uW454JQ==
X-Received: by 2002:a05:701b:4583:10b0:1b5:5915:bb34 with SMTP id a92af1059eb24-1b55915bd9amr17158608c88.4.1795657735413;
        Wed, 25 Nov 2026 17:48:55 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c349csm60595886eec.22.2026.11.25.17.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:48:54 -0800 (PST)
Message-ID: <6bddb1d9-fc18-4308-8d64-73705254733b@kernel.dk>
Date: Wed, 25 Nov 2026 18:48:54 -0700
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
Subject: Re: [PATCH] io_uring/openclose: allow an empty path with O_EMPTYPATH
To: Jori Koolstra <jkoolstra@xs4all.nl>, Hengyu Liang <hengyul@cs.unc.edu>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261125180817.3682397-1-hengyul@cs.unc.edu>
 <170898867.2781789.1795642036410@kpc.webmail.kpnmail.nl>
 <86fea5ad-43d5-46d6-b2e5-f93b8a6afb8f@kernel.dk>
 <805466896.2784291.1795644146928@kpc.webmail.kpnmail.nl>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <805466896.2784291.1795644146928@kpc.webmail.kpnmail.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 3:02 PM, Jori Koolstra wrote:
> 
>> Op 25-11-2026 22:47 CET schreef Jens Axboe <axboe@kernel.dk>:
>>
>>>
>>> Reviewed-by: Jori Koolstra (CIQ) <jkoolstra@xs4all.nl>
>>>
>>> @Jens - You've pulled this already, I don't know if io_uring appreciates reviews
>>> after pull. Let me know if not.
>>
>> Always appreciate that, the link is in the commit too so it'll be
>> discoverable after the fact as well.
>>
> 
> All right, good to know ;) .
> 
> I know Christian does some magic with pulling in the tags even much later,
> but I don't know what he does exactly.

There's no magic, if it's in the commit message after the fact, it's
been rebased.

-- 
Jens Axboe

