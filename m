Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563700;
	b=ByElRqEhKMTlqg7eGmonrAnMf97qctHMKg+BUKZET0s7msGODO1tfcQAPd8IPjzs1cYC
	 Ps6wdn4BWuK+ieM1ZOK4qJg6laYNWi5Ky134GK5IUMfrHy5gK3UpVIlYttNPXcP/KT3W3
	 f33XGU5/pVnCCr/RyKFBRzSfs1ed7iifEwilMMRxRh0tqlRe7J9yss/eajlSS52b9IvuU
	 +cVdVjM3OR+Q2qCK0RjtDq7JiI7WygwnWEWdOFmbOWzdupyW94SQshPMsiyGN5ppT6J0a
	 G+WitNKna4PEld6o6OMEklbLlh6Z9sF3sYyZR1+WrWxVQ3k0jG1ABX69hxKr/0JhyGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
	b=uelMYzsvg2udbQd3wkX+88yvo/vam0EqaPSAbLd/8QplViN9K9uHXhXpe1ZSD0n4eu3f
	 RZW6d7xN9O2bVOq1oRcr7sjkgIs/SLONH06SrfI6sAUdhbCBnwT+STo4M6mva7hC7A+me
	 nI4AP91DvUylrEhjAMBhe5cc15+2+hXv7Le+Dp3ABSzQfscTSEs4bpxmMqkQ/C8N6yowz
	 nf7HodlH7BE207lSHJzP8/DZl2cYLx2Pstc59PhjMzUbCjW2TK0Yrk6NQJBF1fp+h5+KH
	 WPchYMBCW/rP6kaS/KHLhyRpv0hR0LrBZqhb3UhUW4aJjygkn1CAYkqydU2Tzd8XPTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA160A2608
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 09:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45DA160A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=sk58W6sW
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so171534466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 01:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794563698; x=1795168498; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=sk58W6sWmN4ERo+6S+koVh/BM/TVuc998Smvb7+dAHAHasLoIxA1PyH7SpTb2sphTs
         qaL8BceJIK/C5zTluK59TXAg0t7i18MIhSXKzAc74GDtFkVBtJ5XexxofTn2ErTCpEyw
         wBL0ZIwSoD+QdFLNUYuAtp3uhttIIU+8CcgeY50Q9BuPcdVkRSxffNnvhBi5q+TOT3Z0
         N0fPVcnw8avDa7R0wdKzwUNoVC/3vPRCD1SmgKjZfrkNv7BBIugYP8aqCryl3mRTzhIm
         nyzLSOhSkS/Bye+QA00IM2MsjhnUA408QIyungJaHYxvuyXbuTeC6K0dJcKnUnQNsCLo
         BJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563698; x=1795168498;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G8DmFU4pJwAPCJlqHBF8SKasEEThxtJNlC1sg/CSkLw=;
        b=t+mf3u+z3UO91yIzs7xOV1b/g1YEsVa++BG7mXwHsUmpqFuEd0o7DNsYTjeGFIPSq2
         8MhPbncnaIMYBARZ7K4UkaWgnl7aQs7zBWwZht2XbvPqq4i2SuoZKFUbzXdXvhdEzo50
         HKyeV52rQLQJ401uX09WS8YqyV3GeIOz9UETm+dfhWzsnbIZHq2BENpEJc+7DdtWPTOB
         g1HSytwK3s2D0CquJ1gx4fKxcM1owgVUP8aXGzHG1TZ11ty2Rew53P1i0ME9xWpk6ZQ7
         e6EU0mHWWyJ0PG0MGUhYjjLB+ES/KwLqid5GIMQBzNi3zob7pqnWmDhyNbOj74YFE4eD
         f98A==
X-Forwarded-Encrypted: i=1; AL+hErHX3R+0YNbVsPFSN8keT80ViaQuULpLb0usifEtLHE1M47q+CWjg753mm90fwf8l8pP7TCdLxQIAoY87I+S@vger.kernel.org
X-Gm-Message-State: APuU4Z9zpcLi7oNAe+cKhak991YblellO/43cbRzQ207edMLA67t4Q9/
	pRnfYgzitwnmMy0IBueJ+RAXzomtmDgd4jFGJABmssJ1JOGdMIRH6kj/hgDe+m4hbO51
X-Gm-Gg: AYBFou2ZJ7t+JJAhmaxKIk/e8IkUpCd6KSLNgQ9mIEBgPGAjGU20szL7LbC6NaBVYg0
	w8Vg8M2gsMr72bzds4dvL/xsqU2iV01jXX223DUMgKpN0mfmAK90OGowtiE6OiwTFT5dXEAuSCd
	JsGCTU81hvn/ylqHa1Y63vbaJVriXP9UbBKSbAl8XUQ19emWTl1ha0IdJzIzQnsSmYaK7VrVd8+
	KMkV316VSILZRJz/bEbQWKdgbHHOg95OZY83XF+cIhNFXu9g877Uh1L5OGu7BaNL+cDpOfmTR18
	yZU8hZnnvVf76fQzmYU+Gs4bQIa8A0Kuf+OhIL6Cev7az5GKwbaZcC7qbh9Gn8HhxHddzUYSuLu
	JhTSKgPMCJndk+MwqBJpLTIpZdDTBWJZaYQfticr9OUXr00CQVLyqpqExd0JmQZ7e4yZwpyXTC5
	MD2mxwCEE+j9dL3ItgOYt9YyXxt731gW/vieXMN3Qi4SLlNOGiLBpAbownSByA7s7nBTZ6Ut6D1
	EOeibKj1Ma6HK2OCx/wbz7dSG5YUWYIiSSNz5QSo31BWtn+LDGu+kPzEMFWn+yc1cKFOqVMaE2M
	zYnZVc/bIPkNyLAMEcSZh1lKG2NtB/sMzhgrCfZ/KVvg3nNPYPouPthoMx1l2cc=
X-Received: by 2002:a17:907:ea93:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c50963bdb9bmr198299566b.44.1794563698514;
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50957c6c1fsm75151566b.0.2026.11.13.01.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:54:58 -0800 (PST)
Message-ID: <b42c9f4d29a9cbea66929c95cc8f736f12703c72.camel@amutable.com>
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef
 Bacik	 <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, 	stable@vger.kernel.org
Date: Fri, 13 Nov 2026 10:54:56 +0100
In-Reply-To: <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
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

On Tue, 2026-11-10 at 10:14 +0100, Christian Brauner wrote:
> loop_configure() takes any file as long as it implements -
> >read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses
> files
> without FMODE_READ. Direct I/O has called ->read_iter() of the
> backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write}
> for
> buffered I/O") buffered I/O calls ->read_iter() directly as well.
> That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only
> allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense
> in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0drivers/block/loop.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index a3325ceab484..c96e35c3ef42 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -528,6 +528,9 @@ static void loop_assign_backing_file(struct
> loop_device *lo, struct file *file)
> =C2=A0
> =C2=A0static int loop_check_backing_file(struct file *file)
> =C2=A0{
> +	if (!(file->f_mode & FMODE_READ))
> +		return -EBADF;
> +
> =C2=A0	if (!file->f_op->read_iter)
> =C2=A0		return -EINVAL;
> =C2=A0
