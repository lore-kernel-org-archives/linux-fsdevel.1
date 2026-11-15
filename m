Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794757115;
	b=1CizDAvdS116EGZswjQmtkfIx+Ph2yg8uuu5BqDlspoglqOX0GwWnZwpmZqIUC3miJtW
	 wpQmOa2FTE618kgsU0AUkavrVfaonq6piROVk4l0tE0tICOGtT1gQ3O3aJ2dbAyG0g+l4
	 +U1Qu+a9XneA5Y4s5b1tEvIVCTRJcjxOlNWWoFXnZrByyDbq49MmLwadAvMMqLMYz8iU1
	 qgaoNFHyC6EdMTRz+d8izEZkuUfH4U0Y4+S3FuDyEOs2iyYf7N/T4af+vaSgBULS9TcP8
	 RVLlZJGIRRzeFDRUeQJzJ9dEppKYRjiHXv+qfrmXofZ9XyrZmvEb6Mwo58F6cWigyyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=43TKtnAFPmjk4ebFbbqKjDRdAPGhXSebrdUtk/jZxo4=;
	b=An9V2piu2Ur39CCpRH/FFWOYZR0QNsPQKj0EIZdj8kVIpjzzeSlB88Cl5AUwF8WAEfhA
	 00LJWljaW2pxBR+E3Rabv54blUm72FGY699rqrcx8Gep4rAxZB37xeO38U033TsaE11rO
	 NiFka/ie6osApJCNzASrhUQXi3HleLH3aNsigf8TrjgxfBdT9kVYwCAt4Xhwf8zxDKwwC
	 P4s+vqedul9XX5LEA2WG2RQwI//R1JEONk5pms0ignm4thstxx/02FeX1QbtrqEUAgoA/
	 N9D+LKAXLDjvkV91cyNWtYFaOnyRaqSNrYWYtWB6odPck0udCE0/mUOXLZT7Nry4PGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qa8HlHqm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9909E606A31A
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 15:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9909E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qa8HlHqm
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so3928374a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 07:38:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794757113; cv=none;
        d=google.com; s=arc-20260327;
        b=rAigeepgVh3zQHHHfkxkR3u+Z+HBZkJkDdAd1Z77YLGLZ3lEV9S3A39HZppGqpc66b
         uqv/8W4VT5V6ktWF/nXuiEeLkWcRfJcmDeOzlrolcDqkyoggMvW0zcJQROY/xhYYV1Yw
         6lKQedUCqOCuRRmLRzxTBYCDXlUKAZTDtN4OLTIpB9uN7vyQCpGGpRaDISUCuhuDs9Nx
         rI+LBB8NzC04HoN44+Sl64rMHqCRCqdpHh2IPKVdfSrOV4MIamL6xQUQgjL2NVL/Ep7S
         xhpMLiQdlDfnW5U7LptL6oT3W67F1qDsNyumifvBwDoaXqBaFShmZdTU+UknZ5Uxohku
         TrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=43TKtnAFPmjk4ebFbbqKjDRdAPGhXSebrdUtk/jZxo4=;
        fh=qtZxAndXb/85UDvhLOKPnK6KpJuMrC8EodS6n6wPOSI=;
        b=TVFEoCdWQVf2Gs0An9eTFCb/86doh4R8veUmSLyRjbPzVjfNkOkPQD6ocJosrtAWNn
         kM2rlpViqh/Neohzqwrg+VrOyOozM3110xEGaRyIsrp1vCBUl0M9X09ZynPxF6ErTs7z
         L6/8qAIEh3kkpGC0Yaqf/gxgmK3A8nbV+u3RhwUVP8SJMAztgAXlmmKUslRCos5aQASW
         trsMmC24k1PSdhZqJPGi4OX4baLANEmqoYxruVHGOXU/Gh3JAACAbdWsajFyU1Phla9w
         EujklaT4pwZASLygnGTe25/IJoGn8qaCJjDPnsw/k+DaHwwfiLaKrNKsjCOlRLh8lZoE
         qj+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794757113; x=1795361913; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43TKtnAFPmjk4ebFbbqKjDRdAPGhXSebrdUtk/jZxo4=;
        b=Qa8HlHqm9AmXqHs1ltdkYRPJexFyF07kHWlTDrWk/ImAzQx4k4eDdLiMPB5t19gFNg
         YYP8Q+8WQTYBG1TbQQerTvkl3IZqAjCBeQGs61oMk2fLncD8QXZpjy0KaLGxM/5yfpvB
         8qmUlOfhEiBFI8f4FuwhBfIGOGvK39Ag9qX6dveZwBUoRVUgTCokF+mNH1qllhX9bsPC
         7yJ3xINylvso9k9Zu9ve2i4hIM66uhPhodmv0GPNWPo/AyeqIe4+A28Td0Ahfg4FHL9+
         rrQfNDP0uyfoqeI/QBZWvGMmhtVSoBMLjao2IkTh+nDqdFNVfwHFgNl4XyteEHmL1Jdr
         V5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794757113; x=1795361913;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43TKtnAFPmjk4ebFbbqKjDRdAPGhXSebrdUtk/jZxo4=;
        b=Zi8Z58wFBBpmk9PZUcRKO1SZ5pl3O2sjpma/zE23bYcZBcpefO21+7I95uDP7CegYQ
         MZN8ObJlmBcfNS6LezNw5tdv9ES8ZbZtxGb/fBSgX3E0gq5hgnP32TVflLHenNfMnHCh
         damscjmZ73S60shx6UPYL+95T6vpWLoXxzCQydLAMm63/ImakZPEmn8jP5x9qxkS7rUB
         ZiUeUwo/vEO3lW0PhNwsreBe49Jby9vauBTNQ+h8sodLqq/gAZETHBrO1jy+sId9I/CK
         +9omrv82Niw1FD3v9q5BFYkinxBek+sy7dMLohrYIiveUv7MF6McO6gHsmvgNKP7jVTS
         SnPA==
