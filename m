Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97382468C0E
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448530; cv=none; b=UVE7XjZ6O9EtSJ2uMY8kSzhXPBtJHWCUcyUXJwZ0SjQ5zKhbV2/VwmmIwQ/U9xcJaSqO32mSy5T+WXV4XVdrZbsxfLikONQRPikc7rXSExkrWdHRRzXZAFAv77UJBoOaUOOh3MHfJbJQT0jGTFrnbHyo9ihs2BvRJS/rlpe8cVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448530; c=relaxed/simple;
	bh=qFZ9XYDnRmDNjL7pv3XMAFeV1pKbOYwxExOW601tFFQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X+dAkMxjULGbPMSKI07mVp2crkIheX6X0zSDXTXbgPrgKL7yPIEzqGRuDnHbzzzGIlkKqW5kGhr4muCk8JWswr4j8FPnveIm+P5mV+365fHB3K8kfG5DTg5oPTO2+Kunl+2lb3WJjjCmwCuYrM3uM2JZj0vj10A152WcHsLOgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDqWwK0P; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDqWwK0P"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8200b55dc47so30558807b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788448529; x=1789053329; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mf2cMzcJB7ZgyTGSGNOkCh7zEnrruRaHuarVNveDD7w=;
        b=mDqWwK0PQ7m5lMf/fgtFw3ZzNzsZ95zIEQu90I+etmPdGUROdjlgMgAWK5B7xGy98U
         0dW8EBLNDlUvdNUOOYNb8Z8BUrGW5Desz8k/npo7WDhf4lx65F5aZ8qe+BfLC47sNvA9
         d1hSmSz6TXDHi384E6LvSv1yfC7jXaKDnNsL9sBltKPbb9dUKgXRAMtSD6iqwCHJP/RF
         CeKM5V+4Muv+AFds1eNEXVKOP/7RgWhui+ScY4GHCKY0dSP+4p7f3CwDbog/tz1ORWnl
         OCSirwcBdU73uMghCdT/b3g9GGWFohS074H5LaPKlVymmbDCCJJOLAfEeq9WaW4EPHoC
         iixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448529; x=1789053329;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mf2cMzcJB7ZgyTGSGNOkCh7zEnrruRaHuarVNveDD7w=;
        b=lab8n8aLKnpK9IUR1yO9OqH7WxBbwlE7td4DudFrQ2cYHbkJtRPgiF/LExt63PXVig
         YYBQ065LAYsTXX4W43aZtD8HLqGc/Q8XlNjvebxX7HiCCx6+WThi6E3ErSB3tguPprdc
         7ciTqZ3GZzDt9p6r01zoOQtT13vofl+qvipJkdkKWv4+nHYFgF3ueCYMbaHJPRb3OTcL
         lwxuaxb8vJSGCdEqaoZHVp6xxUKgkBcVWTqaV0CNt6kFldm8jctO4sdbAMLHnhr7BYz8
         i7DgCQYFNDByvrf4bsUIg8JqEW9UQmFkiTwq18SLVMjSKRFcuKvKZjkDzafuMvGRF5ry
         gF3w==
X-Gm-Message-State: AFuF++nw/RQdyzlTqW5H3fdobSj0NU3ecwyf1/MrALMlTOFiwzQLvRj1
	XeJUcVFK1cob17amkOZzfSYARKpBxliXvhaMKOtmNR3h6TX/T7l5qIOBSFSsxlK2bA==
X-Gm-Gg: AYBFou0AFDi0sO4GanehIuXrg+56aijT4M9Il3+c/Hf0ZYMAAD7cj/QCFItSBlo4Ow8
	obQADAdpg/CMcB8S05jyAEuAF8HuWu8LdrJ5XBsI9a09WP2FsYgXzwJQrC8Ylyqx/qTSPr/EcL4
	4EK/TnYMkApJCgnmsyxoMp4ACRPMYUXInUj/X687CNxhII/dXc2DBd+fCXYeA+vHfYy/rRYj9sG
	sHwDJTVyCnqWFiwxD1ni/RP1CeqXuyNDVSlZDD7Wk7nXL1mEe+uJCVAgcH5+/tIQUawcLzu0RqF
	0+jL+qlHUCCGjabPDwMODNX2KiMtT6QzHAZwq2A6Hj2ZGPDQFRT5My/cyw2mzM/Jr4+ycXLeVjY
	QqOsBcemmbuvuDlRkLCmvcsaJbdB7wqtNeh4HK2efNCSLAOBTuHYHwAwuKuR8mMTcIGJIjn3o5L
	WoDNy1dyZC3Jcqf/vULLM0NnQ46Exy9xeCEWLXqys4NVOZHD7cI0pl/JjNxKZUsZW9mFNxEgKuA
	SSFRavrIEnCnug/7nADNjiABj0EF1QDMc8Pm7cdJ3lcOuYc
X-Received: by 2002:a05:690c:30a:b0:858:def3:3422 with SMTP id 00721157ae682-86c53989a23mr76445507b3.27.1788448527781;
        Thu, 03 Sep 2026 08:15:27 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-86c10c9461esm43081537b3.7.2026.09.03.08.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:15:27 -0700 (PDT)
Date: Thu, 3 Sep 2026 08:15:14 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Jan Kara <jack@suse.cz>
cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    ocfs2-devel@lists.linux.dev, Joseph Qi <joseph.qi@linux.alibaba.com>, 
    Hugh Dickins <hughd@google.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: Re: [PATCH v2 2/2] shmem: Refuse to enable tmpfs format for another
 filesystem
In-Reply-To: <20260903090508.1360863-4-jack@suse.cz>
Message-ID: <3b119174-7b10-6eb6-7aff-462949fcb49a@google.com>
References: <20260903090053.13120-1-jack@suse.cz> <20260903090508.1360863-4-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 3 Sep 2026, Jan Kara wrote:

> It is possible to issue Q_QUOTAON quotactl(2) e.g. for ext4 filesystem
> requesting to enable quota using tmpfs quota format. With suitable
> passed arguments this can actually succeed in enabling tmpfs quota
> format on top of ext4 filesystem which leads to crashes later in
> dquot_acquire().  As tmpfs quota format is intended for tmpfs
> filesystems only, verify we are indeed enabling quotas there.
> 
> Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Hugh Dickins <hughd@google.com>

Thanks: yes, please do route it through your tree.

> ---
>  mm/shmem_quota.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> index d0b92d6da50f..a3fa4bd93e75 100644
> --- a/mm/shmem_quota.c
> +++ b/mm/shmem_quota.c
> @@ -30,6 +30,7 @@
>  #include <linux/slab.h>
>  #include <linux/rbtree.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/magic.h>
>  
>  #include <linux/quotaops.h>
>  #include <linux/quota.h>
> @@ -54,6 +55,10 @@ struct quota_id {
>  
>  static int shmem_check_quota_file(struct super_block *sb, int type)
>  {
> +	/* Verify enabling happens on tmpfs superblock */
> +	if (sb->s_magic != TMPFS_MAGIC)
> +		return 0;
> +
>  	/* There is no real quota file, nothing to do */
>  	return 1;
>  }
> -- 
> 2.51.0
