Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCF3859C4
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350126; cv=none; b=ttQXJxoO+2y0G2ArTnqyFh1/y+oFmSVkBwK8iqoTNAXiRZgByBU1qN1DWPa0mzudYst4TvD2Yp7sHSHtlyuxZQ8egZr1vm/b5OXKfLyHSjK7ULh3L2i7WeVQzo6PqhoM7uFMOsLjfOGBMdEyCp+bGA7vYHle8sg7JXrFrCk9Gls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350126; c=relaxed/simple;
	bh=csK1En/4fONGq/lr85KpbezFYh469Cwgl1uC4F6XmcI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iB5fYezbNeYKZ+YlhpbqxU+1+K1VosfuM9kpYRr/TkRG8AHcevELP6UgCgyZgXhXIeUVUmfdqni+rD9WnGmse2S1IE2luP2kQ+GajtiKQku0grEq9/hREaPFvaLqG4v0ZvJGduUcysuLWJtl3GBnm4CV6ey+uAyNYG/s0VprOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvizAiiE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvizAiiE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so13683535e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773350121; x=1773954921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csK1En/4fONGq/lr85KpbezFYh469Cwgl1uC4F6XmcI=;
        b=YvizAiiE7BMDvvDS9kvEvRxQyshly8YhYGJUjashU/vS5M65boyn+fjNLMoJpUIexG
         nVffyLbYkdEW0oLbxaBdJjXDg6RnnQy+sF7OwTSZ6kTv+Oa+M9Z2cKtpyHW2+qYpVusi
         DzK2AYG45LOahnbHRmAjjsuGhBCFJsy5HQPb0Zl2BB6PZzAbQoJ6yzkHRsBHQ7C5ty9Y
         6z/jF4ciQBr0J3IWsUhSrnpb6eSUrwT/EV+xo/Oq9R1mcJsE4HbjO7pHwB6NqS1r/7eH
         t5dpMddmqY4UFj38bL3RSG5JKP/xvHf9J2LfNuzgI4A/FJGADZEnftI/rh+niNwLLEHv
         oD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773350121; x=1773954921;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csK1En/4fONGq/lr85KpbezFYh469Cwgl1uC4F6XmcI=;
        b=FV32UluwrtFHsga0hJnUqOGuXRo9AorOTbMYNFRaKmAkPts6AzjfoP6OfzvuRsley8
         sJxzRkvG2Xiqp/Cadx5gworBzczakKh/5vo1whbksamk9R4cURlf4stZYkOaKRxE4F9H
         IZoABuilPmYvL3+5lYcTvS5KPAWuM41FDpHEsM1vr+qT8tjhmCkAB6f6HsGFkJJsmUiY
         bVQuwL1SHIN/bBPi3aZOtPizn/JUi/UE+rL2X830s1Vt016B5NVFrCopGlSpFg1W5q8V
         BwLDaL+v7jQ1o2NiBi2BAPEUC6/+9S9SwdAY7giiw3HAlIyy/yVd8kFXwT3gWffZWbld
         aIWA==
X-Forwarded-Encrypted: i=1; AJvYcCXWWGeAL7QgzdaMoUCICvsJZQ2I8otavfwHwUXehm7JKSNwnBr7rXJFhWYKhbLEVyfseIotvKHr5SUkPGH1@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUsfT937jUW1XYD4Jb9+yIWZTt2fn8ZJePU/xiutKyZ6barEY
	me+wFZNNLRhtyHIv0MsvuGj8F6M+5/cQe6GQDlGW3JAuGaul1QAy2EKN
X-Gm-Gg: ATEYQzxQfGUoU/4Pr5++ZP5+GvfghI41htfSpsM2bs1AuCATHrMhauokOIMrxoa5Pti
	f5348TeO+5E3Jm5XnsO2ivBMETajRuNqcdAfUVLxQLAtYGVPk6MMNnXREo4aZgbcEm1+QPt515J
	j2uNTtVTZvKOU2TXS4Qc+Hkw3jSRdrHRP47II1bLUsdUHvWO2VOL1P8d5HEBjw2vr0VZ3JVL/+c
	X4PlNrQGbQSTcjK2ueVu6SW5KNiZ38vbMNVWkWk+OPEf8C6xHGX8TZlk8v2LZYmVhBt6S6dlDBt
	hvU49LD5q4N+TUDHnMGf1JbNGk0v+fasOkegBMvSg1AoMjmZzX5nbTmQfP8sRAr0meUQHPxwwan
	39uef1o4Bo6WLF9eUYjHDQ7K5rzCGkGuNLsgSuV9nXWAoxlLAyWO0MpkWnLBVkbn4BRMOjm6+9y
	65ZB16PKxuPp/ps4IoTyXU678A3g==
X-Received: by 2002:a05:600c:3ba4:b0:485:3f72:3230 with SMTP id 5b1f17b1804b1-485566d936dmr13803785e9.15.1773350121216;
        Thu, 12 Mar 2026 14:15:21 -0700 (PDT)
Received: from ?IPv6:::1? ([2a00:23ee:2968:90cb:1c6d:1979:bcad:501a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855640d915sm5009175e9.4.2026.03.12.14.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 14:15:20 -0700 (PDT)
Date: Thu, 12 Mar 2026 21:15:20 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Message-ID: <c41dbb9d-b8a5-4b5f-9f71-3fe1bed210b6@gmail.com>
In-Reply-To: <43bacae7-3891-417e-9384-20cede8eec6e@gmail.com>
References: <20260312181948.20020-1-objecting@objecting.org> <20260312181948.20020-2-objecting@objecting.org> <20260312135514.e4fc0fa4c1f50e6fbda2644c@linux-foundation.org> <43bacae7-3891-417e-9384-20cede8eec6e@gmail.com>
Subject: Re: [PATCH v3 1/2] lib/idr: fix infinite loop in idr_get_next()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <c41dbb9d-b8a5-4b5f-9f71-3fe1bed210b6@gmail.com>

12 Mar 2026 20:57:48 Josh Law <hlcj1234567@gmail.com>:

> 12 Mar 2026 20:55:15 Andrew Morton <akpm@linux-foundation.org>:
>
>> On Thu, 12 Mar 2026 18:19:47 +0000 Josh Law <hlcj1234567@gmail.com> wrot=
e:
>>
>>> In idr_get_next(), if the returned id from idr_get_next_ul() is greater
>>> than INT_MAX, the function issues a warning and returns NULL without
>>> updating the *nextid pointer. This causes a soft lockup for any caller
>>> iterating over an IDR (e.g. via idr_for_each_entry) because they will
>>> receive NULL, fail to advance their index, and repeatedly query the sam=
e
>>> state forever.
>>
>> This assumes that the idr_get_next() caller ignores the NULL return and
>> just keeps on looping.=C2=A0 Isn't that a caller bug and if so, do we ne=
ed
>> to defend against it here?
>
> The risk isn't just a single loop failure; it's that idr_get_next() break=
s the 'forward-progress' guarantee of the iterator.
> In macros like idr_for_each_entry_continue, if idr_get_next() returns NUL=
L without advancing the pointer, the caller is left in a permanent trap. An=
y attempt to resume or retry the iteration results in an infinite loop of t=
he same warning because the index is never incremented past the problematic=
 ID.
> Advancing the pointer ensures the infrastructure is robust against these =
'soft lockups', even if the caller's error handling is imperfect..

This most definitely needs to be merged.


V/R
