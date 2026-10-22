Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660675;
	b=RnOywHZLRUabxSFEuMk4lhC82qd9rcxIAaG7bQodygc34jP1hQnBpaIxxq3+rj0zuH1Q
	 2ALSbgaAquqorPJxHJxvxu68GqJ8B8K7WqfTzikCdeKpJiZkcBA+WXELZieRFtcYc2T3c
	 SG8Gp///xvlnhe9/68yuWVdBOPLd6qv4bI+1iEENaTC1NErg3eewF6uPiB1vyBFnu+vSR
	 qeekVBlDg1lmGQ5lTqHUxccA8MEFc5k16zak9CCM3LX5PJN9IKWdAi7dWK2ytkN09y5UD
	 SVTOxxGXMcKQQ8Jf6iSLQDLEV69MUymgqIjI8TF8wNjEISt6kO0KR2Gmg7BgRFjqU4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660675;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ocag04n70GUcrKlBG1nR2WLrZJEaM8t3kqqnu98kXw0=;
	b=XoiIDVOEVs6kbumAaAPj4/wONbH3xTztGpuQVGxWsBQfAMhyKdtGHby1v3rGMGnPabVp
	 RVqFsAjYReCWZyz/QuaDnBJxAMw2w0815S85xL5mRtz2mzzaN6bzCfduhW1gnZPBUbzFt
	 ozDYnJuY5FZ1+tUTkA4LdLJGdI4G+2viKvdCSyfpGRSKl1TRHxH4N06iBIOntXXZGYK3F
	 qRJ3kC0wgBkH7NPuwHS6pFhYEfiq3xlOMGDS8SLUfbTG0dOhfiWM3eSDxTPIwIICLT2Bu
	 +cw2AJDjtqqL3I9CiOvDgQdDiewrBv+4GH7A/9DC2ZmoLACwLgP2ZuYGskJSvtwSlOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ARxRqF2b;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905560A2601
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 09:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E905560A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ARxRqF2b
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-157fe9d771bso2113940c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 02:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792660674; x=1793265474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ocag04n70GUcrKlBG1nR2WLrZJEaM8t3kqqnu98kXw0=;
        b=ARxRqF2bp1UI07Z6dZENz8Wz0U7A+8wUi0hR3rQfntMekDe3/ZIvk90kzCQF2iloOd
         xNoO1j/kJR5XS0r4OIeupeR7SWe4OwElclPwzLKrkxYrh8r94cnh9aNmzOHQaEm8hnDH
         XGyCdxxwxs7gVpEzP+lNMH2Y3JlCyTJAZQCujSVywYST0kDNpNaZGVnIAXzHU5FnMIDW
         eC9SG6aiViNYNxqOz7Z7k78GHfmaG2zfu+tCZ3zSgHLiEyRgQ7zo7HDMFXivF8cu57l/
         rnJzapELfq8GMFKElJHWgGiaMalghAvq5FgPYayjuJQ7ZdMcleg6SpOGegTmfSTeW8Le
         6cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660674; x=1793265474;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ocag04n70GUcrKlBG1nR2WLrZJEaM8t3kqqnu98kXw0=;
        b=nG7qIsbwjUyFakngSP3Ir0EUz2D/bCW+tAuFuUsR7dMVxdg1zHJ08hs5S4J3PUBbvZ
         Y8WlUHJnr3z45hRCvlQGrFl+Xwdr8X/0o2UrFC32O4RFMbGitc1rF3g0uhtiQjjGqSpH
         Z8sT0CQA2wUKZ3QxF/NtLEolngQtO/DSuNuk71ayjsGScpdaxuCSEgp22EcY1sR+zQz4
         wsZf1MzcTzrNWdDygnryhbcbAWXwmrXG+PFcAT5k2FtNuxUQap540NP5smVlczvUsdP9
         Im4I2LeUi6B3I4hB1pkiOOsD5+z0ohzWh/UmPSPKTsIrOwgBIqdBABldnYkIcts0r87n
         acBw==
