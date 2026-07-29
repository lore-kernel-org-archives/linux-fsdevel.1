Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA8456283
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351467; cv=pass; b=Amv6nZAjL9FAp1FkJOvaGKpn3NBdoBaDScIFS+jMr9/F7eqABvMnddSIjtMWWP/7T9gtfX/Prgvt6ULuyUTvDYgEj0f/khaWWYOFfhUFxUNS5MMQ8Jq+fhpF+dCxfVNQBGvaVLMZwO56zpn3NNHhjGsDMR7itffT3PK/wayeNeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351467; c=relaxed/simple;
	bh=KPTM8WsrM+BqDuldSkxfB5b9uV+pWlsBXXIQBR+/rKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLY9YxlyJVTBzve74YE8dBtxF5K/FLg0QwEiCopDdeFgptY7tEy+UgCsL9t121dDBaznaCj4gRVACRM5ZzFbOLSoLrln8IMFIMzace+ou2iQsDHUUuTpm8C0BC3NhLqnniLOqBxmfxEvtRp146pnHHUBqyvaI8XeHIqAp+XzuSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG0tt/YA; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG0tt/YA"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f9ab7ee38so860658f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 11:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785351464; cv=none;
        d=google.com; s=arc-20260327;
        b=AwQ3v8FAJUX+lvfRX6JXVcDXa8fwvEMtpgS4pQJNYueubOS7a1tRnmus1obw1CxmuB
         4myrWrbhJuMebnZ7CUNxsd7enaoRspYpBa2TnG+g7vN9/ITiKbXzvg7dmrmmpkSmLwmp
         xfWK5ZbVEJ6E5W/bk+yRK4KmaN80IpdMXX9k/2T52zij4HrUNq26eEt8N3NOwcw+td0b
         47kIqxxtL2K8TxRR5qjqVwrkoknXUFMBc6arNZck9JhFmV4ELI3icOJmUs2YZUABUdSH
         q6ogQ4JBSBg+l3fScgv0fsU0htz776VY0zWnYFW0LKm+HM296dlWJXY/VJhmCLhghYi4
         Dckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hrYoz+dHSHJ6SiWtUtRhVIViWrdquT77cC2xckRZ/s4=;
        fh=BWaTmF1EM5QYWboeVhGkEUVJNPjDZSRsUT4XSnv0940=;
        b=i26aUY3ZjX7NK2/MXeEyeqbGv4dL3JGJJIXLB/SNa3nXYmSEa+aerlio/Z+RsgF3Vr
         L91Sx8v40m9XHMcgeMGwbVPYYbEAPNPQ8NuxTEbYT9jd6t96Obvn96VJITxZMOZ/iZE4
         KK16sWdXMi/Yj93SqBxAVJ+KeOkGpbVsn/fPWs8bSV8YtSAGJRm/C8vnYWdIRx9P3X+F
         XBr7rhXEaaYsiZJo9FjJzwRgOTASsfja4PkRNFdn+0t/TxWljNv2dFrUnpl8UGj9AKs1
         hKj6B9fkD0M+7jysEbBbQYmmJZOMlGI7FXkMqnpDG+lDmmwvaXAMsXrDmQpX7GRnvi8F
         /rAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785351464; x=1785956264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hrYoz+dHSHJ6SiWtUtRhVIViWrdquT77cC2xckRZ/s4=;
        b=HG0tt/YA/SSLfwLylBcNQhEwFyWO1drr3eRQ2k8B23pLjX/HI/2cb2evXopALFvuuk
         MAFC6cRYVjBdqMBoSW2+zuwN84/HqCRN3O40w/7tZWCeNwv0TUt3vAD+BiGVToHDx+g0
         1/1vFeXQ2C3WQFDDua64DpArALa8XLd6ttONE70FinI5kKaDBY6Hdwmtp92A6XKzD4CQ
         S+/6R412oyLDPlk13gILEfPil8d/9Ca6o0sb2L0ETV1/MSAC8sLudxzOpLpVP4Ys8gVS
         sUjqUqBnjydvSZW21v4EyZOx+/hTh3+245DMaYmGIIEveluYyb1EcsfN6VIQ6/qQOOHD
         Qreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785351464; x=1785956264;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hrYoz+dHSHJ6SiWtUtRhVIViWrdquT77cC2xckRZ/s4=;
        b=O0UKCmPcFfyn0qhX64EpK7m/M8nXvykaHCEHRUIVBmZ+SLmY1nzaSOKodJiiH0PQOD
         fO9u8NunLXebJbxnkDsQd5HpeSpAdZ2Blhh7Dj8w4KFCILM/Gtixa/h2taDnD0vIyLrZ
         gi2VrTLQZYic+9Q9ssw9VlBYkZ2KSO70xgj5GSt1r69WMDnosUGH2XzvXCAW4+Bv2erD
         hSOnCPlYjC/9YAY4RRX6WsX44tS6r1NGL5KoP7XVNfK+gw9j6Htq6L0OWsduPU65PlBP
         i5PxS06wqHoqBHnWodUtn20UZHoBl/lnu8MEIslKL535K0x9oa6VSnjOutVfoNqfX+1N
         kL3w==
