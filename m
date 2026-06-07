Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C40730E838
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857606; cv=none; b=o+QS6hEA8NoaqHQTxtHRY9xHy3x8sZyc74uFk6nEy8znvly+dMRiI/4XOBoKHYDzycf18lxOigDKL61cnJU2WX3iKHxqRyGhQOjYsYyFAc05qGlWiWNn+7N8XVlZuBPnBKSjjYx7FJGzdmqjXV0kh7KUBcVO9HiNDJfsyTybt5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857606; c=relaxed/simple;
	bh=x8Z/kZPJbC8/Fv1CvcNt3yyEwoKOPTmPHfT6NYYJ/8I=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=ujSmd1RjQHt1wpKGadrDVt2k45L7y04Bvb7/5WGQLeM3P8uCqe1FZCwfCbwoC0SM95XImwuwqrFA3It6spkauuk12ZNjLcmJkRlccB4fW6U93lFIW3th3SAtDgul/ZeES0FsekkIPUpmqcoSIGp40C5ql3nxY6CvGGPMo8WqxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=uIUuaj2+; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="uIUuaj2+"
X-KPN-MessageId: 48db96fa-62a0-11f1-8ff7-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 48db96fa-62a0-11f1-8ff7-005056999439;
	Sun, 07 Jun 2026 20:39:58 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 48dc67c6-62a0-11f1-b5d4-0050569981f5;
	Sun, 07 Jun 2026 20:39:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=OCaItIhxH27o2mCXjo8Dr1EamQ166KnS1GVOoVaGWCE=;
	b=uIUuaj2+40SgWq6Nia320B0pZBjNY7qS9LQIkbw/bgfnqtkREgxx2Q4ALAfT7LkPunvfpCNdvjIvT
	 RpviEqwqdn7tsIjUvI/urGe5hBBFLiNiqnzc1vVTbKu6bWp9uVmcqEYHhS5C8rYTmFk6fBowfiRq6r
	 wSYTAwx3xfd/yuzN3B55jOS13k9czwoxFEzRpALWL5o73VtRIqs1x0eyucTuQGBJ6hk5qgwwApbuq7
	 rW1KPMgnsL8mNxAILwtMD+7GZAem/VCCW3VCAgFeXQasvHqywk4agXyToGnQsYYfgwzIgrZnTE0dCg
	 g+Iobv0J2XN0CU4qUYckG70gWyyHNBA==
X-KPN-MID: 33|Mh6tuC3tC/6R131M7+3S3XKagWHMP+2wUsemglHj6g0X9lPbiFydRNyCacEpi8X
 QXZwR7PcxHMq+0aKu+a5V7BrH6sAbFbgTkNHWuTfOV/c=
X-CMASSUN: 33|NIZjmHoaoNL6smGFLmx1kEYybBdFxNN/Rqp9ZAKDNPUNn6VO5fULP281bdLJiiN
 8um1i9hoqCWuCdRn0heFOSA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh07 (cpxoxapps-mh07.personalcloud.so.kpn.org [10.128.135.213])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 48d5fc1d-62a0-11f1-b8d7-005056995d6c;
	Sun, 07 Jun 2026 20:39:58 +0200 (CEST)
Date: Sun, 7 Jun 2026 20:39:58 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <696696440.856299.1780857598136@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH 1/3] file: add fd_except cleanup class
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

On Sun, Jun 07, 2026 at 06:41:34PM +0200, Andreas Gruenbacher wrote:
> CLASS(fd_except, f)(fd, mask) allows to specify whether to accept or reject
> O_PATH file descriptors by passing a mode value of 0 or FMODE_PATH rather than
> using a specific cleanup class for each case (CLASS(fd, f)(fd) or CLASS(fd_raw,
> f)(fd)).
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  fs/file.c            | 5 +++++
>  include/linux/file.h | 2 ++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 2c81c0b162d0..c34049b36e6f 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1211,6 +1211,11 @@ struct fd fdget(unsigned int fd)
>  }
>  EXPORT_SYMBOL(fdget);
>  
> +struct fd fdget_except(unsigned int fd, fmode_t mask)
> +{
> +	return __fget_light(fd, mask);
> +}
> +
>  struct fd fdget_raw(unsigned int fd)
>  {
>  	return __fget_light(fd, 0);
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 27484b444d31..947765f064fe 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -70,6 +70,7 @@ extern struct file *fget_task_next(struct task_struct *task, unsigned int *fd);
>  extern void __f_unlock_pos(struct file *);
>  
>  struct fd fdget(unsigned int fd);
> +struct fd fdget_except(unsigned int fd, fmode_t mask);
>  struct fd fdget_raw(unsigned int fd);
>  struct fd fdget_pos(unsigned int fd);
>  
> @@ -81,6 +82,7 @@ static inline void fdput_pos(struct fd f)
>  }
>  
>  DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
> +DEFINE_CLASS(fd_except, struct fd, fdput(_T), fdget_except(fd, mask), int fd, fmode_t mask)
>  DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_raw(fd), int fd)
>  DEFINE_CLASS(fd_pos, struct fd, fdput_pos(_T), fdget_pos(fd), int fd)
>  
> -- 
> 2.54.0
> 

Looks fine to me, but I do dislike the fdget_except() name. Maybe if
fd_raw() is only used for DEFINE_CLASS(fd_raw) anyway, we can just
reuse it.
