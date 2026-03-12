Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221439022D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336535; cv=none; b=h6qsPgQcWcxgINGNmpApakaFiLu325aJpXINPcnWPVQDS7c8o2kEJkVP7hgjb7FM+VBB9Ulgoc8hZdbteyYqU9CP0JTUog0RHbGA0zviT0OCSCr2/KIJgk0cSMbBUIp17MMRop66QqVoBqSIiTSKobyHmovzQT9/5Abzt9SvCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336535; c=relaxed/simple;
	bh=DI4uIRiym7HF+uV8f3Y+IQhxu5vX/UZXiPwGeaFqfEc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=EDTST6WkfEITnrIGL0jOt5s4DF8UrjA0Be2CFk3lsF2bWjpsPFbcLfihvW/H8TWR95C61r7XbCMJMHUc+za2Xp68t9MJzkbRFeDWIP9/odeDFzDkYH52iPwM35usT0pVpkhcfPugsRZxVlewG+17+LprNnlWoxfcr1dW+vkHvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKau1+m3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKau1+m3"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so11838805e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 10:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773336533; x=1773941333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI4uIRiym7HF+uV8f3Y+IQhxu5vX/UZXiPwGeaFqfEc=;
        b=SKau1+m3qXuVD8kiFNprqOKmDH2gDG4faXPLeTrM3aNAqBem9zqvrabTGaTbc3pE9S
         c0uDmy3JmIR47UhmT4crRBPcCazfeVXD7R3a9X675UmWnqwj3BYSsO8oqVD5KT+i2sBa
         t6BS4QqCk2akKoyyTTHcgI2s/j8SB+dNQYQscCsUiW+5Uwq9nVmBlZJjTsA2z21bVcIt
         zjYTvO64KBXT8p0aV5pRJIZMNcMSXptxh5aBC7Sz2LknkUILcmxjdfU8yM7iz+v3DXY8
         TjuLHfyfldO6+jb69igvpe7kvqMXA9SBmWM4/oe9UkXb+npuFFNK0YUE8MRZM9nQ1iCq
         Yerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773336533; x=1773941333;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DI4uIRiym7HF+uV8f3Y+IQhxu5vX/UZXiPwGeaFqfEc=;
        b=oE4urQF5grr5vck19OeSAp4ta/5jRiCUFfhLLDG5b4gC8ZRuoLUbxCDpHnPY3rFJmE
         CylWRpFIeX9rpzixInPqE/cDnmWwryj9w7bRl3DtajOGO5KoVu3qdDG4wUqkZuz4cEA4
         Zm6YWBn4NQYScaDusLUp2EwhNFMWfNm9IqqgLUz2YeQNQHuJgGMh0lHid+AR5UG8/6aL
         13DnxtA9PNKyC2/eqcUDr95q3X8eg3INs6Y402JJfET3yc5ENo9tZ9PshWN2qDlX2rPy
         71Z6+48YX3qU3S4LyeSZsa17iz2JsLo5nwqBb4j3OCpfQO53506nFzaP4yFbsPS6FqjY
         j39A==
X-Forwarded-Encrypted: i=1; AJvYcCXYlRnb9JNN2idCTRlTNaE1eHZ0UqxY5X4bqlNs+QghGVZeJ2YDA/vllCuEGl68Q9CQxiLpfKra/9/UbN6I@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6FQoiIieUEaqoq+Pkljolu6GumoDY0qWIlZfk50tTTNiOS5n
	ANWTidad83/yENX0MImUoQJvdMLMX3jOl2IYQpAwfjXCBSfsG3i4B0jHhKbozrYza6A=
X-Gm-Gg: ATEYQzzZ+h5CPPjUt5ylOvllsWQ25yDtuxs7xxOsFQxYx90Uw/57pL85PZw/PddxeBb
	x5iu30n8ReeWiRmLg9J5PTMIeVPBS4H6ChjKSiFKqbixqplx8JpgRaZFcITjLbZqRsZQ+2ECu4h
	P99jl0AXmowE67hW4n1BdbShqUMlspYNOQ3E/Wkis26eLfj6+Omt6ptmwYrgMPlQb9+Ht8ccraf
	8VlvcREFncup/IY8W12smASw05fhvHmTLwSYJJleC2Qd9L41e+eYmI4ytrjHjrV3G1QICHfrMli
	gr3nPCAloUDMrt/SO7UDM7fcw+q1Q96wUh/RlA4pDiitrdTQTUBZpipAeW8R4Ejpo+V/WxOJGX1
	Fsukr6fWhhVhmr5oXhNUVxaB2j/YixvLiUoMjP7rdOu9+W2kcOUrC91sxgezuWu3orVk2oFhzt9
	R1RsQA/buVEz8i4U1J
X-Received: by 2002:a05:600c:8714:b0:483:ad56:8d16 with SMTP id 5b1f17b1804b1-485566cf048mr2521805e9.6.1773336532525;
        Thu, 12 Mar 2026 10:28:52 -0700 (PDT)
Received: from [127.0.0.1] ([86.1.69.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fdf09abesm9556172f8f.0.2026.03.12.10.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 10:28:50 -0700 (PDT)
Date: Thu, 12 Mar 2026 17:28:48 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Message-ID: <40767ecf-7e25-48f5-a604-c43b835b6b66@gmail.com>
In-Reply-To: <abL3U3xm9c4oSbKM@casper.infradead.org>
References: <20260312171238.7961-1-objecting@objecting.org> <abL3U3xm9c4oSbKM@casper.infradead.org>
Subject: Re: [PATCH v2] lib/idr: fix infinite loop in idr_get_next()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <40767ecf-7e25-48f5-a604-c43b835b6b66@gmail.com>

12 Mar 2026 17:26:44 Matthew Wilcox <willy@infradead.org>:

> On Thu, Mar 12, 2026 at 05:12:38PM +0000, Josh Law wrote:
>> From: Josh Law <objecting@objecting.org>
>>
>> In idr_get_next(), if the returned id from idr_get_next_ul() is greater
>> than INT_MAX, the function issues a warning and returns NULL without
>> updating the *nextid pointer. This causes a soft lockup for any caller
>> iterating over an IDR (e.g. via idr_for_each_entry) because they will
>> receive NULL, fail to advance their index, and repeatedly query the same
>> state forever.
>>
>> Fix this by setting *nextid to INT_MAX when the bounds check fails,
>> ensuring the caller's iteration will terminate.
>
> Can you add a test-case for this?=C2=A0 And the IDA patch you also sent?

Lmao you and your test cases, absolutely ill add some test cases
