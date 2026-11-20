Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795190318;
	b=EZZBAEMnAN0HfRu5ejBfnKjsudG3l3WTnvL+8BaIHRGFdd3CNOx6aZk33wWI4a3F01CK
	 bzj1HBd97al3EtkRFgAsd33+bftS9PjU68eNxhtLxYH3sLVk4i69FES7wN5qLpnNnuGny
	 gvoTSzF3UjlzUxUG3J+KGekaNQsrlGFP7hc3yYKLo9BsXYgYrjKd86DFZMW4/LKT4Ewmq
	 vPY94hzPIXTKaxSAtKGXmjmz1h0vry7phkYoDfsuYDfi9NwA92yHufRihQZy81tMrajJh
	 fOLpjtEhNg955hN1u/oYAiDChK0XWLBRiy/5lHAMrEKxVrDT+ouumvqFXPBy794BFcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6kM0KOtHeHKXYurgzFZtJQepqztK7z7Hv0tSSDFAXAE=;
	b=vCUDEv6Gq+vhfPMHJQ/jELruVPeN0L5mGWiqiXMgLRMmrwpegcJJ2c5NijY1aiFGaibE
	 8HqCojB/VHP0sWXptbkPrukX/4B73uy96Q1m40HjyAK4O2Zb25ZJKBuida7EJoeaCTSsu
	 JJ4vSyeJs6Axx8vbogBGKlFo7GVbNaKi0WTd9cLwlvzjEVjN2dhOk19Za3OjMKpbn8F4g
	 loSoWEzLqlexc759gzSs7DNNqq/OCN+Yalah8yyugYRzn+ykbhl38xJn4zcl7uzUwOaIY
	 RfEA7Jm9/Fgu2sxW0SjWT70g7Y4oApdWdO56sQnTHHa9l2UD+svzTP5fLrJ5a9xh5og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTc+eMp4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C7606A332
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 15:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 068C7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTc+eMp4
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ba38c41804so1125104a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 07:58:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795190316; cv=none;
        d=google.com; s=arc-20260327;
        b=Y+TJTzqbetDveME9OOq5bRGFeZLh4fV4gHWBgz3ARLS3EY9yZffLUFp6cc/c7pMNfI
         anZizxOFMnb8mnQlnrQ2FNtkryQk5pwUoF7iFoA3m7Czc9oArY/VvYIUbYMguchsHkSG
         zlFEk1fgP7YdAxRZoPlV/Xf35dA62dp5mrGBjSmz/mpOkOSwyG2UbXr9ZWkv/j7omy3B
         peoNcFNYl5QQpAeSqBLuQCGO7Re1Ty1X7npD7KEgAFUI00K8tu2w/HRQKPrTqKbjYrbu
         +TMcec9LMV3scQ/ybfVBaFH5A9vc0DmIxQArWxnPSzOlect+BbraHntEug2RFSVvY/AO
         1mqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6kM0KOtHeHKXYurgzFZtJQepqztK7z7Hv0tSSDFAXAE=;
        fh=pNWhrkY4GWy9PSU7A1g3cNKyl6VqJs87A4+i6Gkrw8Y=;
        b=l2no/A7AmTTKZXqleS5RSoubWBqo70D8B2Xpv+oSrGJ8z2B5zDop1viz5nc9Gedjv/
         gD2Zu77vtaWvx45LroahxlU2umUtBFE/ZETN5zfzNN+z11nx0jxC3hB4AbpnyaFMkTwg
         Y+hr6nIfviwYbdFEvmWMv0n2b7086xZKteExAirUosj1Isic7DJOAin4cKdlcnoUlKeY
         +FG/P72OuTSTe+LWSCErWHhjBLnLiYRQjtnqiDNWDHbG3hxAKHsc5wcx0I9m+xUXEkuO
         x3TverolFWuUyUdLNsygKGhsFa9RMfzPBTOKlNXk2cX3vnimgfFHMPpfEupS2IdSbKcX
         vEBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190316; x=1795795116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6kM0KOtHeHKXYurgzFZtJQepqztK7z7Hv0tSSDFAXAE=;
        b=eTc+eMp4bITMI7jgx5jM4l7NyEFh1c9lTC1VxvFXF9G+vcYBoZB53yLQdKfrQOpf6F
         Mtz8FTmSSTw6Ei7un/2M30yiLReetEhAe/lO4dm/xLE7CcivvqjbhlK/KCKhN5ARxijZ
         ChezPcoSYPSGA4dYvVLO7Yd9kb7uDyVuUiuKTqgzbCAKx1XbYJKzxg+Mx7ccVg34Vcwt
         Sq2087h5YZQNFE89KJ0Ys4A0dIfGzwnygs4zE++uxupxXjpFy9vZB08cycp+xBcweq9+
         96UTqALXMzvyeJr5t/bjHIhkmiHd4xvEUtcz6apgxXUf6gRVWrykVKb8LpEbPe+pU8hS
         b+2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190316; x=1795795116;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kM0KOtHeHKXYurgzFZtJQepqztK7z7Hv0tSSDFAXAE=;
        b=lytXQ47i01yc5eT+6lg4vYMT5w6ZX+alC9oWtl7eZ2CDsHsOXQWT2Vmwy6eUBy+vyY
         IeM+ES97juYxe/Gl7SanhD6s6mCF0dTmyJ7Hii85aZfiNVHQ2vsZm8qdIisCmnwwr1de
         fwlR/3iIrV4lYwJKGFYxDLNEOBQ1ymte87ut6mkT7Zyx7X1De0Y9oUWZI6cDSXbJ2VEe
         L8cDx5UDJPuJM0I525aiRxOvsi7V/TPWsXSEm511VsUGm0lrDghG4Vw9GpJ739ullms+
         jtSv/83Ph821xvqqnpVfAwdIpu1ELPombmhBgunrfwvjtudvq4+Cg+mBxSW4wdyozZ18
         N01Q==
