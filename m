Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536011;
	b=HwTMq+7qN/2GhpKn1hgksVp/g8iCnbv0Kp7fKNsAtvsXXuph80fC/sgwleHadR+ddWxZ
	 6E/F1OaBBbQvVIMPCW8ZusLgtz+2OpmD/O0x3w+n2O8xTNF3fS50c1yFU4NvgZ8OQeVnE
	 RTOtWf11RUvmboiZ3ekw6X+Bx7UwDOPUn4Z1gR13FCLIlbYUb1fMS8VavRF2O5v9pNQzd
	 WA2vXFJDGyX5lEtNXVX/ygn7deKD+g8hf7R/CVSY048S2AWJSEW2b/uUrPISY2DZaFuvJ
	 pS0Cj6gKl+bP2r6mxrOlQ7fZEKNIsMsmosajp3OscfaXU4GKVQbi0T9Ma1u3L0GYQsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536011;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=WyDdvfjHNhbIjglf8XuLVeDKVR/gcGoOR6RkKSo72Xg=;
	b=UC4eKI260X15caep67EZYsD18wUeOwcdD9+otW581rA4aiLqN1oEylNXdAC9Ai74L6Qu
	 o+7teJjOdrv/y25AHMoSfrszRiKDSaIHZaVzIh2xFuLzr+R+xBkTVO9Fub7IHIKKcUVlJ
	 bsNTHubxW+ZrbeFmer/7zd5e7rxBlNJx2XxaAQqODmLTafGFfh8GMM+/0u3PcQJQIlPjO
	 j618bOEyzHV/q7YVLbi4YPZsVeNbdVQDlXF5RLoU7AAGJSGfAn8Cb1np7KZcKuCVywFQb
	 O2JEMhRZwFGvut5QCqhXemf5E289HeCyI+no5yGXk0s2jHg9crmmAeQjAPqVoQk1fTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=OJSXW4JT;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sHN2TWmm;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=OJSXW4JT;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sHN2TWmm;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98638606A327;
	Tue, 24 Nov 2026 16:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98638606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=OJSXW4JT;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sHN2TWmm;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=OJSXW4JT;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sHN2TWmm
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46B6E222FC;
	Tue, 24 Nov 2026 16:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795536008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyDdvfjHNhbIjglf8XuLVeDKVR/gcGoOR6RkKSo72Xg=;
	b=OJSXW4JTlCx8xys7tyF6wx/SiwZqltuo49A48APilde8a20vmcTR4+N6WFauzBkUxca1jb
	mkGjYfJT2h6Yk9JKlq9SH2CaNfNJenQl5XP+EQNwpTmVT73RCnyAzDhHrNRfkmXJ5LMhAN
	LO3MwbBS0WGnH1jyEQsu0wCAzB+8Jn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795536008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyDdvfjHNhbIjglf8XuLVeDKVR/gcGoOR6RkKSo72Xg=;
	b=sHN2TWmm9SnvEtBxVEAhWLxgnorU/8t4HbU4Xfp5rhsecu+IuOkETQSETThWurkQ1hqkfL
	yS4jWWCXmoFsUcCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795536008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyDdvfjHNhbIjglf8XuLVeDKVR/gcGoOR6RkKSo72Xg=;
	b=OJSXW4JTlCx8xys7tyF6wx/SiwZqltuo49A48APilde8a20vmcTR4+N6WFauzBkUxca1jb
	mkGjYfJT2h6Yk9JKlq9SH2CaNfNJenQl5XP+EQNwpTmVT73RCnyAzDhHrNRfkmXJ5LMhAN
	LO3MwbBS0WGnH1jyEQsu0wCAzB+8Jn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795536008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WyDdvfjHNhbIjglf8XuLVeDKVR/gcGoOR6RkKSo72Xg=;
	b=sHN2TWmm9SnvEtBxVEAhWLxgnorU/8t4HbU4Xfp5rhsecu+IuOkETQSETThWurkQ1hqkfL
	yS4jWWCXmoFsUcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1836F1339F;
	Tue, 24 Nov 2026 16:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lHpUOYe0BWv4DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 16:00:08 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 9D39427A0B; Tue, 24 Nov 2026 17:00:03 +0100 (CET)
Date: Tue, 24 Nov 2026 17:00:03 +0100
From: Jan Kara <jack@suse.cz>
To: koraynilay <koray.fra@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Edward Adam Davis <eadavis@qq.com>, 
	Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: fix file_getattr hint to request xflags
Message-ID: <254hewuzyamtl5ud7rgmirp3klfqzlqua5ky2z54c2im54bs5h@oycxxuv7zbgz>
References: <20261124150108.189282-1-koray.fra@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124150108.189282-1-koray.fra@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,qq.com,gmail.com,szeredi.hu,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -11.30

