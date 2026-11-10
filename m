Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323278;
	b=0BcNho7hQY7BE21iGRrs1rEE/1wrGTe6fGFKRLnxqMH9fCk9CUaskTK8P9Nmu2MOxrwF
	 3SnqrBRQjsVx8/AvssOH58s/bVB4kuuw8mU8EABK0gP6mCdTcDgK0AsOaAC0sBnxZx1GM
	 2UKXYS0oLpfL00PPPeSzGfA9kUTLl3w4bRC75geoxX5Bkv9WjAoYGbcLl+je77YnOM3XW
	 idC3WPzPfKDEBvWYETL2t9na+3hbBDCvwgzBBM84CtnqGKciRnOSUS7Ypgrk26snvTUqi
	 zwCFXMCjvzPmHgznmWKPqmvMVDKBSpd3uhh3hd3OA54YcXO3vvr5aNg9iocr3s+yj4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
	b=4iwGYcpCx0IPUjIS9DJlwtBS6Gr4E2ZDfXPcV82npA/LRL3v0/cGSAiifVOo/T4Fq4Ue
	 7mxWzMsaYFaWDc+pwD8XH7e8/fqEwP94ePCizWlN6sTgbJFWt5Dcg5oaFzO8hnpusXumu
	 kadUWNqfa5kjNw9p1vCz+nuEiHu7V+gIV57zeLhwDUT2GDX8k3woCL3sdhkdkCXx1oVEQ
	 WORps8Ah64E+/ghUKw7cbx1k5btbBi8fsoGUJzdOyIv9QNacOnRQZrjvzNN/SISdfhhUQ
	 Wj4Yg50ofOqdypl/oV77TGkOIp0YIu1JdkRSxgDgiCNWzDjdL2xDC1tCRtl/49ucXOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9C60A2624
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 15:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24B9C60A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso12775825ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 07:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323277; x=1794928077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=LHozpx7ZkQyIUBsAkv4C311vzxfheFN2pzrL9Y/FTHkEXQzaVUkMAz9U9wFUejAOr8
         YATASi40x9WcOvyF4dkS6SJQ2bBJHO0yE68WsOT8oewufPXMhMYT6O7d4/5H33a+EMHR
         jjCu1KqktdAA/9c8ZIpbjFjA/3BLyNbgEZc3fS3F9+PTZ5y3jCgkJQ9rhGft5ONP+cJO
         aTEF5vn9sQP8UWqDXO8UszNcV0yZFTKvtrsUk25y1Sz/3h5njQt9uj1PBQLO+FuWPgpB
         LsGoLTWDE/iFYFuKD+GJLya2PXFipxPXM8zYDthkWkjgd0549O004Xgoom3qc/ylK84T
         vykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323277; x=1794928077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=OiLvxQgf0YjeJXhjnjZzqBYRRHzpX2HLtJtsA61aWyMmaKJbgdLjxWgErRDPRKSNTd
         Zoae9nuatgePbzYZKcWc4F1rEYZhxIWI6ar7BazkJe/BlgeXIRjbmw3gPxjk0RH500gV
         2XhZMW0tM/kB/H2mLBth66tKZQOxUb4vzPYIEBLLST7OiVILWkDZnOs93wACwGN8Qg49
         QtCNCH7M/RMkFSvjw2V1qYQPuzdTfoUBjfqbBBJSTBecNtg6GqzgxzjO34Xu/MKPnQJ4
         J0U8C0jMUzfy8b9YNvg2IQkULBLD3szbpOv+xpk87nXqHFgXrNmHOUNZj9alxNZZOTf1
         XY5A==
X-Forwarded-Encrypted: i=1; AL+hErFYStX2Hryh0kyZutRTbqMu+zIved3JxShliRvemil6Q/TAzAH2PMRkTRborABEccu75QW0zyEjSYGq4v44@vger.kernel.org
X-Gm-Message-State: APuU4Z8sGh75QHubdCkcwkHoSkt0lyq0RIJgVaqzzq37nc32D1e+ItFN
	SgduQNnjn8DZwDRiZ5srfJPNS3CjFA29uHa2f50FOIKWjdFvEDEx9D8l
X-Gm-Gg: AYBFou0pw1a4KY2lP7yM27CNbybwjCLuPGI1IiIQ/+KkPtNVVyzRrSl6PISVXUfp4PY
	I2LMpDbtbiL8mK1/+mjxVlDPh6OjjyaE6zQadyu0PJwOLP9FjM2cKa4XNElKUykrPSwdCQgDFxF
	2yO6BVSeDHWFZCnZF4XOZ42nV25b6rbevzLgva5rarq+7vSbi08/JXHlLEXwnzZ8ZZyiOMyHsoJ
	ypu4xkY2P2yb2v1CaJrBGRORIpENYPj+JNNTOK0GmZvtCSmyg8ome8MleqzWp1klprVvRulOU+g
	R/YTeA+IMbb7QgbiYDVm/XfgIok6VOkI/gz/T2nXCdSIFtBkmp5h89zP4ArQdKq4RfeUBlhZMW9
	TQBPK8CVS+Cwd6O+To6nl9KDD+Gz5kulmWaE5WqGMOC2BAB7XPdbZmdvKaM6+2Kd43CSzK/c2Qs
	cj5XFsEL7zLXQSnwXL0Fb9mBNzTlVjLCzC7X7T6aMNVtVuQadIdqnr/druqsLRVzTKFEzgCg2JM
	jZERIDlzRf1o/MVx6htpr/raDLNnftLml19zRuTK2KMVzVq+UwbnkxeAkFGz0LqSG6ljNDi+gqR
	F1IsM2bsZkD+WHNMcVT0j/SgzRJ1A0HsYOknsuXhB8gIEC1gZ6o5UmkEWM2doL5e+SiVIeRL4Oi
	KzM81pX9Ce5U=
X-Received: by 2002:a17:902:d481:b0:2ed:1ef3:9ec with SMTP id d9443c01a7336-2edb9172a2dmr26826345ad.14.1794323276968;
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Received: from [192.168.2.6] ([27.75.101.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d78dbcsm10397575ad.27.2026.11.10.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Message-ID: <71f76e5e-ce24-4a71-863a-169ad262c510@gmail.com>
Date: Tue, 10 Nov 2026 22:07:46 +0700
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 36/41] nvmet: refuse files on pseudo filesystems as
 namespace backing files
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Language: en-US
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 4:14 PM, Christian Brauner wrote:
> The file backend takes any path that isn't a block device. With
> buffered_io=1 that includes files on procfs or sysfs which then get read
> and written by a kernel worker on behalf of the host. Refuse files on
> pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  drivers/nvme/target/io-cmd-file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index dfa8aa46188c..71c69bac5394 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -52,6 +52,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  		goto err;
>  	}
>  
> +	if (file_is_pseudo(ns->file)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
>  	nvmet_file_ns_revalidate(ns);
>  
>  	/*
> 

I noticed patch 41/41 doesn't include a test for nvmet. Would it make
sense to add one with buffered_io=1? The test would need a pseudo file
that can be opened with O_RDWR and supports both read_iter and
write_iter. Otherwise, it could pass without ever reaching the new
file_is_pseudo() check.

Thanks.
