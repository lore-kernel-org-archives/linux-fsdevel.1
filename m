Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB02727EB
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118439; cv=none; b=icbX7qZlJ2LkLyuoGjwyjmpx7qjY7go0niDIF5Kpsn50NvbqDdfVx/u+wpUIjIQo83LmkXNYbv1iiJhdkD+5CkHiTMUQFOpAHjd2+4K8OU6yaOiVvvgkOtmSZhBZbZ8iduxShUdaNfTGP/2UHODohh56oAKdLuQD6YlisOE2Ux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118439; c=relaxed/simple;
	bh=x+F6iVAYzw1NRIqhfPrRSfYgcL7CkOLLB9OJGj4G1T8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1mZLa1H8Q85WolBmHOdL7uXzG7peBh2/TYOZObgTUAKc76k3ojPYF0ABPg8YVoEeV8kL2xkePyVzlLhdEn7qzCJoAtxf4gCg8WZ6eGL+E69L84rPbaF/mLl7zVOwvlgeUUGgkK5LOGhos3bTIKUxF6EW/u8wBsK5Xwa47kwsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vlr8kONJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vlr8kONJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1764FC2BCB0
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 01:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778118439;
	bh=x+F6iVAYzw1NRIqhfPrRSfYgcL7CkOLLB9OJGj4G1T8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vlr8kONJFFx06q4smAK0e/9hNlz4u/UioDVbeCiPjIH/ms12bcPR82s1h5HN/nreo
	 R/I1itT/Jxid/HhSNO7ojqbrcUZ0EXowkmum53pT3UFQuM1vwR85C48nbpuJoFO2Qy
	 kdmvU+qGuvGiY6ddCvu92VEDh7b0TL8j4bseSbcFiI5BQuAUtL3A1IAwOBDmfeL7VM
	 qCExzHZNMY0ikd+qSEvZmgWnsGDTyuXVB4u5n2CkXNv+UhV3Ieq5cAU64/zk95ehve
	 R2yZB870/Z7giMIQ/jbRoLMr8IAAweN+Ln5hIILsMf7bp9RBSNNEi0UvntM+UFUz+A
	 nzQT5Kc+Tt6VA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso362269a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 18:47:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+BqS4TLT5TNSzD28o8Ns6efv0gJ6Tg8mWakZQralXRbUL2Gu5B9tSJGvia7EMsZT2mN9vt/Z57yjqCA/yM@vger.kernel.org
X-Gm-Message-State: AOJu0YyYUe4lpPwuEdyY5FT/Rl/WY0z8x3RsRt8LG0N8qb8r9DxtRbln
	XJNs9S2rgH9FQjSKvewipwPL+0dqmfGYVlCRgM4KxQinbGk6S3bhro9713+oBFtPnCNR5qrc3vx
	TYzI8rwJ8tcVHHFbJtmFlPxovK6JDMO0=
X-Received: by 2002:a17:907:2688:b0:ba6:5855:1cc0 with SMTP id
 a640c23a62f3a-bc56ac390f6mr328426066b.2.1778118437725; Wed, 06 May 2026
 18:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506153850.774060-1-charsyam@gmail.com>
In-Reply-To: <20260506153850.774060-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 7 May 2026 10:47:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8ky6jUTtmGP4RkxLzRwRKG6yAM7ZD6nhgAgtvY9GAs=A@mail.gmail.com>
X-Gm-Features: AVHnY4KJ4DAgh5m3JRJGNyrZE-xHY3F7NojbdT7gFfY6fn9lxH0mrKAJqimYkow
Message-ID: <CAKYAXd8ky6jUTtmGP4RkxLzRwRKG6yAM7ZD6nhgAgtvY9GAs=A@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix out-of-bounds write in ntfs_index_walk_down()
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -1979,14 +1980,20 @@ struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct ntfs_ind
>                         ib = kvzalloc(ictx->block_size, GFP_NOFS);
>                         if (!ib)
>                                 return ERR_PTR(-ENOMEM);
> -                       /* down from level zero */
> +                       /* is_in_root implies pindex == 0; move to the first child level. */
> +                       err = ntfs_icx_parent_inc(ictx);
> +                       if (err) {
> +                               kvfree(ib);
> +                               return ERR_PTR(err);
> +                       }

At this point is_in_root is true, so ->pindex is guaranteed to be 0.
Calling ntfs_icx_parent_inc() which includes an overflow check and
error handling is unnecessary here, and the error handling code
becomes dead code. Directly setting the value will be simpler and
clearer like this.

/*
 * Descending from root index (level 0) to the first child level.
 * is_in_root == true implies pindex == 0, so advance to level 1.
 */
ictx->pindex = 1;
