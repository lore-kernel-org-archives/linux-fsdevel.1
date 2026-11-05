Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793915604;
	b=bjK+m+r3HNciFge0iy9h7WHD1L4YcT612abKSHB+vT9Sv3ozLZuj8j2EkWr5J49UOBN2
	 INCPzlEn1HeVGVhM3vtWkLOw8s57Y2PziL7QpDU4p11lnVU/WTf229foDvhKzrhRN4NGv
	 bqOwAphFWS8+m0DCnLqKnVeA9kmCQXC5UUAmsydZ0oNPeoTSppoyBUTUEFIhn/2z0LAO8
	 9lS2LczqkRthRsznUA6AcZvtWJKW6GJXqIu+HsFsJumNgKuNgf28WYGD5FtNOis2cFEUs
	 btYEK9u4vHovn3oD7dDTL9jcutpd7qKCYtZRKpYiod8mDA74FssVSlyjBHAjPRvvgBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793915604;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=T1Goy7xxYTpLl6iI5Cf/SMnYKLYp7F0i7eE5R2yNQC8=;
	b=ug8lm7SON0Fa/iQydWHMcQ7gIASyJDw+j9545zDJXdHX1gukVOP7qaH92c4IvY+0/j9L
	 py0cS+dRYDuLyNbQV1nXioeO7o/v1tJ9O5dwx6GlWxOhIvo4xVQURcYi7qKWHwHHv52yW
	 DlJ/f2W9HvTXpfTIWmNm98AKqedd5s4uUXkQkjQFzFCID7xeplRennl1l8SS/SomKYYr+
	 kd7w/OA5uG06KQXXzCtvJgFfqdSPQYzQj5Ckqa93EAeCJ6AYnNCcHQAPTqjUUBbqDWdc0
	 ntrhL/M72mkeiYHmXffi0SmLKmTgFgorX984zdBYhMX1iHZtdt/I0ZSlM6byzu2ywiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BvKY6e2X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B263606D830
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 21:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B263606D830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BvKY6e2X
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ed3f563739so17115ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 13:53:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793915604; cv=none;
        d=google.com; s=arc-20260327;
        b=har+ISTHeayglbj53DaBq2REKLNZ5p2vuk6/qyKEn2ihnULt4RKf6q4YJEHjYrYkHM
         wUThk2o88kBVb9F8GimScZ+0/ZZBgKne698cQB4VX32Km7JLL/1w2blm1w/uWR4p5242
         aYdOLzuhWF89MncqgZLD+IIQEb3IWH0s7B3AoqsfXPro2mQi5abqklvn41nSO+Lplpp5
         amj9ZEHae6MAjTbhWXHU4b5njO3lT3oSuR3zhw9KpNMFDOoRhqB3uwsKU1SWx8GnlUSJ
         8PzdsLkatRryyXucIpSQ4bGxTtQ5TlYnpL/XsIDZobASJgmc+6aeXINCyrKKcc/xgjgH
         e/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T1Goy7xxYTpLl6iI5Cf/SMnYKLYp7F0i7eE5R2yNQC8=;
        fh=yflVqdGPu2oRxRYu4Md+RYPmrZ8ngI4uzTYNDLsmx0g=;
        b=cPxk7wvXD5C4fHeHn5TckmXSujC5gCfo5xhOJbNVpimwt9dOoSr73ymVfDFXepLETo
         Hwkjl9qf1pdZg73gTu43vc/P2zw7W58p0LvnrZ4m3QFAfggqNdwODJPjC9DMiFxzE2jf
         6xs9v0VKc0HZx6tuzQ8/QNjuDxZkyYktPD2rvcsyP12tR/6V2GPRqem5yEZvOB+V1ndv
         Ko6yG5/ov4XSczLH3HCi9Ws0PyFkce5PMlmOqcZu2vNK3E0p8yUCmGmPxGiomVAicuuo
         t5MHDNJi5IdP1GAoOPu2Yp/N+PDem836RJS+gF7SZhNdFfuvpeoHFJNbnzj7SUY2cM4b
         MiZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793915604; x=1794520404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T1Goy7xxYTpLl6iI5Cf/SMnYKLYp7F0i7eE5R2yNQC8=;
        b=BvKY6e2Xp6Ln5F/x7uNfqdzKgtfxq1IkJFx3pmCOe8AAZ8lEZ/Vyof2i0EbXWI2Kev
         o0vJTBuh5IlEZrN+FoMHcWBASIlx70c9/Adv6yKBmkGLu8NvECmBYo5BWv+20zsjaZTP
         BTJWvsdkA+A89jdxh3/XR6JKPs2jlvstBhYvKqkg694XZwu0UlHnD2bZPsyJlMu/FqI2
         5rVfmYKb5EK8qZa8eRjwlef2Q/zF4LV+SdOUFeg/3SfNdSqzrjKqO+STiWOuSDJ+5YbJ
         mpmnN23JttD9xkcrQy5mN+cuuJMA0UZNHbYctSe8k729RY9Dj4GCfWEXEAue11TzHaPK
         /Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793915604; x=1794520404;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T1Goy7xxYTpLl6iI5Cf/SMnYKLYp7F0i7eE5R2yNQC8=;
        b=ASZYgc/gmG6dKFsA4k114NJzL9SBolXYxNXFRNRzITDyL/kYvnXGVIgEMHHW8VSvjW
         vTDQz6ciM1ScewytmdLGZRrOHwR0LZgrP2WLg2a3ZmiXZFhGdZB7EQCNPsfX0mOHzlIL
         NarSQ2ohEGkKV6w/pS6WyaX36XeI3Gf2JaZzCc3IpuM3h3SaiDWFMVbV1ExFfePw3hg/
         tYNrlzHv53+R42gcs0ZFqYAXlivMkL/2/wOilB/WgI2Ckw9WqWUcX69C20C2Ko675R1+
         uCStrd6JBw1SHuicQvbeK96zJXM7Pg9Ey2MW6d48iPcMLok/L5SeI4hBdppByIX6hrFA
         q09A==
