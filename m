Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD96370D6F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848593; cv=pass; b=lnALmhMjiHpufnquSypYa2C7uJzoK0Bl1Sy8X+CBNbyUwcx6X/Ti0unt6/TSAkI2K+VA+OWOtzzvk3SNt60QhfUzprbXHBiDip2F9203+WnwcLO31l+aNTkMrbww4hjSjUAZ4cuum3f30KeGkWB2cwao0YLU2epHRzOz52xLaqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848593; c=relaxed/simple;
	bh=OnSqMpn50OnD/GS3xCMbVy0x7R1KvCBf5vcHImLyZO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qy/6wx86OrMeNBJ9mPAYUsOWxIP2Q0YHuXXoWVr49+dtAX/KeB4S1dkWsbjWP7cXeAw+y1LpkDPwTjmOEWQMfDRUdxMTP0VY5sQ13Nhs3WZpWEgcYq66Ms84qnvUYR/iMQTpu0csukqpOlWinRpE8o6ayc/WR51FmjQLFGLwOD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUgtk9X9; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUgtk9X9"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ba67b332bbaso516625266b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 02:03:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776848590; cv=none;
        d=google.com; s=arc-20240605;
        b=M29nb6r2r3lhAkuJAJnyhTEW9CR0xGi+bFRrDFcO5exYLtl6QAULu8N4AIzi97Fljx
         AGYOr0lWOB7HnNM+z5pnEY035ze/KJPxV0rMQGfwxsmzv2u0ApW2lL1Dh58c57/DKv1c
         b1dKCB5bRSRjWlFmkgU7TenFUB+asaZM1P/uAU2spwRXRC9G/j9pMqNeNq2DTR/2K8k8
         KwjfDHhm0zepgFQvfIHCcStr2WNBeh3RS8Ze6CEPKIfvnxQtcj5xJGRBTEkWr6NAnaTa
         47kYiCxe31c/b/LXH/YSWFHBKAQKUL8ljdOk+TzmSr+2apsJPTbMjOSp/+9xcYL5asRp
         9r/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/zmrzhJ82hqsZYSfFtPL0nnBqq6Ni7welpDOg1+muwU=;
        fh=CyiOmM7AN2J2T84Xc6ByO9voQDZEP82H4fj0yxVv4Vc=;
        b=HMz0+5fSsnNRU4RMMADKNDxnJuCz0QuUwfyfp/9KdQZQ8oRVJQvmzLA3XBvw5nuMtV
         z/KHr2YbZtC/Cekk2JgfDKuiSp5zYOAG0nt7U92N+AoPwOzz8fubnkv3WOCXg5pbOCzL
         j8R7Im8Y+x68jyIzstgt6nHYSOlLcHMp046enrJpJSYSNymFmhDK9Pp/Oy3HrxgZdj3F
         PwGlcZfjpusJq0BjwTP9HvY1XLyKCzyy7n14ZD/cN2G2oetm/Jq7WGnsjI/c2mSjQGjr
         wbEpOjKM/bvsFvPSTzltr51ki9XDAs2vrnKVkivY9E/nJyFQfY/JPcclLZQTKTNmbOon
         Nqhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776848590; x=1777453390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zmrzhJ82hqsZYSfFtPL0nnBqq6Ni7welpDOg1+muwU=;
        b=SUgtk9X9zH82Z3wBouIqDS4ua29KsRBHdZNRiXPyigXbWREMDGAq7pic8OBsUp9Bpx
         cWZf3pe3q5IAeOx7weMwkp0I3oxFGSPgW/jx1zIkhGYcJoeGgY4RSOXynqvxeO1SMla1
         3LfS1VSFdiT9KgLjX65/E9XiZ5zmQkoTH/YDCKQ0zLqMlWsacTfyici30fSFISc54jOt
         UH7iqm7UNqdFu1vZ0i8o5hA91v3Ux5ED7bEXLvcE8yrO2qDXG51/CrolfV49xiVNJUhJ
         ZKHrLQOD1gO4E3P5MYaOyU5JB+WjtRLS9RGTGqan0lf9AwCwky+lDO1bX7Tw71AH9Vb0
         uhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776848590; x=1777453390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/zmrzhJ82hqsZYSfFtPL0nnBqq6Ni7welpDOg1+muwU=;
        b=E0DAuEcXQZvAm4BeHs78tzLEVThwkTKsXxzF4Yx10/106VS82jf4Emb1yeyQR4AjjG
         9meDKEuuvUy2a+POir70p6TxuNYKxI/6e7kUzugTjxXRapRXIZKHyF7ZmmvHiyPD5EPQ
         A2/bEuab3lMFgrgT9OQf9/7pCTNqlOFLUSAu2Qm2r9VcykQRhEPEzx3Y7YClBW2GHMrr
         wU6IfD8aiBhBq3ucvDM236JknLwSZ0P+30dAVWnvt7xh9JzlpVAErjwr6PdYUKVcIUZ6
         6sxRTGPIM638IInqdcjs3RNWmNygwbF+ckD70RlCyYg9c9fg8+DWT6dImil1ShPRSsvs
         zUzw==