X-Forwarded-Encrypted: i=1; AKwUvBx5Wa056pjxlefSS4y9BWcCfbW5G8jfnY3lvTJe0n+2Wgl58vObeO3RvSaGbQobm8YVxXYtQiI2b0AzIYup@vger.kernel.org
X-Gm-Message-State: AFq9FYJtZSfF521QA9EXqGBFLUP13VBTzyLJU9f4a/JuknHXlG5xHxnj
	yiz+Gfrg1U98ayKIVQBU6rwbtzKU2eBnpBBh8TnJH91bRiuK/FEjYlDD
X-Gm-Gg: AYBFou0Rs9vR/ndbW8LdmxZeQBmN1T2l0Th9eZC+BGAch3cHrIZvu6HPXMgWBEbKJJC
	XZATWUS2JawaG0pND2bOFsPJGtSUqpt75+TJ7iLVX9Vvo1PcFhwdCI/GHMT7QgQ41I0XK6bCjUh
	22P/reTkV6zAVIFujxy7G/KwdaRwS/OIgkSZlCZyqC9E4z5U3Q8qzAU0jlh8Wjq3RsluOwv77XD
	ymySgs4DgG5AeSgw51I9CSva9MM/XMDMD3Ngv3euOwmJOlhq69CdUuvXr9+NkOHa7mkTQcmMY0+
	W6UxvMyfWNbA8Viq5K6DJD+uPpi+l5ml8HITeqCU63Wb8sZO4CbkLdHcVbVMu6t/nNkxHE5U3k3
	c2DjFYf6MU7TOun05ukbWTevGH41a6DJ7PGdoyGJhNivrB9mhQ1WuOqLGzClym8UHpC74qOI+vX
	ZCz+y62wjrawAYP/SN7lMuj3ILGyTsV251yoZjWsTarv2sRvJ5fKtDmsPj9a9QVkotaN0sBSovo
	ii+uKwLi2jRMVUUV6pVPdaOz1npg20VCn+0iNumIwiSiOVLr8KfDzAighpH96q54/6coEYKRphy
	ZMYN4ndQ567PXNsKMIk=
X-Received: by 2002:a05:701b:4194:10b0:15b:7f7a:730d with SMTP id a92af1059eb24-190a632f93fmr5636140c88.28.1792660673930;
        Thu, 22 Oct 2026 02:17:53 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bf5d0a1sm13436256c88.14.2026.10.22.02.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:17:53 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] fs/aio: io_setup integer wrap can exhaust global aio quota
Date: Thu, 22 Oct 2026 02:17:48 -0700
Message-Id: <20261022091748.3653127-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

ioctx_alloc() saves the 32-bit nr_events in max_reqs, then doubles
nr_events before checking the ring-size bound.  For
nr_events=0x80000001, the doubled value wraps to 2, so the ring check
passes and aio_setup_ring() builds a one-page/127-slot ring.  The
original 0x80000001 is still stored in ctx->max_reqs and charged to the
global aio_nr quota.

If an administrator has raised fs.aio-max-nr to at least 0x80000001,
an unprivileged process can create that context and make later normal
io_setup() calls fail with -EAGAIN until the wrapped context is
destroyed.

Observed on Linux v7.3, commit
08ab31164c55f20c7a2653de3186ae333470e2c1, with the administrator
raising fs.aio-max-nr to 2147483649 and dropping to uid/gid 65534:

  io_setup(0x80000001): ret=0
  fs.aio-nr:            2147483649
  ring header nr:       127
  ring VMA size:        4096
  io_setup(1):          -EAGAIN while wrapped context alive
  io_destroy():         0
  fs.aio-nr after:      0

The unprivileged io_submit path stopped at the ring's real 127-slot
capacity.

The default fs.aio-max-nr=65536 blocks the path, so this requires the
documented but unusually large administrator configuration.  Under that
configuration it is a system-wide availability failure.

Check the magnitude before doubling, or use a 64-bit intermediate and
charge the actual validated request count.

I found no matching upstream fix or CVE.

The privileged init wrapper and unprivileged PoC are available on
request.

This was found with a multi-agent workflow; the full
quota/ring sequence was reproduced in QEMU.

Thanks,
Cheng Yongkang
