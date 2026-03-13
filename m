Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E46D3CCFDF
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 18:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426142; cv=pass; b=iDlGZRM63D2VUyRYkh+pRq7rco03O/UI4B6GZAMCnq1hBQImPqoxj3WvsO7eWMSgEJTDxtPy70bexJlVhXlXtjQPpFnxaTj0oGrH+cr5pvg3tJrmQXn2N85ThYqNdpHSFDvPNH4YxUet7IaLQny+b5cKlv0F+3Xm0ZFDR8KA/Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426142; c=relaxed/simple;
	bh=me0UVx/T9bpjAAwjM56y1VQO3PsGHX93I0ZuzfjV9cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSYkfdaOWKVT+1bs5EiQXa2rQrbSOu0Yfz01MlP1t8rMpZFWyiy0T1hg7RGvHwdZH65Rj3IM7WglBWyC9WX7TPgHSMk1twPFbA7cUN7+DyHYhbgYws2/4l9OMZ+Ve08bX6kYR3Tlkl8UFy5cfBKYbt3Rpa0rVCGfVEE7YQV6u1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Vtv3gQ0z; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Vtv3gQ0z"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-417a84c5c2fso201187fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 11:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773426139; cv=none;
        d=google.com; s=arc-20240605;
        b=KElmK//1lWK6cVABbeUnrrrBbCUT86FhUGLk0z7AzoxqQbxjCadmxdGzM8PbSc+2c8
         UlvCWFjfdV3gRfJqiBn0pRTdoZOlNNTmlKE7Tn4zCeSYzW+/KQBfDs11eK4lRHWvSwXS
         X6+a9Nr9gDQOrFIm71GD84+LkinFwQ/r7peGR8Z+VUlcnz0jhm5OT/KCr5/18iVL/n7T
         VXk/8YR93fKpoM8ru3Ooxn1m04vt53fc6Xc/X0yjOYTGi2nUE3mz16ePZu+0VXrYYhpl
         xNio8Q9nGUjFLfQOIkjO7Tb5NozVqH4mvaFBYtCb0d3aGa8SZnrSrrT1qtJ37MHth8PX
         3qRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=me0UVx/T9bpjAAwjM56y1VQO3PsGHX93I0ZuzfjV9cs=;
        fh=yzJ3YJro+7hjQRmHb7+JIW29ZHDBcYbCR7LyhiD6W60=;
        b=E9HaTwxAjrEwWSB7teC1ZPzDZBF9O5qYc6U7VUr2ABsMRT7QGWnGRJhQhlqRK2PM/q
         VKWTbxlpp2gzAWCnITS+Tg9UGcUQo5y8YERlGmeNSmDsE2ajP9WwhGXMvSXf9la7fsDn
         zLM0cyeYLjsPHUEw8XLIsOPH9QKi7cfBttjTRWhGqUznfGcDaQmHkSjA+buY7u24ootM
         w6S7FJvFyYnrc1jQFwSXrvtWkYZXFRavJ6V9wNRebDahbK8FZn0FEZWPqOTQMgADETLp
         qrYIeTSK//26MRC946P7bRKDDUJBZdE0uCu+E+la5u16QN+Z5Qw9CabEUPLFiqjLNYGN
         a8eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1773426139; x=1774030939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=me0UVx/T9bpjAAwjM56y1VQO3PsGHX93I0ZuzfjV9cs=;
        b=Vtv3gQ0zvcqdKYIwr/6c6pP+UcxA4f/9aUMqDN2FAq+PHizsdaWLu9Iair8h1pHBrU
         NjAcvgBOmB45cIfsYF/00yJokd1n4dGu2RN/E1wV9+d8v3Y4wuoeQ35c40wutrOSpyzb
         EUfLlPsU+Lrt0QAwRhcWXK0DxwRPPK0EEjqwqU8PenIp0R3XbX+wIwZBLVvc55RLU4d9
         P+Zzv8DU5ezZX9dw7t+tKC2RwKfLh5V9Lk3jYsIMw/k+I4hMFC3u3hOAy3FlgLPPkGje
         f+6FvKGv83wB2AFq69fNZSlK6cVA5N3CXrkqggm+jOlKOQHanBJrnq8gaDVhUBWFomrA
         Aneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426139; x=1774030939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=me0UVx/T9bpjAAwjM56y1VQO3PsGHX93I0ZuzfjV9cs=;
        b=lA2GB0OXcIk03rTMsITWOqrdYpaDOf6WHXpmJMZMgUe9sb3gLbTrFSaXyzg7zqhpa6
         uossRQ6aOkA54+gA/FN1616Qd+xQjpdkGVFnDYlMdoUxICz1NA0c+iJZLnJKCGp1FCIj
         iuz1kjEA9K0IwLJihvQcRg6DtoWN7kdhsjjtBjSGLmnNzh40exb54f3neR/DW+jw+5bV
         5vieZyKiTtKpVRJqgHx7fcJ0SYs7IF1/q0llBKwGZnqfBxIWkqgMshK9xucYvdpPmo17
         KLBfpvrskWHPfHZp8bhmU9n0RiilsnnnmZsRfr/J0OVK5ZsT7vLfi0w9AsE8C4jpG6Dp
         pV+g==
