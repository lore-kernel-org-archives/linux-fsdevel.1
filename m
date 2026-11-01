Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793526787;
	b=hSE2FmrEcI8hEXN2Fm4tYIwDHsZvNIIJiJbpIOO+SkvigD4+791LT6y+6TeEtSxFrbtf
	 Y9p/N1IL5Slvt4crVy/rcRG/Z4az/oY+rR1ykV0E45Q4ymdnbOYLOIATac13Sba1IcfDZ
	 1e50ZfyaT67wJlJmus67TsnmLSDLLABt6m/MbT6xGP3AzIxDCqlJWXj/6xPDD8DifTz8K
	 umIw/T0LuDQEjlm6dU+lIBtguFdAbRYho9Cle72WXngT/z3v0fL7lBwMj4TR1zTFNiFMt
	 3ntbsOTJ3qElwDF0bikGQcFOi23KNhajVJLanZk0OaVc+sp5GoIeDM9XC4aC759ckAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793526787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=6+Z1HcyucRArSh6XcF3VCepTj+eagFW1p74LS1mjYl0=;
	b=c4szRnVfbVxM05840bgk79/vCuckgoWy5+nZqRhfpRBnX5yQOLok8HZMRCYH0J5EpOmj
	 BIpEsY9x6iOYtfcbXNn1Qu4OghjUMKlkEHsiwFWRdH7eo+lOdBEMyWxLSbf19eNQMcWUR
	 plh1F4v193shGbmJw7AEST1AqwDxUULod3TyzvQXQYlAo6PyV3zAcTUQNhuSLUm4ye907
	 BAzphE9isS8EnYIlucWhGoFkzQrlWGO4GVxib3+/EdP+pEYz15rlX1S9Vz7bxGBoq3WUC
	 Rhy3Xi0yMRsT+inbRShn6fupInTd8LgERZB2Okp3HGLXP2loh3cu53dj2g/h5PYjlbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OvMYEV6i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.200
Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59783606A325
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 09:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59783606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OvMYEV6i
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-51cddc2451aso1007106b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 01:53:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793526786; cv=none;
        d=google.com; s=arc-20260327;
        b=DaRfHLXERGTpwRUrHhGE/n1wtA+qtu4Rd4XzlGis7yBMm63OanGm3a9FLy4Pezu0ew
         qKVUGnF9boszaL7kR6gjCif6p+y2pTuhtxVsX0AdbqnpXw3F1Y3R0z6oA6zjgubkCWzn
         EnjK+e692+r0pGayw2haQIEMmlJeYYG5qKai7XAyjyMpC4Jf32Oe1td5jiQia2+95MLF
         T6+0fh7yarHpoCP6JLwNTD4wxiiSC2wUVU8hL+ZcXxNwsd6l47Xa8jei7ahnISMLD54v
         XyoCaz2v/CEZmlf0Wv0glxjfhhbkz1LaRxnuEmGDcGp8waj4hvsCjwFcUkfiItluJwHA
         LZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6+Z1HcyucRArSh6XcF3VCepTj+eagFW1p74LS1mjYl0=;
        fh=/zvo3nytuqhcJTHhuBrJve3Lxfj0NI8KJXg8fqofNhg=;
        b=BZZOYoYHkbO1VJMOGaRv3Pn/5HPF4+QwpEw1UGOOzROCOFPH/DXhj52wKAPtprED+Y
         /Fbhhbnk44p0OViWqFrrUZPescBRJM0enkIWeg9+N6/EyvPSgYp4VaJmuKucQNkT2n4W
         72lyQff3vt+mTNos+pMUdFTce5URtr7Vlk7L+pGtubtf4dAfnhQDZuWKz1E0ZHWwPf3W
         4H/OHomDFIHCwuF3jI+CdjdSMFt7zHKcK4lQ2JHoPGD50xqS4aB/dkrmzXUTX8Kg3fUD
         n63dtAWpa5c/dsF1/kNaheKZ6Lf5OJBBSPNVKzdBOrub/k2EVc17kzbjEkCcNSjPyEdK
         3Bsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793526786; x=1794131586; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6+Z1HcyucRArSh6XcF3VCepTj+eagFW1p74LS1mjYl0=;
        b=OvMYEV6i2iauu2LTuQBYnjshutwyWPDNKqvesrdch0d0Wczq+hIKcFuNKqC3e8USi8
         8bz5o4YrqpNN77MZfcqMBciXeztqO3McW7kcNIWLl4PCLd66HD4Ml1aEYU56n2ZLJYau
         orY5Vw8GJkESrMqGTn2qE6mMaLQXtl2kR77UV4AiJm5hdWgWct8s6kfXPe5EjIzKVNXV
         RMaObVaG9OCDYGCZ15qemtA0IuCAsc3D7HdpICnJdHsvohuHcPa8CYRfxHzHpTQq6Ht4
         T5YB+UpWnVqHHvS2x/0pt75CaokI6Q2UszPBh7ovjiHpSmquII0BwLAVFiUnHDbNwkqL
         t8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793526786; x=1794131586;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6+Z1HcyucRArSh6XcF3VCepTj+eagFW1p74LS1mjYl0=;
        b=CnWHqAEGzt/18wxutIzKfl45m8znpzD5dV1LgGW9v1LoJd/Or3DzV3haRgypqGSFhn
         vuln7vtf5Ehm6ad6slctLfQh/ykAyS/qmDKuTPyiRRWniw3Tn/XGfmXCpll0W1JTz72A
         ekdYydsgRGKL02PlYnYmIJ3m40tiPEWHR1aNx9nTI+MOLsJYjudgXv7h3taRTEVnUxBR
         oqFw4j994IQf69UFjOOmBhcwY6V1aJ/9W3lBivvrzJiZ/BLstezDBeYmc2Zu/dWuPSNE
         EByKtNawV0ec5HXDeKY5TJcD92OBsojnKQA59dSNr6AB+qfXVw3hhwbYhpUw/+/B9uqj
         ymvw==
