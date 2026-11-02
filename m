Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793632195;
	b=AK+m7vCpUieM73a+0kNVSN4xuzfGQ4mqd4nCe3poMS03cAgzeNOF48OIzFrDhDr0VMa7
	 tf1nx7GwaIzH7sL5pQLFcO0kWPwB6hhAtRkTh9fcpSROU8bRjUiLqJCCcZkFUlHJ/avml
	 AZ3GBX89iYn2rs0TzAwxT2/qZTs1odPH6Q6SMRKzjmWLBXqcdMAOUQrsbOJk/jAvMmQzN
	 qwCO8OpHiUQiBglIv7iGoKJIsPoVRJ6Xe1qf0DUsS3Ns0EXveg8Rw8Yu005Hwy8jPc6Uo
	 To9TT/6KmgUk7eImpxSAXDM6fMoq2HmLJXWks1PJETlDeiP6uXVAwVuzBn+bIdOmpAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V5oGEHqJ8v+T24gYPQlWKHiFIfSM1fugDdyxpETnIGg=;
	b=sVicNqgyiPrqnKAsdgw2xFMfpV5yvWIYo2g4pvlcJY/xoLV+Yg+EC5ssLY1XcIUwjd41
	 07oLowZp/98jdCofVQIlXAb6LfaJfQRckayaCr7yScOCg6caxdVIf+Jhjfw3ADgiIlHpP
	 ++9cNteW4Qd7cijKST30hArFTNG2PUg2EIk5JXtOAIK9qRcWGjKchTOM4cBonW8wDRfkM
	 r9dgn4UxO79taUzA5/jxo/Q0HbsvZfcplI8y8g8ZOJOCpdvYG6/to82h8EtBcb2apwYb6
	 1dQy3aDhJI6qLOhrk/SopFR6ybzCFPlAK8gTsjojigycLTafWalJpVely5JwjLISS7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mIOy3AeV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3E8606B0FE
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 15:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A3E8606B0FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mIOy3AeV
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c414e5d282eso369646666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 07:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793632193; cv=none;
        d=google.com; s=arc-20260327;
        b=X3nzSWipbgBbwGoGTR9ov46iHV4Q/6ptezXEs4dT7V+hOQ1HeTF4Tbbbwollqq4QUQ
         Pu/wG98zIstB3K5CkZr8DnweyWMvOt6RFyv4V5UeAQJPlfzC4VYveOPCS2+JIInLgJtp
         Hzw1Y9EHQQ1JrNOoe/tqDh74JpLDYtoKZlHq5liTJSYI+4+MCJwbF6oSiFILRvNRnA+c
         q5i7dC6lbEpzYPzBJzXbMQM8KuS7qQw8RZoIJZx1hRtF9JgYnOr2CJqelP/XvAgJaQBK
         7C9T0PRer7HOgGWyFadLwUOJqrBP9kKpeZZ+bRw2L33TtltYpKKpJgXKpZ1aQukK198Q
         1uKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5oGEHqJ8v+T24gYPQlWKHiFIfSM1fugDdyxpETnIGg=;
        fh=i2l0T2tzoNdZXBPXlIC/ufWWs8Bvg2lDA7eZeqlX4M8=;
        b=h/PjDHMYd42UYHAtsR4ENg8N5g1S7nDtRlIkhl8eHz3I8kIEELMfCe/dPcEnDwyE1u
         lNgwlB7CR9p4VoeOVqrU+r7R2EPALhQZQa3DA+OcsdCG3LmjenDZKeeI2EkZNlSx2EqE
         fzMtejcntGhOrHppF+pBxSGeHLaCSteHYWPKzvkg0RlvEMc+9rs8mWcYAgTBzEnQvM8K
         ejboD4qj35HiGHjYZnksaysmHxqct7CzvGow6xcHfQhLGzh7eXSYNIvbsSHov+MSebI5
         FMPl/jiiKs7EZsw7YsDuJFa/xRvMyNBsee0Bm1tSHXrsrak/8taaZbF/l7PPGaQ+WPLX
         sMbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632193; x=1794236993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V5oGEHqJ8v+T24gYPQlWKHiFIfSM1fugDdyxpETnIGg=;
        b=mIOy3AeVsuWhyP+l6zA16Ucz20Y+QphUxMILOJk08HJCRUJzanCmGGCzgIzPsgBy9o
         LyJ8inTq2q9yWhRw7me/r58dVxm6liirJLCxwEY6460lx0DXcEkaqlFP8OV8YCx0kFoM
         HoE+n6yR9RitH33XexK6Z6cy5cl3M3o2JG9Z1WE6aUBM6ZsP/VxlHG534TLHDnsUaare
         jMFzjt20DhnmU8TYEiyotX5hCQYZdGjSym2gUXW1p7xsUyYH1XtX0iiA0HpEhiNC0u/o
         zVGFyTi7a55y36X4lQNFQ7NoXmL3GN3UjbePDGNGL779i91M7RqsaBxPOULjaqJU/Hek
         kMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632193; x=1794236993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5oGEHqJ8v+T24gYPQlWKHiFIfSM1fugDdyxpETnIGg=;
        b=MJiWzeqZWEu1TPEgbeb52n7fz3bvJiUhcUVMpUeCRt6g9zjojc759WMgBAcSNg2geW
         3RSAeE/aoyCkhLllnZzPM3AHUMMhlD2ZolEdjYz4AeSQW6GUEUb1wCOyYnzkywc7sQT4
         0NSAFYP2GL2s58phsA7b3n9kF0WD7ymwP9OJyuCr7cWVWuwt8yEd3Tj7weF2B/mdZQJv
         KN6Z/1yPHcOwUsHZICMyMcDbbBNlIpVgFLKv/uxBycV46iPEqyWgLaWKLqoJBE0MEmT8
         k88n3Dk++4kQ6K/GjIMbXra1OZYPcbaot0hI2nk5jNRqFdElZYPItUmRZX5+SFJ/Sjg8
         QWtg==
