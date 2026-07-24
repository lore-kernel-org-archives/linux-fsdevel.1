Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6F035E1AE
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916597; cv=none; b=HEEJeK+rgfMsMsJJSCYKZtzBokC17Z+RVuh4oBt8iFqVPk6piCkqWvdDlZVA6ODGaDm5IXj5exf/6Qx8E4/ocQLci3bHgbRPAInqfMmC+60Kimp6CkcH2u4iRlnF3CqfSzqKVcHyyUvrkzb5x9lPWkAidrUfdP53Aubh3Qzntb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916597; c=relaxed/simple;
	bh=JZalWn5OPmsOOrSRcS0ujwmQGOJv+KEu5nL8xt/V7YQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmL6psxPLKLa0uy2R/dCebZLcRADJcNfbhgKv0D2Sx8lz9O4U+ER6WxNWRn/AbK7oWTftY3DYed2g1XaJMFUEvX2v5hdznqZT0aFfalJiglJGU6XWVbTg/Ix8lMUfcMlqqbQg5ibmttHw3ti9K/SvTxIqiVqtkJulapfzWwTr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=RZ5X9p4M; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="RZ5X9p4M"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-668432fe416so702871d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 11:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784916595; x=1785521395; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JZalWn5OPmsOOrSRcS0ujwmQGOJv+KEu5nL8xt/V7YQ=;
        b=RZ5X9p4MFDT+4mRLXz9kfuSICWHfrmopGYIq4YGkRlqqAGc42ViVNrWW0Uq2vktFIY
         fsOfP38Ugry8pLs5rkVuCyMedZhCT8nmKXMK+tKY0XjzVhLUsB2XDKXnt6ZY9ptLiNi5
         hqWxjEb4IsJKRMFdMKS123aqnJvvIOEWx90SiB5Hitr3vhefwlw22CNbGCwzKgZo3hcl
         EqlZH/cOYHgtbRENaz7tRZ7gEXFaMLvtwMjRVGyp6gytPZ5Hy683XhE4QHyvMkbz0bSZ
         AChML7Mi/WO5/4rAQ6xBEYCidK+4ziQlccMMnSLP+3TbnVGX9wRm8lywWKFgIBmCJGGT
         G3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784916595; x=1785521395;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JZalWn5OPmsOOrSRcS0ujwmQGOJv+KEu5nL8xt/V7YQ=;
        b=SRnc/wwJ3gk/KEfOz0qtbfMSgaXvuWlTff8vAM4X26HnzobiXP0A6npmyb2rhBm53a
         bunhTxWzAeLbyjEJwUPuXlAHJYP8J1UxyQ1TKG3VL5uRr2Qcnop3KleiAHNbWERXkPHx
         ZmQefRnpfGXEolb73rBAQNvT3HPRBjniCzaATaOzSZztykFzG7gsoXgYpsestWMKC8s0
         oa+mAOBpG4bsgSfoIqCafHFQ1bJMqapzatVvDSsjnNUqKkEiI33NJPYL3AEc5ER7GIBl
         7ImSXAHP2Fdwf9CRi7kX1Zj4/gXh6S03DayJ4Z3aNgvhv2ohUUiwXFSp6USjfxdpGHDq
         MRnQ==
X-Gm-Message-State: AOJu0YzsnHvZCW24EaqyG/WpUNG3iK9XYwFfqONa++R0uiOY3khbNoQp
	TmaNAtKnbJzhDMFmxqcWOuHe2luXWS3k/Dni0oh19m+76TImagHGLFgI7qbjIIQCDqw=
X-Gm-Gg: AR+sD13Z7uC1R+ycJww1CknOn+oLMdnYJD2jPZI4JYIx6g0xxIY1iuadidisb5WNZdQ
	mqAvX01F6IbplXfkFF5bDYc/bbZPJsbNl4pjqLv89BoUwe7mwtZdJMMmH/oQczxthdhOB//wVGy
	oeRsNRPxXOLeNdWKb5g0vJphMZmPa0Fwj8FQQst6F6ZpxHiCPvo7NwidPgTewvGss/RJT26YWp6
	SmAQDydQ/jVrONLbLlw2Jrmnz5Tc4XtsUSmMpgtQd1mic46M5ELQkNDu++fdFSLFcRdMnizTnE/
	eWPTgmyanVRFJbKdMk0TPzpEO0n4NTu49xqFkuOY9YgKXr3JNHBfYL3N0BvSHunG8zOk9kZH+Nj
	Ry4ymsDTobj9RLU7r3qKihN3ygSk+EpWmzAM04fFqLjSQqk9qE6aHmlJU0g+YR/oTYDyevns/fK
	UGQ2wYYp4Wvl8iw6qprZEYuQbeQk8pQ07KXMVRb8oBobxb/XxMHXJhGtTE1ygw2xwoWs/3x1XZa
	G0oavJliR6DsVsKyKZkbCh/W/M2s3uSZsqinqAIVnZoS/U5B1dsd+WgozIkL1LgLVdNXis=
X-Received: by 2002:a05:690c:6f0c:b0:81c:8005:9104 with SMTP id 00721157ae682-81f4c1eaf70mr25261407b3.30.1784916594678;
        Fri, 24 Jul 2026 11:09:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f65770064sm3887757b3.10.2026.07.24.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 11:09:53 -0700 (PDT)
Message-ID: <d97c34b070c97ec3da636c5b73f0c54c9b93ae3b.camel@dubeyko.com>
Subject: Re: [PATCH] fs: hfsplus: remove redundant NULL check before kfree()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: mdshahid@gmail.com, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 24 Jul 2026 11:09:50 -0700
In-Reply-To: <CACRLeC5agyqVnvjdziV5C_Z+y6NPvXg1Nyv2g_mmK2D1QbsfYQ@mail.gmail.com>
References: <20260703102256.58959-1-mdshahid03@gmail.com>
	 <CACRLeC5agyqVnvjdziV5C_Z+y6NPvXg1Nyv2g_mmK2D1QbsfYQ@mail.gmail.com>
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

On Fri, 2026-07-24 at 12:51 +0530, md shahid wrote:
> Hi,
>=20
> Gentle ping on this patch.
>=20
> Could someone please review it when time permits?

Sorry, I've missed this patch because of "fs: hfsplus" title.

>=20
> Thanks!
> Shahid.
>=20
> On Fri, Jul 3, 2026 at 3:53=E2=80=AFPM <mdshahid03@gmail.com> wrote:
> > From: Mohammad Shahid <mdshahid03@gmail.com>
> >=20
> > kfree() safely handles NULL pointers, so the explicit NULL check
> > before calling kfree() is unnecessary.
> >=20
> > This issue was reported by ifnullfree.cocci.
> >=20
> > Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
> > ---
> > =C2=A0fs/hfsplus/unicode_test.c | 3 +--
> > =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/fs/hfsplus/unicode_test.c b/fs/hfsplus/unicode_test.c
> > index 83737c9bafa0..7f6b2a3c69d9 100644
> > --- a/fs/hfsplus/unicode_test.c
> > +++ b/fs/hfsplus/unicode_test.c
> > @@ -39,8 +39,7 @@ static struct test_mock_string_env
> > *setup_mock_str_env(u32 buf_size)
> >=20
> > =C2=A0static void free_mock_str_env(struct test_mock_string_env *env)
> > =C2=A0{
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (env->buf)
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(env->buf)=
;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(env->buf);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(env);
> > =C2=A0}
> >=20

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
