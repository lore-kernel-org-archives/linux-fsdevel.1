Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C218336A035
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Apr 2026 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020380; cv=none; b=kM5ZCJULVA3dGwkLb2lEmblYwfChvMCBmw8BheSjv9ABVQFMkTjdGURHnvB6PLn+uiV/BR2RqC5ySrCQRtlAr6CQ88mMqJURoXEEzBJSBQQi8YKB5BYXaV1Nm+xY5TgbB7QypBgumEAE/JEciiPmzfIadIvpctu5fj0CrTFFGOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020380; c=relaxed/simple;
	bh=knW6SA55bMavy43fJYeZSPmnRH+HzaHIwrL4YNrhk3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf2ccE57F6N7lE/wcBvTGvvBFSDSOLiuGwJl9vVnXgkJQMAnyfApZf7icUw1JVLT5FyXpZbhg94WUN4pWo00z2JgpV/QKW8nG+LpM3nHpGdJLAKtWeFRaU6/LkeVlmVDG3Z/MGcw1O4kzF+sA9UobsNG87Le+EVjT9khl52FKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k52DjATJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k52DjATJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=szDcnKrXbq5QxftSZcOhEpVFQxSQJEmcbKqj411G3oY=; b=k52DjATJ0Q6cqNa2I2InPnQLjR
	oYHjrM6LXq3NMybrvE2iAPOXDFvl/JOt0jUUKH1j8yVy9Q0OwkR4iDcL/a5nRMlQhYvH1TrK7Y9Da
	fX/ke5Os9vRltmwJTsXFa7qaowVk6waOqAAh3X4U517RtJZluXIFJCT6VbOQOrbGqX8QWQt9R0uTx
	ThVt6p/w2GI0/n2Hjh268ohhCDowu8uty5c1k5iiAvDEAlo1Bhc7Y38T5MCDa8h/6lpE7yABV2uuD
	1iIDrv/n06ujqa76xJwQpjOKyysyWij39bYkx8bPfuO96EoUI31mx3+heslRyVI0HOXpAEeqeSOGN
	00n25Ijg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wC05f-0000000BW0I-3AtW;
	Sun, 12 Apr 2026 19:03:28 +0000
Date: Sun, 12 Apr 2026 20:03:27 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH 01/11] shrink_dentry_list(): start with removing from
 shrink list
Message-ID: <20260412190327.GC3836593@ZenIV>
References: <20260411213348.GB3836593@ZenIV>
 <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 11, 2026 at 10:34:44PM +0100, Al Viro wrote:

> +		d_shrink_del(dentry);
> +		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
> +			dentry_free(dentry);
> +			spin_unlock(&dentry->d_lock);
Untested is right - missing
			continue;
here, obviously...
> +		}
>  		rcu_read_lock();
>  		if (!lock_for_kill(dentry)) {
> -			bool can_free;
> -			rcu_read_unlock();
> -			d_shrink_del(dentry);
> -			can_free = dentry->d_flags & DCACHE_DENTRY_KILLED;
>  			spin_unlock(&dentry->d_lock);
> -			if (can_free)
> -				dentry_free(dentry);
> -			continue;
> +			rcu_read_unlock();
> +		} else {
> +			shrink_kill(dentry);
>  		}
> -		d_shrink_del(dentry);
> -		shrink_kill(dentry);
>  	}
>  }
>  EXPORT_SYMBOL(shrink_dentry_list);
> -- 
> 2.47.3
> 
> 
