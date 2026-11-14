Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794659491;
	b=ZnOdT6CFNbt6aTglS0/AtrhZZzzeI+tkO+P4drlIuatwnCvncDaIYvKpeb9dA+KRyAsp
	 v9Idc1QtAQl1AeVo0neLrdPb6Pfm96/fw4ls9NNTLBbMOQsk13NTa/GZNIJ9mtst2t0lk
	 gfqXERL18nzJEnn15qSJfZi09lVDv2dvx7nV6rVKG/XMaRyxHu12KcvZuLi25vk4Vwd+l
	 b9DnE/VZb4sLyProASGf5RDgAGriP1v/I+NIbVufFehPrhb8zqSe4h3xrPJ4pqe12P/KC
	 GpxetRugPjqJfsbafVF/oXXgFknjmD3gerbU5OaQR+30ChcU07VOJnMlkhOU6e5khzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794659491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=CZfWByojIILKVZ4K9YT1Vj6xfFon+RCsS6XQhj1o2C8=;
	b=czQcbU6AaB3W+4ok4CukOgEz2ZO1wmYYfee04pY7aHu1cUzKNuljfISwAFCexPtEfSTb
	 fdExxbf17t9LnUZNVFCUBO7BApNS8yCvxWyo2u+/eXXNRc+kXQ31L30T8CA1YSZoflTYi
	 bOVKidhRzUCD2Nj+4GNnrdji/Dbdn4qb1BCXC/XtGw/Z8En8PeieNwbjew41x5qRfvn73
	 NAf0VJiWK8UcN+M5yudH2iduGLRB9Zmd6wQANg+UGiWzhosI3I5TVbiu0NeimuEFJoB8P
	 4ap8r7+nzih3YAGOL7m+9Cqc3EoX+MpB+zZjstBMhiBYiMc5wHhH8TphU3jHjmfWqPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xk5k8AXF;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86114606A333
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 12:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86114606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xk5k8AXF
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4697404c2bso293656866b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 04:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794659489; x=1795264289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CZfWByojIILKVZ4K9YT1Vj6xfFon+RCsS6XQhj1o2C8=;
        b=xk5k8AXFqxT7yef6MPPmF98XVHauF+JQ8FmSql+0Ywp7RT3PGtBMiEYRGugHWaA0yy
         uHMHw27kawJIk8mS3DE87CZXO/JjudRZXCRfEy3ivSYTMQMQQ74EtLyl5tHmcDfFHRkZ
         dbjIlRrhZS4J4qaj/c247cd+uOSHCpySrwox13uHjxz9mAJaWgWql5fdO1guL0OY36eH
         2Iw7TOPEaq7nT4WptgccWuXT36/gG10tm8G31ueVP9rSW4UYUjlmSGpFpNn+GdaX3YZu
         gWjohMCc/X12KQt7mrnMhw+85d3X0U1RCHuoaJeVzF9ZubEwvGj4M3hZ1JU3k4xA48HG
         OlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794659489; x=1795264289;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZfWByojIILKVZ4K9YT1Vj6xfFon+RCsS6XQhj1o2C8=;
        b=KoyslG6vn19Ceb4nHTgMsCeAPfLm0guWDe+n0CxUoYq2jMYcvBtlfusdEia1SwIkSA
         JaKVQj7JItp2whKJxl6WLqGAyOwg7JWz4ctG6beIfatu+rvkkZ9iClBBJ7UwMXbAfDwb
         0wL7KFUj3tqJLOspDzyOGKOFHfxU7ZBsf9Rl3mvxWQPU7VhSQWqOHqlW4VTpdVgZgVfe
         Rc9V0haxMQn/fTUcEDv1srMyWbHWNTgPcdqa+iYvDWKiwqCF2wvQGR6ytG39OfsYsru4
         nCsiaNKm6h58VOqGKt4byItM7+W4+RJ891/axBAgKuAcG6CvwNxykdtZ9wzwbZMJvroK
         6zYw==
X-Forwarded-Encrypted: i=1; AL+hErHZy4T7rrSyzq9m8dEx9x218H58ECQrDs/txqk6NjmxBCq6v8zhIX6TixjKU4zu//v55Ea5Sm07kHAcXiiF@vger.kernel.org
X-Gm-Message-State: APuU4Z+Zj7eBERL5tv6nw56AjE5lckhJNWVDpsc3n9FLaGhnXJOqcbY6
	kLK9ejKFF++sBjON+QvI/CBA/tWYMBBiU3oa1hUA8fwunk6d/CD7XEyG
