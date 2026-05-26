Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CB35838B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807632; cv=pass; b=akpCwuuJIra8S0BkBZGGyPPBecNaoos5xWvrKwaSx3pOrSMZwKLjaGGn3rR6a8UBVH7Q3bSWR0xlquebk/MECU1JXFkLRy7ZNSr3yA/62S2wphuF1UWt4R9TVoFGHNLfL3XMSIZyqLEFi0zKdsCS0zl68Rlzqlgon62aXBtBGjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807632; c=relaxed/simple;
	bh=EvbsFrM1aOZoE9rzekiebiw0GdV7XyQJiZp1BOpUdEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRFB+j/Pp0/277aZdPqPhmg9a+6q1lVgFDUAHXSjzu3bwWtxn5bMyXHdFoFZeOxHrXxVczWHHCLcq6588VTrAbTSKaX37+pPry3KUYtfjEqsi20NbWc8X8WzLq3pzHfwU6fNLjOJ9R7REERSbE7xXpp5SwmD7gpk90Pw1u/Nybw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qiOyQfLL; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qiOyQfLL"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-9106ea78cd8so1669892685a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 08:00:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807630; cv=none;
        d=google.com; s=arc-20240605;
        b=bG9aUaaxQhbYSXB1ScTOezmnoJ9Bg4MJjy/nmDXTcdDNiO9wTwuYKBEyu5fpP+30SC
         SohOdQ0AMc2hpMuN7MlNRxTL4cGFWWkOQBs8qNAicq5ygSHZUDyhe3syBGsUWvNQI+Fb
         z4bEaT7Aymfv264FRnWWzsRz6tCiIlu7WlR3Cd3XN6v+TuTKKjt6lMnzIVbijcuqEIj/
         yaFm6frTDXaWAs+amT72I5HeaRtxmWzzhre4u887pPWlvaueyjuZp9/LcoM9Ak9DnUDR
         bS7QTtHu31Oil6v92SicdOqY4tNmLUcLzxqToNVDKohEjHOl7YTIQBWo2IscyD7xg7xF
         RZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EvbsFrM1aOZoE9rzekiebiw0GdV7XyQJiZp1BOpUdEc=;
        fh=lbe30U8xvIxxDmL+xqFUn9FMHvg63ci+FpV4k/S/SKU=;
        b=g6fTgYuCld0+jKOMXaE1bdTiJiwsmxMLlgOqMOxYdVPQ8tvULNR/D0LKkBPrIGldOj
         cR4tX1p0V6UPA0zOUVmHddljkCSzp0etTGFsUYsO4vj7U9sgtItu3YNIwVV92V0uCF45
         g2Jhnx0n7+XjjtOWVOa0JDtzvkaH5R6Ec1DGcPP/ckShnT4BXi4XLfwlLnHpp7wnZJd3
         sfP80aEXyKSKR3jZ6Zb022MErsoaEuGLpluv1sl3VRLOLpSZmJOegMwwoYNFO9BwN79s
         EeKTbHFTlHJ2RMohqXNeVrjiCbozqDbLBu6MLFkK+lu8y3MXDAZ4QRaQTjzUOH6ZPJ14
         6sUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779807630; x=1780412430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EvbsFrM1aOZoE9rzekiebiw0GdV7XyQJiZp1BOpUdEc=;
        b=qiOyQfLLvQKJQFdrg3X39/qFxhQHanjRG5XN5rjdJEvvjA020GwKXMmdrbnlt+srAm
         UBvtGirlVxglxkarVFuxih4HyPPjLQOuRQUGmCiEzbu8g/MnqNor84FZTx8p3RvwT3jY
         jRMhAi6WnwmIQlszTYbGFpmfuSBdcQyEyt8Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779807630; x=1780412430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EvbsFrM1aOZoE9rzekiebiw0GdV7XyQJiZp1BOpUdEc=;
        b=EUG4GfvjYtyTAuJtzfugtmks24Q+pxNI8fh4FOBzC7muzT9XQnMljHN59NOfW6TYbr
         zMwnutpG82RxDt6Ma6vKrWBRyH+Xb8hIbNFLy18j5YeFfQUBQhDHRCZigai+683FLxhp
         aL0+Pp8D8JyS3YouuxhBT7e53rx7vN9hDYd92QSI9zzjCU/q0Gl6C/43SNDlIO7DvOv2
         HTc+LyGPo6T2SxIQutf3u11b+bosc4PxCe7maTPylArK19Nl9wgvQewFgTso6ReQ4FIX
         YtCq+ouBrRwaTaSuec5GB79k/1tVLaEf2FDmevoNkOc/gMlHjNuqSGQAkS74noikEX5L
         az0w==
X-Forwarded-Encrypted: i=1; AFNElJ8CoqrYiciRZHwpSFij9yqnUcy/SlkObCmKwUKWcSdMz3NhTiqQEo2ofG6NV3JHJszAfQvbsl8mRKXtiU6t@vger.kernel.org
X-Gm-Message-State: AOJu0YzW51mHykIQU7Gu3Lv+V+wTP1LTvytV6wgNVEX3WAcImf+Y+QFk
	pra87Zg512wjjQpdtQLP8/fmQb8QCrgFtcnHN3T90e/T25YyTCehhpYSNv/8iTjk+kHcYGESLw1
	5fEO2tH2NFfRYIP16OEVlbbyWYce/mj9N0lahfezWtQ==
X-Gm-Gg: Acq92OFTdxP/LJSm+3NBLavv8RoYv5wEH1V430ldszCTX4XhXjxGZwIeqDJXWYw5G3r
	6ZG7AMWg/mQe9nbl8R+vVXdoEQEru2FNCNCU8P9udI3Y/N5Tr+g0bpqsuMA4oiHvZ8ZVfYJz4pD
	B7bhc4bjgKubSibi9sFMbrkblGXUwjwebRn1TSJUb1Z2s7TXvPVw88Ov+9MPbBefC/rIA1iA0Mn
	0YukzLKBkBiitAyTptYaiGaQ3/4j13ZEXAKmg1441kQxNCyGDGgAG/whKc4fjT2JjBCYcsTjwjY
	Xq6YVsr96oFiB4e1Wh+cHU6VFeJHNwtSHQxkQprHg1qGE90dJw==
X-Received: by 2002:a05:620a:2a14:b0:90c:e5b5:65f4 with SMTP id
 af79cd13be357-914b48b5d36mr2776455585a.2.1779807620596; Tue, 26 May 2026
 08:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org> <20260523-b4-fs-v1-12-275e36a83f0e@kernel.org>
In-Reply-To: <20260523-b4-fs-v1-12-275e36a83f0e@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 26 May 2026 17:00:09 +0200
X-Gm-Features: AVHnY4KilITCIvGtFxS6FTciw1vCUm1AhcuYlYRxf5FBmn1jF7w4ka-Ynpxrnvc
Message-ID: <CAJfpeguR8uzC+GdyYfby1LS+HyB=p7=ri3J4aAmUFfZ2V06+1Q@mail.gmail.com>
Subject: Re: [PATCH 12/17] fuse: replace __get_free_page() with kmalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Dave Kleikamp <shaggy@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>, 
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-ext4@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 May 2026 at 19:56, Mike Rapoport (Microsoft) <rppt@kernel.org> wrote:
>
> fuse_do_ioctl allocates memory for struct iov array using
> __get_free_page().
>
> kmalloc() is a better API for such use and it also provides better
> scalability and more debugging possibilities.
>
> Replace use of __get_free_page() with kmalloc().
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
