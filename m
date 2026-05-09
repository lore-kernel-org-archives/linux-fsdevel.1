Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C85261B9E
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 06:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778307263; cv=pass; b=bDJOTBmMtJud+TXTV5/EkJidPPRfyZquh9PHh/6gpd582pstBARpS+hNW6y9667nooO02UX1JyPDlxgqvzAVDVRWToIOZOnhvlmnJY7dv+ttzCLtEvqBeOZyohlIEHJN+bIOdH4EtOeYgmvxFWZcc5tK0YkEDbIYA/5IknbGZXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778307263; c=relaxed/simple;
	bh=bApG66Iyjaj+bxzLGg0/sBmkkKy8yZf5oPe63MxI1AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehvGA7ySA4UMCquaayvbB4A51etecb2dtGMM4Vb73AF+V9kFOIGPLeWtj5dtqQDRC5QWiKevVTn//wPOrgnMgs2zouiQFh+bXwEq8AUCCgxwdXetqA82Qy66ZosEkQJW2rf/hL/tgmnyL5blHUEKRz2+XkEazvcpqldlIEzbFCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrBeVu3j; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrBeVu3j"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ca9d0d189so217840d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 23:14:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778307261; cv=none;
        d=google.com; s=arc-20240605;
        b=YVJrWC1dUpkACIgc4AsCuNqxmDT6SdtPDI3azaUkXIiGM/FQ8UKbBkhKVk+XyGEKwh
         ZFyj6P297ZPLF4gSMiIJS7NcukRu4DN3Oo5uX1RY4Vxx1xHM8MLpMVRV5I+y3FqH0jiz
         yj7d9QDaVWyc/uqXJUmzDRyn0OB5IFK4B2CM8QwjJ/ImA66sWskkrwtK+gR+2gPqFwu9
         BCWW/+Czfb7mHykSBoMMBsEwCoak2poQlcX5hXWKM/cGbakWQB6VvpqKJu6HQlv82B+I
         /4fZjsu5v9FGxzZLxaZeg3Vi32y9Y7jzhn4fTqLH8tsqsc98e7L7LfPwsiotnPpu91jC
         DFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GzvYy02XDu6Dc3091MVWiiJDaPq8goGTqqPoAOqAo3g=;
        fh=aY6IIkbEO0D5Sr8YDYE91wt3/EK2p5OMVHQ5aVIyuU0=;
        b=irblMfIxv8V4KiCTMz2YDOBLSy3SmSyWXtqCcIaYYnDc9iFW2+oz+2KwKOwfWFsGNv
         KGL+YcBfzi5cBQ6kF0qGVdD2w/dCXT2m7oEEaFa8WsQ3KykOP1hOpSOYFRdkpaqYOtM7
         6/bpugdE9lJwX3UPoRTPDWJObP7j0ZRyIt6VpLiv1lZQ7Kc5+kRjgg+yIC7MUGml1Y7+
         6/KHLEPgZ8PigEnTGBkJEJ6o1CSQAcxf/P3gdEW+WKHi8mGWEx5l33cpCYA/aPRbly5V
         4Bi6EmrweYmwaJwEeXI4JDcxflvzK+qG7WJ99xukBiqwHYjzec7VeDYAxD/dpcoiMMpi
         KvmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778307261; x=1778912061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzvYy02XDu6Dc3091MVWiiJDaPq8goGTqqPoAOqAo3g=;
        b=NrBeVu3jlAJrC+kMUtYhkKf4e7hXx8hGGARQyOmRwIFGhidULCuFzSdec8EAfeJXro
         pSBfp9hQv+UZIjHsTK+7jNMKhEFSIHwPpxOSrCVK/6pl5JNj+wnjUWqpVP5emzlEXfkX
         ssIw1Khy4uGBx4pMntZYbCORAx3vG75+4hdhQRoinvg3VLTTQXeeAf6Aa2jRi5Xy8E8N
         5bJDPr7rm4outYQCxZZDtDqc52fcjtLJYc344p9NYw0NTloSx3ukRyUsMsPpPJ1y8oeh
         1dP1PbViKG25QFoni6/FJWTTIQkzc3hxW8fjai2lZeH/HVQWaPoVOSRQiSGicS4VbiGa
         72vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778307261; x=1778912061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GzvYy02XDu6Dc3091MVWiiJDaPq8goGTqqPoAOqAo3g=;
        b=KvsACju30augrvlysTPT/EFCULxO31lxtzC8eBRqIYpwCghhN7aaAM2D3+NUeHMwoX
         y6skNg0oVM4TYB4STl7+Cojl2L1d8WKj7o9ujCQi06AEtnmPHOBHqIhsS7cJjzyrsBrO
         v4XcqWQ1H7toRmDBA2ZFQu2gsbrW3ExCX8dlvfgKdmXF+4lKL3c5W7e7D/dlSBD/GHme
         HJj2EbhwZleKVgp2cZ1xMIL2wdtf9nBelmFzGgxy6fM/Iu37CCeCymcNTm+dSkYyHSC0
         SivQRdPUy2GoJDHIcwLuyxFDVQxk9pKT7GXmsRCedCeXALyf5awNkkZA7xlbJjfBcwU9
         G0Xg==