X-Forwarded-Encrypted: i=1; AFNElJ8P1+Ob2IuBYaRIGOijIbY+lmYqHqVcgBYRa8PYlW8X05LsEz7wZZWnbDcfdE8sTilx27fy99Y/zAqUF5aD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6atETYEBtJHFfPFx3RhaAtI2FTjeBEbv5mr907le3GcRJkV1M
	xkxsu2IaMlRgs2bYlEAoqhKTYLiZzEHq33fqG5ttAYUReiEyLAh45e4rczw6TOkYRlYJcJwj8q8
	EfY7lpXU4w5EHDfMdcx92w0ohkELrreA=
X-Gm-Gg: AeBDieuZkKaTe04eVa+Mph/lcFQtweoWCeLMkkx7JwUf0w60GTmA5vgw3VuenQQBukF
	wFPn53yr0NSn7gyoGDJQOFNDnFlGbw/bboolxsQIz5ORxzOzekJKDMG0uyBRIhm7Q/moEl9f+DK
	gtvocNu/xnVMT+VL/chtyVK1se9Wf9XrgTEqzR9T7WAg4jct4E2NPAJ688EAbGJ6D8i7hZDc1vm
	ciB6Sfvtj0RVibNFt6HW7WAYo/oTt8xC22HVyb3IJ+z9MxnCNYUJJlOnD3rD2wtBP1im7c1iyxt
	YCLRKNn7m69cHkfESK2uCrMHDtgZ0tTTrtiVIjbCad3c0Q9FWpAa
X-Received: by 2002:a17:907:3c89:b0:ba8:8094:f7af with SMTP id
 a640c23a62f3a-ba88094fbc4mr521856266b.18.1776848589508; Wed, 22 Apr 2026
 02:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417142503.1436446-1-amir73il@gmail.com> <20260422085044.339428-1-safinaskar@gmail.com>
In-Reply-To: <20260422085044.339428-1-safinaskar@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Apr 2026 11:02:56 +0200
X-Gm-Features: AQROBzAdC7X3wBRekJz-9eMdze2JR8zkisUispMnc6Noh5P0f4e19FgjiAv0JkQ
Message-ID: <CAOQ4uxgd9wgdYXOH-gGnagqbD-GVs3ck2bA-8OGSgD+kCaS1tg@mail.gmail.com>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
To: Askar Safin <safinaskar@gmail.com>, brauner@kernel.org
Cc: djwong@kernel.org, hch@lst.de, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	tytso@mit.edu, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 10:51=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> Amir Goldstein <amir73il@gmail.com>:
> > +  and the filesystem context API (``fs_context``) for the mount path. =
 See
>
> There is no need to say this, because there is no other code paths since
> this commit: https://lore.kernel.org/all/20251212174403.2882183-1-sandeen=
@redhat.com/

Right, I forgot that :)

Christian,

Do you want to leave something else in place of this?
Did you have anything in mind when you wrote
"I think we can compile a list of must-haves."?

Thanks,
Amir.
