Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794698411;
	b=W8MbA5rZ1Y28otmXoG1Cg8yTsLMk4RYZXHUuYWGqbJS7t5Hb05gqnbQ0IfDUV5xz9QCB
	 JFx1HecAD54wySaQ6d+B3qiK/NFbjEUXcWIIBERd8gfaN/8vbsCNHHFcblxZwwMiX64dX
	 aLGxrLW4bchC0CUDRKhWWbC1RWMb8fo4vp6fzRb5l/VE3ZLknRAoa+TeSgTf2pbP2z8Po
	 yqOnt/NS7Yua/8rMcphjyyvw6uQ2MENnr82spTxb5Mnq55PlqSMpO8CRuKZ+aiYOB/n0t
	 KKuehXFcQKMOXikuR5xgOdqO09pDZ+l5wX2OTGgD7428/GXNScgdZg4scloimoW2QGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794698411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
	b=RGF+JeSLRvWIXlBuSpxPHZ+RaJM6FokIGzE7kK3gckQKHA5o0TwbyYLmwS63GCXoP7hU
	 wU5Z/lnbSjQbNzGeFmzWE1MQmqSe584TBU34/x7o9X+W1Hk94vytBziSkk2gm9pqm2NrH
	 6wYfQirCYYhbwd2UUHrfV486ALz4eZ4HsXc3HPrdsb5QuHn0y9ydwTI+DdCsrt06HGNbW
	 vWBro28dRJnXApF1Om86ov/OhO6nXqKD+4dslsnFHBGWwbOACJJ2PJpiHpJ633KhGYVdP
	 UC20CG7kbygYF2hR4pgZK3DRgT0MaKvOkBp+QIBidEy+O/Mq6/e55RplnZk+orIC0Fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA19606A335
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 23:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEA19606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bZ4A5V+6
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so3771025a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 15:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794698409; cv=none;
        d=google.com; s=arc-20260327;
        b=cKttFsaMd1QW6zGc6tD0aN76QGUeYwgZwCD8TLHrbD1/NTCjnKe7FPs9slUOS+YwiW
         2HlRV4OxTzXFLbBxv2IJL1EMXEWjNFQwSfVvsK1lBU3fybT2fbLRwMcJxo+f4oioXb+q
         SWKBYsg435gRjE7qBvHqoWqylE8t9YQxaws9xgbU8B9DIZNwJc0t5EwCx18WEPRZfXBc
         KB54NsLWxybF2RteT8OINz4qgrA/DOVLGOq6jVdhxxj5k7iUcijKl6XKgUFWQpBG+rux
         w6fIDvoTaRc+R78R4zU3/Gf5St1rjwdEpzHQYksdpt2qgoydWqLTcOUPZc1CfMr9Ksk6
         tWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        fh=yJD9d4KxHIE89cfHGYwfP1FHEBgT+tQ1uUpg+yFfWv0=;
        b=UiitOkG9e/9ohAvRSZ7h5w2aKTOjgqdV1ROudPfZqUrZF6fQkvsEaMB+dzcDYIu0Bf
         k8hsq3vJRo53G+IJNFwzcz/RD4b2DaKvinwt9iQ+3bfjJA1ak6GyRqWX5y+JNtgIfKVg
         Dftv8gWx1hdNE6stg9BtMrAZz+W+5PVJcQTEWexJ0zX32wqtSazE073Hg2xP730zydRY
         cnDv4LLMd7DEZp3ViAQSVgRE0J8VnMnqDfLMuVeEYE36nXh3DaouLpoLz7P3qfcqooC2
         tWd/sLV46pQ12KlpuxgTqk/AOgNAJcF0Tz4ccciAn1vfvMhEAc0JHtw/gSWPWWx3tEkY
         Idow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794698409; x=1795303209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=bZ4A5V+6Vs4HKIPLNbCXlaoHg6GUiZAgPE1CoHup/u8F9XnmCFMSb6naMqQFAl++mw
         +LZR0jt78s/FhrwMU+95xN0Ho10rZ/g9p6M/dfGpr9SfvlaOXM2WfiTCtO0CejnyefhK
         5gg17lDjyCI6S+pTTK/DIWzHtcTY1JHkLI4t/I/Teu6/Lgz9A0oKfkx231Ay53Fdu4Kp
         zCo0ecwmPzO3ZOIddRCFMjOjLH94BU3oXsC8cOhJgJSeLFwZkZlFyxo1cq6JVw7hHb6A
         21NW8PziNlBat7d4DfM9UgO0YIScpglsDnmQoGQNIOQhlOx3hw76q6t8+8jTPfBn24eS
         FVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794698409; x=1795303209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=98mXXJR5XCg4Z4S2yqrizowpYg4fQiN0pgPOU/BiUFY=;
        b=F/ZmDa95wJewWlrs825fMVlpcn8yVylcEMODkQDeRJEL1UbqbMTD3NIAtUDISqpWCf
         avrK1L81yMU4eiaQWidV8/mW3kux/ajcSlza9TIdWW5YNV1sNtzXHPZAQSM/XLZFH13O
         2vPfyUmpdsDQ6iYet+KATg3+ypW8GKj6CteJXRx75peX+VnLCvFtxsbQmqVTb513HcGv
         N3UMTMYB9+9bavaimtPIF1M3kogaQ4Fo88y5Bs1VSKsr4jlE0MAb4hWiobJ5fo0BwrAz
         R5ZJWvPMpyMYOZ2zyhY2DBtgTX+JlkhZrz2tpigfo7UleLBZelA9jBO8TCcHTZp3m9UK
         10rw==