X-Forwarded-Encrypted: i=1; AHgh+Rrh16pcqh+Kb2dfhQsCPSA2JcqXr6gCpDepmiPTRpyRXvQxB9iSJqSD/Nmdyprpuj/L8TgX61tRH2jAA6e4@vger.kernel.org
X-Gm-Message-State: AOJu0YxEn5tlGi2xXuerG8D/1UpWPtl/tL85FxJxMMgsHP+FAtN5r7aU
	jK6E3cjjA1BaP8QywUud7ChXRpWYnyqI+AbXmUSU2VJ6UbPzXa1Pl9fVMu9J8nD8nawPs+SlWR9
	JGY8dYFQZfeSS3cx9pYT7zUib0GOVteM=
X-Gm-Gg: AR+sD13Y7cGBcX/UTxuuwxm5Y8Lxp/bIz3l+jL1EYtdiEj4z6FQCe6Zwu+2cMUVC2I6
	M+5li6mf5wsVuE98mSR9IUNashJkyQk8BU708imZQ6KbmwhKIZ1DjWSfwRwwgBE1DmQiPqFa+aX
	ccMGpp6wEW0/skJ0WW75GHoRmjGUW++y8NQssMh4wWALIaQe7Qnc1Hz+xvWngIJiq+VEzQqoxX6
	/rGQG17AGJuiQXMmY8lRdsYKpRI/naxdrJpLgmM4Yej2SbN0YKaUHrsmce42Y8NCIBBWgT5zrOU
	igXI3QJAJJYEdftinloO8vcs5YGm9aEF3G1n2qcn4m93w2bXSA6BeL4LOzZ7Twt30t6a6onvrMa
	+HhOyjwUBQNbYrTWTbgXZI745
X-Received: by 2002:a05:6000:288a:b0:47f:8e78:4d0c with SMTP id
 ffacd0b85a97d-47fc66738eamr85810f8f.48.1785351463693; Wed, 29 Jul 2026
 11:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727211758.1116539-1-joannelkoong@gmail.com>
 <20260727211758.1116539-21-joannelkoong@gmail.com> <20260727223345.GI2901224@frogsfrogsfrogs>
In-Reply-To: <20260727223345.GI2901224@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 29 Jul 2026 11:57:32 -0700
X-Gm-Features: AUfX_mw2AKZ6T_CPZERPb2AZJh9r8QLmI1mksg1KCuOzXLA3WT8egaBLm2tNcG4
Message-ID: <CAJnrk1Z7Z3F3_Gee0Ej0n_0-2LPxJq=4rxmw=xg+e2ryoa6MNQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/21] iomap: pass iomap_iter_next_fn directly instead
 of struct iomap_ops
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	changfengnan@bytedance.com, kbusch@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	tytso@mit.edu, Jaegeuk Kim <jaegeuk@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, libaokun@linux.alibaba.com, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:33=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> > diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> > index cffcec532ea6..d2d3c84d93f9 100644
> > --- a/fs/xfs/xfs_iomap.h
> > +++ b/fs/xfs/xfs_iomap.h
> > @@ -53,14 +53,22 @@ int xfs_read_iomap_begin(struct inode *inode, loff_=
t offset,
> >               loff_t length, unsigned flags, struct iomap *iomap,
> >               struct iomap *srcmap);
> >
> > -extern const struct iomap_ops xfs_buffered_write_iomap_ops;
> > -extern const struct iomap_ops xfs_direct_write_iomap_ops;
> > -extern const struct iomap_ops xfs_zoned_direct_write_iomap_ops;
> > -extern const struct iomap_ops xfs_read_iomap_ops;
> > -extern const struct iomap_ops xfs_seek_iomap_ops;
> > -extern const struct iomap_ops xfs_xattr_iomap_ops;
> > -extern const struct iomap_ops xfs_dax_write_iomap_ops;
> > -extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
> > +int xfs_buffered_write_iomap_next(const struct iomap_iter *iter,
> > +             struct iomap *iomap, struct iomap *srcmap);
>
> I wonder, would it make more sense to have a macro to define the forward
> declaration?  e.g.
>
> #define DECLARE_IOMAP_NEXT(name) \
>         int name(...)
>
> DECLARE_IOMAP_NEXT(xfs_buffered_write_iomap_next);
>
> Hm?
>
> Though feel free to say "declaration macros suck!" because they do.
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
>

I think this makes sense given that the definitions are generated with
macros. I'll include this change in v5.

Thanks,
Joanne
