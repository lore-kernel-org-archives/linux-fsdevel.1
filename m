Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795474038;
	b=JpEKg+6hPf2lJ4+72o9m/gp9gjwhgbJQSVsxbcuKahs0sMXJ6epYAeToLgmniZYmZgCP
	 iiRHn28ArG8LYwSZEQrESeJBtGBK959mpbkzdsYvo6SpiihPi5x5aPrc6NvUud13UmdLA
	 vdQcmSguu+a7SPNxdl1/0+spHHxmoEcdO4fqJlMEByCegH8qOJ9RcCkLyY+vNg+culqoi
	 BKb8agSrIhmM63TaNA5Jvtsw4PGmmpkn9dC9EfkfDuPmwM8Hug3yCTRKD5ygACIJNxU7l
	 hy/mLIjjgvqtwMuHi5s/EdzuF3mlGDh0MW1e+Q8M5IKpMrkuenqdcYuV4oIE5xWhABQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=prDmnot/bOxVS2gCc8v9HfYcjzpcvwnB8HRgvfXYsr0=;
	b=azg3h1G3yJO/WqjtFzI9XZeN/eFOldc2zqyzt5ZhKHQlZtnRYPzPfnnsfQrvyKhr8US7
	 tSRQignFvVmpS/3fH2EyWACH92FwvSn25ujx/uPKrWrbiby5VVKgHjj1bQ7Zwg2W2VxeU
	 QR0ttOHx9YyLmkX5m3S/S027YidePrduEChbtmWaWxJTaKW4f1jeL3TlKzhgF6OxHqCgJ
	 r296088OLEGFNXXawzmwyRUnx96lvbjVWylN2sZDIdHMqE+DtfamI3pUH8uN+VJ6wW3IP
	 hDSTWRwIYvNNqWlztf5smCInn/hIbz3xNsR0GU6DGSxx3TDHdsNCV6GB0x/2r0JyW6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e9TlTdXc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE884606A326
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 22:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE884606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e9TlTdXc
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b88b74e54eso4643436a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795474036; cv=none;
        d=google.com; s=arc-20260327;
        b=AkCzT/AwzFqYZaWMFyGjJzhOePNVPYCyx/FAzLdJzISQ/Tv1IiXhQkpAoouqaag713
         6GTCM1QskWeWkDUaLbFuIP3tAryXTZfhI3k4k7gEyyuoMh4JKkPRDTg/VO+q0ejpZyxd
         3ucwgw+6Bg1QDwj3X3dPeq4E6nLglkYdPVKCMDIEeJT4YPcpo0wOa6+acWY0LhuJ/9XA
         ynb5AV4ny4PWIuJitiqT7heict2GPbvFGs2YKiNPmLnes0wKx80eQ3wohZYDHEZdJ07H
         QHM7nOl+nGe2P9KvlFBIuEMe6kGU08IEOm2ODeVD7buWhbpOrTZZIjzGb53Q7FvR1svy
         BsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=prDmnot/bOxVS2gCc8v9HfYcjzpcvwnB8HRgvfXYsr0=;
        fh=qwNnoWHYqgIj6VrAW4x9EwH+RtinSVqTmC/QnHhfN8g=;
        b=LezW+67PAIetGEDhXOggKZgDyLRXgHLXDF9Zgxx/pB4uD5pvE8V4f/V76MVR1ci5+A
         YdVahSOicNRaOKKh8WDisORMfiaV+2c2tL/eKO1D1MuHQ/18sLo1lhrFX+YHkZB8xIbA
         WQORhFduuc9xtUkGkz+IIxd5uUz25eAejIlx7nskoOv1HoyiqxClVHxk6gjBlUXMH32H
         oIPQmu0oxZQumCH3ufbY/jUe1QQ4KwiaDQCc3g5lHoKKDU9Zvz+2NayQFMDLNUhNfJbM
         xlKGBqzg5+LEHKdZ0P1aOYrq00c1fNSTVHOdm5OHPbkH6BBS8p+PJqlKYsLD4nVQ1SPQ
         yEDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795474036; x=1796078836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=prDmnot/bOxVS2gCc8v9HfYcjzpcvwnB8HRgvfXYsr0=;
        b=e9TlTdXc+gatXcuCFKKb7aj/RyvKZZs3Fc22DsvCbrqYMGGtwci3FfIjibOfYQ/CZW
         9N8fj6eIrKNnVRdbxmnkFIx1GgLKrWEmFGL9vOQOEa0GR8Bc8q6jIgpflc/R1WmaKkIq
         a1L/XNzQgQR2OfVdP5ZWakzu06AC21i4FBAOG3jwYP8Lhy9AUkzJO9T8iBSrC7rM4aSU
         +QCy52SpD8tCCzGsrVoCDffQdo0iiSxV39ldqNaCG7VxnqiWEDVWhmyRn5+Uk0DxMQhg
         +jgf5l52Pyk6Ega5GmFX/ULCv5YHSq3eiAljutksNIdRm4c/i9EcMfRht5xGucVDbs5/
         qj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795474036; x=1796078836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=prDmnot/bOxVS2gCc8v9HfYcjzpcvwnB8HRgvfXYsr0=;
        b=nh+cn3hVGEfbzhxnSlDrcpc9qJfYRMGKUIbW4MuMnlKgUlxoGcU9j8QT560dZoy+wp
         rB9bCsb1iptZiPQFE2c06faI9EZgl20KnJBZLaQsCUacbihnZ5jdu7B3tn6yA7/axJ4e
         3G82/sx2KRCGIzXJTJ9EsmOJ4K449dlsOuJlm7TjhQ7BbG97jj9iInkU1bC63FVcLAae
         D0fAD8WNwlS1/mxevlzf7DVCG0TRKQHZfqJTL8o9awjuV9iWh0ZPXsUxQ7d1Z/D2j1ka
         yKjj27Z3fIUNVmKlFdI8/eRDgGZUg2gAn/LIeoqcH4IVzX01mdit0vJ7ku8ITueBpx/W
         SMrQ==