X-Forwarded-Encrypted: i=1; AKwUvBwql8bqg3o80FI7IJusbfdD3Jk0NMehrFkwVS78VRpN2O2CMHpBROBGu+PK4oHj3UaK9eqeGyaUpbKWooJW@vger.kernel.org
X-Gm-Message-State: APuU4Z8G7fuo/W6NA/zdQ86tibcqBl5eP1XGoq79iIFdkw8L8l67yEMA
	PKjloQ4eI30RySzevExADc9QrD5LEETraJ5vQTS1wGJE1Lsx50/inHJFybLqhwNXIlnA0scygm0
	QA/ODeou7HMFi14MdKHuumlGJ5dw25Yg=
X-Gm-Gg: AYBFou0ZEwz7HHEjNf2kZvqf3JEshpqAdkGesNg8dbla0T0+36UQFsm5iHz187Ft/zq
	veVOemvmCsba15BesLOGUU/2IF9SLRNw/nJobA0pVlDyqvNRdOHlg7mkNvJvqktzdL7L1ATACGF
	Pf6d7DXkRdDiazg/SiJb9t2JBG4ivVD2sSCAltlUQjqkI6WGU6D7G1ccuPrCoKelW0weTZlNHjR
	HN0dYmxolXh5PR2kmzNrWLQrBZZXH93cVC4e3HiLQXTPYtwo9LBtxn5dEM8cgKy6m8kRNChO2F4
	3tDY4UktVfjlwLETKCH6F8kDsTokJB2ArPwXifcoKDh+E2gqYiYf5b9DHZxYB6NvnT75NoVwVIy
	w0HuclOduwz0Bmvj8aB+qrHpV5gOVO7youVJJ47zwF//PQ44q0Vx7mleUZfiYL7TTkD3jdQ==
X-Received: by 2002:a17:906:4fd5:b0:c46:7fa4:922c with SMTP id
 a640c23a62f3a-c4ca7b20e1fmr868205166b.24.1793632192478; Mon, 02 Nov 2026
 07:09:52 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101015551.786044-1-koray.fra@gmail.com> <20261101015551.786044-4-koray.fra@gmail.com>
 <20261102142452.d6jkitgdeuquy23i@pali>
