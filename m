Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4D3CFF7E
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 11:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215547; cv=none; b=crgR1cfT2+uPhKTlFqkrsrWDomm9x06npv6CIj1MG6/9Y4BoafWhUmPR3KimKWECEZJAK50iZij0eW8WGOqPwEWdJtyRCb6meHAkDFifqyWB8+3nNGZSh+4lK10PTQ7+wmcqNRaGi++TPDY25/5c1V4JUJtDq+sHDOwycp1QiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215547; c=relaxed/simple;
	bh=vSMq+tVBRFkyDtQqvUY0r/b24xLj9JOEUkggBLpr+3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ai+JCMb/8LNiC+bfTrtW4fTqPkM5+o8sCA5mTB6Hh6kaFvU4OmasPYLXDemZtItNaSfJsH566Tleoxc/aZypJ6cx4/Kg8oHy1SwPwJRPfdX6oVft2bmebBaQX5H496IrdBXlvkk8bBQC71V7IBawcybojAQQMg6LRlEKLyN58fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=baLzCHBZ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="baLzCHBZ"
Message-ID: <33cc8eb4-8831-49b0-80d6-b06544a37920@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1782215532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbHk9IuwP6sXbnZHOGBepgq7/3h6RydFMctmwTcnnXE=;
	b=baLzCHBZiCMvODbcElXie9bXXAYXoQSsVix4j82AsGf2L0jSaJKJ1FefcKWnC3r6iptHIP
	6z9boTPXO4s+uyLao5JCtf7fGRULt6DKsSqhHNlx506XqWRGSzLhk3IMcHQxkozhCR1WGw
	OwgsAtR57qiB78+yoCkLdWtn3lW9sg3AEBEN+tkJFH9oaUNydw6Wo3vs8KUZFzug5mmCH7
	zF6kBQpJcfiCi5C4lPNcpeIdnkMLMNt5102SSNoV2IxkMB/vspf7gq6+vUZP1f7fIkyhUj
	Kg3pqGVUUwx7VoP0q0zJwCXppXP0+Tp5vkeHO/Rv/uRItdPHwEXqechS59ZE6w==
Date: Tue, 23 Jun 2026 19:52:05 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] netfs: Fix UAF in netfs_unbuffered_write() on failed
 preparation
To: hongao <hongao@uniontech.com>, David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
References: <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <FA1EF9EEE4C1415E+20260530011403.1686344-1-hongao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi hongao and David,

After applying this patch, I can still reproduce the use-after-free issue.

C reproducer: https://syzkaller.appspot.com/text?tag=ReproC&x=171b697e580000

Note that QEMU should be started with the following virtfs option:

   -virtfs ...,mount_tag=syz,...

On 5/30/26 09:14, hongao wrote:
> If write subrequest preparation fails, netfs_unbuffered_write() calls
> netfs_write_subrequest_terminated() and then reads subreq->error to set
> wreq->error.
> 
> However, netfs_write_subrequest_terminated() consumes a reference to the
> subrequest through netfs_put_subrequest(), so the subrequest may be freed
> before netfs_unbuffered_write() reads subreq->error again.  This can
> trigger a slab-use-after-free.
> 
> Save the error locally before terminating the subrequest, and use the
> saved value afterwards.
> 
> Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequests in strict sequence")
> Reported-by: syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3c74b1f0c372e98efc32
> 
> Signed-off-by: hongao <hongao@uniontech.com>
> ---
>   fs/netfs/direct_write.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
> index 25f8ceb15fad..2d5361702076 100644
> --- a/fs/netfs/direct_write.c
> +++ b/fs/netfs/direct_write.c
> @@ -115,8 +115,9 @@ static int netfs_unbuffered_write(struct netfs_io_request *wreq)
>   
>   		/* Check if (re-)preparation failed. */
>   		if (unlikely(test_bit(NETFS_SREQ_FAILED, &subreq->flags))) {
> -			netfs_write_subrequest_terminated(subreq, subreq->error);
> -			wreq->error = subreq->error;
> +			ret = subreq->error;
> +			wreq->error = ret;
> +			netfs_write_subrequest_terminated(subreq, ret);
>   			break;
>   		}
>   

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en

