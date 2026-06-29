Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9735DA40
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782775114; cv=none; b=Q4OvxRu1VCgRPVVa1R0hMuKLEWJIcZnvzrdh3+9oCUUIXr+0a3gClHyyJmFVSf3QRwBeahGYq912hjRAcl/K6GSEi+XQe4Y8aNMKRusEKpW7+vWhFNrOQX3FW0QOPZJX+cGlZdY/0yjjyaKd2leKLk/QKsncq6cBYvFtUQu5NLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782775114; c=relaxed/simple;
	bh=5QwYmtyK8mDPKQEMdwzLwsu5HLPsbYOnrJaevwTPcH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gcfaXeCC2e42jVtdjoav6M6/U7xL9ZMFOZuFDvnrN89ZZTurGbtG4PocJe8hkY9Cggm+9bORCvXo6uAEOtjZ6aVdKRTcY3kP1WIoY3Q6QdJiXU75Y25fcHHOzazoXMMgrKSlGld4keOSwEJ87Tu/sTIhCZWLrUXHzBRAC/k3daE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=uUkp3Tzn; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="uUkp3Tzn"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-80e46c00f3bso12626737b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 16:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782775111; x=1783379911; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qR0jjB6almaCVIp+GBEkjIasVXF1sJo/GazX0Rc9UuA=;
        b=uUkp3TznjFZSrugd9Y17sMehltQd9nF0JwMbzvV3IqgbLucQlkDirRWzru33ZYZ8FS
         2xsOUWoxwmFp7Xutqvg0er1rWOAYvgO8DpqB4y2amA+VKh+Olszh7aFPv/IF3QElUoyq
         gMrzFVbNdKnv9z9uzfve9vViHEcfo4O6QJMOkF9Z5B4tZ5cxaaSlbkcLtB55aQNKziSW
         s2/NAFR+RQ4rtltFt/tBUCoXF05LrrKkvA0XXBy41Ndo/v8mhJN1CW5us6vgIvdT176A
         q5uCCAlQdhDgWaLC/2Z0rkmZ7gXMX4U55hh4rztKpJe+sEAOKtrH3KjBAetp3z8me0nS
         KOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782775111; x=1783379911;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qR0jjB6almaCVIp+GBEkjIasVXF1sJo/GazX0Rc9UuA=;
        b=M4ITdBUZHV7v2b50f+4BqnIz/hqZJAKaDVLM2Wn1Rds09dvM6GHP9+IRxOswv0L0+a
         H/f6mcGhNcfwPzV3nIkoP8dueeBpVnWnoRw2mODbZWwqIW8UqjW8wmvHzONgxVU98Um1
         tg5xLCRacvdkwW5+3RNULTo8N/WOjyjqxlaYtj90V4fYzkr757X97Ba/k/bCq8uI86wN
         EQno28E8C7VGdtLZMzhRNBw50dyrIQ68LawGhdKjz5CXk4JHEkokRolVNhFqh3iuSiTJ
         ta6BGK7covGxSGYkcgDBPelGgTKACld1g8J73bKpgCEiOi743+NChxmUfQXhic043LDN
         t0FA==
X-Forwarded-Encrypted: i=1; AHgh+RoIlSfsdKq3chxUf5qQpO62Znbo+u9yNzw+530qC10y3MpuqzmlS/RvVv59e8pFCiMr7tWxyN5RgCM7QnDo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn10v6Qqjo0mDKo09Xro7pqwQjWnc3qLCLWU1vfKEb//6qxK4N
	j6wUCOygkaE005txpkluXdbZ4bFH3d8UqR2EJjOoyaATgTZvvbEfyRojEy8NWmzpNWk=
X-Gm-Gg: AfdE7ckjI7oNFzJJdksL9BSbrnB+rkNI/4BWiQF6UEetIyjMXgCR7iQQxqqyTQbzXK7
	IwTCnKysiJGDsNhmTMUqe+Ms9koNVh8bf5tpTQ99NZ5n0a03TIscFkVpX7fQ4aWtRQIryGj1vgX
	Oc0Bx56XTOF09JuH196sjA7UtSaEb2mzZYEcxaEiDKq/cmF1fpwVdm27/Nb1pfNZCn2KweDrmv/
	oyzl38bDo6z1OLlFZGBjwHWFJYtSMFJtBmsCom6LUNrDzcjBfGgYEsS5YSf+I6uZXvTToPmPcuK
	lSDgH/ChcwUfRDp/7r8+Sr4ZZf7IOQW5cWK8c4CuJ5P0KcbVi2VmmuM5UgQmtUBuT0kmFSCoNPW
	lRjsP1uZ4mTFCzNwffDaazX2z4dr62iZtnmKPlbUyWgNxQh2FhrqhjbatV6yUAiGVbGcra4Khyb
	ZvvOLsQkpJInh6vDrhji3b+bJGSvgx1FbI7aLL69VROPrzEPDhVC4EC50a+jttMdON3CBpYIyF9
	Sa1IGYp2bFkcNLLC/CWfTkecdNufpMllavxc942fYcyVQ==
X-Received: by 2002:a05:690c:630d:b0:7b2:513b:34d7 with SMTP id 00721157ae682-810d82dbf80mr16001397b3.29.1782775110535;
        Mon, 29 Jun 2026 16:18:30 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:620b:6926:2bec:7db3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e9d48f01sm4191487b3.25.2026.06.29.16.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 16:18:30 -0700 (PDT)
Message-ID: <4a0ad1fbf065b3d0bc0e3f1f2efbc44249181d03.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: terminate xattr names before listing them
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org
Cc: Yangtao Li <frank.li@vivo.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, outbounddisclosures@openai.com, 
	stable@vger.kernel.org
Date: Mon, 29 Jun 2026 16:18:28 -0700
In-Reply-To: <20260611212710.5134-1-kylebot@openai.com>
References: <20260611212710.5134-1-kylebot@openai.com>
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

The strbuf is allocated by kzalloc() [1] and it is zeroed on every
iteration [2]. Are you really sure that this code is necessary? Can you
reproduce any issue without your patch?

Thanks,
Slava.

> =C2=A0
> =C2=A0		if (!buffer || !size) {
> =C2=A0			if (can_list(strbuf))

[1]
https://elixir.bootlin.com/linux/v7.1/source/fs/hfsplus/xattr.c#L833
[2]
https://elixir.bootlin.com/linux/v7.1/source/fs/hfsplus/xattr.c#L891
