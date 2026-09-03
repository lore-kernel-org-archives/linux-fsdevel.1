Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1DC3515D2
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402724; cv=none; b=JKuqxdCw2fXv0tO3ApQ0eRFILkazwPpdkxISt44kB1AHErub8gNCqfRadL9x63MkXZdR1cj2l2TqCxCSl0CmVs8VGb2CypXkstx0x/5VSxZarjQc7Whjpd6xWweH/57Sd+xQFcoB/dViL8cen64L0f3Dssf0ISCHYkkBzfQSmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402724; c=relaxed/simple;
	bh=mhnQUgpB08Teq6ugPKEvbkk1XBrN1Jr1TmAjxKH8h+4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KkPV/t6f+n+RSV6iLFSpXHG2Ub2G3FHhvCS16gycv0dQgtVadnWFuVqK3h1hdMipxpJb7Uj9cWLqjfDmmJ29uyp3mmh5YbWLr4jSibfbk30gbXZOQ8ldLgymCRjGTg7CQ/YnS1uaS7ihl16SfJYbg86u87v6BekQeXWAvxmZo+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B5DN7vQC; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B5DN7vQC"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-86a29a48ed9so21527927b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 19:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788402719; x=1789007519; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZ9VwK4M9RrXiYAkL+dI7dyHkhFNxu+nw3mnW/q/dvk=;
        b=B5DN7vQCkn9c14rCfZDH6C2g6O14KFPRTb0Ovn6pbqH4f17SOjCRYOdarytBbUC6Sv
         0j2U8PcN1vjRbr051e6PQilMrpphaodjBB4aCpdmiSqvq8QiJsNnoGYy2aozYu9TkL9t
         ia4aD644n6x/mFzK680t00KB/gdXgXMeuz0qZkZ6N6AFYeVicZh1XO9noBmqn3PsuRU5
         174YC6yRQL5WgXu8hvhat0iI5I4fzULluP9WN2LFx4k358usFvEfwCU39hglRyIDJu8j
         xqA3qdjN9siMSNYj2FUBzzNhUdU0wmSu8kGJ9xhxdzyLgvBqksb1ebaow7RGLsBlEBxc
         sJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402719; x=1789007519;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SZ9VwK4M9RrXiYAkL+dI7dyHkhFNxu+nw3mnW/q/dvk=;
        b=KkH0RTLL/x4/1OG4DLFe4k96O9vxt5KgYRV72aH6L61F7jG4OcVapK3D4QwM+2HjLC
         pfJPkyf9s4HN1/0fNCThzsIPbGA29umfMq+0J7bpDxQHGfBr6ysq9PuYfq9tQyt1P1/E
         aQz62ZvhGpGHTAfZ7rvi6lHMvPyJLSX/S3vO60Q3rcobh9+cLJKL0/fIhTcR3c/YFBM7
         8jOMmXr3DCU4mqVb8pNU26qbZhpH/kVRtZWSGIQ19EfKv/KoCjngXu0wMcs8HmNWQC10
         pcdJF+VN0BqZZJ52Fc125G0RNmQhWNuJZDW1+4h/Oo/obb5L4Gkb54s5JtA0y9+TyVhu
         8oaw==
X-Gm-Message-State: AFuF++nNMMFAB/jXyUAVPrbt7epO0inzywBjVws3w4B2DCpfb6upTug3
	B+zHXzIOvTJS0OrJqEbw8+xQM0mmr3T997N8ebqvwxn90aQBoh9+IUUcvU0tBCPdWZM5cEuNpBG
	J8f3OmPPx918=
X-Gm-Gg: AYBFou3zKDqo+nfXl5ituJ7iAhnqwLc71dSBTxiScRlquvom6pBcZhFJA7zwMmL4L5q
	FyiaahzYchPSgY/9j0NmIN7rO2+IJCzxDjaIhXD3R/DkB/huECxPaP4+R381pLu4Qyh825rQFOs
	DmGzF3mda+aNjNwCvgy69X3145dEytGS/zvFs5UW9pbpkLIUZwYTvIpU9NFkJF+xO7wIr5Uq9iz
	l1+A2LTxKm+iawXRwfXQtWn0o6t/zkzCvBwZkJF87WBTDgc5ccbrRxV70LKfFyiYoIC0E5sp2s0
	bZqdlWAvCzJgkfML7TTPGDbgk4nKNhkNQczVCF5fXZcuIN+Dx5gQHK5QJqUk1G8JRAulrHaIPKA
	RAaUanaETG4ePOkyT1lX1sD9vPT+1ED0lBGLsY8+80/ZLuGXaKr5ggbwfBunen2uCpqHV2z4HqF
	/CeIudbf+WrpRjQG3ttCu6KBKBvtoUbdZDPVrBJJ3LtEO8/GJdTJC5aOV0SjwoOwilUjTviDmEh
	Rm37dawuqjE991cqdzxXNhBKcS5sqxrybcaQyweus22Y2Gt
X-Received: by 2002:a05:690e:1689:b0:66e:65b1:6977 with SMTP id 956f58d0204a3-66f9b8f010cmr3430168d50.5.1788402718645;
        Wed, 02 Sep 2026 19:31:58 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66faa62c132sm753177d50.7.2026.09.02.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:31:57 -0700 (PDT)
Date: Wed, 2 Sep 2026 19:31:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Jan Kara <jack@suse.cz>
cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    ocfs2-devel@lists.linux.dev, Joseph Qi <joseph.qi@linux.alibaba.com>, 
    Hugh Dickins <hughd@google.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: Re: [PATCH 2/2] shmem: Refuse to enable tmpfs format for another
 filesystem
In-Reply-To: <20260902133702.1313635-4-jack@suse.cz>
Message-ID: <5f7e2e81-6a79-3b5a-1dc2-83ce775017ac@google.com>
References: <20260902132458.23590-1-jack@suse.cz> <20260902133702.1313635-4-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 2 Sep 2026, Jan Kara wrote:

> It is possible to issue Q_QUOTAON quotactl(2) e.g. for ext4 filesystem
> requesting to enable quota using tmpfs quota format. With suitable
> passed arguments this can actually succeed in enabling tmpfs quota
> format on top of ext4 filesystem which leads to crashes later in
> dquot_acquire().  As tmpfs quota format is intended for tmpfs
> filesystems only, verify we are indeed enabling quotas there.
> 
> Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  mm/shmem_quota.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> index d0b92d6da50f..6e0b43cbded3 100644
> --- a/mm/shmem_quota.c
> +++ b/mm/shmem_quota.c
> @@ -54,6 +54,10 @@ struct quota_id {
>  
>  static int shmem_check_quota_file(struct super_block *sb, int type)
>  {
> +	/* Verify enabling happens on tmpfs superblock */
> +	if (strcmp(sb->s_type->name, "tmpfs"))
> +		return 0;
> +

I don't object to this, but was rather expecting you'd check s_magic
for TMPFS_MAGIC: isn't this the kind of hi-tech thing s_magic is for?

Thanks anyway,
Hugh

>  	/* There is no real quota file, nothing to do */
>  	return 1;
>  }
> -- 
> 2.51.0
