Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163145;
	b=NbRX2d5W3goTg6RYkbAb8gtT8nhuw6UCc2JFF6XkCpsJaTqFhI2E3MB5UTm4ajZ7qhMN
	 RJGfELog00ESSdfPDIhUWOI+3NdFUpjMHUzJkcez/m9ukYKshqlPga5eNua4iyX/BvraG
	 X8GC6bOqTAsnLvg30pevyTe+QkRsxFxNHvvwtKe8KL7xSTYhaSL8IrEeGJN6/8LtTVh9i
	 v5gRSzmCT/u9EBA1wvQxyAGbbZEdY9f6gQ1Q2AYNc344YpITcrkejRTcQhEfdIvTzEjYM
	 zrN9fq6PGTonz1fnsWSj6uvTC8nG2MD9KyK0zATLii3gv3+N9cU+RmQ8K7hIHn0pYQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=kGfrKoF5IEunQnK8Ab/XQNyAZ5mzvOHkU8ItZhatHss=;
	b=sIkMU3lLc95wFWyVn9UoPLGRvqhl7eVTF4tCcuh2+Fh7eCml/HWN58SaQ6i80+Nswqcx
	 2YFJgR/A8CSlF+DheOJirV1qNEerPxWbznBZGioCDb7KWDgYz0R8eRIpQyPVK62ovqVE7
	 U3FegkpV3M42E/O20MqG6lPtGEV0XScvevPA3+P3B8YxpxcfFt8QcNnZi5aLDszKRx157
	 tCeJCXcDCPYl5w+Mbqh9M5g3q5RiN6kmfH8pyFffJcoAArvLdCHYz9PUjYXrXPgmndtd7
	 AMdCyUhFXLPEeHfEOkpgzxnIbM61eFaN4dwWFmq/UXrucmCrZ3kaJqF06zbUixKOINA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=P2kOCs7P;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92424606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 08:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92424606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=P2kOCs7P
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso249221f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 00:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795163143; x=1795767943; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kGfrKoF5IEunQnK8Ab/XQNyAZ5mzvOHkU8ItZhatHss=;
        b=P2kOCs7Ps76+OW1VoPmYekHIumtk0wuQvz7uKBJIr9N9RT4TQBd/+geUmYxrSFT0yW
         u0kBPIlqf69t8u+JIGwEutrPtQ2F8/6eeWWfQZfynZ6vSHmmgYOKnf4YYRjPoqf7Os6s
         h6VSCchC7cGia5WnSn/4TsYZDAQL9phNHMAzptzlWYO+722idJvp1BniR7/B0/KOVjLw
         GCj6CF0Yzt4lTIUngz5PTTzi2FYqySX7nFqFuVDkHHHMThPaa0z9D3gK8Odt85VJ6aSh
         aFOo6RlPqJEEiQI+JDEw4bYUt6PzY46VXTxmDSx4K1wC5g3PH493D16qDR8kMiCQZ3Su
         zw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795163143; x=1795767943;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kGfrKoF5IEunQnK8Ab/XQNyAZ5mzvOHkU8ItZhatHss=;
        b=KeixqGXjBcmKr/aias+hPpyuGMafP18CkTQBHKuNSbn5KokV14awtuakte/jp+SXw5
         0C87qV++Ctps+k1Drnwx/mRaNr1Gjwh93Wgfln02woIYHK6i09D6RpJmnts1N6B7bMq8
         ipQ4O43PPAzwaEH2cWmB/boNvYSMsbAI0FrJA19hQY+h1h4eobZqgl9AV6BypXT5bePx
         IY3/M9BqLRApfJmPi3QMU7Shac/zcey+/KzzZrt2EDiD89gPeyDV6rzLLeVFqoDG/JTF
         +F75Uuyvw1QR9hY2OC8CYRAGxPrgHH8hUJV4cenSeB1ECkxJbmrGPUGChCajB+ACqamU
         aSGQ==