X-Forwarded-Encrypted: i=1; AKwUvByH+brrJU03+sa88qGMReQluhZFb1amATcjLuo3PY1FlCU8eIpMxdgUAiOUFrlMOAr6eg/DBwGOwiRSHogb@vger.kernel.org
X-Gm-Message-State: AFq9FYIQIzmzIygI4X3QzI4SG5v6HknTDasTlLaLgTpxGLewBkbJ5Rod
	yvbXWRO9x8mKdj7SKGEzhHHEb1Hf/jR+Mm2BhdR0+2hlc4w7fUK7/cF3kIpxl/XcS5BUlCzKUnP
	MrIK/uI5kVli6mO2SnyDS+cPYa9rU+LM=
X-Gm-Gg: AYBFou0klRycLzcU8M6aX//1ci/kR+gkhaYuuq5sDQKp8KsOsWVjduCrBNcU0uP7NLc
	GDadjfqwgWbemkXljOU6Yu37/oPFmqWGaDvVIeaZ5GDB5h5iEXCBrlhZDRG9BRpLu0dZubF4qzd
	JqGx8F/wM8FCFKFYvqaQ+lDelIqLWNDzzJEpxBlKk0EVBgzpKP9dSuxe4YgBa8P3WnmGreB8ohh
	uHFbrD11MmtbgnLCqHkmLBfxSvsd7667y2A7YsdK+TUGtFekKRXbXFtkRnewLEGhwBPSRJjIVEi
	pFm2LcUrs0UoHgcTcDfM/9KkKenBnU7AUN5zblXKz8rtZ7zdGqKX1z6rn8BFWX0FpKIk4IO1evp
	D6YkKR34zkcZhrtvSiR01Z9WVGu+AsfBzsCOhhhN+jX5/qBr3P0rDfDcKTF4R7LuP//jqawI=
X-Received: by 2002:a05:6808:13c7:b0:4fb:ac9b:b06c with SMTP id
 5614622812f47-5640d973571mr5026749b6e.1.1793526786130; Sun, 01 Nov 2026
 01:53:06 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Sun, 1 Nov 2026 01:52:54 -0800
X-Gm-Features: AclHuK9NsfrNbFBROmh4ZgKyencv594QLJI8SgBvoXw74aLz-zgoV3FFUaYfe3M
Message-ID: <CAGEkeHcg06kHshHQ=9U6Yrs_wm8W9H28o9bcC2Qh3fw3tANbWA@mail.gmail.com>
Subject: [BUG] overlayfs: inconsistent d_ino in overlay/077
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Amir, Miklos,

While testing the casefold series on arm64/QEMU with ext4 backing
filesystems, I hit the following overlay/077 failure:

  entry o100 has inconsistent d_ino (131490 != 131280)

This also reproduces on ovl-fixes at 1d27da7de3f7 without the
casefold series applied, so it is not introduced by that series.

The failure depends on directory ordering. I reproduced it with
the ext4 directory hash seed 00000000-0000-0000-0000-0000000088bf.
The upstream overlay/077 test and its helper were unchanged.

It appears that ext4 returns a buffered entry after the file has
been unlinked between getdents64() calls. The rebuilt impure cache
no longer contains the name, so overlayfs reports the physical
upper inode number instead of the lower-origin number.

The symptom looks similar to the merge dir case fixed by commit
9011c2791e63 ("ovl: skip stale entries in merge dir cache iteration"),
but this one is in the impure dir path.

I don't have time to pursue this further at the moment, but wanted
to report it here in case someone can take a look.

Thanks,
Hungyu
