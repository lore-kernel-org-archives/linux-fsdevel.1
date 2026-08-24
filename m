Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1943749E2;
	Mon, 24 Aug 2026 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787548086; cv=none; b=T4gLn0S2eAV4UftQMShW/rCcYDRpv27XKCP1YgGCKzpONUoQPB8+TcHaAWqgICQQYHqdSQWMxLT0Ek9Qf8x9UOjByq3Ok60RlJA9T0wcxaARlvH1Ts3K7bf4KMoTpAQhxBSLUfSPHq+Fmb/PBmSVGlR1+IWYrCYtSrUhEcCYB8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787548086; c=relaxed/simple;
	bh=al0XjKu6QSK3MqOaM9PYrNSNqzFeDNbheqkBlzsMHRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XN1mxV7zbjs2faCWZpZYugqmfe7ujCgkz5zLGxDGV+v05OI4BBRBOqueY4+agrSWFuKtkJIZ0gYDDgGwlT8lbmg/lMDt5PLKG9lZ1+/Oub+bpM6TWvAiUWnArOUExbg67KBYTw+iiKhxKr6QBVz1rjEbOUlbtNFlUehmy1AgBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UhKxmLtT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UhKxmLtT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166481F00A3F;
	Mon, 24 Aug 2026 05:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787548084;
	bh=4RTyB5+n27PNOI/KKmFcPfAvw/BEo0NzbcRBVmtvJdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UhKxmLtTm41F3s6zBSqkcY1zGrNYGl8BRToj4Y31ebuvojH7WvXjfWNvPxqfrzqPF
	 ZZb9d34jPV8dgOuIJes2/1dF7gnFspkaWshMueEIDkjldYaYzMRunqpYMVNbmrwaZ1
	 kn0AZanmlTIpuafmef32otIFljAJU00LrztU1NzY=
Date: Mon, 24 Aug 2026 07:08:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devtmpfs: apply mount options to the existing superblock
Message-ID: <2026082445-illusion-overtake-cacc@gregkh>
References: <20260823191254.3696641-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823191254.3696641-1-syoshida@redhat.com>

On Mon, Aug 24, 2026 at 04:12:53AM +0900, Shigeru Yoshida wrote:
> Commit cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in
> public instance") dropped the reconfigure_single() call that
> public_dev_mount() used to apply the options of every new mount to the
> single, internally created superblock. devtmpfs_get_tree() only takes
> a reference on it: the options are still parsed into fc->fs_private,
> but ->reconfigure is now only reached via reconfigure_super(), i.e. on
> remount, so they are discarded by put_fs_context().
> 
> For example, systemd mounts /dev with "-o mode=755,size=4m,nr_inodes=1m",
> so size= is silently ignored and /dev falls back to the tmpfs default of
> 50% of physical RAM.
> 
> Call the underlying ->reconfigure from devtmpfs_get_tree(), the same
> way tracefs and debugfs do; ramfs has no ->reconfigure, hence the NULL
> check.
> 
> This restores the behaviour of commit a6097180d884 ("devtmpfs
> regression fix: reconfigure on each mount"), which fixed the same
> regression when devtmpfs was first converted away from mount_single().
> 
> Fixes: cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in public instance")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  drivers/base/devtmpfs.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Isn't this solved with this series:
	https://lore.kernel.org/r/20260810083438.764684-1-simonlie@amazon.de
?

thanks,

greg k-h