X-Forwarded-Encrypted: i=1; AFNElJ8Dl2vBQu02S0yyQ/qLIL4z56H+A/4wNd66U5pSB/Mprt+/3q4INdg27Gme7tIYX/FrA1OxusyXawXhfkdG@vger.kernel.org
X-Gm-Message-State: AOJu0YyIuHUKsqcTpxZdOvVRWpVnORGG466Yf5F4sUziGkzatU5PvOOp
	7Py0FW+6cPqIxGUP2yWPxoWR/j4sOABuER7hS0VaXn8cMDNYODL7f5SHf4+T/tG7WKRyYCfZ8An
	z81q18fBBbX6GITLSzd54w4GQcJL9Mr0=
X-Gm-Gg: Acq92OHhGW50dUU3RAB/x0Y/U5pf3/PgcSNp0bu1Nucv1yIhnAsdZuq5w6P8uwn1D1v
	5emFhUbwbsbpVxN06UeXbHZqXgdyvUklTvC5FTZ711hGQtSUlY7FCXQTQ29NAeD53JhAiNBKRjz
	pZ8Vdj3+Ex4f4tkcdd5sTW0AQgWDg+0iLEra2eqpWvkJDY/VqK5pwQvJ07mGRL3D8jYH2GGLelf
	YDHRTl98e2Om7hBucp3qfpaww0izVA8SNdGVF/4YqZiasz+3DY4S9K3XKaeI8f/iAFWoGgs0hmt
	6BkpBQ2eFkmWUG3cXkjv
X-Received: by 2002:a05:690e:1697:b0:651:bdff:db07 with SMTP id
 956f58d0204a3-65c7ba535famr9072066d50.7.1778307261473; Fri, 08 May 2026
 23:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508153410.2624801-1-charsyam@gmail.com> <20260508153410.2624801-3-charsyam@gmail.com>
 <CAKYAXd8d7Y21GqeoMYrhRhNyT44uRuqF3hZVO6_dROS1JRFZRw@mail.gmail.com>
In-Reply-To: <CAKYAXd8d7Y21GqeoMYrhRhNyT44uRuqF3hZVO6_dROS1JRFZRw@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Sat, 9 May 2026 15:14:10 +0900
X-Gm-Features: AVHnY4IQjLtgunifLCf4dM7r9FVe8zJIrC9kqP2DE9QoINlGW3WnpLKeHlnizD4
Message-ID: <CAMrLSE6NC3TvfwWRY2Nvu6pL6kuDd30G-WQo_1=9A3+GL9hChQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ntfs: fix MFT bitmap scan 2^32 boundary check
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will send v2 patch again.

Thanks for pointing it out.

2026=EB=85=84 5=EC=9B=94 9=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 1:03, Na=
mjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > Fixes: d3ad708fecaa ("ntfs: Initial commit")
> The warning from checkpatch.pl indicates that the commit ID you
> provided in the Fixes: tag does not exist...
>
> WARNING: Unknown commit id 'd3ad708fecaa', maybe rebased or not pulled?
> #67:
> Fixes: d3ad708fecaa ("ntfs: Initial commit")
>
> If the Fixes: tag refers to a commit from an oot version, please do
> either remove the tag or replace it with the correct upstream commit
> ID that introduced the bug. Other patches also have this tag, so
> please update them all.
>
> > @@ -1279,7 +1279,7 @@ static s64 ntfs_mft_bitmap_find_and_alloc_free_re=
c_nolock(struct ntfs_volume *vo
> >                                 b =3D ffz((unsigned long)*byte);
> >                                 if (b < 8 && b >=3D (bit & 7)) {
> >                                         ll =3D data_pos + (bit & ~7ull)=
 + b;
> > -                                       if (unlikely(ll > (1ll << 32)))=
 {
> > +                                       if (unlikely(ll >=3D (1ll << 32=
))) {
> >  #if LINUX_VERSION_CODE >=3D KERNEL_VERSION(6, 6, 0)
> The kernel version check code is not in the mainline, so it seems this
> patch was created in the oot version... I cannot apply it unless you
> remove this.
> >                                                 folio_unlock(folio);
> >                                                 kunmap_local(buf);
> > --
> > 2.34.1
> >
