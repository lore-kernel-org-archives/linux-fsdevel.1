Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A162641FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785200380; cv=none; b=hxmHwaZsP+EI3S3ZO+9rFtiGujYGYCsdD2XJtsSf2972YnsK0dZjpwQMIVSS/gEt9YDaD/TO4nOe1lN5b7H66bb9CA0Mlc8Yf0FWfpY27LfD+KSnn3AE/mlphPubetPrcegfjZJek39aF4I23ym9R53sc3dXMsqZmbnZXqHsNpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785200380; c=relaxed/simple;
	bh=Z4oTvZ9Mq3I3mjjFJ20lYP4U0fEZ5O1CxUJNdtNMwWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tc0hsBj/56ohgiAD3WKMB6icB/Lia01X/FhNvEjwVC4bkRUMO5QSMZsWJ5r+aqdJfA1am0OQCe1Kaqx8Z6+jZ1G7uBWFQeEZyfKbnh4l9apLVRX5jaAK4lYRltpmlf9DX/1T7FCxq8bf+PlzCctWyy0FwFTnwiTamMYjwBuYNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=P+8Tk1y8; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="P+8Tk1y8"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6681e7911b0so4539054d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 17:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1785200374; x=1785805174; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7kGhNKYBW4yOBpnO3YHXsR0sKK1788xHgW0U1rULLko=;
        b=P+8Tk1y8mK/96q2jOq3RIiTqbAMqZCas3XEL5AdAq8fI2AT66p4i+Z+hNLUfDM+S/4
         8pCBQemaubJqgRjwliLel5ICeroy3QR3Z7hN8osHkT2MXzU9PsTfKZbZKZccSDQL6NOd
         re5bGVuQQ2InelXIxxawenGGcIYeB8TB/8YKB4RaY7H3DxGlKsyKduS0T5e5xUlOY3On
         VmtXww1QAulTlYAmh9nw4DiGnhwIErnWVK7ajmNmbGL+TW+KX+YxCG9ztfrKSWuIrQVw
         pnnT/OooQFNNmMysQ0BYC05yW5Lo0YQgcmbDQMDuZ1mbSnsCbei14fqI4jkaKxXhggbT
         mPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785200374; x=1785805174;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7kGhNKYBW4yOBpnO3YHXsR0sKK1788xHgW0U1rULLko=;
        b=Nsqu0bRr9L9DvwTkhDW90g8jxFniM3UPgs68FLk0MtfybDXsYmHz25m2lttXPa64jg
         zBPUU535RBMnMNWuH3QqfmTEbQvVwNpvFA5mFQa8TbGDoTVY1+A2G4svVFjUgMjr2+6N
         f0tEDzPrfQdAt98z38moqNarYrwq1Hkd8kYCxNMvptmqpmpX1UErQCSkggt+CRHULWOW
         G/Bhxz2TTVRIp1f7KsyXzboyfqEYi2A8HGUYTuBSdE5LOOsMyDsgSN6Zzf+d2Jg3lCWN
         c0MZLYyyJvYrHbTph/CcF9L/yoLW9ZK2m23NyNjqKnGFAYcBNzuRMev2RAXJeqPKilLU
         NNQA==
X-Gm-Message-State: AOJu0YyzYraanunj7tY3u/adc9mo/MUf57IPbHZTTKMfALBeuj+G6fvQ
	tSnGwUgzPUGq1vpjx6JpK7t/6EjTTlh3ZWU/eGljacL2IHjxKofgVbCWhKnfc7N/qQw=
X-Gm-Gg: AR+sD135D0y2JGcTKroH9+Yzo6H6vpOVX8NEsM/BaBkc/PrRG0qEfj8/tPkeIulF9vo
	bdN8G117ClPf5Xydzo93WIFFlyhV+OsU76zgN5oph8G4yD3gfsIv/Q7RMtVOQaMHkK4V2suVSEK
	Pru19YMe/C5CeSlZIwZitA0VQeaaDCBCpuhv4jd8ApHLsj/5SK9iyPmE4VApPintycPijh/CvBt
	l7BlbQFzi2CSFCCC290aF3u6pCOBZK2JDPndTyYcxoAUntKs1a2z7q47Vumu7smzFgs9sot8xht
	kPypQfFAxwubP99a8okZHaIWg9IGi14PXXBZv+k6TPJ2aVkK7mkZq1hx4UpDCxQb9bIH9iiSC1z
	hm6JoPdrAlSkvyJsAPwG2HqEWrsVy3T/YxQoqWrVnKhacULTor2p70adqtuq9GCKTjwo3Jo/lwm
	PDbYJUbtsksyIS5ulrApwPWX9FbGjnFKqjp7OiqxxNUf3/bMozkH/Hl4tsSeld1xT7TSHvcQZp0
	SacXQVHds+aIGJvwv6G69uq9VF1otlZnA==
X-Received: by 2002:a05:690e:438e:b0:667:72da:e798 with SMTP id 956f58d0204a3-669054b8565mr67503d50.31.1785200373849;
        Mon, 27 Jul 2026 17:59:33 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:273a:c0af:6af:54a7])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6f69710sm4243539d50.13.2026.07.27.17.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 17:59:33 -0700 (PDT)
Message-ID: <324da71d47e8b7b501ba0b90819cf00b9a2ac01c.camel@dubeyko.com>
Subject: Re: [PATCH] fs: hfsplus: remove redundant NULL check before kfree()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: mdshahid03@gmail.com, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 27 Jul 2026 17:59:32 -0700
In-Reply-To: <20260726064228.248199-1-mdshahid03@gmail.com>
References: <20260726063939.247892-1-mdshahid03@gmail.com>
	 <20260726064228.248199-1-mdshahid03@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-07-26 at 12:12 +0530, mdshahid03@gmail.com wrote:
> From: Mohammad Shahid <mdshahid03@gmail.com>
>=20
> kfree() safely handles NULL pointers, so the explicit NULL check
> before calling kfree() is unnecessary.
>=20
> This issue was reported by ifnullfree.cocci.
>=20
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> ---
> =C2=A0fs/hfsplus/unicode_test.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/hfsplus/unicode_test.c b/fs/hfsplus/unicode_test.c
> index 83737c9bafa0..7f6b2a3c69d9 100644
> --- a/fs/hfsplus/unicode_test.c
> +++ b/fs/hfsplus/unicode_test.c
> @@ -39,8 +39,7 @@ static struct test_mock_string_env
> *setup_mock_str_env(u32 buf_size)
> =C2=A0
> =C2=A0static void free_mock_str_env(struct test_mock_string_env *env)
> =C2=A0{
> -	if (env->buf)
> -		kfree(env->buf);
> +	kfree(env->buf);
> =C2=A0	kfree(env);
> =C2=A0}
> =C2=A0

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