X-Forwarded-Encrypted: i=1; AL+hErFpspzrTwnlmL68qXzbv8sJafsmr8fCbTlztnPwbSe4iqOEG1V2zYRYMI293UzzbTbNc7RXC2xPWXpBhgMq@vger.kernel.org
X-Gm-Message-State: APuU4Z/BAsAg/CewM2K6u6Sg9p6EYrxy/t7TsEi1BrGk1UKgSQTOsaxF
	xR+NUep8OTcNSeSOUwdFYRektzwqPRoIal/M+3ypGnxUOU72PPz0gsYLrhHrCGWdnTlyK6VEIxD
	WqyOOY+ejQhl3uJBWHWzwtlYSOOgl5ag=
X-Gm-Gg: AZFdTZcJEoqrPY3GkYfAAXEqEIGYbuSk+UzYlgL24ypge4vte7dqo/b/o1aw0i9Oy1J
	yd1JLKO1tpZEfCp2aq7G8ueyH9hzEBy958UOcq6brOW/wnlAeImomQSNuz7FrPFssuwwHKSW5nf
	83WMbHMDwj330yQwi0DAtuAlg+sDPmyxAO0SkFECsHiVztzCIkG8/IarJSeuFru3bLkpjwM42qT
	pNEffUd9EfC05lHZCIs48b/JFznFxvqG9aLxfTQ+NDVEQxBmwJIRIanJeMjPmr4ZkKF/aaP61w1
	nh835XoqsFxFgO/LGTEuqOTJ1P/omHpvTCPXwYJm+UW4AtDVHtP/rY0D+ZG8YOj5WJJ5Wpf8Trr
	lpvswLTP1EILp26a2e74mstR4Jk9EMayfamE7cI9pBPBgYnWcIYeTh/+uadikLX0LxzBeoQ==
X-Received: by 2002:a05:6402:52c8:b0:6b8:5aba:6c06 with SMTP id
 4fb4d7f45d1cf-6ba37d652f3mr2090064a12.14.1795190315774; Fri, 20 Nov 2026
 07:58:35 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115180343.576773-1-koray.fra@gmail.com> <20261115180343.576773-4-koray.fra@gmail.com>
In-Reply-To: <20261115180343.576773-4-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Nov 2026 16:58:24 +0100
X-Gm-Features: Aa3M54pideZA7GJITw5PojgxjktVU6GBxKullq4dSyaJ0XYgg1VLGv1zO6-iMnU
Message-ID: <CAOQ4uxjdEiuJMQxtSL8XrPYHSamtfMh+BM8kS1wj_PVME4JynQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 03/10] ntfs3: make crtime user-settable using ptime
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Paulo Alcantara <pc@manguebit.org>, Chris Mason <mason@kernel.org>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Sean Smith <defendthedisabled@gmail.com>, Andrey Albershteyn <aalbersh@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 7:04=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> Since NTFS supports user-settable file creation timestamps, map
> provenance time (ptime) to NTFS file creation time (crtime) by using the
> newly introduced ptime API (in commit "vfs: add provenance time
> (ptime)").
>
> To do this, update ntfs_fileattr_[gs]et(), ntfs_getattr() and make it
> persist to disk in ni_write_inode().
>
> The timestamp is now retrievable by using file_getattr() or statx(), and
> is settable by using file_setattr() with the FS_XFLAG_PTIME flag.
>
> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
> Signed-off-by: koraynilay <koray.fra@gmail.com>
> ---
>  fs/ntfs3/file.c    | 20 ++++++++++++++++++--
>  fs/ntfs3/frecord.c |  8 +++++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)

Please don't change the unmaintained ntfs3 driver.

If you want to include an ntfs patch work on the new fs/ntfs driver.

Thanks,
Amir.
