Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793628043;
	b=qWfYF79PApfbN9FywIdMQB+v3lbD7VkaaLnfbnCC6EiyaroUnwqUvMehGDLnCJgdwEq3
	 AQzro2vgyr4qQlnros4ESWrApuCv+vhhcxCvmNgKUHiQLxVzWcK45bU0aSrsfmJVS6XAv
	 7d5cfv7O4kDmDBPU0H4BA1itPrUCEAHiwuhsIoEioMvECDfwvJv99E6gfEI6wRf12JDSD
	 Ma6huATC+1rBcl75LYXyoiLvDq8B8shSrPhGG02JjHS/YbagRNZ6FbgLw+x8dp7lG5pC2
	 8yfQj8Bs6Ba1Wp/fNnHjLCFOXJUucRFcXWsXCk3xhWOwj3YCll3UZ9yZSGH5u/AAY0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793628043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=s5Xf4onWksy+tbgDhi+LvOuZ3PKtrfpCQRc1Tg6vJHg=;
	b=3rwPeAbixfnI3MtmLT3iRcfcT3h3PbJ5cD6Ihw7i4Y9rpWY9La5uc/uJ+mrbri67+jfK
	 N/jDzQv9uoikR7Bs1yOUGlQhR4lHEahp0HjROzICytZuukt8/eAVIS+jPayMkNLCZ1VaT
	 +bXMs7gZbcrGaxr6zRQlk9pXISPOlMyeXG7eeqUicq545XToJ9C63WbmPlXA460U0eVIK
	 gDnTCSNFG8rqP9qYXc42itoIp6yqIoDDvxqmjxKtJOhP45aagsRHT55P3XHnnjrFsoaBk
	 BgWVDun2DlprO6O1hNqXJ5BlSwk8WplUdhwS8G5ATX9oN2o3T0heNLtcsjDeZxWMrhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqAIi+u2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3660A2615
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 14:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BF3660A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqAIi+u2
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so488624666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 06:00:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793628042; cv=none;
        d=google.com; s=arc-20260327;
        b=Pg88xsGeOf0u1yjspLzCC0CJK+tpc7cBlf5Y5SnbBkH4IY3vsfBBSOrUWKaIgCNtGM
         rPA2MpXMpRkUNBAhDCs5TWVgwI/u/lmu7GjhI36cVtSgk0V0UMkgBNqvtY9bMIsxC8u2
         CuRQgoTzJ6HH2d4ysm2YEMJKk+jvyxEXmJRlIJEe4V1vK3al9TkywlN94wwruecdOPQ8
         iurZN+2JJRcvyQTjnrxMMpKi2rpnECO7uFwlCddiBlyIoTyDz7bZASyNdtCzIlQcGn+3
         BLjDVXDJnckDM1rl/GoZawsN8nMHz6EdvWbYqlPBkRdmuOExpncSVbIAMthFn/f1qXjh
         78qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s5Xf4onWksy+tbgDhi+LvOuZ3PKtrfpCQRc1Tg6vJHg=;
        fh=jfVMGh4xKak7m2OxWn3eq8QkW2TCO1UmfDtaiHhAzSQ=;
        b=FQAbuY0LuPWgiH3stVsFDQTz/F6yZ6fRqhys9Rs/k0j3rCC31mCNtsyPyMkvYocJ8j
         tMsTgO21kz4Oze9/G52SEWsrDaWfqLCgSesms6Df/JD2W2pEcaMi8eCJlEU8nwwt13FX
         vcleO6JYU11sH2cOCP2wQevLR9dYW+1EGemayo/Ffh9dJ8SNjmtf5bnNxXqCs8K40EN5
         SmkNV/ClM5PwhNi6mdcYGshzquWWzKFiylF4BID7sJM0F21eU6J/FnI9w7HAepfo8LCD
         8bClFmNkMu3v5wapVEaJAEEYf48jsYDcriMSGkKi3xb+wPLX4zCA0o/UcTdxB/YB2D5C
         Sveg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793628042; x=1794232842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s5Xf4onWksy+tbgDhi+LvOuZ3PKtrfpCQRc1Tg6vJHg=;
        b=sqAIi+u2ogK6jCFX9j76dArnOThd5X0GCkPk+9VoPxB/STC2ao3yNQSapJ/76uyvZF
         UQeJMLj3OjZQ6jYb3yKYpQYBgapfOVjbaeH6XWMUdukR6YyyOJiZarpmEibYav80QQel
         ARzb1zBdJX680p6g7SYIcqKej0UMKNcuV/AzvXi9sTPGi/DS+5e8TNR91gHolVHyQs08
         0pb9QRYTbtnS9lHSmz2/j9UIRd0UCpD0n6qnEqh4x5brTozZCvk/gpLraes7Ilzx05Qt
         g2ZPufDM/NVNfGkokXFUysAeDG9pH92EnlHodWhDjFX58izRV8iTvo18CdxRQeNzpMZ6
         WV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793628042; x=1794232842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s5Xf4onWksy+tbgDhi+LvOuZ3PKtrfpCQRc1Tg6vJHg=;
        b=iiwgMKx/9nN/djBH4xflI4HiXzC0ZMByzTFY5TEN2IMAjjEuya/EPCqRm8bVXB8TrT
         1VytOTQrlLh21rRrUhpJm0B7Nv3mK1aJrOri4TVPp/cBTXrXukKsZX3aevP+QuqQLEcK
         SyhJceb6g+lBa/cB+niZI/Rh/r9+aUBcidDveaYXiLzpNAmEBtJdxrc74Dzf6Sm1zTGG
         WWdDdRZEd4aSziV7hQUGHhaNbROCMjxFsallrq2XjUO9WrPjz1ssjsKUVAlJrRz5BIq/
         t4eqSa08Q8G+yhqYENcNrEcCdq8VZ0GnTi7vYUhkLnvzUtqTlMQqm9KFS6t+QzTTNuxB
         ykAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxnGx8gLMbKS2yulbhQbzJfwETkx4aOB6WChQ/625Qhvxw6C0gy7Z/mIvyWrh/ad/E3TakonqE8kMv6TaQh@vger.kernel.org
