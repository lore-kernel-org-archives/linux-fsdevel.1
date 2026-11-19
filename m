Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795117028;
	b=O5k8Tt7bws4VF8vCgXxR9ZFXWkO57RfHWEIIQXjNEsLjmUm5m3xvaZ1jhG4EPqHz2DCY
	 zoY09kItrAoZcXBGlTdamrfCq2FiHNeim7bQO7f0MdonI9PTN1zoiwPaoM2gDU9jjqMWS
	 RRgKqdzZm3Ipf8iZJB4HCX/8R/fSeo23XpvAdMo5IzC6fOHugC9aSrGVk2gL8vhsb+bm+
	 vv7Qa/QciSJCNFNxpZGdY9/qeFIMC7dalcYSFOViCiBQrWpcfc5/O4AIgFKYautAEqPQ6
	 jBEHLbHz3xxJu8QC1zt3LN21NXrE5C5LGFELvQUAdxVadgudGQugp2uua1m8uWLHgnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vs2p+NKw9cBxSHvLMTQ1TCNiiuqtzY0tMFYF/M3imDY=;
	b=JXMSe3F1QJiQLDJ584ek96zb7VqPCx3T+ltcYJnfvH4bcatF1If6dHkVuWarwDv62xoY
	 G3Xlw2W+FeAKQNeoOUifaA/x3PtPwsjzjy9gLAkTr8AC7f9/wyS3yfId67v6BKYRiiitB
	 02uB7NXflwtHHmnmGXG8vYyxhjbGoWYgszDCQzDdkqZwadidCtAdwGtYj9MujYgZH9mnF
	 GnUfBwjDKkmTYlPYvbHg4JugzDlCIPYefhwvZxE27zThH77dJh2zTNWvYVc3AB5vGIZlU
	 5p633AS+JG+xhGbbceVucpKrVeDijUzBjbhakmCrm9yolkU2qBSK9IjRn6EQtATsDnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9hNUci0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948C60A260F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4948C60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b9hNUci0
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b88bc47e23so126348a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 11:37:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795117025; cv=none;
        d=google.com; s=arc-20260327;
        b=jnp8uhwIlvgPjy6wEhhIaDGG5VAqQwbejFdm66t8erQqCBbq1PMNiFINdjtvJeTklu
         6IeAIEh3MkksjRMoR/p2nHimLFMREOV0ipV2AWBi1P1qPwCxmteI4G7OQU7qJ/KKWbds
         olXgxYNoE0E91UuiEFcyv5jxGGmilduFm2m8Eqtb2s3K06xJLAwPp7Ij+gW884rHIY6+
         eIFEuADqpphatrGNymrhQKvc2OL7ye8bG4ZzbFCWNt9+iMy237Ur2G/mPB5p2lW3wBPT
         B/aXujKtou7Nd5BbJ3HQDzyWpLBORCOpdBU6g8+9GH4OK7wHFDovocvcIPVKCdJOzLyf
         5KfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vs2p+NKw9cBxSHvLMTQ1TCNiiuqtzY0tMFYF/M3imDY=;
        fh=lstbPXWERA4qav96iRojqvTlIHWyapHUbg/1FAycKR0=;
        b=GSiHECVur60YR8Cj7iKxKkrqR1juXsiy0MN3jqvxD7AhEIU85W/qjy0wASe8kKSdQM
         uitIbpsGh8NCmIwQbLR5LO5g9pzsJk5SnmOEAoyOkDfhxhe6oSC6PhnI2SuvUEtp9e65
         RmYytYYt0cBqfArU3oi9rtfSFWWliaLievtyDtqZhxR9pUj5WzM5fCoNoHgFT++G+pZH
         2EaZwLi0LZn49aY50N39vn5liUxs6SOaP6QIVszniNbdKgrT6VZ+CveHYQ2z/0KG4+L5
         m/rsKJe9hk3r2IUYOyOhSawP6apIu35b9ITPgPZDxvzSxjmv1SmdeeFUAbjcxNoV1sWo
         O4VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795117025; x=1795721825; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vs2p+NKw9cBxSHvLMTQ1TCNiiuqtzY0tMFYF/M3imDY=;
        b=b9hNUci0rojZWNqoKRlLxiGjE5O/mMAM8AK9l59ZnDFbMczLDpjtuuM0Osoehm0BQ/
         NYKtrZ6N6TrPJMUH8KqItunnDXVUFIisduSqIk3MLFeVCz0C/5j2m/sWiQlzTfIUoaDX
         DGn5aiBa+sgHtIJmckN/9TqGGmW9i3wzMtJl5wRy+R2vF5iEGyoxyRWY8gSO8dzne+TB
         udWcopu9HU0OOPMbxBEnoI6eZfWxlM9zTPiiEpQKxtBZzhYoQIfKQ1mP51+b+Ave0hfT
         23t/TnwEZXjVKNPT0QTy6ThRyPAfrqob2c9GmETVZUyrxi6wC8iOPlASQg6Idz/nwMNC
         9+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795117025; x=1795721825;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vs2p+NKw9cBxSHvLMTQ1TCNiiuqtzY0tMFYF/M3imDY=;
        b=RQkL9XyymzGt7pS9AVrS9ZtF6GsgonxZNDRecWTPJvfHsVn3ycNS58u8mXMjat5zvl
         XRGQ4D4zVNzogST5Asl8WHHZq2EqLuDj8hNpWeca6NHdAvNM4rwm3CuDVyEBU34DwGTi
         DYs08jYO46VH7K4mgZCjNa+5isOboXoELyGmfEQbJVhEwHvpbn6n7d+gp/lCV17VevFd
         TG0paJbq7GiuFydeiAlxaBp4QU4nN53AkGczdpjk4Mt88nVDw1SAyXY+Y4WVhHSI6qXp
         s7tRpVAuR7gbjqH9HmjI0sgopBbwnsA3IYV9y4lV3GpHQtEQMKoEzeVLAuc+VgWDboDz
         bPzQ==