X-Forwarded-Encrypted: i=1; AL+hErFxgrVWOhBfGlvuKDJW4LRTADYsIVK5O/MSmELQqrr81X934uewOFfruX6SZ2P9JHxfihoQOExxy6TZyIk3@vger.kernel.org
X-Gm-Message-State: APuU4Z8681kWD8lQGSuJbXNOYn63A0Q32RjnpGQ91dJdyIQbadK3cnek
	vQkVBI2ZCwT/z8Pclb1vIqjhyoRJHpY10xA2mQRqo+TQG/I3bawYKEc5HN0IIgWvQeQpRM3A31Z
	tZswEPTpVZqCBgqmOP6HHk2wyXQVETeQ=
X-Gm-Gg: AZFdTZclxE8TZKRnExAzZ6HXpq4heR9xvN4C9SnA37g56QVXgcW0BKA2/94PKv/eLpT
	kXY+yDHGgzLuDMc+dO7fiMlinGSOHX/UdKZ5/p0xtLN6kPtifBjFzdy3Qy2/WQafla1WLAS/PfJ
	QyJnuuqkqh4RAxF21GmPiWsnrhZ0l9MAnTjDumfksUVLkxX+7zfTKcTH2N454Zs4++GSdvoTcK7
	89ix9t0fB0F5xwnqHXm1ahKTnMQAV3SMNek19lnxuizI0Cka+yxFp8Ztsas9a8QIscGsfliwVX2
	239jUNs1sggG0F898Ye49lPiFcE5LNzqvPszX3V6BQq9ioiODGd9CGZ0shQ7k8RXmnKwXqebgKZ
	3tTkpOjflTXVnpzXbsC2JrKlkcqRaGx5YGOm9sGQ/E+AF45+dBA3l+M9RCsl+TduTNjnrTg==
X-Received: by 2002:aa7:c710:0:b0:6b8:e848:d004 with SMTP id
 4fb4d7f45d1cf-6ba37e8dec5mr6855932a12.29.1795474036043; Mon, 23 Nov 2026
 14:47:16 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122000856.536902-1-koray.fra@gmail.com> <CAOQ4uxgf2KE=Ag13EPAu5=KnrFwt7zRH=im-qmLc8+i10Tjd+Q@mail.gmail.com>
 <DN2X3RC5JUFQ.2LNGLQOUX4ZPF@gmail.com>
In-Reply-To: <DN2X3RC5JUFQ.2LNGLQOUX4ZPF@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Nov 2026 23:47:04 +0100
X-Gm-Features: Aa3M54pZr_aGN97hdgjJEJclpmHDWTbmXWMujrk4s8rCr1BMot2r_DEgpbuT4T0
Message-ID: <CAOQ4uxhsv_1EEqAZ3Ebp5Uy8Q6nvEnE3EAomJjjQO86nTcW0cg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add f*_xflags_{rw,ro}_mask flags to the fileattr API
To: koraynilay <koray.fra@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Darrick J . Wong" <djwong@kernel.org>, Andrey Albershteyn <aalbersh@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:45=E2=80=AFPM koraynilay <koray.fra@gmail.com> w=
rote:
>
> On Mon Nov 23, 2026 at 2:35 PM CET, Amir Goldstein wrote:
> > On Sun, Nov 22, 2026 at 1:09=E2=80=AFAM koraynilay <koray.fra@gmail.com=
> wrote:
> >>
> >> This is a follow up patch series stemmed from [1] and [2], splitting t=
he
> >> _mask change for the fileattr API into its own separate patch.
> >>
> >> The first patch is a preparatory patch so that the code in the patch
> >> after can be formatted better.
> >>
> >> The second patch is the actual implementation, which introduces:
> >> - fa_xflags_{rw,ro}_mask fields to struct file_attr
> >> - fsx_xflags_{rw,ro}_mask fields and has_masks selector to struct file=
_kattr
> >>
> >> These masks have the following semantics:
> >> - rw_mask:
> >>   * for filesystems: advertise which xflags they support changing
> >>   * for userspace: specify which xflags it wants to modify
> >> - ro_mask:
> >>   * for filesystems: advertise which xflags they support only reading
> >>   * for userspace: ignored
> >
> > Nice!
> > I think this API description is very clear and coherent
>
> By the way, should I use this description in the commit message (and

You could use that as a short TLDR intro

> integrate it with missing information before/after the bullet points),
> or should I keep the current one?
>
> (current one:)
> > This lets filesystems advertise their support for specific xflags, like
> > statx.stx_attributes_mask does, and userspace can specify only which
> > xflags it wants to change without needing a RMW cycle:
> > - on GET: each filesystem that wants to support this new API fills the
> >   masks according to its supported and read-only xflags, then:
> >   * for boolean xflags: it fills fsx_xflags with the current on-disk va=
lue
> >   * for value xflags: it sets the xflag bit to 1 in fsx_xflags and the
> >     xflag value in the struct field;
> > - on SET: userspace fills the rw_mask with the bits of the xflags it
> >   wants to change, then:
> >   * for boolean xflags: it provides the xflag value as a bit in fa_xfla=
gs
> >   * for value xflags: it sets the xflag bit to 1 in fa_xflags and then
> >     provides the value in the struct field; if the xflag bit is set to =
0
> >     instead, this informs the kernel to unset/clear that value.

You can keep it also but tbh UAPI documentation is more useful in
comments and in Documentation than in commit messages.

Thanks,
Amir.
