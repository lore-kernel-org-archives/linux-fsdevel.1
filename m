Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686760;
	b=ThQ/qa5Jx6NfT00sRdl4nFSx3uV/oGrxGh+MvzYAgjZQAo568j3NgU2Z7/MtF9u+C6lU
	 oXakCsegvyWaZODWE8DEGBMbwftGZvkP3HFQjM9p4WFIgexoLpgJ9hcp3J3S/7MQSn79C
	 y5VNePrnQwLMvCKqz3/+X9y+FmPd6ndUcd9kA3ErHZFAMpQbQuRClIj/chpJj6SWVdC3B
	 RHMj3WP0s35UbJv03C2cPqRL+LuPeog2TIrGmUSTvSwCz/fawjHWm1UA7Xm3mSRrMBYpr
	 MuiRgixVZ7/JiRjBBhPypUOv6apUQU4/FCXRSQzUJ0Z8e/t/TOihyBumPxXrBe6XkhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Message-ID:User-Agent;
	bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
	b=PIG+JLzZGMM9T7GD/nFp60+8gbNzpuvyzldzJtOoRkhTOT7gT8uJ8ncGzrYy07GqHxOe
	 oHowa1Ad+m0KwZQrIYulW9VUOw4s5Yrav3avc1efyU8LYa1TRhFUQOJG8FNbtZZDgUSxC
	 g5c/VNdffSqC9PggqPqQWnJpZhQ+ZMPL7pqI2XqaCSwPwW4Y4jaYXVHDFocWSwG3m/57A
	 ocMp7TZ5Qp0Bhu5YiUezt/1o55c+ebDUKR70z9f8nnwtjS690V29TGCntuUU9Pijm0/Q9
	 5G1ppgljQz3l48PNpZyM+wyKqLYybUelQ0ACw/1QejyhbCqOkCFrzTi6ijBH48NMQ8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B22460A2606
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 20:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B22460A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so854733a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686758; x=1795291558; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=t4xxtvlP4RAICjpBIWPIkESb6EJJVOcRd9+LEytv251d1ZQsfD2pYblwETMOf/zroc
         BDzAo5elUgpAiRA0oYEfExHYSjjGywxztBxThvGs665InMbo4S8LytfXKr2B4Cw2IX6x
         hCl30XcWjOl3zGKKK0Vny1KN9lt2zjyLiPz3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686758; x=1795291558;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=aTrF6SRHYY4G7qib5KCB2uLfaSuTfTeu5GDvN1/192gRFzsU8d6re1hKZdpHmwxXKK
         CBgTloZi9UFCPc9olqVPlLGvAO29yyKjSYST+UkvKQhOXwgn2Y+IZANHMcZGSsa6V5oT
         l80I1fgJAACQvs2MJyjD4PeHuzT8OMQEICsmyposLAN6oqvA88Na5Fg+wrTxOHQmeD8/
         EysvRzhYJ/9E0g4qOaGNLLiniqIX2g9XkwjXR22k2ED1id+rnpoNud93VLzcueh58PjE
         bypN0aiua2DWvZKjFstFqKvbtw+8topICmiEJa0D0GJ1TyJzhqXfnvHOeS7tTL4VEKfD
         E/+g==
X-Gm-Message-State: APuU4Z87lm+SBsTBFvov/QgwqGwcZg0jzaqPsBUhRyj8IYwyFV62zXDL
	Yrr6HDisZuN8Jca6zQN4DJZ6pYN0USXPrIcj2IiiZRDS6XOvoDgMYRQoW4KJUr534Fk=
X-Gm-Gg: AYBFou20ZtFmKp3+74kzkdapStb8aAcnUbSmlEDGGsgf2zi5h42pzMuV+H1uDvjiZyj
	htdPmvhokfAg5AaZFY+UYegED0wuRBhWm2l7JBDa6a7l4DcP3a3qFoXeOqTW1HSMRRl3mobpGho
	Gr775UEm/EJY2VHEBf3UppmDjiZ53IBykoMlKITYHRD6/3CzvltwPGCWNcQ4hrotbp4EpWNkpjN
	5UxcNRVS1WYVmoUDAuwBnU7JzwYWbfQwK/0wTN9tz2nMhPgX60O9QSDHOo/NUXWkTeSU9Pos/cy
	5nt8VuREm1hBTc/DqyK23vV2ZBkTHoItOoK9oXgFcOS6HLOnk1D8x9Z2gXG+dU1mFuWFFV7ItQP
	0yiOWH3fKI17PXmeklaM+y8UNfNodvOAKHgWmc26UQB7KG28IRHv3u8qkinvVfa2mkDoO9gbuna
	jWEHQNMKyQZEwOsB0Dm7JHzDUxz6FyAfYvn/ZhpPEKqoKOOTctRzDWph/pwyPRPZ1wgCxEebzql
	zoAk81l+a8u2v11yKnTtJmfIYAxC+C2abl/YgfdWaQw020MJZqUGuIQ00ECUitTcPooYFirCkKw
	qbyD5yuDOktLVcOMjtIHhtf80VpbQx/9CkRG8h93BsFRYbgK0Hf91PtSJ4jAbCJD5WFlgDr+8Xx
	dnRQDoIs5nESEEqpxVRNEY+d/30ZjzvmuyOrOpOHmR9YVL73+sHipyx3MOe+/60H3a7bbKYZLvF
	M2nqrlTJxJZwjbm82YFWzfBKOuY5hXifK9+ULlm3gwwExKlyOqILb7AMbE
X-Received: by 2002:a17:90b:3b8a:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b1b0b5f2c1mr6192503a91.52.1794686758572;
        Sat, 14 Nov 2026 12:05:58 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm4654869a91.1.2026.11.14.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:57 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:55 -0800
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
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
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
Message-ID: <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>AppArmor puts a .null device node into securityfs but only ever opens
>it via dentry_open() which doesn't care about SB_I_NODEV.

Not a big deal, but userspace can see that node too, as
/sys/kernel/security/apparmor/.null. Opening it by path works in current
kernels and fails with EACCES after this patch. Now, I don't know of
anything that does that, but selinuxfs gets SB_I_NODEV cleared again in
the next patch for the same kind of node, so I think we should do the
same thing here. If not, it would be good to have a line in the
changelog saying that opening it by path is meant to stop working.

Once that's fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>
