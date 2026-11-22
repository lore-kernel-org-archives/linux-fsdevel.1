Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306696;
	b=kGGjgk+kjZjItVSstneO9mPIdAsli9ITql0qS34MG4q5Oj+dzH5ed3pDtsxyB3wP2MFd
	 RRU5qE69uBONJUpSFRoI+ZBDdpQ8u6SpENqZvfR23MYcgSWniWAYpnNt7olvc7sf5WKYS
	 dLxLkgEnP4uxAFpqI6RclziI6eSyVtOPk9mkpic8IvZkuMCppFAN+2iRBvgPtRpqtYami
	 ekB3ofVEXSSieFjoTzDb7yR3QojtypVt+2o5Hl754B1kxfOYSk+ZePcHSO8WW9fM5MWRw
	 WcRkNw7A29d3r082d6voz3PAoNRZFJ4fUfGf+2pFVVVNOKMW07iumrFNFe45Iqmi4jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306696;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=n3n064Qsk3rdX1FqPH4kxS8Bgm27CPleORQhLo802h4=;
	b=vSeBPsUeHScYxiSGJtzEWOoKX7o9LjRtOmEr3cCnbOv4xgm4Kif30AwibK3DKLvaKRhn
	 cDpYJ2j1XplSqpvLSeVfhsHHfTo8bvmhvkARWUIRCKzWBPHfS5SzI+Fra80ECLQDlHVVg
	 QIxNpc3Cl1rZWy5+o23N1k/959Xqg59yITrlsi+Wv/+YqbqzBg/HrAyIlxkdqtMotkjEQ
	 E+zLo5E/hXKDT7pJSJ4zWOoLQJrRKUqwTmttjobn83f3D7ry3Pk/ZS1QKuvIYhn+OLBjo
	 cz8UMLJLM6UUIqGQB/LjKkCE4OooH6ku4EsSrIth1NePvj0hlrICnd2jMUi05WYCdvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eohuO05q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15F606A339
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 00:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eohuO05q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125D31F000C6
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Nov 2026 00:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306696;
	bh=n3n064Qsk3rdX1FqPH4kxS8Bgm27CPleORQhLo802h4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eohuO05q1IHKD2z24EmnbHK6EZjlYRSfGlTuLjhQlM8YfpqjrSuilbC0yg15Rpg4r
	 +Ap5+FWwomY68WPOoCjXyNbnbL07D0Pr9Yic6d1uI2+SqGy+mfHn3z/FmOUmFO9vQU
	 dkd7Mla4Ccq1qd+e6EtyEUiyT0+HW08x+E2R4ALePJIN95H9EEdsALz5VmGJlgHxlu
	 FbB8M1EHHe5wU6ELCvxscDsFON8mOC26s5UxjpTxxfecI5KVI4VQb5KTP7Dvq3CVSN
	 zV+5NnK5eh1SyFMERHXAVu6VlAyV+Slfulp+K3X8dDa4T1DDrUD/+Phn8obyJmGJji
	 4ZVJHxyoOWriA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c511c0e2826so257665866b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 16:18:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEpawt69/AbKkY45w/b8mqW70Q6Ea6WdUnC4NeHaGBt2t4NOqa6A2PixejHYPgq2ZB0sI00nlL8837LeR1q@vger.kernel.org
X-Gm-Message-State: APuU4Z+SIvs//5OIej+bf0XoVscDIdXNZfnisd3CdwBrB5Vx0gAXjtwn
	Z5xXe9DKGFX6wiIPSLWK+wnLjF6eiqCM7qmiFXG+oj6+xDQAjRX7IT++dJp+VziQrr2SaD0S9Uq
	7WnTExvepYGKy1KX9KSSsqGIV3CVc2yo=
X-Received: by 2002:a17:906:b2d0:b0:c4d:2f6b:435 with SMTP id
 a640c23a62f3a-c513a9ae264mr488487966b.18.1795306694724; Sat, 21 Nov 2026
 16:18:14 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121174315.500249-1-shaopei_1012@163.com>
