Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647EC3B8D70;
	Tue, 10 Mar 2026 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158586; cv=none; b=rfVSNB2Ge3plqT6oTT33qyzqVbl8k9A/8jH8mTjs/TujmFg2z///FuD3zAon8o8uihHWlXLmW/4wshC/+70cLeTvtI6fk2hfUKvlFIxC+cizHWT0orRDLLTwRby5naRy/ZdGIrR3k3RmIGvvm/iLOGiJv73Hcb6qh1rKp6EK5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158586; c=relaxed/simple;
	bh=9ZX3Wpp7xiuWRrLbpMrF1C3fJABdc7jL3cwbG33Jg88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cedoBOKWwMDuaSa+TKIkN36eQokIgNfvh73XMDD9PfcjhhY3q9XIbBtdzvFUaODYL5NRS2975L9S1m/C7+k2aR3SfB6YKFZSN/IyPe22GScQvZ9daIKAI6MY1RaWOKMCMkA9ZwgUlWquYemVQEGohTviNXQIHnKOs5JtxVqPkqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tARv0nAn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tARv0nAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF12BC19423;
	Tue, 10 Mar 2026 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773158586;
	bh=9ZX3Wpp7xiuWRrLbpMrF1C3fJABdc7jL3cwbG33Jg88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tARv0nAnDVxBuNxCl1dSgqG2A5I4KeU5b46XG6VpJP84pjPINPMPvSBV9RoxULGMp
	 SYJPTR7+cok/iNS63JNAfrlU70GlMinIK0hm5Gw1gtJdYOsO9Q39irnsSp0WS9Xxdk
	 yjDcafNbncBw7Y4dqab6aXESjy6aT4J+bAYCOAzxQTY+adCijKvibQZXXu8QvLvv03
	 6M5/7tItaO6MPbGoL7qefwdPdU7XMA78mSLIYaKYxYp7rJZHA/DKs0/anMD+iZbptv
	 TYVN7kc1U3UXB+QkKmIerb2D8bGf4iiJ0MD/Y4v9/XPGqmX34y6/WnHxyKrQMsU6Jm
	 c3IEvwDvz90fA==
Date: Tue, 10 Mar 2026 17:03:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH RFC v2 01/23] fs: notice when init abandons fs sharing
Message-ID: <20260310-ortsgemeinde-skorpion-241922c18219@brauner>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
 <20260306-work-kthread-nullfs-v2-1-ad1b4bed7d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306-work-kthread-nullfs-v2-1-ad1b4bed7d3e@kernel.org>

> +struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
> +{
> +	struct fs_struct *fs;
> +
> +	fs = current->fs;
> +	read_seqlock_excl(&fs->seq);
> +	current->fs = new_fs;
> +	if (--fs->users)
> +		new_fs = NULL;
> +	else
> +		new_fs = fs;
> +	read_sequnlock_excl(&fs->seq);
> +
> +	nullfs_userspace_init(fs);

This is called under task_lock() and nullfs_userspace_init() may sleep.
Oversight on my part.
