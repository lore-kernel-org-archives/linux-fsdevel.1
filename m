Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B2D33AD9A
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362820; cv=none; b=BwroYYJPK+vgVv6ZIJvrtG8tDZ0C1xZeNMbLk7723cfizpp4lrkbplGpdCpKG6ChPJX0ijQgYvVb6ioxyoCwAsBA8cfB9drccQqmrnFGpO/pa/7U2IszYDGlDSyGDfxw5+C3yQTmoht+80UYiL3joDhrAMoftYg/+qt1yvYEjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362820; c=relaxed/simple;
	bh=i3A9N27SfZiBBC07JfxGiMBzjIzCy2hY2hUn5i5aVHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPjQGxMLEwNfW9VjrEYr/JZWxMDjZpVILD9N6QiiQBg4JLzA239RZ/4e2mBjwphUs42FahN2GUVL6Lp02Ox0BPAUTOg/n33ZIBJCbUrcuAZHazCYFpZklrVx+T74Rb0ldEwZhomKvFHzbajoh9W5xJK+ZoEsSliRHC13YnLgivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG0XxH0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG0XxH0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8530E1F00A3F
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781362818;
	bh=kYclayMMyVZJiV67Pogm2jkm3NAjaoGlCueDZvNmqY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gG0XxH0qaa7fBPShvzHkD7jfJ+8Q5NO02Tbn1cD8e+MFjB1qTNyO/YVaesLptI6te
	 tlYbw+INCcKQxDpeV37s45FrpdeN6zokFuwhICNAqXztGa6oSFFfy5svZP0SMZvX5b
	 NGXWf0gk6mt5xzQZ1eOIEtwcnLy6YO1GwRKTOKnDtlBSV8D7vHfrTgdwW7mRYcwBkr
	 CSza8pzsdYPflOfB5nAHujUeczKfWTaHa0QpEoFwf1ONgu6kG1EdT1u0ikkTI+JU4r
	 sRked1dXXnrLOY5i5kJXIskfYB9juM6yx+vXbkjkFy8gC1M6GbncehKcxsoqAEqlES
	 o7Bj7lcCxAgAw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so3082439a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 08:00:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9hF3y5+sjIYGyCheDp/i4dVzIRwK+1Yo+2GXfBuUk0dFRdDQnn0gWGvssvSMBx3p+a7bTaZq3SUwVhIwe2@vger.kernel.org
X-Gm-Message-State: AOJu0YykfDJAE7o0LCBXLWOiwXJYK9RRG0sPYi06t+whGOK6XF3KzAiN
	dxR9WAcIN5VvgBIsZEY6zdYdMpNsGyjHNKJDKw34Csm8x00bjBHbowQyumUM4gj9Rzw8k4PfhpS
	+mGNqwF+C0J/zOkAnOYRWlmPxZvnO2KE=
X-Received: by 2002:a17:907:868f:b0:bf9:48a8:aee3 with SMTP id
 a640c23a62f3a-bff4bdfc207mr174671766b.34.1781362817196; Sat, 13 Jun 2026
 08:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-b4-disp-d3abc2b6-v2-1-258241593ae4@proton.me>
In-Reply-To: <20260612-b4-disp-d3abc2b6-v2-1-258241593ae4@proton.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 14 Jun 2026 00:00:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_o2n5R-w+RyWNaNE=b2tBeSSFQW09SAB4Q1-ZsFs6+CQ@mail.gmail.com>
X-Gm-Features: AVVi8CcaNKz1zR5adggmlpBxZWyhoddcw34eiQ_IYAm77WzgkHZWbcCkZLRXPdE
Message-ID: <CAKYAXd_o2n5R-w+RyWNaNE=b2tBeSSFQW09SAB4Q1-ZsFs6+CQ@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: bound uniname advance in exfat_find_dir_entry()
To: hexlabsecurity@proton.me
Cc: linux-kernel@vger.kernel.org, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 4:29=E2=80=AFAM Bryam Vargas via B4 Relay
<devnull+hexlabsecurity.proton.me@kernel.org> wrote:
>
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> In exfat_find_dir_entry(), each TYPE_EXTEND (file name) entry advances th=
e
> output pointer by a fixed amount while the loop guard only tracks the
> accumulated name length:
>
>         if (++order =3D=3D 2)
>                 uniname =3D p_uniname->name;
>         else
>                 uniname +=3D EXFAT_FILE_NAME_LEN;
>         len =3D exfat_extract_uni_name(ep, entry_uniname);
>         name_len +=3D len;
>         unichar =3D *(uniname+len);
>         *(uniname+len) =3D 0x0;
>
> uniname grows by EXFAT_FILE_NAME_LEN (15) per name entry, but name_len
> grows only by the actual extracted length, which is shorter when a name
> fragment contains an early NUL.  The only guard is
> `name_len >=3D MAX_NAME_LENGTH`, so a crafted directory with many short
> name fragments lets uniname run far past the
> p_uniname->name[MAX_NAME_LENGTH + 3] buffer while name_len stays small,
> causing an out-of-bounds read and write at *(uniname+len).
>
> The sibling extractor exfat_get_uniname_from_ext_entry() already stops
> on a short fragment (the lockstep `len !=3D EXFAT_FILE_NAME_LEN` guard
> added in commit d42334578eba ("exfat: check if filename entries exceeds
> max filename length")); exfat_find_dir_entry() never got the
> equivalent.  Track the per-entry write offset as a count and reject a
> fragment once the offset, or the offset plus the extracted length, would
> exceed MAX_NAME_LENGTH, before forming the output pointer.
>
> Fixes: ca06197382bd ("exfat: add directory operations")
> Cc: stable@vger.kernel.org
> Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Applied it to #dev.
Thanks!
