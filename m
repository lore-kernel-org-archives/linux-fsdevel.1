Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF23AE6F7
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702174; cv=none; b=W9WyvDvmUEzG/zeK7SvLr7tNmmm2wic+o+MvZkn1wtyXNomER2DKBDtOGX3ugJoCfet88Rd5h5DkMGqTKRbVJS3FFd8sIRlIQ+HMy8iRb053KwJurlI2NwAhEsX/ou0BaQVCIc6MS8YJ0jaA1zyt7NZjHFcG9QrYpmqttbey/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702174; c=relaxed/simple;
	bh=DZwcPmH+04E4hEMYfZxmWOphebXi2TK5M+0gKLhYoho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CQZmSCYiy/Vz6g4Is0It9pZQERubnTlsMqnAMt5nGdABcSrrYH0t33Dg9Wk3qAp7VyccpYXJvnjSAX0yHRYOMd3XKCszYCT+nuxA+ZddaUoqUzL40H0ocy2T3J66pmNE7RU8NbbeE+XY+MV6kUhlTiOA8kHgleuXsKjjkYSQgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=f6Pt21f3; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="f6Pt21f3"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6966f99716fso3766802eaf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778702171; x=1779306971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=krbyiVc8jSJdhIcgAt5f1amAPCSUW93oLBkGCtEucHU=;
        b=f6Pt21f3Ba14Ughj5nW6FhvEeVxnfyxR9Hfd9N7qfBD4kWEcfzBLegRro2xaxCtbp1
         4TEoU78u9kP28JeO9U0b8EcJsREKriT3MhAY0wmftebymQVxymEiXhRfPXSHFih4UZ0v
         NKdxQz6d/Gcpy1N+ZW++VET0zyzI8kGSKr0chlV0oQCAGSlmfIRglFiX3+Q2QuiyoiA/
         YzfcMT3DtoJcyUtulPMnUF7dCBTrkTklahLRCYunTq0esIWG+yJ14TQbHoz6U2KgOpUC
         mBWxUlVHn2a6ztPjnlaFqb31OFSIOAgBZs9PPmQTBx0tJ0uZJO81Y1Bh+1IiVQA+kjsQ
         jNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778702171; x=1779306971;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krbyiVc8jSJdhIcgAt5f1amAPCSUW93oLBkGCtEucHU=;
        b=SdiUYEGYzkx6t+7hnTPL0YkxfOmxCiTAnO6qyMwZzU8LuDCMOuwzpyjMVEzNVEJdk7
         iWQWTrsrn41qVxu/2kr4MPDtGOsmlRsnBmjCLi3iP/q266k0e5oUlrlPkXGZrYtxgIUF
         5JR+2WNX5Nlcz95r915l1I1j46s/aFE1GI4srCrvb4akfaW8pQsP/CXJNTAaskT2NKQW
         1BR6MuyF1fs3u9VOS+Np1simRgR9KYbB3HYKZ25lDdxLsF4Gsv/XnMZ3sTom0kXPNGh4
         ycbQNZdOsqo05vqLU74TbIyGVn++6ZwaDILcoobW5kDHVcw5Fo+2+Vo8vMz01GTmyYfp
         pZPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TI8QLDrQkWrg7xflzUN9xwpoLdsQW5gUp+rHdaDbLsmMR2kEt8Akv3Zon/yvACJec/TyYYhM9YN4Xb61T@vger.kernel.org
X-Gm-Message-State: AOJu0Yzia+CJ/VfHVnbK+fn0aBCAviM5ALY7c2IDKJrrTfDD1Wk9JkA3
	u2gEX6QwOjR6g9PTBNZNBzSMDQN7C8yY5ShU+P8F0TT8XlkBoHavLdPSsuU4Ja2V71Q=
X-Gm-Gg: Acq92OHYna7RD0MltvCS7pCXG/ul95O9OJvrS4FHkS+86FI74Fi2MoJXZNY7TWOAsKk
	H9/Xb/aPwjfsAtmgVPnJfN1HYNzUshZqtNN/46Zci4Q6jM0srTzbvHithAxrVE/pyEdqNLzaoby
	D8GhZzX8v/fDb/2CFbQ4hBhz/k0LFTxBEOrVXz0QmSBwNThnFWVmTcxrBlzYUXgv2IO1qa9hpdQ
	MIW6qwqjv2vTssoSlWLgKQEv9fWFKi9kR8Mc6y8Kvm5DCej1V2VjEdqLlqh4ONjY3amcANkieJB
	q6gCsqWyczMjMvc19vLNn7Q870lbQNj+DGkJG6f/Ui+hNgkIJ7F7z+XDkP0d9bGOD55o/UNewLJ
	vmiQDtYV91FRZahUeLgugY48ouwqj2mVBBY9ewVqJbWw4A0Nq0mZmh9ddoZiyrE1Gzlv6oe39xj
	PyrSdJT7olkd6qvBGvIcgY/TkcIp95t09hFUuY+jZVWBaRVNkOiUF1yvEStxqwWrT8gNTiVrRCV
	A9AspFF
X-Received: by 2002:a05:6820:152a:b0:694:9a67:edf6 with SMTP id 006d021491bc7-69b78d81c1cmr2797284eaf.17.1778702170672;
        Wed, 13 May 2026 12:56:10 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25cb58b2sm10339019eaf.8.2026.05.13.12.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 12:56:10 -0700 (PDT)
Message-ID: <30acedd3-e994-4810-8952-613b7d0bd9ca@kernel.dk>
Date: Wed, 13 May 2026 13:56:09 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fix block layer bounce buffering for block size > PAGE_SIZE v2
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Pankaj Raghav <pankaj.raghav@linux.dev>, linux-block@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260507050153.1298375-1-hch@lst.de>
 <683792db-32fc-4765-9ba6-3712af01676c@kernel.dk>
Content-Language: en-US
In-Reply-To: <683792db-32fc-4765-9ba6-3712af01676c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 11:15 AM, Jens Axboe wrote:
> On 5/6/26 11:01 PM, Christoph Hellwig wrote:
>> Hi all,
>>
>> this series has two fixes that make the new block layer bounce
>> buffering code work for the block size > PAGE_SIZE case.
>>
>> Changes since v1:
>>  - update a commit log to better describe the applicability
> 
> Can we get some Fixes tags on these, please?

Looked myself to not delay this any further, both marked with:

Fixes: 8dd5e7c75d7b ("block: add helpers to bounce buffer an iov_iter into bios")

-- 
Jens Axboe
