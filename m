Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE46A3BED7B;
	Mon, 31 Aug 2026 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161834; cv=none; b=jivWJsmf1K4QQhwnD5rWOBbeeURwIBsX/4bs9048SF/DmbHJjwEDM8DDnSlc1vVYrIS4rfk5rVSmaWmk2SY3XHJreeuQ5jlkISHYfwtZ2gnN6stMEyakMQHVnDENDx88OGP3RPtTymkuN9N7YlKES/MmpDzsUeXNMeZPNq8zCv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161834; c=relaxed/simple;
	bh=LB0C0brdyfnftVgvL1iqZUXGLUMFGwAHJqIPC8DcX4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8aTJZRIqUdlO3NasExV2KKQs0iOZH/D/7tTG2UYzmuo1lkOy2X3mL8e6NnApVbb/lak1z6kph9EmbJPbvhhpUrTQHhUSOtA+hcZW0argv3w8GC4Nkt1nZAHTn1oO5kPRMNnCo6wX/ZFwUN9V7pcK5kZl5pNGhTJoLXvOjr8+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVQLYAuK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVQLYAuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B171F000E9;
	Mon, 31 Aug 2026 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161833;
	bh=icIhn3Lxi6zoLKWYZDJZ7RgVfwGTSGo1Ir7IxXgMSIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SVQLYAuKQkzbz49pHfPShD4N9CYVVzp9fPEJD7G8c10Aj3L6+RKrVq3H0IJg+GEzk
	 Dl1aIHATZnnJeJP2W3gObOF/ha6+tf9UjpVQPpmR7fXHxfdsKvGIsqos5kBGW5iiNU
	 3/6ul4pO3/zn8/3mOPTmub3E/pk6v8b6PF2f6S9sEZ5bFZswgwJwyEncUBRSCCFj6Y
	 YPGYVQr11K+xCWmQN3ELcch0QcUQQovjJL55YIBGEJUvL/YckWVXIK5mlL+Ux4vdmN
	 O+GcWs/24yljwhnuHt/zPofko/q4GOBi4Dx6cJmGD7bWiW0gghmn/jiReumtXudf1Y
	 +mUnqsmG7M+Nw==
Date: Mon, 31 Aug 2026 09:37:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: hanzhijian <hanzhijian1991@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: fix s_fs_info leak when setup_bdev_super() fails
Message-ID: <20260831-chinchilla-zugzwang-havarie-7ee3e8639da9@brauner>
References: <20260822023918.2498361-1-hanzhijian1991@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260822023918.2498361-1-hanzhijian1991@gmail.com>

On Sat, Aug 22, 2026 at 10:39:18AM +0800, hanzhijian wrote:
> get_tree_bdev_flags() hands fc->s_fs_info to the newly allocated
> super block in sget_fc() and clears fc->s_fs_info.  If
> setup_bdev_super() then fails (the block device cannot be opened, is
> read-only, or is frozen), fill_super() is never called and sb->s_root
> stays NULL.  The cleanup path calls deactivate_locked_super(), whose
> generic_shutdown_super() skips the whole sb->s_root block -- including
> the put_super() callback that would otherwise release s_fs_info --
> leaking the allocation made by the filesystem's init_fs_context().
> 
> Hand s_fs_info back to the fs_context when setup_bdev_super() fails so
> that put_fs_context() releases it through the filesystem's free()
> callback.
> 
> Reported-by: syzbot+1c70732df5fd4f0e4fbb@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=1c70732df5fd4f0e4fbb
> Signed-off-by: hanzhijian <hanzhijian1991@gmail.com>
> ---

There's a fix for this in vfs.fixes. This is the wrong layer.
