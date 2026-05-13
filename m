Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24664DA55A
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692514; cv=none; b=o9FESE0JtFTtks7YoMjKeh+UQUa9IfxfMVB3FSI2Cxz9VSRfACwKUrvX3HzdYa2HGqGIyXkCSNgKR5esH0f8mVxP/+g4LYQ7DqrDN32iPBX6Jn0dPkmZDiOrjfdHkZ7mSv9E3fkwHtOAMCI1MIGizGH/pH170P5V6O0DRSbmzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692514; c=relaxed/simple;
	bh=Iaz4Ta7/aArc8u5jlDHa5DhHsZ4NcZfOvMTNbV7KGSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEaxyUUGWQYg2FBcZdCZbL3PUUdtUhrcQFunMDFLpvqkvLcH2pzhIaJHJcWUmMvzv+ZA5F3etyicxOdd22jIarQ+UBTXP3L6HB/OBJQ7vgfVTJOx8BgBfhjCI2COCV2umwuyGiC1cRx29FCx+uRGwrMmakh3X/+f9y9yGP7dEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=EdLZOvWG; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="EdLZOvWG"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479aa2dbea2so2998313b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778692509; x=1779297309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FzcET/6EBA26O2gB5meYX8WxvSiEZYzWqssd3s1sb8s=;
        b=EdLZOvWGT9Gnb7r2EIssEUFb9Ljn0BYDLGWy9ymz9FZ/DZtvVdF4eMU9RevEFGtC6+
         FnuUbwavKhWjOqLsCPGzAbjIN3EnJ1m9J93YrxB43NTFqVnKOUrg7vqeGG1TcBKuND4h
         l8HzsyFnYfosMcHpn/kA7XvcbGtkibEW6JVCBR1Lyw6QBVLcKpKyFHqhCe9UXvUCgOa3
         W9eSHmyjDwVEufcWBfCOi/oBpX5LJg74IkGaWHG8OdNcDjmEASRLv4YqnCDFize26s25
         YdCpETz1XXOKMvG3wGIBAKaesTi9NMrfV+fNjbEcXbS+5IEZ1+PBFWKdmYo0+Thz4fU0
         gA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778692509; x=1779297309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzcET/6EBA26O2gB5meYX8WxvSiEZYzWqssd3s1sb8s=;
        b=VDVWh8oQv/rl70kwwcu0AMKfPE2ngIkARAeTQi2QY0TlxxGl7L37syiClEgRtMDEyN
         QcwdomYzkqUwpFOZSGAm7hnb/S0DC/cUUzf6uEb22JzwaOXBxm2AqJE+LEjrWWVVT9DG
         E99fydb+Y0S6Gx5/icO8l28Pha1Ff06mOVeeFInfFN0w0tc/EgpQzsXWyzbki4KNFFDU
         zXbAn3qd9+v3oYG/P/wAADSBJx7M5JUZrgf2EmwYNe8vcsIGua+z7vp2MQjNdn94s8gw
         QU9kiHZtVf8RGo/+NhE8IafErtSh3edJXQVdug6yOGrhRSie1MXYFeOhjjIa3j//l748
         FGHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8UKq4ei+lUiBLzrQerNzvAJBJrkqweuWywz4EuiPW6WwidMtR9HnMYYwN6TYxw2wZ1Zwbhe1DJumCMnwE1@vger.kernel.org
X-Gm-Message-State: AOJu0YyeikAAmsTkq/TOwt4CYw48pq2fHMrwZwEl2qq8b3S0dHmXLHEW
	ECoVb4ae/5JJFIt2rz5PSg/hfEWkn1s+jowNb2FP2aeRY6BDHPWrjlz9OzJAd6L7JyY=
X-Gm-Gg: Acq92OG0QCl7PWS8x1n31++ybH07iczBsVjkBYVnK+c5SqGqidUaJgGACi4ig8fXkFG
	Ky6scR8+l0eGaCAVeTGikVn5mTTZeFNnghhFCwrwozYZyKw/e83du3mDS3Ra8Y25PrDDxqpOubD
	wdUBnRa/bYjEln5hVfZ/c3juCawlBgPYAmPyxvbnFCSWDA63KNuxZ/+WJsoqaPRbaTYLDKxKsf0
	H0QHpHxegGlfLTh5xdaMgV3+vOSRfx0Jm6kyPSgtY6iXmA4kY5ewNx5eFHT5rvxsvoqSUyMu22A
	EGgKnBuWrcg4/JRsDVbZmCZV0ufdjeGzq9AZrZ11qdYQPcwUmqLqGJjYAFVvX+qwV+sWpCF7EoK
	41AI6DBibYiwV13PANIWaZiHhV4GDH6FK/tBH+CCzRacLOm5lDgiM7f/XuJH+GFQTqhnc1GuHrr
	qz6vVUgd6qGstNzYhxxovWua2lkHNGwVhNm5slXpH77jtL1hA+xDzi8sPD2z6QDfr3gLlcR+6oA
	/QJ4X4j
X-Received: by 2002:a05:6820:4b0b:b0:696:1fae:fb83 with SMTP id 006d021491bc7-69b78dd8381mr2499356eaf.34.1778692509425;
        Wed, 13 May 2026 10:15:09 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25e0dbb5sm9611857eaf.13.2026.05.13.10.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 10:15:08 -0700 (PDT)
Message-ID: <683792db-32fc-4765-9ba6-3712af01676c@kernel.dk>
Date: Wed, 13 May 2026 11:15:07 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fix block layer bounce buffering for block size > PAGE_SIZE v2
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>,
 Pankaj Raghav <pankaj.raghav@linux.dev>, linux-block@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260507050153.1298375-1-hch@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260507050153.1298375-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/26 11:01 PM, Christoph Hellwig wrote:
> Hi all,
> 
> this series has two fixes that make the new block layer bounce
> buffering code work for the block size > PAGE_SIZE case.
> 
> Changes since v1:
>  - update a commit log to better describe the applicability

Can we get some Fixes tags on these, please?

-- 
Jens Axboe

