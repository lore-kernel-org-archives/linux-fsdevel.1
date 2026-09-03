Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9571036212F;
	Thu,  3 Sep 2026 04:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788410092; cv=none; b=EH4gr5Lp345lR3g5quKOlce1MtyqULQD74BmEPQSKUwl52kZdKzFgYJUqHwrn7KP+XwHf6TG4+1pryVak6b1ocq5u7jvgcmQYTFiQxqGBAKjKpMe2ViAHGODjtqSsXeAAyGs0xmEZ/A48QW/PvIxEpA2Y8zyna1tgsYN+8kh3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788410092; c=relaxed/simple;
	bh=PcB710B/IhM4skkfgKnH9GKp/iK67Z8H2/MoXjSwQe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqLnzKwLSVE1kYag5WI5O8xbKRMV3L55QpGUC9Zz7qjjk9X6wtuIYCTlq1FeTD9pwBsuirFfiHmq0YYzKRf3np35BlIHfKeYW9sRKxWB58K5V+i2VLtD+wBQgI/KffZHAkWj4XkWIC1FP+ZO+NVvccUGPC8WKoxaNe5ZYkb3GgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hdw72yJ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hdw72yJ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04B51F000E9;
	Thu,  3 Sep 2026 04:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788410091;
	bh=jm6IklPUG84+JOVuRABoU1ve3l9Iwr94DueD7vB8jnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hdw72yJ/h2HszzuCDBDpMhE+VsKrcNCmhnU3T8qolI1ML/o/iwbS+/TDXS633NZdu
	 8mL/3s3CVu5qILdwgFVV7VXSvtw/oiPk7wOZ08r+Fz8cSEv9sJUvY0VQOcrFwD/Bv0
	 e8h+RYfqFokkByl+pxVUwn4P+rRC03CwJz50Oyfo=
Date: Thu, 3 Sep 2026 06:33:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	lxc-devel@lists.linuxcontainers.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] devpts: reject max=0 instead of silently lifting the
 limit
Message-ID: <2026090337-crowbar-unable-24b0@gregkh>
References: <20260903033625.1042796-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903033625.1042796-1-cui.tao@linux.dev>

On Thu, Sep 03, 2026 at 11:36:25AM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> mount_opts.max == 0 is consumed as ida_alloc_max(..., max - 1), which
> wraps to 0xffffffff.  The IDA layer treats a negative max as INT_MAX,
> so "mount -t devpts -o max=0" does not disable ptys - it lifts the
> per-instance limit entirely and only the global kernel.pty.max still
> applies.
> 
> Reject the value at parse time:
> 
>   $ mount -t devpts -o max=0 pt /tmp/pt
>   mount: /tmp/pt: wrong fs type, bad option, bad superblock...
> 
> No userspace relies on 0 meaning "unlimited": runc and crun never
> set max=, and LXC, the only runtime that does, omits the property
> entirely when the configured value is 0.
> 
> The value has never been validated since the option was introduced,
> so there is no Fixes tag.

Shouldn't the Fixes tag be where the option was introduced?

Anyway, not all that big of a deal as this is a root-only thing.

thanks,

greg k-h
