Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.221.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793389710;
	b=2U4hlkNwap3hJKikdXSIZAqo8DOdZfXoQL8LWu29vIZ6mGFfVVmwRpPZ7gX96l5cYI81
	 YYHV/iKnQBhEvpcZ/NUXG0Kwm5mH9VttCVk5EvzSLGI+tx/4iyLgGXQgo9cUGXrlmLazj
	 dHVYrQa4DFZjBydqhcLrHBibMn9CU01UIuqStFiIwe2g923OzheTTHnASGXcpxd8fjpcb
	 sASkM6wGpda6khioDhG4F1/fXwDAJvb0WRijw3QeETUqXFIspVHcrRoPUuaZC4b15lsB/
	 GVTyH6zh3X6xwN33L7o+WJW8TYv+/yD9oJ0g3Nu7xohRsTKMCsKaH0yprynirCMRXww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793389710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=B3QeQKv83CCubBRhLwLfDBWq4r5yqUeetrN4Gz6lflQ=;
	b=yQv7s9ck3442HEfPg3k+Fkhv/ILZc7ktl3mLowlTgI93Zb3GKzEAKFx5Mn2E4B5kt5xx
	 ogf87erPXN/6wsnpnxznDJnSCveqNy1a5ea33xT4H3t3fRgzAIzaaRl+H5Pp3nEOKmmsc
	 xJVk/6TuTwp2+Hd1E6ueT6QEITWbS+xN8VJzAeKDX/eN+fS/AEx1/MvHHmy7FF33cx8E+
	 P63MWLHAWhsQ1T+1oT09YrKfP9DK3jM9v9rvzrJZc39AItyqD1wR407irgH3VLJBDvYPc
	 Ez0WEKY7Ev33mj6vUrclZ3S8SF+m4goPhG2Tz4uuMJaOB+58Ok6/gP5O94Bd6UbBW/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wyv/v7L8";
	arc=fail smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9493606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 19:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9493606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wyv/v7L8
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e00eee27dso644696f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 12:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793389708; cv=none;
        d=google.com; s=arc-20260327;
        b=g4wLm449CpIKjS/AHKHBQVMs3eLeCMf1wDR/OZK68KKd/KzCmuGsfaYMsxB1CP/mb5
         SAdxQTw85u1T6eyqiNz1PQn1PJcbOo1KfHcFWr7GxNql3T8NPxM9YdedtyWnC/JW4uRI
         Cw4LnlnZ/iopBrt55tCEAnL8wLgQBVZs34XG2R8AWXTmspZ/xCcJEkwTf31Lm4pDaeUI
         tnGueoedRtDCOM0oT9hciAUFdUcs1GyWwtluY+rnF1YL6eQLKQV7hXOUGaJHOyQfOAC+
         ufPd2JFUAImsQZQwMJH/RvcR9mRY1AuoT0zrHdfQRGNMpfVUC2bcPZRr0MQagJKrB9yF
         fcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3QeQKv83CCubBRhLwLfDBWq4r5yqUeetrN4Gz6lflQ=;
        fh=p/g2qphBoAA5c+/hZ4iluCG4VSpG3DeAy1MTltuc8qI=;
        b=Wib5a4Mt/jlvXelb6uQnWJFoyFu7rA7f2MRt2TY9YexvwPIeRFhsmPwMDsI7/6b1OB
         8YXewi97460IjR999XYXziyi+izetVnMc5O6rb0d2ACOPe3IMmMwnTPwRYpNsDizYD/8
         pQK2CoBQVQrAJZ1e2bawWbQYPoMGy1D10IipVZR1XhND4BfKKRQfx8f4UWSAuSjYlsE3
         40Pj/zcqWxS+vxAZSWNn4Be1IM9VLgC6m4WqGSKCteCP/REwn5fFSTsy+BVeKhQikuBn
         F+6wdj1Mpz/F9zq323ONylIm5wdwwIJLIfkBgqXjNOcvAEz4jbEqSwzR2ys+B2ATUw+v
         t51A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793389708; x=1793994508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B3QeQKv83CCubBRhLwLfDBWq4r5yqUeetrN4Gz6lflQ=;
        b=wyv/v7L8ZjnHsyc20OjjJOPmD/d8wZkqutlwDLWfoawPlVGaLkb+9+1Q4rDqm0kyyr
         lbSR15f762gdfiaSH5Q7eEU9n6kF6PrrymY/LNTU9ZS2K3cEw4P7hxyB3qy3qk2K3HX2
         9EACw1yTy6dG+Th59oeBPohq82am5cg3DuP5ilBO2nTZwcaEXu/Qokyz/TBYdnp8BIec
         9WJho9V8nkW9owQOoX+dF9K+f+xSf4u195/2QTDbn5vRjTcZjNCpDHIMZM1Dd5YXUJWX
         VvuQq7SrYbYvRUp5v66RyLaybHGnVGnuRLAkTqvqY0/1OiP7Wkf58D4Sf0ROqP8yLS2I
         GfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793389708; x=1793994508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3QeQKv83CCubBRhLwLfDBWq4r5yqUeetrN4Gz6lflQ=;
        b=GixWr78zMeC5eWUz9A4MtiraC8p5CeBm3VjR6yZct0yX69N+MRc1Zu7zjpteHfywN1
         KQ5MyWrzi1g43sopOEgsXGh1RDnNJgs3GBT2xYoaS5o7ac29MQg9fCc5V54pSC8EhW5s
         msXE6xtrkq9xvkLrPX+f0o0IGe5qiMIPMyoric9pg8xd61qDMRDnMXZ0dPfnmUgL37pM
         RF4isoJDpLGE4ymEQ2o0puP3OHTKAsvzdgKDR+6wDk5yPP9M80oOP4r1dxDQXvMiC6Cn
         gwFUgbxjAVlRs08MkOkKi/hSljxess3G9l9DEIDNicuGYRSimw/uhZ1/JM0aKwi8jQ3/
         A6kw==
