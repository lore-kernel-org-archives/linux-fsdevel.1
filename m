Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53B3769FC
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807058; cv=none; b=FoV3OXeezNRPQ/vpzUR5cJ8t+cgZJj7FKHUH8qtv7XRsSLrHSq3xSCCJd23mBvFe05POYVW2sAfilpwsiOPKSt/hnBW7AY9jP4S020WPXnmqeRlZUu8jk+Yo076z76HLlUuvVLF+vZRjLKod3BW+KW7JxlxN5T6otEsVaShLwMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807058; c=relaxed/simple;
	bh=zHZHrJPqR/72k8j/7zs76hmEVzjIOpHLv/LDru9J2Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzKZ9gVwU/YLpmkBNyYSOguWDGbVyi83m4/5N/TYDbCvldJGN3ykXh3bmN4o2J88Yevc+PChJmk6jCAIj7eFd73p2j4Ise7ru9uWlZHTYm7JojvTi087QE8ftUqzvAQYQfY3WA6KNcwiKlZjLZmEQqPze3VK8QoEOZfXvkOIEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDB0/qkF; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDB0/qkF"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8424b00710aso880423b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 11:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781807057; x=1782411857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHZHrJPqR/72k8j/7zs76hmEVzjIOpHLv/LDru9J2Ns=;
        b=dDB0/qkFO3XZZHSqt5o9++S1aExX8Rnmeeoiu/Pjcv9sz0KC2gNi3y5ZoJDvQGylTO
         fBbXLaIYYYLk/QuT8mhwi2RDPzgYJIodzaUarDNOwh/w4KouVjjs3Oskc/AVIgkLCnJ0
         jxlilf2jE3zoyWVTD6GZNCDBOWi8ZPZrauMxwzcZjIl+OjSSHRFfE8cInWfUnyn3x0ek
         9c3+MtgPzyh6ouP4i6dPtQC/klZewD2t/lW0HlrHALGgKStzCYTIVT29c1YgKnBafldZ
         /ThDOPefZLJtzyk5D8Dx0FtS+iiX6Bp7W4M4p8g3aK2sg6wIrwYrB9zZfpq94fAh8A+/
         Am3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781807057; x=1782411857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHZHrJPqR/72k8j/7zs76hmEVzjIOpHLv/LDru9J2Ns=;
        b=n8eY2LCoodXQfhRmoHhdjh/ybwsTwj6DIMHxI4zccaRi7ZjhPgQWXLHSW/GCM/c7YP
         2L8pjo+gTA36YgsHdyLUXN2CpmDoRMAl2CrnXJZxBcZlhNSBMhNjGusuGHPvk7vqqxHB
         QCTy5dGyJuo+Hsp3Nrvzx8xBfkEhBW8K2htQfo02NMK73y6+kbQyMyIQ326cADpOvUqz
         p9CKUUnW96vmXgADENJmUgWP4T/1KnY0QQ+EJSj0vCmJ9ucUkrrteM8BGP1VxcW41N0a
         EevV3f3ll1hIvIhiw3IKtZP5365eBBlemibN2rTGsN44Pb/MTlaQX6cjedFSxlcqV7Ej
         ZckA==
X-Forwarded-Encrypted: i=1; AFNElJ8APWoIBX4aeW5y4OajAOXyUQCue5zBAipCh2PXsV3mY5eaQjeXxPSC4ctLsc0QEfGXU4j6XJKCV4IuemYs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz65xyetHERS4H8mZDm4rGYAJbziXjXgmHgnrMFlN/7t0vKGqdb
	NJ+5QtKJ7gqe6eRb1vDjFlUoTwdIAPt1k3IMxttATFNRhOBV/gvdJyK3
X-Gm-Gg: AfdE7cme6eBjYZk1v9CQVIEP2cKpgg2Jsz7LAQXwlXwX0x71hK/0L7hKjH0Fc3+agXF
	v7i1ZqGkeoWXnMn41jS+JVBprwkcbpLWJPYMfm5Ox+DiNrBdMXGdcMDolo0xr/L2AzQGdXaz2eo
	vB3kY7jg5ARm7g7eD1GWmDrTee67tLAp3y+Vy3CC7gD8IOepRdK0GG7TWSjPZ/1jioM9A9FoWmt
	sdcZhwxgtXQCom/1btdeTJTgZCjExrKZSOwrsx0WXaUc+Pel1z9oHdECzwGVoUH2n4noD1nRhVC
	3DnN1ftcLMc/K+HEVF1SVe8Mgc+NdA5BxvbA6Mf5elFjCzHycaAChKM8+sXXHGD1Qme3UPPPFuq
	63EA7k2zljEH5MBGJdNzGgE9hCOMx29zip6RqetfI/aXA1T6MzArvu8NN2/UJ9r5J+opzt0LGVc
	NQkGRuEBRLdQ==
X-Received: by 2002:a05:6a00:339a:b0:842:6004:3fda with SMTP id d2e1a72fcca58-8455087b4c3mr43350b3a.25.1781807057093;
        Thu, 18 Jun 2026 11:24:17 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c474sm18790640b3a.2.2026.06.18.11.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:24:16 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:24:14 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 2/2] selftests/bpf: Add test for bpf_sock_read_xattr()
 kfunc
Message-ID: <ajQ3to7T3eFOpB7q@john-p8>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-2-a1276f7c9da3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-2-a1276f7c9da3@kernel.org>

On Wed, Jun 17, 2026 at 01:18:28PM +0200, Christian Brauner wrote:
>Add a selftest that loads the kfunc in sleepable and non-sleepable
>lsm/socket_connect programs and checks that a value set via fsetxattr()
>on a socket is read back.
>
>Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
