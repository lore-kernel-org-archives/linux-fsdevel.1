Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA10286D5E
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399419; cv=none; b=BuJ+AXj/g/zhT4nsVVzyWZ5cH6VWYyxUnc7tfZJrQjFHc7ZCxWPfQYnrtXbBhHkmwF4Y43Odmnul0F419YuZema8hDMHgXnmUuVMoOiHFil+Tfpwkrla56tw2qWJEwfMHN5HHlXpmMjs6c4HLlyAoAoKkn88iSH6Vb+R2DEjIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399419; c=relaxed/simple;
	bh=A9wPB/8EmOQCGuIA98MTaeW5eFFBrCkau+sQczMZbwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ef2xz6UOUkp3YOjj1ZM2bJCoFgabZ4HB7e7Jbq8td1f2qTGx24oBhpHvvM9nqyhj/GbjAmeBDd3EjcBWzSuoUNANSpPb+WYBxh6PwLvygHx/dAjy+yKy7sraxbjWJ0Y5BjbA6MSRT9pZJuIc6oLzla9aK8CljT1XGOu2s8cguYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Xi+G5uut; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Xi+G5uut"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788399413; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=e541pMb9oMqhXLTyZBftOnSifT1JVi2i2ff57bVED4c=;
	b=Xi+G5uut+AJDQNkvLZyBkcSMfM28p9ORQ3yaTodx/LvGGOk89zMyBsyAYdVRLhqp/9KdQJxhQ6XQ9Ncv9afZDLXoLnYwbyD94Mu0kDffOZcXwL2JyICaQMeNcFLOLaHCFFslIEvw5uS9iFmoxckZMi9bvwyuV1viv7+FDbX2gw8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XAEOibv_1788399411;
Received: from 30.221.131.71(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XAEOibv_1788399411 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Sep 2026 09:36:52 +0800
Message-ID: <8d78e72c-a7f5-4b08-a249-34e924bda588@linux.alibaba.com>
Date: Thu, 3 Sep 2026 09:36:51 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ocfs2: Refuse to enable ocfs2 format for another
 filesystem
To: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org, ocfs2-devel@lists.linux.dev,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Farhad Alemi <farhad.alemi@berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20260902132458.23590-1-jack@suse.cz>
 <20260902133702.1313635-3-jack@suse.cz>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20260902133702.1313635-3-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/26 9:36 PM, Jan Kara wrote:
> It is possible to issue Q_QUOTAON quotactl(2) e.g. for ext4 filesystem
> requesting to enable quota using ocfs2 quota format. With suitable
> passed arguments this can get upto ocfs2_local_check_quota_file() where
> the passed superblock is from the ext4 filesystem and that can cause all
> sorts of interesting things, most likely crashes. As ocfs2 quotas are
> specific to ocfs2 filesystem, verify we are indeed enabling quotas
> there.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/quota_local.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
> index f55810c59b1b..97dee8ee6096 100644
> --- a/fs/ocfs2/quota_local.c
> +++ b/fs/ocfs2/quota_local.c
> @@ -171,6 +171,10 @@ static int ocfs2_local_check_quota_file(struct super_block *sb, int type)
>  	struct ocfs2_disk_dqheader *dqhead;
>  	int status, ret = 0;
>  
> +	/* OCFS2 quota format is supported only for OCFS2 filesystems */
> +	if (strcmp(sb->s_type->name, "ocfs2"))
> +		goto out_err;
> +
>  	/* First check whether we understand local quota file */
>  	status = ocfs2_read_quota_block(linode, 0, &bh);
>  	if (status) {