X-Forwarded-Encrypted: i=1; AL+hErEEddsLz6y12PY+itVr0P5zeFENzGVT+w2eleI5MTAz9j7e1pKdNF89vmLh1e6HDwQQvOhL8p8404FzOr93@vger.kernel.org
X-Gm-Message-State: APuU4Z/Yk+YK5JFoMc4xEmwavDqSLlj+KczM72dy7lzTkGJLWqznwv/c
	UF5xUPUeeI1dTKV6f659Mv0uKgJVu/4dTbyrNNWqV8wevR61GktqL0g8dXVUXvGRK7AvP6puAYr
	7U4rTrZ9nFpQox89cdWCnxf5q2J7S9EA=
X-Gm-Gg: AYBFou1IA/qKUC8gkmpVn34go3T8flSnonuygOhbqfmyivcV4QmqqRc+LmEF3az4CFV
	f+xM0Usx5v53dKOee90Ck6XqUqxMDY1JWFVftp2yflOU7I5Atqk1Chc67u4qlpyrvgbytOB43cg
	ibG5hKen+UOYvuidmKWCLGGCciLkw2bWc8IeBvBKse+8umq0MQh2C7yrQPPNSo2nWbdsRHTtkz5
	Nf5yQPYOiKqka13bbHAT9maVfld8hcIJX/5L/MD9udR59j9Al/WheLT7UMyDmznDSyB1zMiBhju
	kfTFqPakODBuCc+hhvcu1axGzJLj+aLgy8Kcba9gEnDJcMJNAZs1GGpTD6q1gZDJyb/OD8E4L7L
	OgZ3STbzrWbFU4O078rjz+TpeNJ7/5azUzmsrKYGuqY1p5j0Ml1MILbos2TEjcuoAxzuppkE=
X-Received: by 2002:a05:6402:897:b0:6b8:8328:8e66 with SMTP id
 4fb4d7f45d1cf-6ba37d62a2dmr239724a12.7.1795117025446; Thu, 19 Nov 2026
 11:37:05 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115180343.576773-1-koray.fra@gmail.com> <20261115180343.576773-3-koray.fra@gmail.com>
