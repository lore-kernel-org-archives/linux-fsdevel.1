Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBF833DEDF
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700106; cv=none; b=iBAmygPMW8LL87+XGQvxPYUTbfxmhxuF85p6aRVyv8jq/yijawbiyU3oOWJob8UjZlsUbcjgR4fpm6E9MGj7wvciaYtbb9X9/SoREE3csKqTGHmS2x4/gK2YPs/P/FiDW9gsVajvN1O81ubCATGF7/v29m7vexHfsxtLnd6q3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700106; c=relaxed/simple;
	bh=2ZOuC26EFCFGlw8dxFdxDxRnwRkvdA98P/FL6tA+chQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyxEgBU+keJZT9EumlclQgJ7vwaDELjbbHgWmzGqw5zSGWMzj0NfOy8aq4HNZE9dzv0uGtCwFY22vU9Of+AuBj1FVYPZiGhvogtioVKDeLZhT1mzUXE81enrLqd9kPd+QDeEDdzdwakx+dR5KqQzs8dwj3nT/53YgOuX4n0WJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpAshdRr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpAshdRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB2AC2BCB4;
	Mon, 20 Apr 2026 15:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776700106;
	bh=2ZOuC26EFCFGlw8dxFdxDxRnwRkvdA98P/FL6tA+chQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpAshdRrhbAWZ6DfrkVcbst3/goxNsH+3TGbt3sYXot6njDGzkC35YXB9RurK8vEi
	 7FZjMd78f/6stA6dBaXi6b5QgW2ETg9O+1GnXfVq70H4HZjGjmIgf+UQHqsgyov8VC
	 Gt93VBMad9GjBOB3gji2VRMJW+FHlFXNH0LLNIWICF+ExFJZ4hwR7jrFu8gSkFnVmL
	 7qodQq5xY4AF9xKkkWG0p+lwcVMnxFHg9V6I1VAQb3zxKNh23GdbjUuGUyKFciaNga
	 1MQSeSbfhiGRdZc166ZY59WjhRqoGZB7hgAm8RW8/46jCOV2Os9W1T9C2sPhMgFP3/
	 12G2aeH5hMUnA==
Date: Mon, 20 Apr 2026 08:48:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v2 13/25] Add support for the new linux mount API
Message-ID: <20260420154826.GJ7727@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-13-b1ca8fcbf60f@bsbernd.com>
 <20260330182731.GW6202@frogsfrogsfrogs>
 <a83cb254-2b7f-4957-9e88-6f5d1dbc716a@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a83cb254-2b7f-4957-9e88-6f5d1dbc716a@bsbernd.com>

On Sun, Apr 19, 2026 at 07:45:39PM +0200, Bernd Schubert wrote:
> 
> 
> On 3/30/26 20:27, Darrick J. Wong wrote:
> > On Thu, Mar 26, 2026 at 10:34:46PM +0100, Bernd Schubert wrote:
> >> From: Bernd Schubert <bschubert@ddn.com>
> >>
> >> So far only supported for fuse_session_mount(), which is called
> >> from high and low level API, but not yet supported for
> >> fuse_open_channel(), which used for privilege drop through
> >> mount.fuse. Main goal for the new API is support for synchronous
> >> FUSE_INIT and I don't think that is going to work with
> >> fuse_open_channel(). At least not with io-uring support as long
> >> as it is started from FUSE_INIT.
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

<snip>

> >> +/*
> >> + * Apply VFS superblock flags to the filesystem context.
> >> + * Only handles flags that are filesystem parameters (ro, sync, dirsync).
> >> + * Mount attributes (nosuid, nodev, etc.) are handled separately via fsmount().
> >> + */
> >> +static int apply_mount_flags(int fsfd, unsigned long flags)
> >> +{
> >> +	int res, save_errno;
> >> +
> >> +	/* Handle read-only flag */
> >> +	if (flags & MS_RDONLY) {
> >> +		const char *flag = "ro";
> >> +
> >> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
> >> +		if (res == -1) {
> >> +			save_errno = errno;
> >> +			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
> >> +			log_fsconfig_kmsg(fsfd);
> >> +			return -save_errno;
> >> +		}
> >> +	}
> >> +
> >> +	/* Handle sync flag */
> >> +	if (flags & MS_SYNCHRONOUS) {
> >> +		const char *flag = "sync";
> >> +
> >> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
> >> +		if (res == -1) {
> >> +			save_errno = errno;
> >> +			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
> >> +			log_fsconfig_kmsg(fsfd);
> >> +			return -save_errno;
> >> +		}
> >> +	}
> >> +
> >> +#ifndef __NetBSD__
> > 
> > This is always true, right?  Only Linux has fsmount.
> > 
> >> +	/* Handle dirsync flag */
> >> +	if (flags & MS_DIRSYNC) {
> >> +		const char *flag = "dirsync";
> >> +
> >> +		res = fsconfig(fsfd, FSCONFIG_SET_FLAG, flag, NULL, 0);
> >> +		if (res == -1) {
> >> +			save_errno = errno;
> >> +			fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", flag);
> >> +			log_fsconfig_kmsg(fsfd);
> >> +			return -save_errno;
> >> +		}
> >> +	}
> >> +#endif
> >> +
> >> +	return 0;
> > 
> > I did this a bit differently:
> > 
> > 
> > static const struct ms_to_str_map strflags[] = {
> > 	{ MS_SYNCHRONOUS,	"sync" },
> > 	{ MS_DIRSYNC,		"dirsync" },
> > 	{ MS_LAZYTIME,		"lazytime" },
> > 	{ 0, 0 },
> > };
> > 
> > static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
> > {
> > 	const struct ms_to_str_map *i;
> > 	int ret;
> > 
> > 	for (i = strflags; i->ms_flag != 0; i++) {
> > 		if (!(ms_flags & i->ms_flag))
> > 			continue;
> > 
> > 		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
> > 			       NULL, 0);
> > 		if (ret) {
> > 			int error = errno;
> > 
> > 			fprintf(stderr, "%s: set %s option: %s\n",
> > 				mo->msgtag, i->string, strerror(error));
> > 			emit_fsconfig_messages(mo);
> > 
> > 			errno = error;
> > 			return -1;
> > 		}
> > 		ms_flags &= ~i->ms_flag;
> > 	}
> > 
> > 	/*
> > 	 * We can't translate all the supplied MS_ flags into MOUNT_ATTR_ flags
> > 	 * or string flags!  Return a magic code so the caller will fall back
> > 	 * to regular mount(2).
> > 	 */
> > 	return ms_flags ? -2 : 0;
> > }
> > 
> > That way you can always fall back to classic mount() instead of quietly
> > dropping an MS_ flag here if one ever gets added without a corresponding
> > MOUNT_ATTR_ flag.  AFAICT there aren't any that *would* get dropped and
> > you can verify via code inspection, but why not avoid the logic bomb?
> 
> I took your function, just slightly modified it, like we can always fall
> back from new mount api to classic.

