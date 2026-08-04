Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255E3C4B8E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 00:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785801684; cv=none; b=qOiB5a9XgZrPckzG8XlHW1zu1BD4rDZQqYfOzJsGZ7uq1YzfquroeU2j/exMpl5CHsutCZsjkm/Dt/hHEnwcwmyHO9UZW6Zb0/qYsuVd1s1E89g/foB5hBATPgAjBF5dfxblUoObi2xcsE3YnVSgrvG0cXGSimAKjM0cpBInGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785801684; c=relaxed/simple;
	bh=2odeOeh1T+U7dvOGrIBGgChezk5e0BwvV/4VQvkXvXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3T8kYurnQQzYV+QS4UuRM5ZvSfgVnz0AQEdkN6hXvFzhCrkN8Q5EbaHAMxDw6V5p5ucU2kOchPij0s+HOKIk6UKFMwZa37ccw2lD1jH4RNv2GthaOPutXHqhAOIpHWGDuJL2xDkiLLM4VaZa0QkZenOror2hgHeQVI/yVtgXtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqCMbVd5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqCMbVd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDAD91F00A3E
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785801680;
	bh=k4QGE6NSPXlab5Yww5cEWxbsUkUBTyzy6TaVwcYtAmM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VqCMbVd57pX6BjJdZYnsEZEwf9vgTQN9socyzIsZxX8Fr/KElZghl2KBsTmp5cfuc
	 RHIpZ3rWdxZm5pk4g8pwEkYrtCudm6JfxSVwxz0FI0R2LUvynx80Dljp95ed3l1z6L
	 oHO/Zy78bYA5ibpzOl8F34Qx9378yhXnPlv1nbMLmxklATg0Ww7Do1jDpAr1XoQcPP
	 c0EYC3ChavJZ8IdKvXrvTLDMGYUxvMkShCF91C+5aVDojPehHuVpjvwtIVhgGUmYMs
	 bIdgyJtAiaYW0qt7CTDcKfo6k/2qD59TdPJEUyHo9cTWaCOxF/gxsyvfP6pkG9yMNb
	 3lI47pMAxIBxw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c2022323c37so87463866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 17:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqDSSaLWYXrNCKYQFJgmvVm5maVwTB5hBFJcxnxQJ7IbJ5BhSTsLkuDxagECXhBMwslKN4Np9KPQlf2e3M+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SCpY6YqSQrd/iceXhmXrRvD4Se5U/lhVc1TCSUDLm6ul9WS3
	RbYnlZShfDK1ScqWsQzIgGlo6T+LUucxxUQuY0/RYMRzEf9wp2dCufRCeCkycYMs98SR1LjUndx
	XtRM5umh387rb6g4sCPNO4XbxvIYxaqo=
X-Received: by 2002:a17:907:97d6:b0:c19:6d4a:425b with SMTP id
 a640c23a62f3a-c1ff382b897mr965775766b.18.1785801679418; Mon, 03 Aug 2026
 17:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729110036.12129-1-linkinjeon@kernel.org> <CAPJSo4WUxiKcfjDkHuOVhqBmvHng7JdWX1dibsYFjW6qwTCUSw@mail.gmail.com>
In-Reply-To: <CAPJSo4WUxiKcfjDkHuOVhqBmvHng7JdWX1dibsYFjW6qwTCUSw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 4 Aug 2026 09:01:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_oohSF2rLCns432OMACc6S-M7Hv8jCGtkD-rOd2QMYEQ@mail.gmail.com>
X-Gm-Features: AUfX_mzMcNYphat83VSAzBWJ7zNVLgLPGxzUUc8iSZVmufsI1rI9f8b9t-YmBaY
Message-ID: <CAKYAXd_oohSF2rLCns432OMACc6S-M7Hv8jCGtkD-rOd2QMYEQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ntfs: add ioctl support for named data streams
To: Lionel Cons <lionelcons1972@gmail.com>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:10=E2=80=AFPM Lionel Cons <lionelcons1972@gmail.co=
m> wrote:
>
> On Wed, 29 Jul 2026 at 13:00, Namjae Jeon <linkinjeon@kernel.org> wrote:
> >
> > Sebastian and Cedric requested NTFS driver support for an interface tha=
t
> > WINE can use to access named data streams.
> >
> > NTFS supports multiple named $DATA attributes, commonly known as altern=
ate
> > data streams, but they are not directly accessible through the existing
> > file operations. Add NTFS-specific ioctl commands to let userspace list=
,
> > read, write, and remove named data streams on an opened file.
> >
> > The new UAPI provides separate commands for each operation:
> >
> >   - NTFS_IOC_STREAM_READ
> >   - NTFS_IOC_STREAM_WRITE
> >   - NTFS_IOC_STREAM_REMOVE
>
> Wouldn't it be better to just provide an API to get a fd, relative to
> a filename? Win32 named streams can be sparse, and it is common to
> punch holes to deallocate sections of streams too. Streams do have
> their own timestamps, too.
I believe the current ioctl interface is the best fit for this
support. It operates on an already-open base-file fd, avoids pathname
ambiguity with :, supports UTF-16 stream names, and does not require a
new system call or VFS changes. If WINE requires hole punching for
sparse streams, I can extend the ioctl interface to support it.
>
> >   - NTFS_IOC_LIST_STREAMS
>
> NTFS_IOC_LIST_STREAMS looks OK.
Thanks!