In-Reply-To: <20261102142452.d6jkitgdeuquy23i@pali>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 2 Nov 2026 16:09:41 +0100
X-Gm-Features: AclHuK8kuq8eQ7yCdpsnJrZqU_PhMlxnY90gMXEz8lBNnkHZ5ogvsTJfHTXbOfo
Message-ID: <CAOQ4uxhQ3uhq6s+4deEJAQV5iy8QZoucojR58_dUNYrnjt_yvA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/5] ntfs3: make crtime user-settable using ptime
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: koraynilay <koray.fra@gmail.com>, David Sterba <dsterba@suse.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Chris Mason <mason@kernel.org>, 
	Jan Kara <jack@suse.cz>, Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <cel@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Sean Smith <defendthedisabled@gmail.com>, 
	Andrey Albershteyn <aalbersh@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	exfat@lists.linux.dev, ntfs3@lists.linux.dev, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:24=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
>
> On Sunday 01 November 2026 02:55:49 koraynilay wrote:
> > @@ -154,6 +158,11 @@ int ntfs_fileattr_set(const struct mnt_idmap *idma=
p, struct dentry *dentry,
> >       if (flags & FS_APPEND_FL)
> >               new_fl |=3D S_APPEND;
> >
> > +     if (fa->fsx_xflags & FS_XFLAG_PTIME) {
> > +             ni->i_crtime.tv_sec =3D fa->fsx_ptime.tv_sec;
> > +             ni->i_crtime.tv_nsec =3D fa->fsx_ptime.tv_nsec;
> > +     }
> > +
> >       inode_set_flags(inode, new_fl, S_IMMUTABLE | S_APPEND);
> >
> >       /* Save nodump flag to return in ntfs_getattr. */
> > @@ -275,8 +284,9 @@ int ntfs_getattr(const struct mnt_idmap *idmap, con=
st struct path *path,
> >       if (unlikely(is_bad_ni(ni)))
> >               return -EINVAL;
> >
> > -     stat->result_mask |=3D STATX_BTIME;
> > +     stat->result_mask |=3D (STATX_BTIME | STATX_PTIME);
> >       stat->btime =3D ni->i_crtime;
> > +     stat->ptime =3D ni->i_crtime;
>
> For me this patch looks dangerous. Somehow I would expect that the
> "btime" will never change for existing inode.
>
> But because the ptime is mapped to i_crtime and ptime is settable from
> userspace, with this patch it is directly possible to change btime.
>
>
>
> I was thinking more about it... Is not this just misunderstanding of how
> the security model around the times is working on different systems?
> Because on NTFS there is stored just one field which says when the file
> was created. There are not two fields like "time set by user and time
> set by system".
>
> Windows security model allows anybody with WRITE_ATTRIBUTES access to
> change that create time. Linux security model does not allow to change it=
.
>
> NTFS in this view is just a filesystem like any other (ext4, btrfs, ...).
> In my opinion if the ext4 or btrfs filesystem is correctly implemented
> on Windows systems, then Windows security model should handle it in the
> same way like for NTFS or exFAT. So if something grants WRITE_ATTRIBUTES
> access, then Windows should allow to change also btime on ext4 or btrfs.
>
>
>
> On the other hand, I understand the use case to have two creation times.
> One time which would never be changed and could be used for any kind of
> atomic / synchronization by userspace application logic (this btime).
> And another time for human which can be changed at any time to any value
> which user wants (this ptime).
>
> In any case, I would suggest that filesystem driver would not report to
> userspace unsupported values and would not try to invent other values
> and lying about them.

But all those fs with mutable creation time already report it with STATX_BT=
IME
so what can we do about this?

If userspace requests both STATX_BTIME|STATX_PTIME in mask arg,
those fs could technically return only STATX_PTIME and it should not regres=
s
existing programs.

But this is still a bit surprising behavior is it not?

Thanks,
Amir.
