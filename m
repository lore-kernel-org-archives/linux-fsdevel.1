Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92A1A6800
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724369; cv=none; b=EhdZjY6gDlO8pvRYiNP+h9MOY7XDyJc1i2ht49gfs4tS7RjwS55EzX5GOSVQc/anc8KztJI6JVoUKAGJ7BvZh+QWZucL6i1+gPyYvY9Gezv4iblBzRC5QiSmbYKJ4Evmvq9wolzSNbtpO3IQKsYrj5vkylkZikJAmcCgB93Jqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724369; c=relaxed/simple;
	bh=vpGCCL4Q0nJpkSpWrkJqG3FrzHhYqpOyO1pa6FzlFpg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=p9+fAmGRwmC8jdgnfHu/IBu0fBdRHi40qrqFG62ZSAUxwogvdE5F5yOsjfu5kYa/d1E437w2MLvMr76IIWhYyXCGOM0apiqK65M94fWWM4wyr37EDBIhjD083ZbrY6Cl0J+gdeiD6da+XDQ84UDJTc39rRmMXzEX0iAjcIwN//0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0zBbNFu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0zBbNFu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44161F000E9;
	Wed, 22 Jul 2026 12:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724364;
	bh=xcusMYl0iPe+mub00ztq214n6jvxyZsjn293B7zZMnQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=P0zBbNFuD4OkSaRfArwgqB6aliEVaiD2+AH2mE0fR42hRb4z5wpGU3lD9s5S2u1wM
	 rK9o5ku/gzJi4YE28HKCEuaJmU8719TbZHsMcuMximFdqJ2cBf2hoyaQ6cZahQa6su
	 4qL9NzmCBaYr6UoaUecHqasywktcnPMd0lYsMxbqy9P7rEKl6pwqL8azczvP2RJtP3
	 lnd0C+NoSNcZinwJfCUIqqInvgOawi+gdvLElglr3XylUQpT+D8j46DAL172kYgBRR
	 KsGSlV0nNh6iZhExgWhDPJJPlzesMQvWS4kEnHzIyln88GsKfwz/CxCXfZNu4xiq8g
	 rI+DVgleBl+VA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] VFS: fix various typos in documentation for
 start_creating start_removing etc
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260701233128.3356519-2-neilb@ownmail.net>
References: <20260701233128.3356519-1-neilb@ownmail.net>
 <20260701233128.3356519-2-neilb@ownmail.net>
Date: Wed, 22 Jul 2026 14:45:57 +0200
Message-Id: <20260722-bonzen-wohlmeinend-mitinhaber-dd3fc5948605@brauner>
X-Mailer: b4 0.16-dev-9dec3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vpGCCL4Q0nJpkSpWrkJqG3FrzHhYqpOyO1pa6FzlFpg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQl7O7KfjGdKe3adIGixM6VLwOtH1j6bq278Ofh6skle
 o42dUbHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyayIjQ8v7Y1ujHcKqpjRW
 OB7jzHQ2/yEh4xRm/3/jI7efxjuudjIyrGlq0GlvVZbh1dIo4CuU+3hrf3jT+2efSxcWzn9n8no
 TAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Various typos fixes.
> start_creating_dentry() now documented as *creating*, not *removing* the
> entry.
> Unwanted spaces in Documentation/filesystems/porting.rst removed.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
> index d13f0a23c882..fa464f0ebd7c 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1203,7 +1203,7 @@ will fail-safe.
>  
>  ---
>  
> -** mandatory**
> +**mandatory**
>  
>  lookup_one(), lookup_one_unlocked(), lookup_one_positive_unlocked() now
>  take a qstr instead of a name and len.  These, not the "one_len"
> @@ -1212,7 +1212,7 @@ that filesysmtem, through a mount point - which will have a mnt_idmap.

"filesysmtem" could be fixed while at it.

> @@ -3259,7 +3259,7 @@ EXPORT_SYMBOL(lookup_one_unlocked);
>   * the i_rwsem itself if necessary.  If a fatal signal is pending or
>   * delivered, it will return %-EINTR if the lock is needed.
>   *
> - * Returns: A dentry, possibly negative, or
> + * Returns: A positive dentry, or

There's another "qstr olding pathname component" in the
lookup_one_positive_killable() kernel-doc.

-- 

