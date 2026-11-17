Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794925910;
	b=vvDTpZxGqnW6eIubQZEOq6ylKNC4Mmmbt4mK+bmG2CtKxIVP3C3LwP67/7/c3XXI7Feu
	 l3SQlSwEv+9k+ATUA7l7eF7oEtD5veODLIF8ZZ8Uck0CR3tMSzAG+IHin3WZF0NTC2PNJ
	 C+cLovJeKjdg2kIvAaLssI5DEZi5VzuMmSmXc/XBR00nxQCKuS1nNXTFJXmko6fjW7ILH
	 glcGedf3rHa3Ke6MFPGspKk8dn88YPYZgVQ37aDnnamVBgFlKjy5SeDTazAgTY6CMfXz0
	 +Odp2HmhhOV/f3oEthhNmIAkTa/EzoIuRcnoqjJQHolDvPA0okQdyFPauO/g7BkKPfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J8J/dU+jQllMyvNevSPXlfSxT9AbwROgLjn7O3WN4IA=;
	b=w5oUyElCOlu/AXAUhOtNhe7u9d+kzUA2dV0xj5pQ8jAGKqIB9SX3G/9c0l9B1vsbhTL6
	 TTlGTfj0prpTHDZb6Oq63l+/9UBu6r8Djn7aEIU41D0oaUvtIeijcoH07nMgCRfTHEzEM
	 X+ZwCnQQKVUFGF1qso2og0SYwMC6UozjYCm3d3vssQRWgFheeyM03q8u8cR28Sk5Lr9eP
	 ZYDEaZab59yU5LfALKxE9dDLgWse8ZCpXiu5o46WyyeCpgfct9mDRZaacWZk79tlQL/AC
	 TiMRr83/+YayJ7JSRZ/OoPkFbCkYaZU+Yo2/cSkl1bHCZgEEaTu92OhxhcXgU3qzhkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtKGVGn0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F240606A32F
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 14:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F240606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wtKGVGn0
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso4790335a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 06:31:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794925909; cv=none;
        d=google.com; s=arc-20260327;
        b=m6649avw3KTqx+1hZ6lRHLJbqXpOQLNlsSJFfx430ypY5/akkgXo4h8SraxnVkbJDA
         Y22t5/7y9cMjVAOl2hTf7Le9e0vlbkb6esteovVvJ4p7LD6LeuioCdbXGsKUFshgYw8X
         uixVEUyUs037Kab6pSgWXtwX5dBf4NdEC7ZnqRm32Wdvay8/A9G9kLBLxK9V0k8Vn/VH
         oeEU+nwBbBBbHUV+QvSalZkpJEz/Mg5iIJf6hwOIf6EF3JC6r14p9J63R86u4DY1tI0x
         T7n5SIGfdqZN2aACDLfwP2E0Sfd15J6VG0WHnddGney8f4FWPU+PM7yCOnZzBIlJVScS
         EU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J8J/dU+jQllMyvNevSPXlfSxT9AbwROgLjn7O3WN4IA=;
        fh=9Y4UW1eZMwjItYnXwQe7P+ZelzuEfiAy+WI1snBFwpQ=;
        b=F+AjEXyMnVQO4LBoIVyFxeG5AM9746uDJwmpIb34j7Ld0wyc1AphFgDCNW2atMJ2iM
         583UyIwvb7v17x75GmxGCdRUXRutoPw3vXNsD4CHpvWJIWrSxZvcfQi6O7PSEkqPSion
         BQPdcTGLh7op8HOxwl5zwbFAL8cFgZoEhtRtpdN9p+4OkMRKhzMQNtusZRfWsOorwFHt
         WTXRDuRQmG/RhJ6nlnQvSITQOBcqcv5qtbST/wes15cTGgFtJc7/sGGp6927aTiVAZ8l
         JHetwuvWPt+Mb73GD5qje5y52WkqZhlT6CpcAQtofZFCKZLensWVKGs8YkPq3tOTPUHd
         f3Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794925909; x=1795530709; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J8J/dU+jQllMyvNevSPXlfSxT9AbwROgLjn7O3WN4IA=;
        b=wtKGVGn0xuIg9f8ztH4vispZRzPrxenA19/h1TAjvBuP+4Fvd0WIB2CcOZkuGudL4d
         xJnId+eqSALHeE3/PkEg8uVqqyd/tDX+Rr6RjCJFiJQ0ZihepHK14fGjEyRnp1Bvnf/O
         UwdgI8ifrlGm6EIA4NcgTSX7GZg5H/tSmlInPjG8WAPqy5PdauGM2qUrjTnr2LnFLCzj
         a94as4JAHrR1uf+TAp3KypwkaLHmK/oeHEncKbjRxf6usPeFL3l9vdD63fSOIJTVzEt1
         xb9IPXG7EwjHpE/cfjzmkoTUVNFaEgi+eSC6PJer7I22OucBiZvkaMoO/FWaAbtcpSqT
         UHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794925909; x=1795530709;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J8J/dU+jQllMyvNevSPXlfSxT9AbwROgLjn7O3WN4IA=;
        b=BsVohwLs4uBldr/s/QqwdfMqZYEKOAXSJ0S/XTHFqaC7gclRWmKjvFFgySb2kSE+vO
         C+AvHWcEch6VrWNIW49sjzkzGeDqvwc62Sta8qtlqM42HXeEBGxOeU3QwbfDQ4guhmKG
         X/ClV9hgQAeXnS1vMs0mI2ArgYHmfuCtlGFhMqlWAvlUoV040Tn8VtIOqx+mLo1hk05N
         6BUU43kenqf38Jpoj4xMOrRJL/4QrS5DcrfattmFuzYslcldFZC4+qlEWyAEjaFpXZ/l
         ym3vNGqhh7uBWeYRIvBaCICwvAwUfdqZ9yqGYkgZo9CSxx0ePo2O2CemmUqbUKPZkq8a
         kk2w==