X-Gm-Message-State: APuU4Z/ajlWO//m6Ot4pppanjcRyNzqey4dcGkwOQPLi8aLbX1f4Rwor
	4ZDV8kgea5YLY3Uw+ckMFEBz8sW5jfGTCH0wjevJJV9Z0GZrbwADvyTMJsyZDvuYExoR
X-Gm-Gg: AZFdTZfKH9Hvh+fg7rxft30kxk0Nq9VZcTVtUULXPv8VkUgyyFD+i7bdtPdEPBMXcue
	c34mXOlxuY976LMQ/PMDMSp9fvCKUxR16X6B2dZPV2SEGDNZSiZ8XXUf9zA+PXWYKdsoA+RUz4s
	gMKz4onFVRUQ7i0582t+uUpJ3LVinifMK5gSR9wUAoFDkd7IJ0SapnnYOj0i7xdoH3JUee7juKR
	bvSpghr1I1Sb6aQrZZvmtk9rG6XHa5KVIKce5AkZ4PXUPGBMHjkFTJ6T1DwVpH1bsAi08HCuk7H
	BW8gXXR6PAO72X7U/QcFPBmaoqT5Y6Z3C8qibGgQiMJI+hI/aA01r7vDH3xT/G7Xx26gCa1pV0O
	56yKbvz0YOEJMejLVsMkGF5ktKRb+wFyF2pfZZf2hEXxr+0m1RvZqf107gwQIB45tTnOnUtbP90
	5xRgpZxg/UVznz80Vg9sNBIc6jMqyGaMuwIhgJDEs906sDr6+0wyO3Cm7zvlU2Lf+jue6IvzFWs
	ojIu6agLnnhSiJfqYMgD79xZz3pNgB7q3GCbQajHAREW7H/ud5OWWWdyHxE7LXUnC6won5L7uBg
	qPp5ptRbn4WLBGl1tZ/kp4sD5F66TLpRUOkicz3Y90bEtaLpap6/cXrw4o3plZ2oZw==
X-Received: by 2002:a05:6000:4808:b0:4a9:760f:1843 with SMTP id ffacd0b85a97d-4abb0d51e12mr4500017f8f.27.1795163142689;
        Fri, 20 Nov 2026 00:25:42 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm3992584f8f.32.2026.11.20.00.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:25:42 -0800 (PST)
Message-ID: <982814d1f60b01387b24ff277478b77ef53da336.camel@amutable.com>
Subject: Re: [PATCH v2] fs: add ->f_real() file operation
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Amir Goldstein <amir73il@gmail.com>, Christian Brauner
 <brauner@kernel.org>,  Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, Ding Feng
	 <dingf3ng@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Date: Fri, 20 Nov 2026 09:25:40 +0100
In-Reply-To: <20261119211542.1509119-1-amir73il@gmail.com>
References: <20261119211542.1509119-1-amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-19 at 22:15 +0100, Amir Goldstein wrote:
> sync_file_range(2) and cachestat(2) operate on file->f_mapping.=C2=A0 For
> a
> file on a stacking filesystem, such as overlayfs, the data and its
> page
> cache are in the real (backing) file, so on a stacked file
> sync_file_range() writes back nothing and cachestat() reports
> nothing.
>=20
> Add a ->f_real() file operation, modelled after ->d_real(), and a
> file_real() helper in backing-file.h that returns the backing file
> holding the data of a stacked file, or the file itself.=C2=A0 file_real()
> is
> a no-op without CONFIG_FS_STACK; otherwise it calls
> backing_file_real()
> in fs/backing-file.c, which calls ->f_real() and verifies that it
> returned a backing file.=C2=A0 The real file is owned by the stacked file=
,
> so
> it is valid for as long as the caller holds the stacked file.
>=20
> file_real() is only meant for inspecting and writing back the page
> cache
> of the data.=C2=A0 Operations that need the credentials or permission
> checks
> of the stacking filesystem need a dedicated file operation, like
> ->fadvise().
>=20
> Use file_real() in sync_file_range() (also used by io_uring) and in
> cachestat(), and implement ->f_real() for overlayfs.
>=20
> Tested-by: Ding Feng <dingf3ng@gmail.com>
> Link:
> https://lore.kernel.org/r/20261118040056.6543-1-dingf3ng@gmail.com/
> Tested-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Link:
> https://lore.kernel.org/r/20261119183039.1505892-2-ptikhomirov@virtuozzo.=
com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Hi Amir,