X-Gm-Message-State: AFq9FYJtraoQF17YP1pAWwcLXpWvGaRTAACcOITN0p1FKBc8s6mNy/Wz
	WZaNajtOtRqTU591m2kj8NJxYPeDaSXFrf1F2wQlsNwM9raR1J7IZvnm+rdfQv5h18+hbuonOWd
	giLHVutFl5u7qZ9BC8pBUBDwxvL5Noy8=
X-Gm-Gg: AYBFou24yGyhmfjpcx7I4oQ2jappUcv9tnXMtGTuvr+Ye7a/ws4Gobl13xtI8za/D2H
	uG/g2u2H0YczuZfChbEuNIwyMEOUWjcjOtOYVIE9QMJ5Pg1r1VHyssDcRXkQSPO1/4aF9UOS6H2
	h2P1rN3b3Rg23XfF4zspxoxazf8CnxY4iG9IQMpoNJW8n1OimTYFERGwVdwt89DytE1wRv2Dwt+
	PpDPpOa8ZpU1urVWGAXwx6PM8eTIwgzIPGdGSbUPGIsbeh1fvy/sAwk3Y0cJ+OZQzPySoAR2Xjz
	RPZvzlZBpHlVORNPnL2zL3AG2RrYGH5i07Dyo7jMtrNYSZajLjJNkhPsAoV5v0aaHa5f5cVIbJM
	/JJeRF6t9iD1cfDgLaqXQ3krJEt4ModSeWxPALpkpesNjKspQdglDtRvWNjzG4RGjtg5QaaDhaB
	zfVaKzVJCI+xs+SJivmw==
X-Received: by 2002:a05:6000:40ca:b0:48c:5304:5e50 with SMTP id
 ffacd0b85a97d-48e6e2620d8mr8708785f8f.0.1793389707952; Fri, 30 Oct 2026
 12:48:27 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027215326.2693300-1-joannelkoong@gmail.com>
In-Reply-To: <20261027215326.2693300-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 30 Oct 2026 12:48:15 -0700
X-Gm-Features: AclHuK9oCK5VP76Wbek63tch4M8ewVUH28c6PHPAdmsJkgtv-kMhmrFiNwyHte4
Message-ID: <CAJnrk1bqPCy8ryVjCsUWR2+4jkNE8rJJU2bUFsO3Q7nznsF7xA@mail.gmail.com>
Subject: Re: [PATCH 0/5] iomap: remaining patches for iomap_iter_next conversion
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	"Darrick J . Wong" <djwong@kernel.org>, changfengnan@bytedance.com, kbusch@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, libaokun@linux.alibaba.com, bfoster@redhat.com, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org, fuse-devel@lists.linux.dev, 
	Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:58=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> These patches are being sent out now in case anyone wants to look at the
> preparatory patches or patch 4. This series applies cleanly to both curre=
nt
> mainline and next-20261027. If anything conflicts by the time you pick it=
 up
> at the end of the merge window, I'll rebase and resend.
>

I pulled in Linus's latest tree (commit abf8c33470f7) and the series
still applies cleanly with no conflicts. It also applies cleanly on
top of next-20261030, which includes the remaining btrfs, ntfs, exfat,
ext2, and gfs2 changes that haven't been merged yet. There shouldn't
be any conflicts between this series and anything else going in this
window.

Thanks,
Joanne