On Tue 24-11-26 16:01:08, koraynilay wrote:
> When using a FUSE mount over an underlying filesystem that supports
> xflags, querying them from userspace with file_getattr() strips them
> because file_getattr sets flags_valid = true so FUSE uses
> FS_IOC_GETFLAGS instead of FS_IOC_FSGETXATTR.
> 
> Fix it by setting fsx_valid = true instead.
> 
> Output when using a simple FUSE mount that simply forwards the ioctls to
> the underlying fs:
> 
> before the fix:
> 
>   /xfs/file: FS_IOC_FSGETXATTR: ret=0, projid=69
>   /xfs/file: file_getattr:      ret=0, projid=0
>   /ext4/file: FS_IOC_FSGETXATTR: ret=0, projid=42
>   /ext4/file: file_getattr:      ret=0, projid=0
> 
> after the fix:
> 
>   /xfs/file: FS_IOC_FSGETXATTR: ret=0, projid=69
>   /xfs/file: file_getattr:      ret=0, projid=69
>   /ext4/file: FS_IOC_FSGETXATTR: ret=0, projid=42
>   /ext4/file: file_getattr:      ret=0, projid=42
> 
> Fixes: cb184dd19154 ("fs: init flags_valid before calling vfs_fileattr_get")
> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.11
> Signed-off-by: koraynilay <koray.fra@gmail.com>

Good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
>   
>   mount xfs.img xfs
>   mount ext4.img ext4
>   touch {xfs,ext4}/file
>   
>   chattr -p 69 xfs/file
>   chattr -p 42 ext4/file
>   
>   mkdir fuse
>   ./repro_fuse_getattr fuse "$PWD"/xfs/file
>   ./repro_fuse_getattr fuse "$PWD"/ext4/file
>   
>   umount xfs ext4
> 
> where repro_fuse_getattr is a simple fuse mount, compiled with:
> 
>   gcc repro_fuse_getattr.c -o repro_fuse_getattr $(pkg-config fuse3 --cflags --libs)
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
>   
>   /* needed to get the file's file descriptor for the ioctl */
>   static int my_getattr(const char *path, struct stat *st, struct fuse_file_info *fi)
>   {
>   	memset(st, 0, sizeof(*st));
>   	if (!strcmp(path, "/")) {
>   		st->st_mode = S_IFDIR | 0755;
>   		st->st_nlink = 2;
>   		return 0;
>   	}
>   	return stat(fuse_get_context()->private_data, st) < 0 ? -errno : 0;
>   }
>   
>   /* pass down the ioctl to the fs */
>   static int my_ioctl(const char *path, unsigned int cmd, void *arg,
>   		    struct fuse_file_info *fi, unsigned int flags, void *data)
>   {
>   	int fd = open(fuse_get_context()->private_data, O_RDONLY);
>   	int ret = ioctl(fd, cmd, data);
>   	close(fd);
>   	return ret < 0 ? -errno : 0;
>   }
>   
>   static const struct fuse_operations ops = {
>   	.getattr = my_getattr,
>   	.ioctl   = my_ioctl,
>   };
>   
>   int main(int argc, char *argv[])
>   {
>   	const char *mnt = argv[1]; /* FUSE mount point */
>   	const char *real_file = argv[2]; // full path of the file on the
>   					 // underlying fs
>   
>   	/* start FUSE */
>   	pid_t pid = fork();
>   	if (pid == 0) {
>   		char *fuse_argv[] = { "fuse", "-f", (char *)mnt, NULL };
>   		return fuse_main(3, fuse_argv, &ops, (void *)real_file);
>   	}
>   
>   	usleep(300000); /* wait for FUSE mount */
>   
>   	/* Query the file attributes through FUSE mount */
>   	char fuse_file[4096];
>   	snprintf(fuse_file, sizeof(fuse_file), "%s/file", mnt);
>   
>   	int fd = open(fuse_file, O_RDONLY);
>   
>   	struct fsxattr x = {};
>   	int ret_fsget = ioctl(fd, FS_IOC_FSGETXATTR, &x);
>   
>   	struct file_attr fa = {};
>   	long ret_sys = syscall(SYS_file_getattr, -100, fuse_file, &fa, sizeof(fa), 0);
>   
>   	close(fd);
>   
>   	printf("%s: FS_IOC_FSGETXATTR: ret=%d, projid=%u\n",
>   	       real_file, ret_fsget, x.fsx_projid);
>   	printf("%s: file_getattr:      ret=%ld, projid=%llu\n",
>   	       real_file, ret_sys, (unsigned long long)fa.fa_projid);
>   
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
> @@ -383,7 +383,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
>  	struct path filepath __free(path_put) = {};
>  	unsigned int lookup_flags = 0;
>  	struct file_attr fattr;
> -	struct file_kattr fa = { .flags_valid = true }; /* hint only */
> +	struct file_kattr fa = { .fsx_valid = true }; /* hint only */
>  	int error;
>  
>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> 
> base-commit: 3857587d9d6fa44d40d1c73bde6a39f6f7a5216c
> -- 
> 2.56.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
