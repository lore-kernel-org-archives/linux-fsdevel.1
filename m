Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795126384;
	b=I49f4MaAS0Hxi81U2l2mzmY9u8QOBJWOfUcX+6XVDSQPXULea+Ejb68QiwXcFOg95o4r
	 HR6G0a33QyHzVRH1qdSsDAc+0GX3MxLz5wdvXx+cTT8UsEgntQiuhZS/c7wPg3jErzxXO
	 Ytbt+kwGI92GPuGDTQbAVPT6KgwMXHd+JQvFW/xsesMPxvryO9XsGKgkWOXMZm95H0cpV
	 W6Qr7TAjRCVLhQ5iPEMLWFx4aqZ5Vooe+ACmiID8AoiX0qkhyYAA0tIAnfcIZp81DxnR8
	 gOVlBDwaKituxrZ59sE4N8DKAj7Viv/Hfhtfg+3V0lIyDcj64t02fC3KuOuo3/NQBqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=IoYLwm6HerTHe4foGRx/rnGtvlKmmT7FHejTxyvI3lY=;
	b=sFFSCqk5f7XptLegybKuY+IY+wrIpqvUlyaPyYDjksMzLU3d1vxOEI+5ycCJw4HPNmcX
	 R6obh8Cm4IYa0FqOhztI1aN8QFHqbLfO0T5kKKt2oJUTsCsS9rZsElaY/R22qjar8rdsf
	 GtPkSYu4qkS8seGf7fJrIUPUIjj19GgLdbk98hGVtguApJc+ZKbOG0zR8EaeqkGdglFLB
	 bk6E/xzfdYQu64+hizHoAKyTjCZY05hXpbv52p4qwcQHA54INXhvvkX1n5JNdKBt+hjJX
	 I+COSkD2r/gDEr6XNRNktzjhaZrJrJ6JnQ21cQFl5Zlp7tsdHPlLhotdw4Q8BQABK8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJySXOd6;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D6F606A33C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 22:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D6F606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lJySXOd6
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49412eb1474so116008f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 14:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795126381; x=1795731181; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IoYLwm6HerTHe4foGRx/rnGtvlKmmT7FHejTxyvI3lY=;
        b=lJySXOd6kt1Mf9579i+PqKhbbIDUlyG+putGxErLptt3tRxHAoefA+y8GVioFvjBol
         WaLSoJSBjP0wkS0+4HdljzaY2A21KXiUI547PDkeHgIDY0C48NIVWarlrtsldLKz1Xdf
         S9zJF4q2tt6095iDOzZhoPIfxFqzN8dJcUMR3A6r8bC4KThLG7sLxXkQmyLQxPuZN+qn
         6CeROb7WSfaI4tZ+7OOEM0ahYm8a0G16oizVaOjzsfBU1R8lWSLiQSa4sU1RUudp9qSl
         y3iOCsJQuTn5qC2Ni5aq31sJhgAm571NGcnHh9sONKPS7agbY8SiwGBV3eMUr6kkJHwr
         UvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795126381; x=1795731181;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IoYLwm6HerTHe4foGRx/rnGtvlKmmT7FHejTxyvI3lY=;
        b=SA28mPZDWzXku/WHxdkkrD02Qondb/r9GctF/Ylg+NDEpki1yMCLVj0WK1Rk+WHfq1
         cWj8mg1rNmHRnuei7DDQRFhiI7e6xHjzrzhLqVVlwQWIydMT2g7CqdXy+uVbc/Ci3+nQ
         t5BrKaIFt06koAKyZrkh8INatmTft5DW8j6+fLgTpknIT5lw1tfWwXySXwQ4kYeJfLyn
         pQLIAolxFqLvakr+ZndRcui0ANIh2k1A0h3j/CtJQmDqpiZ/vJRVi8KmYOtatLrAs7Z6
         xU2SwWGLqoDWQoIDcwA53OFcEDmWtt7iKdTwf0cS00irsicaQ+HtLHHTOnZrgW1WKm0B
         072Q==
X-Forwarded-Encrypted: i=1; AL+hErGd0j0b69w6kA7WmrJReKC0RMUdtJgNyLIPsz8vV6yY7QtOtK+3PjGwKiCdtXgbSBzVKD4YnJmRnHFOicuF@vger.kernel.org
X-Gm-Message-State: APuU4Z+lRWPLOwCXj3PcAVg/aIDpIHolqYuzasEuklb+4wj1VfCgoUa3
	1hXr0A75UWUzB77wp9cjJrqNG8xghnu8FFSWNwLdc2g+SGg0bHaEfyJ6
