Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536810;
	b=aq+6otKwSuabhawNwkrfqVHOBp8P6OnCGEx09blR+CTgjzHert+8Az/bpUapPfqsst8C
	 uwYozOGpw0CNOzN7Fz9h33Hp6SeJ/dpyCR4vK6O9YoZFniMQkGGvGQJCG+RtTv8BV2wrg
	 eFPU18GOtFuz0l3gdFLVk0/aavw/n21gA25B8eve2eEW1SmD8sCoQZgEBXiheb9lPEa/Z
	 W2sp+AVSYGqQHJ9CpacCBv0NoFZD2TI1z8EoOGoA9UPk8dyOuhNyVNIGRnzRX1s31+4l3
	 TH3zR7ogTOHPOfFll3fhTGemD0JDq5s4QxJ/HIVqWAR1ln0UeleoYTIXGXss7787NiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536810;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9Yy6grSCr+u8lAghLloqJJERK2XEpnnBGJ2Uw0VUpVM=;
	b=QPZ0QEFTD+YcYqQ82mMccj8YSN3rTGrOqIZOZhUWC52OpFdqMmwVPvydCyD1A1GflUt5
	 RZmVAfotNPHBOGM1xqK2TQpmdxojH26zLw5HO77ArYZ8PnmupoBDW2lWKxnVsV6vj3JRG
	 9Tdc7f2mUqy9itCP9YaUr/yhrzWeNzn6sI+JNW1Ic+LPAX20KdUhYsQEkg8XvrkVKICy2
	 egUarDZG8IEO/QTyXhXyP/TiS64xG2tV8nLYnfWBOqyp+SLBR3+2EqN2I72tZFOcS6K15
	 1Izav4HGO7bwRsdWgrE1jZsyy77Z8F9MerQBtNi34NugnboKjb7XmuN748zCrCyN2KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=oj5sRO0x;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D0606A68D;
	Tue, 24 Nov 2026 16:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159D0606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=oj5sRO0x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=9Yy6grSCr+u8lAghLloqJJERK2XEpnnBGJ2Uw0VUpVM=; t=1795536809; x=2110896809; 
	b=oj5sRO0xxkA6BisA81n2Z/+2j9cOdVjjLzi0FWZK+6ecdrSuyLXnMee0KAf0ytdU6FoE6a7oD/7
	A7qZ2ZgTrEfMjrXy7WsgaHN31e8iaZAkgVarn1DvND/fCGNdV/IEVAsAhhQVPZS6oq6y2ajZyoMc4
	PgHIJL4QxGKEWom+kmj1aWVF5rM2RTYQ0qQjmmBWQNwt40fRFGb3Niu4g/q+fq2ClcBWG6Wk/dUp9
	kFEWxK47MuaEASUNQFTbwhWhQFlfk5DMQyzjfpS18BwFkqSME/Qq/TogUdfiSVo/4mdo5jwG9rzy1
	F964EsjOKeeHSBII37pCs6SF3uD0DiEmAK5w==;