X-Forwarded-Encrypted: i=1; AJvYcCXotVVtxn4rpua4Av9ekrjLdgGmmKu54VRhvLRWF5EFIvfbsbubkyD9yF5JRHQwOf9zWGxRCTRuQSat3wHK@vger.kernel.org
X-Gm-Message-State: AOJu0YwXA2oG0i/r7WFnx4qvOWC2sn+5royCxX/2PLfY3yvVM70cFdM9
	zF9We66xkmqM9/F1k5RpjtY5gjV4agLuiS3jxfYRb32gRQryW/dAL/AhmbS5NrxAWErO4NAs3Bt
	6/JSNF3Tir8kB9nnHUz7X1alix8+7B7fRKNRGhyGGcA==
X-Gm-Gg: ATEYQzxe7AUjZ6fGhb1WnQxILJ8fR46dqRH9qwfMSZJ1yuDUmdgpMprR302tV83oD7f
	vbzNF2BqPOKw9q+QUesJFi5jXJxK0vHKZGpSiiCMNAeg3bbUek4lYOYrToehkKmgU1QWbo5IuAW
	B6wAAcQY2b5iy2JIXA8xYyY6Y1XV4dvQEYIJ861mCpKo+Mc9JyFLw4EPrOp6pt7X7n8Fniu8koo
	s7vz7XyVovBIF/XrBxoCrEdH597pEINJ0TItQ+gRsize9bMZy738rBuyE2oUmRP3RIBg2qT87Zc
	G2u38jSWifR5CKLnJaU=
X-Received: by 2002:a05:6870:212:b0:417:1a62:17df with SMTP id
 586e51a60fabf-417b938ab11mr1856263fac.3.1773426138746; Fri, 13 Mar 2026
 11:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313181038.30018-1-objecting@objecting.org>
 <20260313181038.30018-2-objecting@objecting.org> <CADUfDZo0L-ZkkSRwAumA5Tx2oevBg2qKKGM3uN3vpFKburqJ7g@mail.gmail.com>
 <90C824E0-8930-4D34-8615-B9B31D6C867D@objecting.org>
In-Reply-To: <90C824E0-8930-4D34-8615-B9B31D6C867D@objecting.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 13 Mar 2026 11:22:07 -0700
X-Gm-Features: AaiRm52kpITTsI-Z0ptaxKiv_35njfM8mw9op21OEr6w7NRxh0wbj_PElsIBnRc
Message-ID: <CADUfDZpe1M1f4MFtM-imqw=L4P+rfyC264ASS+5z4SvO7AL5fQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] lib/iov_iter: fix missing allocation failure check in iov_iter_extract_bvec_pages()
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 11:20=E2=80=AFAM Josh Law <objecting@objecting.org>=
 wrote:
>
>
>
> >> Signed-off-by: Josh Law <objecting@objecting.org>
> >
> >Don't think you can object to the Developer=E2=80=99s Certificate of Ori=
gin if
> >you want your patches in the kernel.
> >
> >Best,
> >Caleb
>
>
> Hello Caleb, I have to ask, is this a joke? Or did I genuinely do somethi=
ng wrong

Is that your actual email address? objecting.org doesn't look like a
real website, so I assumed you were indicating that you objected to
the DCO.

Best,
Caleb