X-Gm-Gg: AYBFou2Dp82QkgllAfDjMRv+Ib4ob/abUGzbjqqdBPdLf4hoL/KLQwdOC/vwUKNT/i2
	vfGfv5C/0LUIkmsBAgN5XGcbylxyUGarxcncUMIgr7KAfi7qrIzj4M6nRwh7R0aWEfg7ot2HBin
	oUCybsK4r/97OmcsI+QSQ2B1K1TWouNaV19z+eM3xvmevdKVK0aBHcPVXQ5Q+Raf3Oj/99I2aFr
	jiiz1T2PDHvIeAduH722I2PyhbRjWTY9O2Cwf38QipsXvHpybne1CbqY0pLxz9V/DSWAr91LkN3
	4C1gcNIeb0YEGLXZxlw9gLBKzvyuQdEBLa89y11NIxg8Cmz+/9/XmFQ+7n4JzJvk4kt7uEbrUEn
	gNfYCgMYXaWeebKE7daGxDa6biTrLVsiDr1gXgqaMYK4uc6V2JLYUT9wG72AVP7VcbnoVLX1tB9
	nY3X5EBwgSIJnaaMMmJVBGPAKNj24eTNDBm4nZUA1NQaviNNNoIF6OpoVdp+o3CmMavUsbKA8+i
	U8iRNM9ToK+EhcU/A+Cy3ylO0qKqexEC+Go02/9d4ATJvFfrHIC+wgrovvDj1U0v5yIuu22CC2l
	Zo7W87I05bO5975DCLK8nv2TLhcSRBED0RpOfd1L18J/v7hWKs8AkPq6Jok1SzNLWw+2Nkc0iu4
	j0lezf1rpHaRa
X-Received: by 2002:a17:907:3d0d:b0:c46:7fa4:922b with SMTP id a640c23a62f3a-c509643babcmr407431366b.33.1794659488691;
        Sat, 14 Nov 2026 04:31:28 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm213162066b.0.2026.11.14.04.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:31:28 -0800 (PST)
Date: Sat, 14 Nov 2026 13:31:27 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 00/12] fs: take freeze protection for writes to backing
 files
Message-ID: <avhUn1Hb5iT6zBZp@amir-ThinkPad-T480>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
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
In-Reply-To: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>

On Sat, Nov 14, 2026 at 11:47:07AM +0100, Christian Brauner wrote:
> While testing the pseudo filesystem series I noticed that zloop, the
> nvme target's file backend and the fileio backend of the scsi target
> with fd_async_io=1 call ->write_iter() of their backing files without
> taking freeze protection. So their writes go straight through to a
> frozen filesystem. ext4 complains loudly:
> 
>     WARNING: fs/ext4/ext4_jbd2.c:90 at ext4_journal_check_start+0x1f6/0x2d0
> 
> Loop doesn't get it right for discard and write zeroes. Those end up
> calling ->fallocate() of the backing file directly. The fileio backend
> does the same for UNMAP. And zloop records its write pointers on flush
> with vfs_setxattr() which leaves freeze protection to the caller. So all
> of them modify a frozen filesystem just the same. Fix them too.
> 
> Looking for more of the same turned up a few simple ones. coredump
> truncates the core file, overlayfs stores its uuid xattr on mount, nfsd
> truncates on OPEN and the BPF xattr kfuncs modify xattrs, all without
> freeze protection. Fix those as well. The ones that need more work in
> their subsystems I have reported separately.
> 
> The fileio backend also frees its aio command in the completion handler
> while the filesystem may still be using the kiocb. KASAN catches ext4
> doing that for direct reads on v7.4-rc1. ext4 gets its own fix (cf. [1])
> but fileio should hold a reference across the submission like loop,
> zloop and fs/backing-file.c do.
> 
> [1]: https://lore.kernel.org/r/20261113-work-ext4-dio_read_kiocb-v1-1-172a88be803c@kernel.org
> 

Claude says you missed another one.
nfs_local_write_iocb_done() does not end_write
its ended too early right after submission.

Thanks,
Amir.

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Christian Brauner (12):
>       fs: add kiocb_start_write_trylock()
>       zloop: take freeze protection for writes
>       nvmet: take freeze protection for writes to files
>       target: fileio: don't free the aio command under the filesystem
>       target: fileio: take freeze protection for aio writes
>       loop: take freeze protection for discard and write zeroes
>       zloop: take freeze protection when recording write pointers
>       target: fileio: take freeze protection for unmap
>       coredump: take freeze protection for the truncate
>       ovl: take freeze protection when storing the uuid
>       bpf: fs/xattr: take freeze protection in the xattr kfuncs
>       nfsd: take freeze protection for the truncate on open
> 
>  drivers/block/loop.c              |  2 ++
>  drivers/block/zloop.c             | 31 ++++++++++++++++++++-------
>  drivers/nvme/target/io-cmd-file.c | 37 +++++++++++++++++++++++++-------
>  drivers/target/target_core_file.c | 44 ++++++++++++++++++++++++++++++++-------
>  fs/bpf_fs_kfuncs.c                |  8 +++++++
>  fs/coredump.c                     |  6 ++++--
>  fs/nfsd/nfs4state.c               | 10 ++++++++-
>  fs/overlayfs/util.c               |  8 +++++--
>  include/linux/fs.h                | 22 ++++++++++++++++++++
>  io_uring/rw.c                     |  9 +-------
>  10 files changed, 142 insertions(+), 35 deletions(-)
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261113-work-fs-frozen_writes-042ca762bfb8
> 
