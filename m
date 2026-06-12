Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530438F25C
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 04:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781237673; cv=none; b=WZJou2krlFDnUYjKK0A87nSNZTvKKChbbJEWL0SX/lppuwyk/6VCx8y5CvAP2qJPzlBmjemRFKZF/ROg05SKu5WlcZl3sidlVyd7sszZZOypiwsbeda22LtYTvUeEVNKgaPKlJOt0YKBmv6bDBf11r3HsX98ZfmRKvoEf3McLdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781237673; c=relaxed/simple;
	bh=PjhCrdXWJabW012Ua1edPjXkfGNGhKm2yozMm/lPqpA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g03n1lCZ97NgdDoj3fpqKsB/GdPPxsgcNPoi8G8wpySMzxm8lajZ/yhOAQad/V5GPRQeEuQgst8ZrAASi98RGzRiYYBDEPkzSup8Sz7gjZzmH1AgNylDk+MJWF378teAI3IqGr/w4eRkrl1CotVdlafV0hySzv0raWIzKO4FlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=oeRHGsCa; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="oeRHGsCa"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa66893e9fso164962e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781237671; x=1781842471; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xNeGUEt4eUHsOpLT1IXxTwBhy2+nBKi5ET9yUpqdWI0=;
        b=oeRHGsCavlJ56vtyNiXRwax7GCcvPTVVGsdsngydFwsl/0DmDgtnyQOHUcijqOARqE
         rjN6AAS/JjtcjIRKFAjk77jEKfxUl0LYARO2UdTBkqKVf9FDrd5rqbKVijikL0oY5sTC
         JSHT+nReUQMH5a6TkGRrcEnAsxTh/dJWz7TLsHlT8nsCU94fBbxZQS/t8QwZRjQPM9Hh
         MXwqmOZzwPc0T9j+5QyVKmGkUX4Uh3F0V48JYAZEZNVpodT8jW4yQE7hztUxRmtIRiWt
         5rffI8vt2dOAkgeUhDpUyksRE6glbGIYGhoKBC9GCF1BmjOm4kgp7N1Kaq+7jhnHSgdY
         e+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781237671; x=1781842471;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNeGUEt4eUHsOpLT1IXxTwBhy2+nBKi5ET9yUpqdWI0=;
        b=qLoW77BkhfXL69veHmT+WEO+RWwQy/6odVT3McDQ0FxhxbhXp33BofUZUiKWXvOnFu
         PwCWOJf9HD7lStwvm67KdYB+oxFwcoCVIygarKLH08AS2t0cFz/csamgIC+NbJjTwMCQ
         dCboX01KK6IL9IKTFHaUzYQQ2ApjQ5fXdhdMGDkA6IvhHh1oCXx6fo0eRs9+ng0dfWjx
         1Fkb9zN8pl2vqf7LRDgCZLGQPbZacyHWsD/esjRNR0oWY9kGoca6+AEotLCJnDYuul3+
         l/t/MtWsQtlqQKgI5Qd/gpj4uh08f6TRdc+QN5pby2xq6zwQ7R1UdmvnV7BnbTCDRwLF
         xCPA==
X-Forwarded-Encrypted: i=1; AFNElJ99/PLmT5Bvr10KCrnqMOiK+jJof53k6+jq5ALgnj6/A8FW2V1zTmsmCigTwzuTVU/C7L+38OZ07M122F/r@vger.kernel.org
X-Gm-Message-State: AOJu0Yz41uUtH4jhG27D1wEqaGh/hZhRgxUS4nuADsP8etWWeNwYMJjF
	aXayq6GW3npD+0W554O3UuGXpEvXVG4CaO3DUK7ZGEMeAZKEO7MpEBMFGjdwZohA5tee/oMeDaw
	3+YfkvIuPvg==
X-Gm-Gg: Acq92OEbx0TtrrC4fW3l2N/nU8NyIpZs3tQS9j94NfCn13KtCaIDXY7GW8TYSQ9Y4yP
	/nFofI60pWC7y0kmkQ3mHQexPvWbccXUP0NoF+uHWKw5ZqOxzoTpjoHG2q3pU6zLVDAm+iHgstm
	VGy5X+kHS/PakVcfGE2YLgSgzXxuFHvodsmGrnl3UkEIjMYMs+9CUZfj+pRWi4C8F70jTIfXSvM
	SDot3bodE4KmAJeGUqbRHQO5UPbtJPxa+c54KgJNHi8HEurLROruB1/C1bBqolyFZZ5uhbNaspL
	68E2pAsiZ5UalDJnenLbgmh9eTau3vKPpyzk0lIwZk288rU43kwEmR6WiGncHEwOurT1FNo0sY+
	rTwqYs3ArzYSOQ1aqo2cderw3NnJR0FYtlUvETqCLmLtWIdntVeTsXpDI7SC/8euTB4RLg2IVAp
	kR7LZn7Osso6dMS3cTW4insuhUzYydLS18j6oF8xp++YpUfjy7gCEK1+OdpUvJes4g+a8z6Q/eb
	cAakjRGd+2n1HxBf49m/mvG3g1MRXdTU1g/rz0JP+lYEh7jkX6B3DyQ
X-Received: by 2002:a05:6512:1553:20b0:5aa:6a3b:3cc3 with SMTP id 2adb3069b0e04-5ad2db25009mr249276e87.6.1781237670635;
        Thu, 11 Jun 2026 21:14:30 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1b4869sm169252e87.75.2026.06.11.21.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 21:14:30 -0700 (PDT)
Message-ID: <49224b901ab27115c85605cb01706119687a36a8.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: terminate xattr names before listing them
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, outbounddisclosures@openai.com, 
	stable@vger.kernel.org
Date: Thu, 11 Jun 2026 21:14:26 -0700
In-Reply-To: <20260611212710.5134-1-kylebot@openai.com>
References: <20260611212710.5134-1-kylebot@openai.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-06-11 at 14:27 -0700, Kyle Zeng wrote:
> hfsplus_uni2asc_xattr_str() returns the converted byte count but does
> not
> append a trailing NUL. hfsplus_listxattr() then passes the reusable
> conversion buffer to string helpers such as can_list(), name_len(),
> and
> copy_name().
>=20
> If a shorter converted xattr name follows a longer one, stale bytes
> after
> the new byte count can make strscpy() fail with -E2BIG. The caller
> adds
> copy_name()'s return value to the running output offset, so a
> negative
> return can move the next write before the listxattr buffer.
>=20
> Explicitly terminate the converted name at the returned byte count
> before
> treating it as a C string.
>=20
> Fixes: 127e5f5ae51ef ("hfsplus: rework functionality of getting,
> setting and deleting of extended attributes")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> =C2=A0fs/hfsplus/xattr.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 452a1f9becb2..35fcbc397b62 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -870,6 +870,7 @@ ssize_t hfsplus_listxattr(struct dentry *dentry,
> char *buffer, size_t size)
> =C2=A0			res =3D -EIO;
> =C2=A0			goto end_listxattr;
> =C2=A0		}
> +		strbuf[xattr_name_len] =3D '\0';
> =C2=A0
> =C2=A0		if (!buffer || !size) {
> =C2=A0			if (can_list(strbuf))

Have you run xfstsests for the patch?

Thanks,
Slava.