X-Forwarded-Encrypted: i=1; AL+hErEx43CPvkXHRMPVTihwCd7HZOaGAjZtSvYz66cMDVP6NWjjJB0gh7AJmqwFOun7zdySqQRnNTGgM4gXEdzA@vger.kernel.org
X-Gm-Message-State: APuU4Z/sqizDRUZ/mVTiiE7+e4GJe4XYzPkwYWbSKdvuktT/vjVlKOLs
	2XKKf9golQaxvdbaQ7Xnvk6kpeql/IR0GZPo/YMaBvB4z7Au63x4SDdhhgHea2mgoYRbFk2m7y9
	WRl1RMeAfnYTEgqaIGqw9D2clXrv+Krg=
X-Gm-Gg: AYBFou05Yqjw2q5jUqc1T9TqIb7BILv0Isp9IEeA01HtGZOXUQAtTHBh6bx50svuI91
	iYAASZffTnOz+coONzlMk3PZnY4Zls2PdhTAg3TopSxgKhCDfSRI1gHxBRkYOb928lkgTK/4dv0
	JHxmXQmdLfCenUZMm5LFgdvDsifTkBIty3qJNL7M/Poq+qLCOZVGL1DIR7msoCwxWs7Q0UJi8sJ
	f+OJtDTu/b/C/apBwxlmOJPwSSvdP1bKXY0XvulUwvJ3Z1hSy+qvCDTcQvpjcmHIs7pCyAUYqTG
	ukayL6avWj7R02aJHLeW7n8y7yBUYEiIIMbtbMrXyTtbdtRIydvefI9934/pJn1+inRcP2ciERd
	glDJ/A73rG/+mtgiVDrQgO+5ERJ2ldMA8/migkl6gt6SC3SyoHtrnP3hwMq3REgL98lYcAGWoEz
	MSLCns6icnhWV45Sg=
X-Received: by 2002:a05:6402:c51b:10b0:6b4:2aa6:2c07 with SMTP id
 4fb4d7f45d1cf-6b7c0bc4ecbmr4490181a12.14.1794757112869; Sun, 15 Nov 2026
 07:38:32 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015143601.2095784-1-amir73il@gmail.com> <CAOQ4uxh7oEQ_BzzN23C87+LN1SLoNz2PNYi=k3fNn-NHG4P-5Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxh7oEQ_BzzN23C87+LN1SLoNz2PNYi=k3fNn-NHG4P-5Q@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 16:38:21 +0100
X-Gm-Features: AclHuK_1yuu7Y3LFUYSMeOSSzZK_Xr_ZVO-xEJaYMS6fCcxVigFstp9yh7r5ado
Message-ID: <CAOQ4uxi-6trYv2PR3PAVeX2Sg9X8uv3dz5xi=o0dYKBFbw+PAw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] Partition the fanotify watchers by type
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 7:20=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Oct 15, 2026 at 4:36=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > Jan,
> >
> > As discussed on the "namespace monitoring" patch set [1], the proposed
> > namespace events do not need to be mixed on the same group with legacy
> > fanotify filesystem events.
> >
> > The mount events are already not mixable with filesystem events, but we
> > want to be able to mix them with the new namespace events.
> >
> > Therefore, introduce the concept of "watcher type" where all the legacy
> > events belong to the filesystem watcher type and the new mount events
> > belong to a new namespace watcher type.
> >
> > The new watcher type is free to reuse most of the 32bit mask space that
> > we have internally in fsnotify for event masks.
> >
> > The prep patch set only does the partitioning by watcher type.
> > Followup namepsace events work in available for review in my tree [2].
> >
> > If you are fine with this plan and have time to review the patches,
> > perhaps it is not too late to stage this prep series for next cycle?
> >
> > Otherwise, we could aim for merging this together with the namespace
> > events for the following cycle.
> >
>
> Hi Jan,
>
> I suppose with the firehose of bugs you had not had a chance to look
> at this yet.
>
> Just making sure it didn't fall between the cracks.

Anyway, I addressed some review comments from AI tools.
Besides some issues that I already mentioned on specific patches,
fixed sparse warnings reported by the kbuild robot and some other
minor cleanups and pushed to fsnotify_group_type branch on github.

I won't send v4 for those minor changes because I first want to know
that you are ok with the shape that this took since your v2 review.

Thanks,
Amir.