X-Gm-Message-State: APuU4Z+bssZSKEj1wqzTvCJH/qDuHB+3CJU6+SnXahVuUUiSiG/ZBm0b
	7gCNiZM3/3nyhAG1F1ADnY7nGHG3HIc0pFry7Vo834TGpzcNEBB5WGKZhAARQKf1cWjJDkaAIea
	KAZyoGbG98WdsAM8FvMshekkm4n4iq6w=
X-Gm-Gg: AYBFou2fCBHIyv5EHbRpWX13sCk5tnr1jWzaMCCBojEiHCZUrdwPrJ2YzMwj6Du8/p7
	8ELesOX0K7evtfpcx3xifsdWCY06+EUjT0n6ja542YNmkJsy1SwpMg6qlriaffgGfl7o/XLyzuD
	6Bc+t8dISxQAxMIij8upvscTDEPaEBt7/GAMozyk0YBzLfHSIFeGa2JTSIXhpIGY5sTWG0VfzCw
	GYjQKehVtvyNMjcZLgF4fwWkcgRHfjJtnGMF0TWQRyPSezN+WBD3PJuG8yfNv98gU3syPg8A8ES
	yeJyQYuZifCeW4dDoSrxv+0m3cA9uZ4bYJxwY54OTw3LyJEzrANNxVXv3/w4uErHu71wwdhs2RZ
	taFf3medv3zsUxLsPiiNb6txSHPtWBKEDIoiH1i1gYGaUmcFZ7qG49ajQgVbeRj0NsXRfsA==
X-Received: by 2002:a17:906:9f87:b0:c33:9fab:5f61 with SMTP id
 a640c23a62f3a-c4ca7a80dfcmr888696766b.29.1793628041476; Mon, 02 Nov 2026
 06:00:41 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101015551.786044-1-koray.fra@gmail.com> <20261101015551.786044-2-koray.fra@gmail.com>
In-Reply-To: <20261101015551.786044-2-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 2 Nov 2026 15:00:29 +0100
X-Gm-Features: AclHuK8C6KXo0yGTK4G9AdpXOF6ch7dlD0GPHOdparCBMVqSIwGLvVGFGi1BG64
Message-ID: <CAOQ4uxiuJ=eZu28FZAUz3rpqPKqCimPxJucOnYYuBowvD09_Cw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/5] vfs: add provenance time (ptime)
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Chris Mason <mason@kernel.org>, 
	Jan Kara <jack@suse.cz>, Yuezhang Mo <yuezhang.mo@sony.com>, Chuck Lever <cel@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Sean Smith <defendthedisabled@gmail.com>, 
	Andrey Albershteyn <aalbersh@kernel.org>, Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 2:57=E2=80=AFAM koraynilay <koray.fra@gmail.com> wro=