X-Gm-Gg: AZFdTZcTXI066MJX0a5MeVTogViEyBsVgxVRk59ydeWbxcV8F2q2aaMexpsSfS+8Z73
	jA+DoktD47plK4gkj+HueFBnCQC9avKMLh2f6aGGN8h5uoUbu7vEXVjFgRuV4ayKl3QDShnb4jZ
	SosSP66XvtNc0pdJu+p0soFVTK1Xb4/hk+ztPd1YB3ieP6PgrAEiiiVdm3UJXwGbxZvVHhIe+Kh
	jPL0vsqrDcnoyZ3kzCqTMZRu6ZwMtEMqrj0pGob6a++D7paoVvT2I/gM13s0NGcQuLHkylD/wQv
	CFX1DJtfs0Eu/RxVpQ6c8YaS9PsNavc2NERn91+vmaszO02h6PiMRC44L4LfjJ7XhPAsSo/Z4fj
	gvwHODvQQ9K+/It/Q8jJJob50OQ7YSQMwKMLeJkrb0z2RstwuW4PSokdATg9z/TSHk+8niF6h+8
	73Xa7qU+jngOwN/aIRvmiZc/5wzQsArNPW9B0vCEQpi3AGHOU+Tyf+hjAXghJwhgcjVEmacjJf9
	lP/h/rF/36ggv/OyqH7ou8TiLteSpvem3R6vJu8o7TVVR/nBnS1LK+MjJ11A/hu6NG5JPMUshOU
	cCCtbA1RmRovfjdXMNwdoWj3VA==
X-Received: by 2002:a05:6000:4904:b0:4a6:60b2:afed with SMTP id ffacd0b85a97d-4abb3c37a2dmr1397766f8f.11.1795126381480;
        Thu, 19 Nov 2026 14:13:01 -0800 (PST)
Received: from localhost ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c61f558sm1875580f8f.58.2026.11.19.14.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 14:13:00 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=7470484374e391fd8d57fd43029902e8671499255fadfb82b8d5a6f90081;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 19 Nov 2026 23:12:58 +0100
Message-Id: <DMZJ6XR1X3QE.LSJGBL45MSM6@gmail.com>
Cc: "David Sterba" <dsterba@suse.com>, "Namjae Jeon"
 <linkinjeon@kernel.org>, "Sungjong Seo" <sj1557.seo@samsung.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Trond Myklebust" <trondmy@kernel.org>, "Anna
 Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>, "Jeff Layton"
 <jlayton@kernel.org>, "Konstantin Komarov"
 <almaz.alexandrovich@paragon-software.com>, "Paulo Alcantara"
 <pc@manguebit.org>, "Chris Mason" <mason@kernel.org>, "Yuezhang Mo"
 <yuezhang.mo@sony.com>, "Jan Kara" <jack@suse.cz>, "NeilBrown"
 <neil@brown.name>, "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo"
 <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>, "Ronnie Sahlberg"
 <ronniesahlberg@gmail.com>, "Shyam Prasad N" <sprasad@microsoft.com>,
 "Bharath SM" <bharathsm@microsoft.com>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "ChenXiaoSong" <chenxiaosong@chenxiaosong.com>,
 "Darrick J . Wong" <djwong@kernel.org>, "Sean Smith"
 <defendthedisabled@gmail.com>, "Andrey Albershteyn" <aalbersh@kernel.org>,
 "Pedro Falcato" <pfalcato@suse.de>, =?utf-8?q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, <linux-btrfs@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <exfat@lists.linux.dev>, <ntfs3@lists.linux.dev>,
 <linux-cifs@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
 <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH v4 02/10] vfs: add fileattr_has_fsx_mask()
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261115180343.576773-1-koray.fra@gmail.com>
 <20261115180343.576773-3-koray.fra@gmail.com>
 <CAOQ4uxiRFUqgUMvngvXc1nA7e_HMKSs+aXWVQmAEpcR7yQiQLw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiRFUqgUMvngvXc1nA7e_HMKSs+aXWVQmAEpcR7yQiQLw@mail.gmail.com>

