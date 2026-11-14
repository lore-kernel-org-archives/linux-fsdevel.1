Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686762;
	b=ef3j+I/t30TgCdf4wGmE/d8NLOkJC7p4Gda0A25WjSo09P9UhJDgOCMgFw9aVIq4hfgI
	 m6E28p9UJ8GQXDznoHFYliLHnjPxN7MdS6tVcmXr7HrEHEhMTbHZzutE4LYvAQnuqAoG9
	 +VA1CfjJfSW5zYGVihcJJq35IScar8BtYnED/qXBwaqBD3MwbFSpbeq8ii/8TcIOZFL76
	 BqWhQbDAd1lEsAkaEfH3TqEa4j3IlE0knYqC63ZKhLYMIhzHXZozIqWxZjPfmXkebGyaG
	 e1sGI4nlw/IgpLIDyLK/SL+z7C+ONJGDiluT0eZpmD2jpDskdICTCF7bzINsI8Vn0SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Message-ID:User-Agent;
	bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
	b=kTgshWEQUV1iCOPZ4RYsHcVquSzW/jqcBaazoiDJCgbklfFN3jtcFZmuty8s3TzCYWzf
	 EdPOJbMVlJyTQ1JoV43yOzRcMLj4Gh4knpDcUi90fKNkz2rzH/cfkCQywgsR7yC0Z9siT
	 bUzBrgKWuJRMXDQ48AjggzfWaMZMvr8r7lSxfPumY5EjbKRj7tqC+egkVEhg7EgAWZrFB
	 FexjCMioMiEe11Aojndp0bwf+FM/Bu3z7VG4e0MVi1eUF5D+fOOVfkpxmc7Oer0Zzh9B4
	 Rt76yvjjeybUSzXn4wPEloOzX3gmPNHmucr6w5rmiZq08bNLT1RQARmEyercMAdqhQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4260A380A
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 20:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFE4260A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso2481003a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686761; x=1795291561; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=WyNKKpANsG5sdrHWGAt+Y38DvSIGt+WnCUyNYCZoBM4YbSq3wCVAHI95jQ8BFTGgLn
         +vM7af/q0i5zrzjZXXnriwzXN4L/RbeBg/iztvO0eyeIXYNiQp/OYlS5LD9yZqr2gKgm
         1I+5A88e/cV4J0nLZfgp0f7sQwj9jY0Q4quBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686761; x=1795291561;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=HB3ZLQtmhSw0fI2eXTPe2gsrlhcrBI+5jM1QCFLGPGh4geIb2p/KfzaDd6ouHaWQit
         Fcse6+RWy/5hn03xuVJ4uUScGICc9ZKwexryf7NaVWZaMthFBMP/dCfdPGX5Hhd6Lqw1
         erDoq8C1hfOrwLUBIvV+BwOrti01xU3dzhfkLqucfJhNKQMx3zPQCuzFgaxJKtbkHckA
         d2NpGwbjbC8LBYd/Ag/oexawQF4jmGJxAjPl0s4B7IfH3SizVFJ0lw+CWoSqUJn37Kcx
         FIPzRVCbu72f87p95xKO1zWdM+nJf7ULUKYXCbNX8Glo7LEqtOF+H5RxHevES5zFrfOQ
         MNTQ==
X-Gm-Message-State: APuU4Z+0C2ByCU6XQ4cPkAXu/d9lIls+3k6oRRxHAGMW/K2kVqWeCkXE
	k8wU366K9wPuBTsZSQzAZwtRp1FiBZYD2PC6YWMD2n7SkHklK0tbQEyiwZP5LRBbXbY=
X-Gm-Gg: AYBFou22lWCMU4ZO+CNGBhDwpTvtQC+62sivQ4eKIhJJMUJaXI5uTnQ/hhU3uYPP1nj
	MxDpDqoQ7YjLyjmNT+EHy/WiZKBVuWXUHjTqfz8mWYTXP+KA3CCaVMhos3No9C7af3nqQXHJzsw
	hmq43adZihCJxIOMt82dbVyHTIvb3j7B/h3wC4FySr3+0NzknaK/Fa/ir/dVeG5H3H6PrgK+9yx
	52Lhu1gzOnDjT1WOuyv90fHkLBuBcun5IGXln4L4kX/kAz4QS6CaQu5XKl6CdcbiPOZRIvuWeiv
	Llio1zA5L4RaeB+F6aNnNresmhJLKms1VOOO9mv+mmz65pRu9QY2ZN6jF0NhupZjWBb2fwStACH
	VjF3Fbb4OUZz5/Fi9/IxBpQpJ28/7bCgh1KxmaQ8bfxI3r2ZfviCJEMgy9AqFKJ9qEB2DKyYGEh
	ZgGfLIm4AZvGZ6Vv3NQs5AxwYMy31GbDtFbT3+eoBsESKqo5qKtEKgISuSHrPNJH+ZffpsI+W/R
	m9rZReza4sc08N1XcnPSr3tM2KRqQiICvrz+4MJlCXGxhn6Y9puhP7dewJSqT8xfMl0VfkF5YLB
	DN8ysbz93JEUUD/PGQ6lcFCIeeaZKjOlR6Iyn1RFqfqv55Sjc1uUyPbsi3P/B5ilvLYS42CxNYe
	J2jgFIab4n/NiCnsNTea0B8teJC5fBQqmo5VQjsR2KXQYGeoIEJNz+6tV/HrB6/a6XIZJ19WAHm
	c8kv/Hd7kkKifOHtvQyIyjXXC5/Z9vjEc73lsi+xI3fJBJIaD6v5My8dd5
X-Received: by 2002:a17:90b:2584:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b1b0ba61famr5629200a91.33.1794686761104;
        Sat, 14 Nov 2026 12:06:01 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm5258887a91.0.2026.11.14.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:06:00 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:57 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
In-Reply-To: <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>+	/* Look through stacking filesystems at the inode with the data. */
>+	if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
>+		return -EINVAL;

This looks good in general, but what the bots said about O_PATH files
here is real. With FMODE_PATH this is reached for a file that was never
opened, so on overlayfs nothing has been through ovl_open() to look up
the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
itself, and when that fails it hits the WARN(1) at its end and returns
the overlayfs dentry, so the check passes as well.

Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
it's easy to trigger with that. From a quick test with a metacopy file
whose redirect into a data-only layer points at nothing, registering an
O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives

     ovl_d_real(/f, 0): real dentry not found
     WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
     [...]
      file_check_backing+0x308/0x5e0
      fuse_backing_new+0x219/0x4a0
      fuse_backing_open+0xe8/0x390
      fuse_dev_ioctl+0x53a/0x7d0

and the ioctl still succeeds. A normal open of that file fails with
ENOENT, so nothing could have used it as a backing file anyway, but with
panic_on_warn this is now a panic.

Maybe ovl_d_real() should just stop warning when the lookup fails, now
that it has a caller that isn't trace_uprobe? The check would still pass
for an O_PATH file whose lowerdata couldn't be looked up at that point,
though.

Thanks!

Chris
