Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28135C1AD
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702680; cv=none; b=UwGXjsUrxpJa673HnTyvm/vO7ZxgjGDShXNiVuEoT4peEp3BitzF6kOPOX2gSA8LJ0u7umOmKFcw3CdInCAUR2tK6ZEPK8Uu/vPBf4lxgoQr9vqeVnMe31gz1sLOxad4xiyl/62d9pi/G9fDb6jwl3lplZf5WWSI0HHzEyXPHAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702680; c=relaxed/simple;
	bh=qGsy+K98etOu7JxFdxbYmP0/V7i+s4sSjLvJLDhk/lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix/kVkpWaYZj7bBVdh4MPtX5nFgWN3UCYh7BxtPvyG7Q1H9IWeDxbIJ29+awbK9uQNjZV4LrOE8H5PvOyzXmknWE0/mjegdbkKbMhjauUeq78/A2zPsUH3A7D+b6lS1ATis4iFLGB3hcrJjeLWjPZR8etIObb82E5klI7pSssOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gfp35hSc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gfp35hSc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB17C19425;
	Mon, 20 Apr 2026 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702679;
	bh=qGsy+K98etOu7JxFdxbYmP0/V7i+s4sSjLvJLDhk/lQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gfp35hSch1nVScAW9LRZiWM9Ao8uXKq2n5WHhpZrs/MV+YJCRx18tZQt22+LYfjH8
	 MCm8VyXiaV4zRxCs5OrDxm+d5A/jJ+SdCMdgnTI/mZvuY/Y12hcnWGEmR0HzMQBuNR
	 WDMLs/h7d/NOvucmSYzez9XQX9N14NI2KB6ERjwf2gPc4Vp9+Js2Gek1N7XvCOA5iX
	 hUHuT3i+dM5WukLY93xI/pR7QBfCVZsffoHesLT3kDQFWQrbpOrgOt35iJ4QiErCRm
	 Qp1dLQ5AHckk/FkCz5hbY5vRVUK3qvTY+YOWnMnmNGTXutQKv+DSgFIsBY0hyKekxy
	 a0qb5FwI5SiIA==
Date: Mon, 20 Apr 2026 09:31:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 22/25] Add support for sync-init of unprivileged
 daemons
Message-ID: <20260420163118.GM7727@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-22-b1ca8fcbf60f@bsbernd.com>
 <20260331005425.GI6202@frogsfrogsfrogs>
 <ff90a513-c7e6-4227-b605-b055d0e28247@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff90a513-c7e6-4227-b605-b055d0e28247@bsbernd.com>

On Mon, Apr 20, 2026 at 02:02:45AM +0200, Bernd Schubert wrote:
> 
> 
> On 3/31/26 02:54, Darrick J. Wong wrote:
> > On Thu, Mar 26, 2026 at 10:34:55PM +0100, Bernd Schubert wrote:
> >> From: Bernd Schubert <bschubert@ddn.com>
> >>
> >> This makes use of the bidirectional fusermount. Added is
> >> doc/README.mount, which explains the new bidirectional
> >> communication with fusermount.
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

<snip>

> >> + * On success, *sock_fd_out contains the socket fd for signaling fusermount3
> >> + */
> >> +int mount_fusermount_obtain_fd(const char *mountpoint, struct mount_opts *mo,
> >> +			       const char *opts, int *sock_fd_out,
> >> +			       pid_t *pid_out)
> >> +{
> >> +	int fds[2];
> >> +	pid_t pid;
> >> +	int res;
> >> +	char arg_fd_entry[ARG_FD_ENTRY_SIZE];
> >> +	posix_spawn_file_actions_t action;
> >> +	int fd, status;
> >> +
> >> +	(void)mo;
> >> +
> >> +	if (!mountpoint) {
> >> +		fuse_log(FUSE_LOG_ERR, "fuse: missing mountpoint parameter\n");
> >> +		return -1;
> >> +	}
> >> +
> >> +	res = socketpair(PF_UNIX, SOCK_STREAM, 0, fds);
> >> +	if (res == -1) {
> >> +		fuse_log(FUSE_LOG_ERR, "Running %s: socketpair() failed: %s\n",
> >> +			 FUSERMOUNT_PROG, strerror(errno));
> >> +		return -1;
> >> +	}
> >> +
> >> +	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[0]);
> >> +	setenv(FUSE_COMMFD_ENV, arg_fd_entry, 1);
> >> +	snprintf(arg_fd_entry, sizeof(arg_fd_entry), "%i", fds[1]);
> >> +	setenv(FUSE_COMMFD2_ENV, arg_fd_entry, 1);
> >> +
> >> +	char const *const argv[] = {
> >> +		FUSERMOUNT_PROG,
> >> +		"--sync-init",
> >> +		"-o", opts ? opts : "",
> >> +		"--",
> >> +		mountpoint,
> >> +		NULL,
> >> +	};
> >> +
> >> +	posix_spawn_file_actions_init(&action);
> >> +	posix_spawn_file_actions_addclose(&action, fds[1]);
> >> +	status = fusermount_posix_spawn(&action, argv, &pid);
> >> +	posix_spawn_file_actions_destroy(&action);
> > 
> > Huh.  Would have been nice to have known about posix_spawn when I was
> > writing xfs_healer.
> 
> Could be still updated to that?

Yeah, it's possible.

> > 
> >> +
> >> +	if (status != 0) {
> >> +		close(fds[0]);
> >> +		close(fds[1]);
> >> +		return -1;
> >> +	}
> >> +
> >> +	close(fds[0]);
> >> +
> >> +	fd = receive_fd(fds[1]);
> >> +	if (fd < 0) {
> >> +		close(fds[1]);
> >> +		waitpid(pid, NULL, 0);
> >> +		return -1;
> >> +	}
> >> +
> >> +	fcntl(fd, F_SETFD, FD_CLOEXEC);
> >> +
> >> +	/* Return socket fd for later signaling */
> >> +	*sock_fd_out = fds[1];
> >> +	*pid_out = pid;
> >> +
> >> +	return fd;
> >> +}
> >> +
> >> +/*
> >> + * Send proceed signal to fusermount3 and wait for mount result
> >> + * Returns: 0 on success, -1 on failure
> >> + */
> >> +int fuse_fusermount_proceed_mnt(int sock_fd)
> >> +{
> >> +	char buf = '\0';
> >> +	ssize_t res;
> >> +
> >> +	/* Send proceed signal */
> >> +	do {
> >> +		res = send(sock_fd, &buf, 1, 0);
> >> +	} while (res == -1 && errno == EINTR);
> > 
> > Hrmm, I probably need to wrap the sendmsg/recvmsg calls in my own
> > patches to do this loop, don't I?

Nope.  Sequential packet sockets preserve boundaries between records
sent with MSG_EOR, and reads are required to provide a buffer large
enough to read the entire record.  Undersized read buffers result in the
rest of the record being dropped silently.

IOWs, there's no possibility of a short read or a short write.  But
perhaps I should be checking SO_SNDBUF (aka the maximum record size).

> I guess so, I will try to eventually look into your series later. Go
> painfully late (or early) to update code with all your review comments
> (and with family couldn't work through entirely in peace...).

<nod> I'll do a new posting to the new list before I depart for
LinuxFest on Thursday.

--D