In-Reply-To: <20261121174315.500249-1-shaopei_1012@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 22 Nov 2026 09:18:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8uKrOU=tyJ1yqme=3HBwyLu4-Hg9cw03+VZ+P4k0-B9g@mail.gmail.com>
X-Gm-Features: Aa3M54ovn0x5mU7utYfTW_4kD8G5XRkVPTYp1VL9xIHSa_8ooIpRyn09CO-AvZ0
Message-ID: <CAKYAXd8uKrOU=tyJ1yqme=3HBwyLu4-Hg9cw03+VZ+P4k0-B9g@mail.gmail.com>
Subject: Re: [PATCH] exfat: add EXFAT_IOC_COMBINE to append a file's clusters
 to another
To: Shaopei Zhu <shaopei_1012@163.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 2:43=E2=80=AFAM Shaopei Zhu <shaopei_1012@163.com> =
wrote:
>
> Cameras and dashcams recording to exFAT SD cards often write the video
> stream and auxiliary data (e.g. IMU samples) to separate files and merge
> them when recording stops.  Doing that with read()/write() or
> copy_file_range() rewrites the whole payload, which is slow on such
> media, wears the flash and needs free space for a second copy.
>
> Filesystems supporting reflink can already avoid the copy by cloning
> the source to the end of the destination with FICLONERANGE and then
> unlinking it.  exFAT cannot share clusters between files, so it needs
> an operation that moves them instead.  Its semantics follow from the
> exFAT on-disk format (cluster granularity, a single valid_size per
> file), so it is added as an exfat ioctl rather than a VFS interface;
> fallocate() does not fit either, as it only takes a single file.
>
> Add an ioctl that moves the cluster chain of a source file to the end
> of a destination file and then unlinks the source, so that only
> metadata changes: the FAT, the stream extension entry of the
> destination and the entry set of the source:
>
>         struct exfat_combine_args args =3D { .src_fd =3D src_fd };
>         ioctl(dst_fd, EXFAT_IOC_COMBINE, &args);
>
> The source is unlinked the way btrfs_ioctl_snap_destroy() removes a
> subvolume: start_removing_dentry() revalidates the dentry of the open
> file and locks its parent, may_delete_dentry() checks the permission as
> unlink(2) does, the entry set is deleted by the same code as
> exfat_unlink(), and d_delete_notify() updates the dcache and notifies
> watchers, without re-entering exfat through vfs_unlink().  Since the
> in-memory inode no longer owns the clusters, evicting it frees nothing.
> The permission is checked before anything is changed, and an already
> unlinked source is accepted.
>
> As with EXT4_IOC_MOVE_EXT and F2FS_IOC_MOVE_RANGE, the source must be
> open for reading and writing, the destination for writing, and both
> must be regular files on the same mount.
>
> exFAT has a single size and valid_size per file, so clusters can only
> be appended at a cluster boundary of a fully initialized file.  The
> destination is therefore first zero-filled up to the end of its last
> cluster with exfat_extend_valid_size(), leaving a zero-filled gap
> between the original and the appended data when its size is not
> cluster aligned.  This is documented in the uapi header, and keeps
> stale on-disk data out of the file.
>
> exFAT has no journal, so the data and the FAT, then the destination
> entry, then the deletion of the source entry set are written and
> flushed to the device in that order, as recommended by section 8.1 of
> the exFAT specification; the allocation bitmap is not touched.  A
> crash at any point leaves all data reachable from at least one entry.
> In the worst case both entries share the appended clusters; fsck.exfat
> keeps them in the file it checks first and truncates the other one, so
> either the combine has completed or the source still holds its data.
> If the call fails before the clusters are moved, the zero padding is
> removed again.  s_lock is only held while updating the FAT and the
> entries, not while waiting for the device, so that writers to other
> files on the volume are not stalled.
>
> No file data is copied, so the cost depends on the number of clusters
> (when a FAT chain has to be built for a contiguous file) rather than on
> the amount of data.
>
> The ioctl number is taken from the 'r' range next to the FAT ioctls.
> A user space tool for exfatprogs (exfatcombine) and a test for fstests
> (exfat/002) are posted separately.
>
> This patch was written with the help of an AI coding assistant
> (Claude Code, Opus 5.5); I have reviewed and tested the result.
>
> Signed-off-by: Shaopei Zhu <shaopei_1012@163.com>
First, Please check Sashiko's review comments.

https://sashiko.dev/#/patchset/20261121174315.500249-1-shaopei_1012%40163.c=
om

And please send exfatcombine's PR to exfatprogs.

Thanks.
