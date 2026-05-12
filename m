Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732172F8E9B;
	Tue, 12 May 2026 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615428; cv=none; b=f5a2uSuBzH0nH77GHVzWBJge4rBF8ueFdHLNyBBYbjQcTR/9Ggi1/4n+Ltm4oqF2bSBigpuRpAqMRF2SlZFFyz1vpkHMLKaWDSmtoz9oVMqccorqqQXas/QMwIoZzmuNG9o9u8S5DTwgj3AIEQN8j4yXfUyV2ONeJrh1NYlIGwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615428; c=relaxed/simple;
	bh=Xundm1ZvBUu8C0lnbevb9XS7y1iy6fczD2c2YLf6/q8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=oRQw1XQfG6dYGueckWt7uFGW0kCZZEpDbkDBsH7Jppsfj+0n5Hkw8FFeAn9hye5kGNtXbnOab5HS9zYtre1i7Kj1grcZQZqpNYswyK9SNE4bQnLsPl66b8qw8Knn9nF/ZOSoJ5m9DiZQMR8D2tblRDT0yymuxoXoxeE2+ZbF424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8EPf6iO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8EPf6iO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418C2C2BCC7;
	Tue, 12 May 2026 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778615428;
	bh=Xundm1ZvBUu8C0lnbevb9XS7y1iy6fczD2c2YLf6/q8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=C8EPf6iOax3Z/mxxoMfMoQfHDYn4EEFkEAH0UkAxgZugUe2KA2PE7H/Xj/EPFhFx9
	 0kb4vycZLNTrguui2Gu5ldjxC/nbLM6nIHahCkUJhXcCaQhja3b8dH7u5mvQPLUqgr
	 lM0nFFLosSwO3yhQFOBcGjqzg4jsUvW1bVZa9Z9e6cT94Tx8gOGaIGSr0mI41K8Sk5
	 lg3gQYiKN99qsFJHh/VsmYrvR5j7ivjYOfHIcsFs+p3NOB+Mw64SBnBYmPTAHZZSWY
	 dUhLz3nnR3jcTXCzkZ1UXT9kLxfqi+cJVzJ7Us+w+56msWCGNQeSRaImgrqYplNYHg
	 veMvtwpCh1SIA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] eventpoll: pass struct epoll_filefd through
 ep_find() and ep_insert()
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 brauner@kernel.org
In-Reply-To: <20260503085101.112698-2-axboe@kernel.dk>
References: <20260503085101.112698-1-axboe@kernel.dk>
 <20260503085101.112698-2-axboe@kernel.dk>
Date: Tue, 12 May 2026 21:50:21 +0200
Message-Id: <177861542128.846060.10688550014394641030.b4-review@b4>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Xundm1ZvBUu8C0lnbevb9XS7y1iy6fczD2c2YLf6/q8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQxtzRKbot4EOISfGDjkrxD9iuV5l443/xdhffmi5us3
 hzqtnaqHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZfp/hf6bKjY3KS6Kf+nn1
 NIXrR/bdvvpavuDi3DbtwAkv7/65Hs7IsHHKxM2NNtEnZa1ay+T6mCrFO4U8jSKuXA9q2vD6is4
 5HgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Sun, 03 May 2026 02:49:12 -0600, Jens Axboe <axboe@kernel.dk> wrote:
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index a3090b446af1..f464f2f39e0e 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -339,14 +339,6 @@ static inline int is_file_epoll(struct file *f)
>  	return f->f_op == &eventpoll_fops;
>  }
>  
> -/* Setup the structure that is used as key for the RB tree */
> -static inline void ep_set_ffd(struct epoll_filefd *ffd,

I wish this was named "struct epoll_key" instead of this completely
weird "epoll_filefd" thing,

Reviewed-by: Christian Brauner <brauner@kernel.org>

-- 
Christian Brauner <brauner@kernel.org>