X-Forwarded-Encrypted: i=1; AL+hErHTWo52eEUSc+FbrtL/FRMj2MaFkmkghWn1kiyiSfYEPwX9e86y+jKife3kEs6ZLaK0vmxeWXCL+Y/YpRCl@vger.kernel.org
X-Gm-Message-State: APuU4Z/aRrm/5tEjfHvFQZi/vaxbMHsVoQq8aFnAedW5NKP4debwpt0R
	P3uaD6YYlIGoYoPMXvgvhGbokeyjfhH5qasTUYLYfT7owFMB2tzLkySGesDxcoiDtTrMn+dWKA/
	FM/iNwGpKcQ+sgrL7JgUQJUWOFPtM2Zc=
X-Gm-Gg: AYBFou2y+r3EvvKXpsJ+ydIsWlnvsl6KGICPltvSYsnpGqhfGnfByVICp8ViwhXop/D
	Qk8CPIgyfbTOZcs9JeRyLJFRd+HN+EGuUYN672OnsIrdUP2uzpnwrCoQ2nnueSheUMy15nKfKiF
	BORGRrHKcxF76H4e5xVmY6OpLproGUyU7qqxOawOHfLN6ZGf381XsXg2SsOWeCrY6BCbTj7pfV4
	OGaKr21IZTb5Fs44/UFe//zCjl61ofJoNrKAtAv+YbvcIe5+JOIwqFunyN8mJInbv1MjDDJeB8Q
	bY3V2R5VYdN0FJBliDai2YVHSFEZ3v/YVNBORTBvvg6EPAayC+BiXgZ/AAEjZ7I2JANfuYru29u
	u/Bqd+j6HtpMs39cLj1WV7iLEgKcDszb0c4FW3laN/bb3gGFH6nq08eupQz5PBnmYiTEcgA==
X-Received: by 2002:a05:6402:e10:b0:6b7:f00e:5e56 with SMTP id
 4fb4d7f45d1cf-6b7f00e5f37mr1542816a12.1.1794698409123; Sat, 14 Nov 2026
 15:20:09 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org> <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
In-Reply-To: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 00:19:57 +0100
X-Gm-Features: AclHuK_YVxhIpv6JLzeNAX5mX5IHGfu05WS6uQ-TCKewxE3JKeci2PyA-UDMCbo
Message-ID: <CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo91QjJHH9T_Yw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
To: Chris Down <chris@chrisdown.name>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org, 
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev, 
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 9:06=E2=80=AFPM Chris Down <chris@chrisdown.name> w=
rote:
>
> Hi Christian,
>
> Christian Brauner writes:
> >+      /* Look through stacking filesystems at the inode with the data. =
*/
> >+      if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEU=
DO)
> >+              return -EINVAL;
>
> This looks good in general, but what the bots said about O_PATH files
> here is real. With FMODE_PATH this is reached for a file that was never
> opened, so on overlayfs nothing has been through ovl_open() to look up
> the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
> itself, and when that fails it hits the WARN(1) at its end and returns
> the overlayfs dentry, so the check passes as well.
>
> Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
> it's easy to trigger with that. From a quick test with a metacopy file
> whose redirect into a data-only layer points at nothing, registering an
> O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives
>
>      ovl_d_real(/f, 0): real dentry not found
>      WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
>      [...]
>       file_check_backing+0x308/0x5e0
>       fuse_backing_new+0x219/0x4a0
>       fuse_backing_open+0xe8/0x390
>       fuse_dev_ioctl+0x53a/0x7d0
>
> and the ioctl still succeeds. A normal open of that file fails with
> ENOENT, so nothing could have used it as a backing file anyway, but with
> panic_on_warn this is now a panic.
>
> Maybe ovl_d_real() should just stop warning when the lookup fails, now
> that it has a caller that isn't trace_uprobe?

Yeh I guess that this needs to be a Fixes for lazy data lookup.

The correct fix would be to teach all the callers to deal with an error.

> The check would still pass
> for an O_PATH file whose lowerdata couldn't be looked up at that point,
> though.

One observation relevant to this patch set is that a datadir layer has no
business being a pseudo fs and that can and should be blocked explicitly
at overlayfs mount time.

The other observation is that fuse_passthrough_open() should probably
check the backing_file that was opened for io in addition to checking
in fuse_backing_open(), which could have different FMODE and specifically
could be FMODE_PATH.

Thanks,
Amir.