X-Forwarded-Encrypted: i=1; AL+hErHBQoOf8LDHHVSkLF6ZX1E5xObRV83tWzWfsdL9yBf2Rzz/kXQykweHOikdGMgPALh4Jmhd1B9G/8BgYKEc@vger.kernel.org
X-Gm-Message-State: APuU4Z/71dCJjPdMuRheA210EJl6irfFyrBwfH1QVI7HZ7qL2fLybiJf
	b5BgbbxrnrQBga5vTB7RXYkeGsXBjp1DdeJRoxfy3OU8V6ecsvxd+y3I7Ykg48r7BRs/PvFLy6E
	d7r43ldSTdA5AVa+d15FUjkVnIF7hqOo=
X-Gm-Gg: AYBFou1767GvfnlDJA/g3mNOvFwoAYZeRPjro1dhga3ZW3D7DVfsJ8Brll9OSDvmIiU
	BHOIDQAqb7arF/7aCN6q2OrxxCGDB95Ce393+3i75GApSEGsSdSnhiGiXj67zVJdLLQUiIK8j65
	zNEEmb82hv8p9XQmpOqdNIznP89KHbtBB8f0vAUVnb+X5k+9fuPefrNVzf1Xxxl4TEsQpCs6yGC
	v8YKjiUDoE3PKKSaByrTra6Jf2JnKmlPxkpsKkZA83PZFONNvEbY8m4gdjTsQxXkqI0j0uLedwc
	AKryfDZemuGvDH3HE3CcYE7Z+z8+iK4EJRGW2Fg3vq+KhDfRzWhGSyzFIcuLyymlNjjlpZ0NDzr
	fMG5WljcutJIhXHOlcNSy7jrnJJEWeXo1QlLp/uQ03DfCYXLm2q9g2grc6ZP9ldsZI64DfwRYKI
	tKky2OKB3RiZKRtGg=
X-Received: by 2002:a05:6402:1f49:b0:6b1:cd52:5798 with SMTP id
 4fb4d7f45d1cf-6b7c0d2476dmr11277202a12.42.1794925908479; Tue, 17 Nov 2026
 06:31:48 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117135146.3174252-1-graypanda.inzag@gmail.com> <20261117135146.3174252-3-graypanda.inzag@gmail.com>
In-Reply-To: <20261117135146.3174252-3-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 17 Nov 2026 15:31:36 +0100
X-Gm-Features: AclHuK-1tfZhKwrVCdjfTj54iWvStsZEppahje6OeA9duQdnuQ1FrAmDZgLv9Zg
Message-ID: <CAOQ4uxiTpRO9ZOFpKRHjGakB03X=8HWEhpMxj_xcMp5yc4tMUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] inotify: copy full qstr length for event names
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:52=E2=80=AFPM Junyoung Jang <graypanda.inzag@gmai=
l.com> wrote:
>
> inotify_handle_inode_event() allocates the variable-length event via
> kmalloc(), reserving name->len + 1 bytes for event->name, and stores
> name->len in event->name_len. strscpy() stops at an embedded NUL in
> name->name, leaving the trailing name bytes uninitialized.
> copy_event_to_user() copies event->name_len bytes from that buffer to
> userspace, leaking uninitialized kernel slab memory. The terminator
> and alignment padding are zeroed separately in userspace.
>
> Use memcpy() to copy the full qstr length and write the terminator
> separately, as __d_alloc() and d_path() handle length-bearing names.
>
> Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"=
)
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
> Changes in v2:
> - Use memcpy() as suggested by Amir Goldstein and terminate at name->len.
> - Copy only the valid qstr bytes to avoid a one-byte read past name->name=
.
>
>  fs/notify/inotify/inotify_fsnotify.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/ino=
tify_fsnotify.c
> index 6e3af6452dcc..ecbfc9b4e99c 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -120,8 +120,10 @@ int inotify_handle_inode_event(struct fsnotify_mark =
*inode_mark, u32 mask,
>         event->wd =3D wd;
>         event->sync_cookie =3D cookie;
>         event->name_len =3D len;
> -       if (len)
> -               strscpy(event->name, name->name, event->name_len + 1);
> +       if (len) {
> +               memcpy(event->name, name->name, len);
> +               event->name[len] =3D '\0';
> +       }
>
>         ret =3D fsnotify_add_event(group, fsn_event, inotify_merge);
>         if (ret) {