Received: from bl17-56-70.dsl.telepac.pt ([188.82.56.70] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xVt8z-00000003Y4b-3vgI;
	Tue, 24 Nov 2026 17:13:22 +0100
From: Luis Henriques <luis@igalia.com>
To: koraynilay <koray.fra@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Edward Adam Davis
 <eadavis@qq.com>,  Amir Goldstein <amir73il@gmail.com>,  Miklos Szeredi
 <miklos@szeredi.hu>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: fix file_getattr hint to request xflags
In-Reply-To: <20261124150108.189282-1-koray.fra@gmail.com>
References: <20261124150108.189282-1-koray.fra@gmail.com>
Date: Tue, 24 Nov 2026 16:13:18 +0000
Message-ID: <87se0qb42p.fsf@igalia.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24 2026, koraynilay wrote:

> When using a FUSE mount over an underlying filesystem that supports
> xflags, querying them from userspace with file_getattr() strips them
> because file_getattr sets flags_valid =3D true so FUSE uses
> FS_IOC_GETFLAGS instead of FS_IOC_FSGETXATTR.
>
> Fix it by setting fsx_valid =3D true instead.
>
> Output when using a simple FUSE mount that simply forwards the ioctls to
> the underlying fs:
>
> before the fix:
>
>   /xfs/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D69
>   /xfs/file: file_getattr:      ret=3D0, projid=3D0
>   /ext4/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D42
>   /ext4/file: file_getattr:      ret=3D0, projid=3D0
>
> after the fix:
>
>   /xfs/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D69
>   /xfs/file: file_getattr:      ret=3D0, projid=3D69
>   /ext4/file: FS_IOC_FSGETXATTR: ret=3D0, projid=3D42
>   /ext4/file: file_getattr:      ret=3D0, projid=3D42
>
> Fixes: cb184dd19154 ("fs: init flags_valid before calling vfs_fileattr_ge=
t")
> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.11
> Signed-off-by: koraynilay <koray.fra@gmail.com>
> ---
> Hi, I found this issue while working on the v2 of [1], here is the
> reproducer, not in the commit message because of the size.
>
> script:
>
>   #!/bin/bash
>   truncate -s 100M xfs.img
>   truncate -s 100M ext4.img
>   mkfs.xfs xfs.img
>   mkfs.ext4 -O project ext4.img
>   mkdir xfs ext4
>=20=20=20
>   mount xfs.img xfs
>   mount ext4.img ext4
>   touch {xfs,ext4}/file
>=20=20=20
>   chattr -p 69 xfs/file
>   chattr -p 42 ext4/file
>=20=20=20
>   mkdir fuse
>   ./repro_fuse_getattr fuse "$PWD"/xfs/file
>   ./repro_fuse_getattr fuse "$PWD"/ext4/file
>=20=20=20
>   umount xfs ext4
>
> where repro_fuse_getattr is a simple fuse mount, compiled with:
>
>   gcc repro_fuse_getattr.c -o repro_fuse_getattr $(pkg-config fuse3 --cfl=
ags --libs)
>
> and used like:
>
>   ./repro_fuse_getattr <fuse_mount_dir> <full_path_to_real_file>
>
> repro_fuse_getattr.c:
>
>   #define _GNU_SOURCE
>   #define FUSE_USE_VERSION 35
>   #include <fuse3/fuse.h>
>   #include <stdio.h>
>   #include <string.h>
>   #include <errno.h>
>   #include <fcntl.h>
>   #include <unistd.h>
>   #include <sys/syscall.h>
>   #include <sys/ioctl.h>
>   #include <sys/mount.h>
>   #include <linux/fs.h>
>=20=20=20
>   /* needed to get the file's file descriptor for the ioctl */
>   static int my_getattr(const char *path, struct stat *st, struct fuse_fi=
le_info *fi)
>   {
>   	memset(st, 0, sizeof(*st));
>   	if (!strcmp(path, "/")) {
>   		st->st_mode =3D S_IFDIR | 0755;
>   		st->st_nlink =3D 2;
>   		return 0;
>   	}
>   	return stat(fuse_get_context()->private_data, st) < 0 ? -errno : 0;
>   }
>=20=20=20
>   /* pass down the ioctl to the fs */
>   static int my_ioctl(const char *path, unsigned int cmd, void *arg,
>   		    struct fuse_file_info *fi, unsigned int flags, void *data)
>   {
>   	int fd =3D open(fuse_get_context()->private_data, O_RDONLY);
>   	int ret =3D ioctl(fd, cmd, data);
>   	close(fd);
>   	return ret < 0 ? -errno : 0;
>   }
>=20=20=20
>   static const struct fuse_operations ops =3D {
>   	.getattr =3D my_getattr,
>   	.ioctl   =3D my_ioctl,
>   };
>=20=20=20
>   int main(int argc, char *argv[])
>   {
>   	const char *mnt =3D argv[1]; /* FUSE mount point */
>   	const char *real_file =3D argv[2]; // full path of the file on the
>   					 // underlying fs
>=20=20=20
>   	/* start FUSE */
>   	pid_t pid =3D fork();
>   	if (pid =3D=3D 0) {
>   		char *fuse_argv[] =3D { "fuse", "-f", (char *)mnt, NULL };
>   		return fuse_main(3, fuse_argv, &ops, (void *)real_file);
>   	}
>=20=20=20
>   	usleep(300000); /* wait for FUSE mount */
>=20=20=20
>   	/* Query the file attributes through FUSE mount */
>   	char fuse_file[4096];
>   	snprintf(fuse_file, sizeof(fuse_file), "%s/file", mnt);
>=20=20=20
>   	int fd =3D open(fuse_file, O_RDONLY);
>=20=20=20
>   	struct fsxattr x =3D {};
>   	int ret_fsget =3D ioctl(fd, FS_IOC_FSGETXATTR, &x);
>=20=20=20
>   	struct file_attr fa =3D {};
>   	long ret_sys =3D syscall(SYS_file_getattr, -100, fuse_file, &fa, sizeo=
f(fa), 0);
>=20=20=20
>   	close(fd);
>=20=20=20
>   	printf("%s: FS_IOC_FSGETXATTR: ret=3D%d, projid=3D%u\n",
>   	       real_file, ret_fsget, x.fsx_projid);
>   	printf("%s: file_getattr:      ret=3D%ld, projid=3D%llu\n",
>   	       real_file, ret_sys, (unsigned long long)fa.fa_projid);
>=20=20=20
>   	umount(mnt);
>   	return 0;
>   }
>
> Thanks,
> koraynilay
>
> [1]: https://lore.kernel.org/all/DN2YMTH77KWE.3IPE9OG8377X0@gmail.com/T/#t
>
>  fs/file_attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 833e03810b24..3b249a0a6b36 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -383,7 +383,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __=
user *, filename,
>  	struct path filepath __free(path_put) =3D {};
>  	unsigned int lookup_flags =3D 0;
>  	struct file_attr fattr;
> -	struct file_kattr fa =3D { .flags_valid =3D true }; /* hint only */
> +	struct file_kattr fa =3D { .fsx_valid =3D true }; /* hint only */

Isn't this reintroducing the bug that was fixed by commit

cb184dd19154 ("fs: init flags_valid before calling vfs_fileattr_get") ?

Maybe fuse_fileattr_get() shouldn't be handling FS_IOC_FSGETXATTR at all,
and FS_IOC_FSGETXATTR handling should be moved into fuse_do_ioctl()
instead?  (Or, more likely, I'm missing something!)

Cheers,
--=20
Lu=C3=ADs

>  	int error;
>=20=20
>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
>
> base-commit: 3857587d9d6fa44d40d1c73bde6a39f6f7a5216c
> --=20
> 2.56.0
>
>