In-Reply-To: <20261115180343.576773-3-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Nov 2026 20:36:52 +0100
X-Gm-Features: AclHuK-9kUyGBTzq0h8pZyp8mMZSXIXsu9pOi4Bu2Y5vLjqBJOsUk2EoN70jtkI
Message-ID: <CAOQ4uxiRFUqgUMvngvXc1nA7e_HMKSs+aXWVQmAEpcR7yQiQLw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 02/10] vfs: add fileattr_has_fsx_mask()
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Paulo Alcantara <pc@manguebit.org>, Chris Mason <mason@kernel.org>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Sean Smith <defendthedisabled@gmail.com>, Andrey Albershteyn <aalbersh@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 7:04=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> Add fileattr_has_fsx_mask() as a helper to let filesystems check for
> unsupported xflags while allowing supported ones. Can be used in the
> same way as fileattr_has_fsx().
>
> Also make fileattr_has_fsx() a wrapper around fileattr_has_fsx_mask().
>
> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
> Signed-off-by: koraynilay <koray.fra@gmail.com>
> ---
>  include/linux/fileattr.h | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> index 42b92ccdc583..ba7ed3b387d8 100644
> --- a/include/linux/fileattr.h
> +++ b/include/linux/fileattr.h
> @@ -65,6 +65,23 @@ int copy_fsxattr_to_user(const struct file_kattr *fa, =
struct fsxattr __user *ufa
>  void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags);
>  void fileattr_fill_flags(struct file_kattr *fa, u32 flags);
>
> +/**
> + * fileattr_has_fsx_mask - check for extended flags/attributes
> + * @fa:                                fileattr pointer
> + * @allowed_xflags_mask:       additional xflags permitted
> + *
> + * Return: true if any attributes are present that are not represented i=
n
> + * ->flags or @allowed_xflags_mask.
> + */
> +static inline bool fileattr_has_fsx_mask(const struct file_kattr *fa,
> +                                        u32 allowed_xflags_mask)
> +{
> +       return fa->fsx_valid &&
> +               ((fa->fsx_xflags & ~(FS_XFLAG_COMMON | allowed_xflags_mas=
k)) ||
> +                fa->fsx_extsize !=3D 0 || fa->fsx_projid !=3D 0 ||
> +                fa->fsx_cowextsize !=3D 0);
> +}
> +

Every patch in your series did:

       if (fileattr_has_fsx_mask(fa, EXFAT_SUPPORTED_XFLAGS))
               return -EOPNOTSUPP;

       if (fa->fsx_xflags_mask & ~EXFAT_SUPPORTED_XFLAGS)
               return -EOPNOTSUPP;

It looks like this helper is not as helpful as it could have been
and you have raised this question yourself in the cover letter.

Effectively every filesystem that supports fileattr_set() already has
a defined SUPPORTED mask, so I think it's better to do the negated
something like:

static inline bool fileattr_supported_fsx_mask(const struct file_kattr *fa,
                                               u32 supported)
{
        if (!fa->fsx_valid)
                return true;
        if ((fa->fsx_xflags | fa->fsx_xflags_mask) & ~supported)
                return false;
        if (fa->fsx_extsize &&
            !(supported & (FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT)))
                return false;
        if (fa->fsx_cowextsize && !(supported & FS_XFLAG_COWEXTSIZE))
                return false;
        if (fa->fsx_projid && !(supported & FS_XFLAG_PROJID))
                return false;
        return true;
}


...

       if (!fileattr_supported_fsx_mask(fa, EXFAT_SUPPORTED_XFLAGS))
               return -EOPNOTSUPP;


>  /**
>   * fileattr_has_fsx - check for extended flags/attributes
>   * @fa:                fileattr pointer
> @@ -74,9 +91,7 @@ void fileattr_fill_flags(struct file_kattr *fa, u32 fla=
gs);
>   */
>  static inline bool fileattr_has_fsx(const struct file_kattr *fa)
>  {
> -       return fa->fsx_valid &&
> -               ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize !=
=3D 0 ||
> -                fa->fsx_projid !=3D 0 || fa->fsx_cowextsize !=3D 0);
> +       return fileattr_has_fsx_mask(fa, 0);

            return !fileattr_supported_fsx_mask(fa, FS_XFLAG_COMMON);

I hope I got this right.

Thanks,
Amir.
