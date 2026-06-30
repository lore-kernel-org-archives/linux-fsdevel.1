Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854F3E168F;
	Tue, 30 Jun 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810726; cv=none; b=b8mH8/QdkmNq4iIV2H0ZKuhKjrNZWewfxk/PyRoLIMtSgp0iux9wDkzYyX+rJ9ymL1WEP06Hq+sMkMGrmyC98vU3nkWJLtHXTyVFDHxG5YjA6u7GMCqn6TC9zMwr2JEmXo0QYFqgIvZ3/8B5cvsaycZFaBMS+Zt+xX7iRysRNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810726; c=relaxed/simple;
	bh=IYg3bC4yI11SfWP0F8LyuT/aOaCMeMsZ83QlYDDEJhY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=REbUo/9z318szJnazx3aYWWAQJaCohkJzPU+pCPTgrh4HOmg74t5BBEkBG7bUv/kO3FBRh50qQzsppOvW6OY30JXiTcEm/jns7kA69vr+rgtCOe2US0xSijmKZrC6Aygxg6h5xuZPACxEGTAV2hJ2oy/2io29VNRorTtwrcn8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw3Wejav; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw3Wejav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B491F000E9;
	Tue, 30 Jun 2026 09:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782810724;
	bh=rFTUoYLf9fPfCc5JqhqshB9gxtzyiaH/x/jaQSm17yg=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Nw3WejavqH+n7FZ4eMWqgpwOXmRV3Xv1vGnLDnsjbL0B4PWWbTyJTCNBhjjsiAUnL
	 NtSbH8ZzVasCKL1RZw646rKngNp6ZBAeKocTo0d6HrOqqOK+q7WG7xUFBX+kzvIXPP
	 u+9xq96Bgsdfp0xyEyfPWoqK5xu3T9SvimGeFb+muxJKwTcRDCchg88mq7Ckp6x9eT
	 kg7vBop1UFugXcICXlPcsbpMREvChrd5u8DQhiapD4PduDSMxkU5tEwDWuiyKo1jpE
	 zEne58T0kgraMnIdQP5QlVoayswzpLd1yupstMSgzq2RTwPmu5GTS2mtCvFVrE7/7t
	 OkHrZwvJoSpbg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/3] xattrat: accept empty O_PATH file descriptors
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260607164136.2948550-2-agruenba@redhat.com>
References: <20260607164136.2948550-1-agruenba@redhat.com>
 <20260607164136.2948550-2-agruenba@redhat.com>
Date: Tue, 30 Jun 2026 11:11:59 +0200
Message-Id: <20260630-wunsch-wichtel-ansporn-f4754acc8bcf@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IYg3bC4yI11SfWP0F8LyuT/aOaCMeMsZ83QlYDDEJhY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5dyRl3Zo4QeyHeLrSHrGyfs5K86ULJ1kdXyzZWh4x2
 SRiY1J4RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER4mBgZPtWGvrg2YXbvdK7I
 U4XmX+WZGN1/HGae0Fb9qvXf040N8xgZvuy4M41DKWiv/osNd7yOTy7/+eqojuTGa0UaZx8WKi+
 IZwYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Right now, the setxattrat(), getxattrat(), listxattrat(), and removexattrat()
> system calls fail with -EBADF when dfd is an O_PATH file descriptor, pathname
> is an empty string or NULL, and the AT_EMPTY_PATH flag in at_flags is set.
> (Regular non-O_PATH file descriptors are accepted.)  This is inconsistent with
> the behavior of system calls like fstatat() and fchmodat() which do accept
> those file descriptors.
> 
> The same operations can also be carried out indirectly by using
> "/proc/self/fd/<dfd>" as the pathname, but that is only more cumbersome, and
> for no good reason.  Fix that by changing the xattrat() system calls to accept
> these file descriptors directly.
> 
> We stick with the existing practice of leaving the behavior of the fsetxattr(),
> fgetxattr(), flistxattr(), and fremovexattr() system calls unchanged: those
> will still reject O_PATH file descriptors.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index d58979115200..4737554df5fa 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -700,7 +700,8 @@ int filename_setxattr(int dfd, struct filename *filename,
>  
>  static int path_setxattrat(int dfd, const char __user *pathname,
>  			   unsigned int at_flags, const char __user *name,
> -			   const void __user *value, size_t size, int flags)
> +			   const void __user *value, size_t size, int flags,
> +			   fmode_t mask)
>  {
>  	struct xattr_name kname;
>  	struct kernel_xattr_ctx ctx = {
> @@ -725,7 +726,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
>  
>  	CLASS(filename_maybe_null, filename)(pathname, at_flags);
>  	if (!filename && dfd >= 0) {
> -		CLASS(fd, f)(dfd);
> +		CLASS(fd_except, f)(dfd, mask);

So I can live with the O_PATH change, I guess...
but I really dislike fd_except. The code should never bother to pass
FMODE_PATH directly which is just rather ugly and we've taken pain to
make it work without passing it.

I also don't yet understand why this would be necessary at all.

-- 
Christian Brauner <brauner@kernel.org>
