Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64A36C9D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806841; cv=none; b=X4TLfGnh89Tme0o1eGNjm5jdEDWPtpCRCD8/jCC6fYBUPZFwtDEKzTUh/nrqG1i9q/NclDOLhY+t0/XTeW/b0spGEI6eVxztar1Z6GYETBZCgvpOTRl57hjrtsruou/2xd7UfsgyoeAhkX2fXOSFk/eL9RSJ6wLJkF7KYE4c3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806841; c=relaxed/simple;
	bh=lmAls8g6TYWNiaABx/R8EHu8Nnn5uWDl1XOyYBPHlEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuAQV1CAwF6VYR5n73TykblGOkBo+ZQjmfL+OLq/6ddzqF39DRmnno7bdbN7oZvAhKPFFfamVh6ZQpxTJblgK533PCMSs70nKtvjNc/E4FOZqMIv/DJ0HU9dQUAiV2YiX83ImG7pm2fLpi6Yzgyf3F3/yyKmsKOqiFCf9AeDvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zd3P9Lml; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd3P9Lml"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36d8b644473so1020864a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781806837; x=1782411637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmAls8g6TYWNiaABx/R8EHu8Nnn5uWDl1XOyYBPHlEY=;
        b=Zd3P9LmlCJ3UAL1PQbhcEV6ghxr2eyxhvKJ6nkuGoS8zpkgwwAz+EXez5ngHOvG78P
         zaDRH8jQWU1DD1+QgYOYLpPl2zWNw2AAT638LAolJpV9+pzqW1MZRaiwziHqJ+nBTaxO
         qNJBfKVJCPkWGmxlEzjvhXBGcDIiQDP9RmlDq3mqvPFlyYGjDysGZ9QOOlO1sooyU2Mt
         p8ZKVvrQZQW7NwR2XVxqrD4FSoeflSH2xKQW9GsPYQm2kl01jAzwCzI/Lm4g3aptuBkL
         QLX6fbNwmh1kloHTN1WK6f9jcYRMbMXZHIyp/A8e0KpVWMUk9ENc+fWdM5yRE2CWwVpM
         JHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781806838; x=1782411638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmAls8g6TYWNiaABx/R8EHu8Nnn5uWDl1XOyYBPHlEY=;
        b=QjBcfN67XVh0mTux3fqF8LxsrVLKOQ/7a0MuGSi+stdCXPfpBwIR1EnubsTquDuRsD
         ZmnJoHXwz5ssSB1hOV73jTTNEdjDVsYj4uNP2ct3uoUh29gZi5ILPre4f9p9avjn7wi7
         LjFXfv9rp9FJ1TTCW0qfwG6driUFEFfrR/I1zgRCZ7XGHND4dkrM1P+VUzJTgtkYDLgL
         qCWXSNPYrR56kEKTHfHg+jrHX/nRL6Zh/pi4mL45JyOXN1dGNhPXdp+ONuZpRApKbNPu
         YMq7+j2FPdFavl4YcNEdhjhbEtxBoIdHhPyMmhPFsVt4lzA5z5ovlbu/SmZ6iuYkhCgk
         HNwA==
X-Forwarded-Encrypted: i=1; AFNElJ8JbPOPPrcfo2jo8XK1edSKg1hKrP3tDJjihfvDcBZ0RzYsfBD++NI4/8ebz3+h/bwH21U53iuJrmENCHfv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz0G0qJB00DPkueO/Z5zlecm6Tm9abxKeL1XnBIfLYL4xAUVbB
	gd8PVF0ot4I3+CSX9dK92PQhb2/2Pjximjdf1hV+p+SuzpmKSNTfLfkH
X-Gm-Gg: AfdE7cmqbXwtokzttcvRC0LOMMDqsNCocthWhmBg+86M/WIOvSslMtzqMZYDMYYKhK2
	v01ijgKTtwUgj79GyciM84Eva/J7lVKhq9J9jQ7IVIW1epCHySZDuvcv6wMULY4npaZDtb7Bl6q
	+Sgsc8gvKrkIzNYgsO0mtl/n2WUlMXecwtUlRjwKDrUgG5aen/xb0oTRPeItWqDPebb+wXOS1ps
	GIJcuWrYSc5JrKlSoH98M+/M4WRt52yWJogq13IwzoSN8hruKO8FJ2I6JNReN1k47RLstwZhAEN
	D53jzuv8UtLP3glJFSzt1GSm2ci9xG+VTWtmybi56MMhALawDnqDPcY5nmdtcsGpCTQ7cdWbxBW
	SNXtwjKiqCfnTAZOjCjA6Ys75cAnc9fYSJN9SmL4Mcx5R9pNEAyaSBkTGGh+SyIXEOVLugdNNR9
	doR0eTQfrfNQ==
X-Received: by 2002:a17:90b:3ece:b0:36d:635b:85a0 with SMTP id 98e67ed59e1d1-37d15fbff00mr568255a91.3.1781806837595;
        Thu, 18 Jun 2026 11:20:37 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1558b599sm341702a91.7.2026.06.18.11.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 11:20:36 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:20:34 -0700
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
Subject: Re: [PATCH 1/2] fs: Add bpf_sock_read_xattr() kfunc to read socket
 xattrs
Message-ID: <ajQ0p4ernwLzxkhu@john-p8>
References: <20260617-work-bpf-sock-xattr-v1-0-a1276f7c9da3@kernel.org>
 <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260617-work-bpf-sock-xattr-v1-1-a1276f7c9da3@kernel.org>

On Wed, Jun 17, 2026 at 01:18:27PM +0200, Christian Brauner wrote:
>In c8db08110cbe ("Merge tag 'vfs-7.1-rc1.xattr' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs")
>we added support for extended attributes for sockets. This comes in two
>flavors: sockfs and non-sockfs/filesystem sockets. Filesystem sockets
>are actual filesystem objects so reading xattrs must use dedicated fs
>helpers such as bpf_get_dentry_xattr() and bpf_get_file_xattr(). Those
>are inherently sleeping operations. Sockfs sockets on the other hand
>don't need to use sleeping operations as the underlying data structure
>is lockless. In addition, retrieval of sockfs extended attributes often
>happens from LSM hooks that only provide struct socket and it's
>completely nonsensical to grab a reference to a file, then force a
>sleeping operation to retrieve the xattr and drop the reference. We know
>that the sockfs file cannot go away while the LSM hook runs.

[...]

>
>Link: https://github.com/systemd/systemd/pull/40559 [1]
>Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>---

Nice this will simplify some of our socket tracking.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