--7470484374e391fd8d57fd43029902e8671499255fadfb82b8d5a6f90081
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Nov 19, 2026 at 8:36 PM CET, Amir Goldstein wrote:
> On Sun, Nov 15, 2026 at 7:04=E2=80=AFPM koraynilay <koray.fra@gmail.com> =
wrote:
>>
>> Add fileattr_has_fsx_mask() as a helper to let filesystems check for
>> unsupported xflags while allowing supported ones. Can be used in the
>> same way as fileattr_has_fsx().
>>
>> Also make fileattr_has_fsx() a wrapper around fileattr_has_fsx_mask().
>>
>> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
>> Signed-off-by: koraynilay <koray.fra@gmail.com>
>> ---
>>  include/linux/fileattr.h | 21 ++++++++++++++++++---
>>  1 file changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
>> index 42b92ccdc583..ba7ed3b387d8 100644
>> --- a/include/linux/fileattr.h
>> +++ b/include/linux/fileattr.h
>> @@ -65,6 +65,23 @@ int copy_fsxattr_to_user(const struct file_kattr *fa,=
 struct fsxattr __user *ufa
>>  void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags);
>>  void fileattr_fill_flags(struct file_kattr *fa, u32 flags);
>>
>> +/**
>> + * fileattr_has_fsx_mask - check for extended flags/attributes
>> + * @fa:                                fileattr pointer
>> + * @allowed_xflags_mask:       additional xflags permitted
>> + *
>> + * Return: true if any attributes are present that are not represented =
in
>> + * ->flags or @allowed_xflags_mask.
>> + */
>> +static inline bool fileattr_has_fsx_mask(const struct file_kattr *fa,
>> +                                        u32 allowed_xflags_mask)
>> +{
>> +       return fa->fsx_valid &&
>> +               ((fa->fsx_xflags & ~(FS_XFLAG_COMMON | allowed_xflags_ma=
sk)) ||
>> +                fa->fsx_extsize !=3D 0 || fa->fsx_projid !=3D 0 ||
>> +                fa->fsx_cowextsize !=3D 0);
>> +}
>> +
>
> Every patch in your series did:
>
>        if (fileattr_has_fsx_mask(fa, EXFAT_SUPPORTED_XFLAGS))
>                return -EOPNOTSUPP;
>
>        if (fa->fsx_xflags_mask & ~EXFAT_SUPPORTED_XFLAGS)
>                return -EOPNOTSUPP;
>
> It looks like this helper is not as helpful as it could have been
> and you have raised this question yourself in the cover letter.
>
> Effectively every filesystem that supports fileattr_set() already has
> a defined SUPPORTED mask, so I think it's better to do the negated
> something like:
>
> static inline bool fileattr_supported_fsx_mask(const struct file_kattr *f=
a,
>                                                u32 supported)
> {
>         if (!fa->fsx_valid)
>                 return true;
>         if ((fa->fsx_xflags | fa->fsx_xflags_mask) & ~supported)
>                 return false;
>         if (fa->fsx_extsize &&
>             !(supported & (FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT)))
>                 return false;
>         if (fa->fsx_cowextsize && !(supported & FS_XFLAG_COWEXTSIZE))
>                 return false;
>         if (fa->fsx_projid && !(supported & FS_XFLAG_PROJID))
>                 return false;
>         return true;
> }
>
>
> ...
>
>        if (!fileattr_supported_fsx_mask(fa, EXFAT_SUPPORTED_XFLAGS))
>                return -EOPNOTSUPP;
>
>
>>  /**
>>   * fileattr_has_fsx - check for extended flags/attributes
>>   * @fa:                fileattr pointer
>> @@ -74,9 +91,7 @@ void fileattr_fill_flags(struct file_kattr *fa, u32 fl=
ags);
>>   */
>>  static inline bool fileattr_has_fsx(const struct file_kattr *fa)
>>  {
>> -       return fa->fsx_valid &&
>> -               ((fa->fsx_xflags & ~FS_XFLAG_COMMON) || fa->fsx_extsize =
!=3D 0 ||
>> -                fa->fsx_projid !=3D 0 || fa->fsx_cowextsize !=3D 0);
>> +       return fileattr_has_fsx_mask(fa, 0);
>
>             return !fileattr_supported_fsx_mask(fa, FS_XFLAG_COMMON);
>
> I hope I got this right.

I think so yeah, though for me it's easier to think about it as
"unsupported" instead of "supported", but the idea should be correct.

Though yeah, this helper may not even be needed, I'll see if it's better
to keep it and write it like you did here, or just remove it altogether
and just do & ~SUPPORTED.

Thanks,
koraynilay

> Thanks,
> Amir.


--7470484374e391fd8d57fd43029902e8671499255fadfb82b8d5a6f90081
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSgVimKafU5DQMcjcDmj22qf5IGXAUCav90agAKCRDmj22qf5IG
XPKZAP0VIIYNYcMXcJcBnssVPLsh/PdS/1YfbeS+1fY2/mTfywEAh1K4KuZwkU+c
so3nKRdXgi3OcK+mKOduMSp71HXfUgE=
=ip1X
-----END PGP SIGNATURE-----

--7470484374e391fd8d57fd43029902e8671499255fadfb82b8d5a6f90081--
