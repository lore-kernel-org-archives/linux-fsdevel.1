Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9A3B27D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073409; cv=none; b=ZrkD/h2O6fPckHBimxp1O1tJcLyKuSKlhKcckTNaZR1o7lBLJm6F/sUsQgojeTS93npjBSlP24pDdbbqTi/E3zMhGfnLFADGFalIB465Muy7INoAnT/he85PEMgQlwEaz6EE2fuDMF2U6Eo/SoctbiQYnzO5Me9qpRWHr1MowBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073409; c=relaxed/simple;
	bh=DMskuNQVMj+uoBFxEGvl83x9Kmbf58EB1yX4IXsdyAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4X+10/VBfIvBhFmmtw7yiFrqfjFJ0ipMFdFLP5fsZCxzOkskwcXXxtGN8hjA6QT5FqNcynBf8+Tim0/A9dGiq+zmIG/JimT0j7TAzXvDvHRdjfU93hniKGYPwZqqmtDRz1f3DVytIcdXZ09M4Pe7CGXt0Cmr0WeUcykvbrZn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=CpBOYaFI; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="CpBOYaFI"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0cfb29cso137828a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 13:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073407; x=1789678207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZdl25+fTdFEnFxWqmQ6klfnpO36ISnMAYm6McTSM6g=;
        b=CpBOYaFIry/s/eHA4Rq9upG7oOTNN1kuNiXh3xH1pik8JOaDYehMbrbv4fBk9pKaXh
         lBLScF4Eq3/maprx9zN8xTMNaJqQJVSHvMPAgWMRTZEBCjxlujKlWNHdwhCnOSrsidxQ
         tnSHQzcgL/MuuHYeaBSeUj2fus04xjoJh+kdPEQgaq4bAq8B4l4t5yA0eVcg69PaJsZj
         MtClqjmw+jV/QWKkZVTuMF6y0VRd9y9psdlx+0Yrs9n+fjA/pkrmLsEriSyMv+6w0aAa
         egS5mHWNt5H8cj2YYU+tQapufHtp4tXfOxNTYenvQevUu3sdMr89OWFubdNzc3LWaij6
         3TLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073407; x=1789678207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pZdl25+fTdFEnFxWqmQ6klfnpO36ISnMAYm6McTSM6g=;
        b=aZZqBLVYtkvvFnnQK4/FvtBLDg2SoDTfC01Uo+nSLbrp2A4Q2Ppk4jyswk8nsPn0uT
         TFwe54H719EvlsBCNgxZBWFDjBXD1ObP4Xe2w0jqW59G372LlVBhweRYlTO4jUkADxts
         Ymwvos2sCB2BF/lgq+3NGT42BrE/3OHaxUj477uBgrFIcSaJE9YWz7RXBBj7W29VsRlI
         KwlohVu0IxuCXvF8yP7YKL814ZHa8Com+gjYZxlqabsOpFOD5jpeMea+s7jsUiv1dsMz
         iPaXCUeUTYHali/TU4yW2e7att7j1i/iDkl1hKbR0TjawkjKcNSv46sVhGEPTkpizYdV
         79+Q==
X-Forwarded-Encrypted: i=1; AKwUvBywhDdjyHgzlw6Y45lYEIUnn37jWJaI7HVBV1oH4W5D93mRo46FXz418EQyDHrgFn9uuKWMj6PZ6tzKWVuR@vger.kernel.org
X-Gm-Message-State: AFuF++kwy4oMJPMqHXdNZ6jtbwfm5h1FAh8LZAEsJoqaf0cUMV+g5Pyn
	lmX7viXxzmqrku6azEHy1QXRHBh4MNS6JUFoi8/+8X6lkC/vbf1cmBajVe5V+D3AvLs=
X-Gm-Gg: AYBFou19ohkm5FBUyc3cP76cEp4mIY2gXQ0VpqBx6WnqL4bbaR0MawClgSJeI8JIwdB
	p6nZcoeqvWgY14OItfcPIPzLRepe7pyIuOVZNoOFbPGaYPfXKVbzhFfvMU4Q3UvqfXrf6SVYft7
	BcTXnEaD2PFF1yf9tI3/5fDysKfyuZZBjtpBt/0Du5np8EbrXXxDVcSvtiJKsIye/D2/TZNxD7M
	YGLJKl7sqz3wMZzV3WD+fXw7506gIngnYss8Pl4g6F3l5JguoyLxL4yOHqBbMWDdymcLpsK+y/+
	8Ek4/8vyz6wiS85QQxnMxUzRYHj3zHZBwKUbABFZQWsrTpkVs3XVkXEFhQtvlH4iTY3NRP4iBBF
	v93tZnHZvGsJsuUNNgOpQSorV+xSZl1NOYx99GwDSwsYmrwCqrwc7reuTk0wLRvrlEYhaz/oA+J
	aLD/83dNuONzD+ZQkKCje1gQvJJVFeFxnCxgyTh8be1VvQrNCjVN/jJ5iiZJVw7pRZRb3619rsJ
	/S/liDC0Gg7x+c9o4Bqy8WZGStyo/JfHR1wF9UsPDMAH2peHTntBtDQ
X-Received: by 2002:a05:6830:2702:b0:7f4:ea33:8f56 with SMTP id 46e09a7af769-803fec05043mr748651a34.6.1789073406770;
        Thu, 10 Sep 2026 13:50:06 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f670d8c4sm611145a34.19.2026.09.10.13.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:50:05 -0700 (PDT)
Message-ID: <fe537c5f-114d-4d9a-817d-93f359e12924@kernel.dk>
Date: Thu, 10 Sep 2026 14:50:04 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lazy bounce buffering for checksummed reads v3
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>
Cc: Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260909060924.1102037-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260909060924.1102037-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/26 12:08 AM, Christoph Hellwig wrote:
> NOTE/QUESTION TO SUBSYSTEM MAINTAINERS: The patches in this series are
> split over 3 subsystems, and I'd love to hear from the maintainers
> about their preferences for merging this.

It's a little hard to split as you have eg block patches both at the
start and beginning... In the spirit of getting this some runtime, I'm
going to queue it up in a separate branch,
for-7.4/lazy-bounce-buffering for now.

-- 
Jens Axboe
