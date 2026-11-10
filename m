Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305680;
	b=2Gg81hs3BIx+RfWcV38Qw/fyFwHmVvDOBoZr8ZI4QHz4lfSGMfJ8sknnCec0c/rcf9jC
	 XHNHu+SMcDTm8ZCRIrkkIZjuyNDixdjX0AzP2B+72A0s1+8CA5mYL+6lWLf28o68qYwAc
	 FLnDLBxnZK+eTVph27kR+RWbRMKqeULuUzkLLwG68sZ5I9lXj3L2gXyvzB/8saEzxszGQ
	 1eXvy+opVUlbbrjQTu7bUPQt6NEoiEAQgqcqVq0Eo9MuyMJsgmogSo+kRJngfwUYQ3r1M
	 DrMOJIQ+WVTaqfUc1oSRXdSHFqJztQ6KNts9kCvf4/+2BXXE7BZrwpZUKacgd4g6yhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
	b=tt1Vto2JihyXOuZioq1Dp0K5nvUQxHJguUX/bn5vFBR/e0Soys5Am5pW11lB1oZmThxY
	 1221vfRFsolJhpbhRi0aTnGSq2cX4jdvSqc9oXnANh4ADri+ErshGmxI8B2inIxeEhEBq
	 lkWursqbJJO0jQ+MGyLGzuPqyDO6vojUt/MjlaVoj+hsgKbxJK4i6nnsxsWx9XbtlxFpg
	 Yytf7W/A2eaVSE9hIIEvproDLgtBl1qPzifudcJ+IjskYjsdB9skFz2ZwX8iFitj8GjpP
	 RA+PgH/1Sz1aASEPbPyWkyNoc519z/GoeBgK5+FAzOJqMA6PR2Fge8c/GtkeicqQOVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE36606AA46
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 10:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EE36606AA46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b547d6c07bso2304489a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794305678; x=1794910478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=DrlQYRb4d+FJBQLFk4gip1vdMb9pZcbFm0QRoW/O9nsnnIGk5B/dcI7komCKzkv/uM
         Uz0TTkL3EB0XOLA2v0TTxwYvqDOvah1wiwbB4uUsiRRXfj1OcdvtnHWnMQS6yfKTNN5Y
         2S+sbZpFj/oUd6OIfB1K+t4luOgmpm8MRta8dNUBz+XdEb16ui6jztHrAySR2QYDDBtW
         UcH7ksMk3kyTCuhLg24n4RSbgP43bR1MD63YWBBHbNHKba+s6Adtgd3r0iiTavTYgvkx
         vCBmyxhjfzRfUpjuhY0K7x1CK/3uUIf/0FzbTbFW5bHu/k5G1xko0Cr6O3LrrObY61iA
         y+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794305678; x=1794910478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=ZTFD3BfIs7mj0J9DnDqLTy35dxFQvjaarkKPBkXI+h+2LfL3iB51aFmMzNdVyY/cCK
         BcRst/wYGVMA0W1k3yQ/lxzV5vaTU0LfOEEi+Vzu6xxJoQdZnmbxhJRLEi/ZFXwzPXdB
         TVBcUpGBuWrnMlaoLW0mIXQNhyceDJZhJdiiujI+Nd6F+poyPVOfvhwJ0s/C3B3FFPK5
         pRqlku9aZelWx9Um9kjpoSeCig/E2N7p6OduvyL2vKM8N5UBCpJtgLgaxfwziUf5UYZf
         dRt9di4rJ43ODqkDp8cPzxMBVcV36LdSZ/WU1m47dj/X6mcgbN4bcIAf7ir1WgG5AJ9L
         j5Mw==
X-Gm-Message-State: APuU4Z/gbNrLPYgT1IZSRztOTNTqh+fm7q2idMZIeaZHJAokdRQFTpBz
	HDJ9cY23xUSvOGy31faEyZ8dJ/w6OLHKXBZeICmzI+SgR8j/PjoTGQKL
X-Gm-Gg: AYBFou03mWK+pjnfgOcSP/FVQsv3q5ckq4ygoRkC96m/IBlSNSyFQT/7Idym3GmnyVj
	S+qieJRUq8NZ+JzhrJzw8QxSBAUfed7fZztEE5cFv0ppQmwJZfeCJsxvX8UQIUYnVu69svE6u7/
	B9jv4W/VMlIQv3jaH5nODtxUHeUcEFSvv++m1mbUaBnjg3mv9JPdREQmSd9d/Mnws88ZHH/EpyF
	vbh+QqoA1uiU1ySzAeZs/NJgtSqDpu+zAB6IX8S/xyziVtJaOpO/tiAVcsDRCYvuyL0VMBd/PDW
	kUOkpi9zJnIEiic9cvp+3C54JBiGt7aTyFLvO845X7ppYXZvd5ae0AfcTc47jv/UeKkSiL+oX2q
	PUcRYMrm52STKI533K2TQ+WdexWl8ydA/RCMT959/ulG/ut86jrJHOBfi7wC9ANVzwuoLlDdBxW
	CwITMfJuVACTx/cJ2D4RlLo3FoLX8HDhgc501W/12Fr0Ux3CKOaJXmPf3lYfNs1NwtrPGdWTBsu
	P/bRwpkR7p5hMTw+hJ/zOAhhxBXY+UewwkH9Co3DraPxykfNCFX0wGquBT2Y5BsNykf6xIRNlzG
	skPAVI8BCrHgnL/gKPDJ+qS+DPggQCMqfLT/VIivsMyZe6BaD7/q5u25t3BzftaZmVcjeGrrM7I
	G93IVrtjhXMQ6
X-Received: by 2002:a17:907:944d:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c504963ce05mr189793966b.44.1794305677695;
        Tue, 10 Nov 2026 02:14:37 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593eacsm90433466b.36.2026.11.10.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:14:36 -0800 (PST)
Date: Tue, 10 Nov 2026 11:14:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avLui6Mpf8GbKbtc@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
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
In-Reply-To: <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>

On Tue, Nov 10, 2026 at 10:14:54AM +0100, Christian Brauner wrote:
> The fuse server can register any regular file as a backing file. procfs
> and binfmt_misc files are already refused by the stacking depth check as
> both set s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH. sysfs and the
> other pseudo filesystems aren't. Reads and writes of the fuse file would
> then be done on the pseudo file with the fuse server's credentials.
> Refuse files on pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fuse/backing.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 8c21a8a74efb..4e4fb810ddaa 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -147,6 +147,9 @@ static int fuse_backing_open_file(struct fuse_conn *fc, struct fuse_backing *fb,
>  		if (inode->i_sb->s_stack_depth >= fc->max_stack_depth)
>  			return -ELOOP;
>  
> +		if (file_is_pseudo(file))
> +			return -EINVAL;
> +
>  		fb->type = FUSE_BACKING_PATH;
>  		fb->path = file->f_path;
>  		path_get(&fb->path);
> 
> -- 
> 2.53.0
> 

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