How does that work?  If we fail midway through setting parameters with
fsconfig, then the user will see a bunch of error messages from that,
followed by a successful old-school mount(2)?

> > 
> >> +}
> >> +
> >> +static int apply_opt_fd(int fsfd, const char *value)
> >> +{
> >> +	int res, save_errno;
> >> +
> >> +	/* The fd parameter is a u32 value, not a file descriptor to pass */
> >> +	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "fd", value, 0);
> >> +	if (res == -1) {
> >> +		save_errno = errno;
> >> +		fprintf(stderr, "fuse: fsconfig SET_STRING fd=%s failed:",
> >> +			value);
> >> +		log_fsconfig_kmsg(fsfd);
> >> +		return -save_errno;
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >> +static int apply_opt_string(int fsfd, const char *key, const char *value)
> >> +{
> >> +	int res, save_errno;
> >> +
> >> +	res = fsconfig(fsfd, FSCONFIG_SET_STRING, key, value, 0);
> >> +	save_errno = errno;
> >> +	if (res == -1) {
> >> +		log_fsconfig_kmsg(fsfd);
> >> +		fprintf(stderr, "fuse: fsconfig SET_STRING %s=%s failed: ",
> >> +			key, value);
> >> +		return -save_errno;
> > 
> > I think this function should call fprintf and log_fsconfig_kmsg in the
> > same order as the other two apply_opt_* functions.
> > 
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >> +static int apply_opt_flag(int fsfd, const char *opt)
> >> +{
> >> +	int res, save_errno;
> >> +
> >> +	res = fsconfig(fsfd, FSCONFIG_SET_FLAG, opt, NULL, 0);
> >> +	if (res == -1) {
> >> +		save_errno = errno;
> >> +		fprintf(stderr, "fuse: fsconfig SET_FLAG %s failed:", opt);
> >> +		log_fsconfig_kmsg(fsfd);
> >> +		return -save_errno;
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >> +static int apply_opt_key_value(int fsfd, char *opt)
> >> +{
> >> +	char *eq;
> >> +	const char *key;
> >> +	const char *value;
> >> +
> >> +	eq = strchr(opt, '=');
> >> +	if (!eq)
> >> +		return apply_opt_flag(fsfd, opt);
> >> +
> >> +	*eq = '\0';
> >> +	key = opt;
> >> +	value = eq + 1;
> >> +
> >> +	if (strcmp(key, "fd") == 0)
> >> +		return apply_opt_fd(fsfd, value);
> >> +
> >> +	return apply_opt_string(fsfd, key, value);
> >> +}
> >> +
> >> +/**
> >> + * Check if an option is a mount attribute (handled by fsmount, not fsconfig)
> >> + */
> >> +static int is_mount_attr_opt(const char *opt)
> >> +{
> >> +	/* These options are mount attributes passed to fsmount(), not fsconfig() */
> >> +	return strcmp(opt, "nosuid") == 0 ||
> >> +	       strcmp(opt, "suid") == 0 ||
> >> +	       strcmp(opt, "nodev") == 0 ||
> >> +	       strcmp(opt, "dev") == 0 ||
> >> +	       strcmp(opt, "noexec") == 0 ||
> >> +	       strcmp(opt, "exec") == 0 ||
> >> +	       strcmp(opt, "noatime") == 0 ||
> >> +	       strcmp(opt, "atime") == 0 ||
> >> +	       strcmp(opt, "nodiratime") == 0 ||
> >> +	       strcmp(opt, "diratime") == 0 ||
> >> +	       strcmp(opt, "relatime") == 0 ||
> >> +	       strcmp(opt, "norelatime") == 0 ||
> >> +	       strcmp(opt, "strictatime") == 0 ||
> >> +	       strcmp(opt, "nostrictatime") == 0 ||
> >> +	       strcmp(opt, "nosymfollow") == 0 ||
> >> +	       strcmp(opt, "symfollow") == 0;
> > 
> > /me wonders if this should be walking the mount_flags array instead of
> > opencoding the strings here?
> 
> Yes, much better, encoded into
> 
> const struct mount_flags mount_flags[] = {
> 	/*   opt              flag        on  safe  fsconfig/fsmount */
> 	{"rw",           MS_RDONLY,        0,  1,    0},  /* fsconfig */
> 	{"ro",           MS_RDONLY,        1,  1,    0},  /* fsconfig */
> 	{"suid",         MS_NOSUID,        0,  0,    1},  /* fsmount  */
> ...
> 
> as preparation patch.

Nice!

--D

> 
> Thanks,
> Bernd
> 
