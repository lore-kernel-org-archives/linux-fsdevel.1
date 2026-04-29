Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F9378D63
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476611; cv=none; b=D1TngNRsJRLKl4n97WBejv1PC7R5A8yzdzpenoE0BsbAX/hsjbvp3jNhmI/baKGU1XmT06HVWdNh0ElCjc+ZEI2NflyEnZm+QYSRnPo0dUXpU1Cuh23pphKtI/1G6u9KR2iOaIHCClAR6wI5slmEPFXI5Hw+aR77mjEF4RkjNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476611; c=relaxed/simple;
	bh=rzuxUcixg/aGo1wsLI7mfQXDoDsrq+gCA/2UqCKDcbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUXinA0Jbdsd1q4r/80L47YX5aNhHox7ilm6/B8JNJ8Iyrlze5LvDMyhaO92pxenhhxXSXEobhh3NZQbwNRbpBf3H2nhWWMAXW+jPTni6WFvBmasD+MyLfDOk459KzFuG82RLdeUqxslewfe6dGlaECVOtCMArwuk66FiRxk9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMkRCmAG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMkRCmAG"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d77f60944so9089238f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476608; x=1778081408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOLuNiA/kfZwdLV9E2p8TNPc5d6B3zFK/DDHPjJ4Ciw=;
        b=qMkRCmAGPF/CQdcPyMvL7/b3NrrRRQjb9rPJFbEO+e47eRTPnAFflJ7b7/PXCP3za1
         3ecR+Hipy0pr2biy0kmthF9f41ammpPrxLG4BQqO5tHigxmxrKm3zPWOFdhUVbOwpl+G
         dDvxE4hDeh7HYZdShxmepG+bcgdeMrvNTKjgP4hW4567eU776FPkTErKOZTp2J/+JrFG
         jVTk2AjOa4qDaPOr34pI7R7g2xRo/jz7rj0pmtPYD8ZGilkaOFPgMqghJJlgE09MsMLy
         gmb8sXsShLrMJEFyD2OUoNV8ga1ftTKs0EPkyc4QBg7KjbnrHqqABWouhVnp7eKEkqjx
         QwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476608; x=1778081408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOLuNiA/kfZwdLV9E2p8TNPc5d6B3zFK/DDHPjJ4Ciw=;
        b=nxRkhv3xbYv2O6dM/kYriAtKHRFxMXqpSfFOMt+Cj3goRg0/w+pG5WYChI1SVL40eR
         hUynMnbnDMM4+7aJquAsByKyY3pS/etOmaIo/IgZh5y24GpoZjU16UWTK4kL0wtW+54O
         SrYOyWhJqvVcf6n644nwmqvzCipYesEQw22FFn7kewKafvYtRx5elk/Si8OlThZdE27B
         6hwM88Cl2nY9Z5YCPn7oqWk7F4sYyeg/bBa12DgtLzR5LVxK+kv3EoF7atqxlAuD2Z+1
         yiuRWZ/drLJ4qI3swBc7+zHigtFKkt3MU/99rCB6sg3FKNRMqeee9W0nSWs+LIJ8/QYJ
         bpkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pimcg/fmYnsOT23U5uyjYwm3qEGw6X9K5IqYsu1u49RYCRNsxC+3gx5FhqK+PfDLGTS8hrCZ4gPwGit/0@vger.kernel.org
X-Gm-Message-State: AOJu0YzFtgfTAlPdLaUbWRJV9NJjVGCllfW0O3SxyFTJjnS7pm73CcDG
	AS0P2hLmD+QPVH1KNC+e9nsbnZEprXpT+6I1/Vr+tIBO8XV2zB+0SVJi
X-Gm-Gg: AeBDietaZFv9wCcaCjpgrJCCTHlfDQXdUlGBGRakFy/f2MOkjtj6mDBVbtxOTDSCgk4
	AWA58iG40XmSDO1MR+dp3eWBqcRsJbHFrq6dvtdaRxmujP3tGSLeDCiw0auH74fkplaq4SaS2GJ
	Xr9fSMQ5iM0/MRM5oHZOE/k/DOn7MknmrJMC3k9mGMFJUmMYk+f4alBMvCD3xnxmAkJo1WqYImo
	7pkN7DRjGQPFJdwDIjwEoJMM4o2XmMxGPv90NOMAoR9PH7IXVaqnPG9zdUiQyppqOW2njJVQvai
	/9HNaHkQACSXVAj021jjvx5ck+NkE+5Z0HCpUESByUv0swwQzK2LY3ixsf/w8yuzVmL9g3RUutN
	I9d5zK3TeAgrZPw3bp/ZKMMlp2yTkqOKhgCkY6Baq9ZjMYA0zIKNiNyyNmCGKKLFI7inugP5zY9
	pVKNHtdzH3rZLiIWikc8IiECEWUclRzzsLFJ7D4pAERGPwr1uevTQCtpp/QNmCk38gfsCHy9Cjb
	96c9vaYFCbIhXVxOrRBeNktkGwftxrxzwL45a0UKg==
X-Received: by 2002:a05:6000:4313:b0:43d:d037:d59c with SMTP id ffacd0b85a97d-4478eb81cf7mr7566713f8f.16.1777476607642;
        Wed, 29 Apr 2026 08:30:07 -0700 (PDT)
Received: from [10.228.209.141] ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d481fdsm6740381f8f.8.2026.04.29.08.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 08:30:07 -0700 (PDT)
Message-ID: <46bf2c04-72ab-48a2-a8e1-9f4423eb17a6@gmail.com>
Date: Wed, 29 Apr 2026 16:29:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] nvme-pci: implement dma_token backed requests
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi
 <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <5cecb1157ab784f9f303a91449fdf11b03aa6002.1777475843.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/26 16:25, Pavel Begunkov wrote:
> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
> dmabuf when it's mapped, which is then used to initialise requests.

I left nvme request / map setup as it was in Keith's work for the most
part (apart from rebases, adapting it, etc.). It appears I have some
use for prp lists, and I know Kanchan, Nitesh and Anuj already have some
patches adding sgl support and some other optimisations. Hopefully, I
addressed most all feedback from v2.

-- 
Pavel Begunkov