te:
>
> Add provenance time (ptime), indicating the time when a file or
> directory was created. This is user-settable via file_setattr() and
> retrievable via statx(2) (using STATX_PTIME) or file_getattr().
>
> The semantics of when to preserve this new timestamp are the same as
> mtime, the idea being that there is a correspondence like this:
>
> ctime <-> btime
> mtime <-> ptime
>
> so every operation (copying, moving, ...) that currently preserves mtime
> should also preserve ptime.
>
> Furthermore, in order to avoid the legacy FS_IOC_FSSETXATTR accepting
> FS_XFLAG_PTIME, add an FS_FILE_ATTR_XFLAGS_MASK mask to support new
> xflags, and use it in fileattr_to_file_attr()/file_attr_to_fileattr() to
> allow ptime to be used with the file_setattr()/file_getattr() syscalls.
>
> [ This is a re-implementation of the initial patch[1] by Sean Smith
>   <defendthedisabled@gmail.com>, following the advice[2] from Darrick J.
>   Wong <djwong@kernel.org> of using file_setattr() instead of updating
>   utimensat() ]
>
> [1]: https://lore.kernel.org/20260405195007.1306-2-DefendTheDisabled@gmai=
l.com
> [2]: https://lore.kernel.org/20260407014129.GC6192@frogsfrogsfrogs
>
> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.4.7
> Signed-off-by: koraynilay <koray.fra@gmail.com>
> ---
>  fs/file_attr.c            | 33 +++++++++++++++++++++++++++++++--
>  fs/stat.c                 |  2 ++
>  include/linux/fileattr.h  |  5 +++++
>  include/linux/stat.h      |  1 +
>  include/uapi/linux/fs.h   |  8 +++++++-
>  include/uapi/linux/stat.h |  7 ++++++-
>  6 files changed, 52 insertions(+), 4 deletions(-)
>
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 833e03810b24..c0645cb22bf3 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -102,7 +102,7 @@ EXPORT_SYMBOL(vfs_fileattr_get);
>  static void fileattr_to_file_attr(const struct file_kattr *fa,
>                                   struct file_attr *fattr)
>  {
> -       __u32 mask =3D FS_XFLAGS_MASK;
> +       __u32 mask =3D FS_FILE_ATTR_XFLAGS_MASK;
>
>         memset(fattr, 0, sizeof(struct file_attr));
>         fattr->fa_xflags =3D fa->fsx_xflags & mask;
> @@ -110,6 +110,8 @@ static void fileattr_to_file_attr(const struct file_k=
attr *fa,
>         fattr->fa_nextents =3D fa->fsx_nextents;
>         fattr->fa_projid =3D fa->fsx_projid;
>         fattr->fa_cowextsize =3D fa->fsx_cowextsize;
> +       fattr->fa_ptime_sec =3D fa->fsx_ptime.tv_sec;
> +       fattr->fa_ptime_nsec =3D fa->fsx_ptime.tv_nsec;
>  }
>
>  /**
> @@ -141,15 +143,20 @@ EXPORT_SYMBOL(copy_fsxattr_to_user);
>  static int file_attr_to_fileattr(const struct file_attr *fattr,
>                                  struct file_kattr *fa)
>  {
> -       __u64 mask =3D FS_XFLAGS_MASK;
> +       __u64 mask =3D FS_FILE_ATTR_XFLAGS_MASK;

That is not the correct way to extend this API.
This fixed mask was added as a placeholder for
"We intend to add support for more xflags to selective filesystems":
https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-2-amir73il@gma=
il.com/

Please see this POC patch for filesystems to publish their supported
xflags mask:
https://lore.kernel.org/linux-fsdevel/20250329143312.1350603-3-amir73il@gma=
il.com/

This will allow callers of file_getattr() to know if the filesystem
supports ptime
without trying to set it and failing.

Thanks,
Amir.