X-Forwarded-Encrypted: i=1; AKwUvBx3cblIVcSD3yTc8ZldD3vrHA5U+pSjVTBaWPLFzL2YDS31tqiBy2kafYIjRyvzNj6BI0mhqWQG8k1cyrZL@vger.kernel.org
X-Gm-Message-State: APuU4Z9mfu9uwqbhFRAIqpuvjvRvP/1M/IcolpOVsQMs1jigsnE1ymFk
	v4Tgr0gZzIXdj2H6TQ3PxKvlUOfgcCInxoFPA4zsjExTSn1I4F/0kK2GIBZHpEsQMsgnM1cnE/E
	pGjZJLntcyq75v8m4aRF3RRm/bpibnFl4oKNcgqZKixH+jj2Vtz89o3d8XQ4=
X-Gm-Gg: AYBFou285rYp1sT3xqYQbajUFoPvA87wFqCSnuO5atm7AVPwSY2nyKTkuIxYyvUuhAU
	NRHFYQCa5x3FJc36AKkb4EBqVi8RY4NAPEuzD74DYJREBS5QT9pI5BWJ+WpoyP77P/hm+4V6yk6
	DkWH3GU6xQh//b0ExhQf2CiUMQQ17hLrTWYJTRfnDCB8zut9MxSu6FuODAke+AwpimkyhdCeoP5
	oDGUv1TahSejbTKtw2eSoLRznHd9e+rTVTQeuA2GQMYCIZpDC6To1q3VDmUBxgLeafBitSnqTup
	vZxqun0+mOxCxeQ69uVnXHnrptNag8MH0/FDO8CrbnBtR4wqmNXLOj17UBQYxPdnk+kGCJtdE0i
	kLImG8fkKpIpacxSpg8rulRFZZn0kpkYLV9rA4Sfg9G5pX4hUIzqWf9VGMzaEnwFm776jSj9gVI
	rmRGZdWe3+mSnBXiwG/9nI3A==
X-Received: by 2002:a17:903:2984:b0:2ea:1fa0:8068 with SMTP id
 d9443c01a7336-2ed45dc8242mr607525ad.16.1793915603342; Thu, 05 Nov 2026
 13:53:23 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-22-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-22-245e54e87116@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Thu, 5 Nov 2026 22:52:46 +0100
X-Gm-Features: AclHuK--g15JMQpiUrOd3ScDdiWIvqDdktQBZHdY7lnmUTwptYJN0x-mP6LviEE
Message-ID: <CAG48ez0CTxGiZ-q73k8bNhoBTW7xZfWwARCKmmM-WKr6GNBbeQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 22/26] ALSA: info: let procfs own the seq_file
 of text entries
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 8:47=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
> Declare the show function and let procfs open and free the seq_file.
> ->proc_open() only sets up the private data and preallocates the buffer
> now and ->proc_release() no longer releases the seq_file. Reading an
> entry then no longer holds up its removal when the card goes away.
[...]
> +                       goto error;
> +       }
> +       m->private =3D data;
>         return 0;
>
>   error:
> @@ -387,7 +388,6 @@ static int snd_info_text_entry_release(struct inode *=
inode, struct file *file)
>         if (data->wbuffer && entry->c.text.write)
>                 entry->c.text.write(entry, data->wbuffer);
>
> -       single_release(inode, file);
>         kfree(data->rbuffer);
>         if (data->wbuffer) {
>                 kvfree(data->wbuffer->buffer);
> @@ -401,11 +401,10 @@ static int snd_info_text_entry_release(struct inode=
 *inode, struct file *file)
>
>  static const struct proc_ops snd_info_text_entry_ops =3D
>  {
> +       .proc_show      =3D snd_info_seq_show,
>         .proc_open      =3D snd_info_text_entry_open,
>         .proc_release   =3D snd_info_text_entry_release,
>         .proc_write     =3D snd_info_text_entry_write,
> -       .proc_lseek     =3D seq_lseek,
> -       .proc_read      =3D seq_read,
>  };

Is this safe? Looking at the work.procfs.cleanup tree, the
proc_release handler (snd_info_text_entry_release()) can call
`entry->c.text.write(entry, data->wbuffer)`, and the only kind of
reference dropped by snd_info_text_entry_release() is a module
reference.

I think the entry could concurrently get freed by snd_info_free_entry()?