please feel free to add:

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

Kind regards,
Alex

> ---
>=20
> Christian,
>=20
> v2 fixes the nested overlayfs case that Pavel pointed out.
>=20
> Thanks,
> Amir.
>=20
> Changes since v1:
> - ovl_f_real() recurses into a stacked lower fs (Pavel)
> - Rename __file_real() to backing_file_real() and export it for ovl
> - Added Pavel's tested-by and link to his new test
>=20
> v1:
> https://lore.kernel.org/r/20261118123105.1247627-1-amir73il@gmail.com/
>=20
> =C2=A0Documentation/filesystems/locking.rst |=C2=A0 1 +
> =C2=A0Documentation/filesystems/vfs.rst=C2=A0=C2=A0=C2=A0=C2=A0 | 17 ++++=
+++++++++++++
> =C2=A0fs/backing-file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
13 +++++++++++++
> =C2=A0fs/overlayfs/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 17 +++++++++=
++++++++
> =C2=A0fs/sync.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++++
> =C2=A0include/linux/backing-file.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 26
> ++++++++++++++++++++++++++
> =C2=A0include/linux/fs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 +
> =C2=A0mm/filemap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++++-
> =C2=A08 files changed, 91 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/filesystems/locking.rst
> b/Documentation/filesystems/locking.rst
> index f7363ad770c76..db9ba2a8c13e7 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -485,6 +485,7 @@ prototypes::
> =C2=A0			struct file *file_out, loff_t pos_out,
> =C2=A0			loff_t len, unsigned int remap_flags);
> =C2=A0	int (*fadvise)(struct file *, loff_t, loff_t, int);
> +	struct file *(*f_real)(const struct file *);
> =C2=A0
> =C2=A0locking rules:
> =C2=A0	All may block.
> diff --git a/Documentation/filesystems/vfs.rst
> b/Documentation/filesystems/vfs.rst
> index 1824462a43711..e4ce15545244b 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1038,6 +1038,7 @@ This describes how the VFS can manipulate an
> open file.=C2=A0 As of kernel
> =C2=A0					=C2=A0=C2=A0 struct file *file_out,
> loff_t pos_out,
> =C2=A0					=C2=A0=C2=A0 loff_t len, unsigned int
> remap_flags);
> =C2=A0		int (*fadvise)(struct file *, loff_t, loff_t, int);
> +		struct file *(*f_real)(const struct file *);
> =C2=A0		int (*uring_cmd)(struct io_uring_cmd *ioucmd,
> unsigned int issue_flags);
> =C2=A0		int (*uring_cmd_iopoll)(struct io_uring_cmd *,
> struct io_comp_batch *,
> =C2=A0					unsigned int poll_flags);
> @@ -1162,6 +1163,22 @@ otherwise noted.
> =C2=A0``fadvise``
> =C2=A0	possibly called by the fadvise64() system call.
> =C2=A0
> +``f_real``
> +	stacking filesystems (e.g. overlayfs) whose file data is
> accessed
> +	through a backing file implement this method to return that
> backing
> +	file.=C2=A0 It is called through file_real() by system calls that
> operate
> +	on the page cache of the data, such as sync_file_range(2)
> and
> +	cachestat(2).
> +
> +	The returned file must be a backing file (FMODE_BACKING) or
> the file
> +	itself.=C2=A0 It is owned by the file and must remain valid for
> as long
> +	as the caller holds a reference to the file.
> +
> +	The returned file is only used to inspect and write back the
> page
> +	cache of the data.=C2=A0 Operations that need the credentials or
> the
> +	permission checks of the stacking filesystem need a
> dedicated file
> +	operation (e.g. ``fadvise``).
> +
> =C2=A0``mmap_prepare``
> =C2=A0	Called by the mmap(2) system call. Allows a VFS to set up a
> =C2=A0	file-backed memory mapping, most notably establishing
> relevant
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index c601b27f0fd35..c63acb636ad0e 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -102,6 +102,19 @@ struct file *backing_tmpfile_open(const struct
> file *user_file, int flags,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(backing_tmpfile_open);
> =C2=A0
> +/* Get the innermost backing file of @user_file */
> +struct file *backing_file_real(struct file *user_file)
> +{
> +	struct file *real_file =3D user_file->f_op->f_real(user_file);
> +
> +	if (!IS_ERR(real_file) && real_file !=3D user_file &&
> +	=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(!(real_file->f_mode & FMODE_BACKING)))
> +		return ERR_PTR(-EIO);
> +
> +	return real_file;
> +}
> +EXPORT_SYMBOL_GPL(backing_file_real);
> +
> =C2=A0struct backing_aio {
> =C2=A0	struct kiocb iocb;
> =C2=A0	refcount_t ref;
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 7433220d4ad6c..41a3daf3e0663 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -195,6 +195,22 @@ static struct file *ovl_real_file(const struct
> file *file)
> =C2=A0	return ovl_real_file_path(file, &realpath);
> =C2=A0}
> =C2=A0
> +/*
> + * The real file that holds the page cache of the data: the upper
> file after
> + * copy up, otherwise the lower data file.=C2=A0 After copy up of a file
> that was
> + * opened from lower, this opens the upper file, just like a write
> would.
> + */
> +static struct file *ovl_f_real(const struct file *file)
> +{
> +	struct file *real_file =3D ovl_real_file(file);
> +
> +	if (IS_ERR(real_file))
> +		return real_file;
> +
> +	/* Handle recursion into stacked lower fs */
> +	return file_real(real_file);
> +}
> +
> =C2=A0static int ovl_open(struct inode *inode, struct file *file)
> =C2=A0{
> =C2=A0	struct dentry *dentry =3D file_dentry(file);
> @@ -656,6 +672,7 @@ const struct file_operations ovl_file_operations
> =3D {
> =C2=A0	.mmap		=3D ovl_mmap,
> =C2=A0	.fallocate	=3D ovl_fallocate,
> =C2=A0	.fadvise	=3D ovl_fadvise,
> +	.f_real		=3D ovl_f_real,
> =C2=A0	.flush		=3D ovl_flush,
> =C2=A0	.splice_read=C2=A0=C2=A0=C2=A0 =3D ovl_splice_read,
> =C2=A0	.splice_write=C2=A0=C2=A0 =3D ovl_splice_write,
> diff --git a/fs/sync.c b/fs/sync.c
> index 4a84dd837b863..e8f5ddf14cbe4 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -7,6 +7,7 @@
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/file.h>
> =C2=A0#include <linux/fs.h>
> +#include <linux/backing-file.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/export.h>
> =C2=A0#include <linux/namei.h>
> @@ -269,6 +270,13 @@ int sync_file_range(struct file *file, loff_t
> offset, loff_t nbytes,
> =C2=A0	if (!S_ISREG(i_mode) && !S_ISBLK(i_mode) &&
> !S_ISDIR(i_mode))
> =C2=A0		goto out;
> =C2=A0
> +	/* The page cache of a stacked file is in its real file */
> +	file =3D file_real(file);
> +	if (IS_ERR(file)) {
> +		ret =3D PTR_ERR(file);
> +		goto out;
> +	}
> +
> =C2=A0	mapping =3D file->f_mapping;
> =C2=A0	ret =3D 0;
> =C2=A0	if (flags & SYNC_FILE_RANGE_WAIT_BEFORE) {
> diff --git a/include/linux/backing-file.h b/include/linux/backing-
> file.h
> index c939cd222730c..dec7f8f017418 100644
> --- a/include/linux/backing-file.h
> +++ b/include/linux/backing-file.h
> @@ -40,5 +40,31 @@ ssize_t backing_file_splice_write(struct
> pipe_inode_info *pipe,
> =C2=A0				=C2=A0 struct backing_file_ctx *ctx);
> =C2=A0int backing_file_mmap(struct file *file, struct vm_area_struct *vma=
,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct backing_file_ctx *ctx);
> +struct file *backing_file_real(struct file *user_file);
> +
> +/**
> + * file_real - Return the real file hosting the data
> + * @file: the file to query
> + *
> + * If @file is on a stacking filesystem (e.g. overlayfs) whose data
> is
> + * accessed through a backing file, return that backing file.
> + * Otherwise return @file itself.
> + *
> + * The returned file is owned by @file and is valid for as long as
> the
> + * caller holds a reference to @file.
> + *
> + * The real file is only meant to be used for inspecting and writing
> + * back the page cache of the data (e.g. sync_file_range(2),
> cachestat(2)).
> + * It must not be used for operations that require the credentials
> or the
> + * permission checks of the stacking filesystem; those need a
> dedicated
> + * file operation (e.g. ->fadvise()).
> + */
> +static inline struct file *file_real(struct file *file)
> +{
> +	if (!IS_ENABLED(CONFIG_FS_STACK) || likely(!file->f_op-
> >f_real))
> +		return file;
> +
> +	return backing_file_real(file);
> +}
> =C2=A0
> =C2=A0#endif /* _LINUX_BACKING_FILE_H */
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5b3a100aba77b..613f7c692a420 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1960,6 +1960,7 @@ struct file_operations {
> =C2=A0				=C2=A0=C2=A0 struct file *file_out, loff_t
> pos_out,
> =C2=A0				=C2=A0=C2=A0 loff_t len, unsigned int
> remap_flags);
> =C2=A0	int (*fadvise)(struct file *, loff_t, loff_t, int);
> +	struct file *(*f_real)(const struct file *);
> =C2=A0	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int
> issue_flags);
> =C2=A0	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct
> io_comp_batch *,
> =C2=A0				unsigned int poll_flags);
> diff --git a/mm/filemap.c b/mm/filemap.c
> index b04be64a5069f..bead492070ed6 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -31,6 +31,7 @@
> =C2=A0#include <linux/hash.h>
> =C2=A0#include <linux/writeback.h>
> =C2=A0#include <linux/backing-dev.h>
> +#include <linux/backing-file.h>
> =C2=A0#include <linux/folio_batch.h>
> =C2=A0#include <linux/security.h>
> =C2=A0#include <linux/cpuset.h>
> @@ -4782,6 +4783,7 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
> =C2=A0		struct cachestat __user *, cstat, unsigned int,
> flags)
> =C2=A0{
> =C2=A0	CLASS(fd, f)(fd);
> +	struct file *real_file;
> =C2=A0	struct address_space *mapping;
> =C2=A0	struct cachestat_range csr;
> =C2=A0	struct cachestat cs;
> @@ -4804,11 +4806,16 @@ SYSCALL_DEFINE4(cachestat, unsigned int, fd,
> =C2=A0	if (flags !=3D 0)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	/* The page cache of a stacked file is in its real file */
> +	real_file =3D file_real(fd_file(f));
> +	if (IS_ERR(real_file))
> +		return PTR_ERR(real_file);
> +
> =C2=A0	first_index =3D csr.off >> PAGE_SHIFT;
> =C2=A0	last_index =3D
> =C2=A0		csr.len =3D=3D 0 ? ULONG_MAX : (csr.off + csr.len - 1)
> >> PAGE_SHIFT;
> =C2=A0	memset(&cs, 0, sizeof(struct cachestat));
> -	mapping =3D fd_file(f)->f_mapping;
> +	mapping =3D real_file->f_mapping;
> =C2=A0	filemap_cachestat(mapping, first_index, last_index, &cs);
> =C2=A0
> =C2=A0	if (copy_to_user(cstat, &cs, sizeof(struct cachestat)))
