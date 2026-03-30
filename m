Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ACA382F38
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 21:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905517; cv=none; b=UvsMGrzkoiJuiAhgmqD/ELS6uVUyVIZQLqVzkT3hhWMA3GP2w04O0OFJvBNEKk41vUnXtcZ1kKj5YT4KcLJUOryYkczEN9sk+UlQ35+ZGYQ/LzFd5zohdXzZCYEdg699sDHd0ZunxDOK1vH8Ea4GUUzb4bycpR2fzP93khKdm2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905517; c=relaxed/simple;
	bh=wnoeZtLyaziDExS+ZXOt/ckaKsty5nIjB9rrm1pzuaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COO0o6gFQT1nkFD4LuCPjaww5+zknZfmMoEqRKib6rGRYYjjb0XAJAgmhAEvOgHYZEpPR1ciXeMXYEro4btt1ArMV9hcf6KlfEuyebEvykZ6CuaTIVLm4dIO8RbsDtG4Snr73QXgXWNVvbjfgYL2I3iVMz5Bv/wrmBu8yC2SWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvB7JFF4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvB7JFF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4753CC4CEF7;
	Mon, 30 Mar 2026 21:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774905517;
	bh=wnoeZtLyaziDExS+ZXOt/ckaKsty5nIjB9rrm1pzuaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvB7JFF4e+ijFTjt1HcCbqt+E6FjO21E/v51MKV8uChPW+iMzTD590rtq6Z/SRngU
	 1cR0OmT8XeC4SM81We0SwrngAfgwJYRWsK4fUJLX6QdBVM9nHVPQwKxeuyY6oP68vU
	 CLL768s4+dwY13ML8+c+/XNEsZH9t/MTs8jFqyOAkeojRtv1UuH1RgGGOOCH7Jp1rN
	 0mpLBKIKY3RgTTpe/Uv2oax79XsRz+640hQY1K2hf+JJA9Zi0osj1Iue4GZRtfsRYj
	 Qb3NX0afCGhihJEr+i3CPsrnha+d7/y+0X1+41VkFIj4ZqJdcr41Xa+o4oqLet3Xqd
	 3rxGLfV6kahUw==
Date: Mon, 30 Mar 2026 14:18:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd@bsbernd.com" <bernd@bsbernd.com>,
	"miklos@szeredi.hu" <miklos@szeredi.hu>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"joannelkoong@gmail.com" <joannelkoong@gmail.com>
Subject: Re: [PATCH 04/17] mount_service: use the new mount api for the mount
 service
Message-ID: <20260330211836.GE6202@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463189.1008428.16697718096512582220.stgit@frogsfrogsfrogs>
 <2a4afa9c-050e-4867-9dac-e9e87f693f23@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a4afa9c-050e-4867-9dac-e9e87f693f23@ddn.com>

On Mon, Mar 30, 2026 at 09:06:05PM +0000, Bernd Schubert wrote:
> On 3/27/26 02:25, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Use the new fsopen/fsmount system calls to mount the filesystem so that
> > we get somewhat better diagnostics if something gets screwed up.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  meson.build          |   15 +++
> >  util/mount_service.c |  299 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 314 insertions(+)
> > 
> > 
> > diff --git a/meson.build b/meson.build
> > index d6ba8740effd5c..b0988548bf806a 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -130,6 +130,21 @@ special_funcs = {
> >  	int main(int argc, char *argv[]) {
> >            return SD_LISTEN_FDS_START;
> >  	}
> > +    ''',
> > +    'new_mount_api': '''
> > +       #define _GNU_SOURCE
> > +       #include <sys/mount.h>
> > +       #include <linux/mount.h>
> > +       #include <unistd.h>
> > +       #include <fcntl.h>
> > +
> > +       int main(void) {
> > +           int fsfd = fsopen("fuse", FSOPEN_CLOEXEC);
> > +           int res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0);
> > +           int mntfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
> > +           res = move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
> > +           return 0;
> > +       }
> >      '''
> >  }
> >  
> > diff --git a/util/mount_service.c b/util/mount_service.c
> > index ae078e537dc560..4a2c1111b66b91 100644
> > --- a/util/mount_service.c
> > +++ b/util/mount_service.c
> > @@ -65,6 +65,9 @@ struct mount_service {
> >  
> >  	/* O_PATH fd for mount point */
> >  	int mountfd;
> > +
> > +	/* fd for fsopen */
> > +	int fsopenfd;
> >  };
> >  
> >  /* Filter out the subtype of the filesystem (e.g. fuse.Y -> Y) */
> > @@ -87,6 +90,7 @@ static int mount_service_init(struct mount_service *mo, int argc, char *argv[])
> >  	mo->argvfd = -1;
> >  	mo->fusedevfd = -1;
> >  	mo->mountfd = -1;
> > +	mo->fsopenfd = -1;
> >  
> >  	for (i = 0; i < argc; i++) {
> >  		if (!strcmp(argv[i], "-t") && i + 1 < argc) {
> > @@ -690,9 +694,50 @@ static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
> >  		return mount_service_send_reply(mo, error);
> >  	}
> >  
> > +#ifdef HAVE_NEW_MOUNT_API
> > +	/* If this fails we fall back on mount() */
> > +	mo->fsopenfd = fsopen(oc->value, FSOPEN_CLOEXEC);
> > +#endif
> > +
> >  	return mount_service_send_reply(mo, 0);
> >  }
> >  
> > +#ifdef HAVE_NEW_MOUNT_API
> > +/* callers must preserve errno */
> > +static void emit_fsconfig_messages(const struct mount_service *mo)
> > +{
> > +	uint8_t buf[BUFSIZ];
> > +	ssize_t sz;
> > +
> > +	while ((sz = read(mo->fsopenfd, buf, sizeof(buf) - 1)) != -1) {
> > +		if (sz <= 0)
> > +			continue;
> > +		if (buf[sz - 1] == '\n')
> > +			buf[--sz] = '\0';
> > +		else
> > +			buf[sz] = '\0';
> > +
> > +		if (!*buf)
> > +			continue;
> > +
> > +		switch (buf[0]) {
> > +		case 'e':
> > +			fprintf(stderr, "Error: %s\n", buf + 2);
> > +			break;
> > +		case 'w':
> > +			fprintf(stderr, "Warning: %s\n", buf + 2);
> > +			break;
> > +		case 'i':
> > +			fprintf(stderr, "Info: %s\n", buf + 2);
> > +			break;
> > +		default:
> > +			fprintf(stderr, " %s\n", buf);
> > +			break;
> > +		}
> > +	}
> > +}
> > +#endif
> 
> How about unifying that with my series and then use log_fsconfig_kmsg()?
> We can also do it independently, but should not forget to use a common
> function later on. That applies to all these functions for the new mount
> API. Part of the headache I have with my series is that fusermount.c
> duplicates quite some code.
> For me it looks a bit like we can unify most of util/mount_service.c and
> lib/mount_fsmount.c.

<nod> The mount option string parsing (i.e. all that MS_ -> MOUNT_ATTR
translation) and error reporting parts look trivially shareable.
fuse_kern_fsmount isn't so easy to share since the fuse server sends
over all the relevant pieces in separate commands.

> > +
> >  static int mount_service_handle_source_cmd(struct mount_service *mo,
> >  					   const struct fuse_service_packet *p)
> >  {
> > @@ -714,6 +759,21 @@ static int mount_service_handle_source_cmd(struct mount_service *mo,
> >  		return mount_service_send_reply(mo, error);
> >  	}
> >  
> > +#ifdef HAVE_NEW_MOUNT_API
> > +	if (mo->fsopenfd >= 0) {
> > +		int ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_STRING, "source",
> > +			       oc->value, 0);
> > +		if (ret) {
> > +			int error = errno;
> > +
> > +			fprintf(stderr, "%s: fsconfig source: %s\n",
> > +				mo->msgtag, strerror(error));
> > +			emit_fsconfig_messages(mo);
> > +			return mount_service_send_reply(mo, error);
> > +		}
> > +	}
> > +#endif
> > +
> >  	return mount_service_send_reply(mo, 0);
> >  }
> >  
> > @@ -722,6 +782,8 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
> >  {
> >  	struct fuse_service_string_command *oc =
> >  			container_of(p, struct fuse_service_string_command, p);
> > +	char *tokstr = oc->value;
> > +	char *tok, *savetok;
> >  
> >  	if (mo->mntopts) {
> >  		fprintf(stderr, "%s: mount options respecified!\n",
> > @@ -738,6 +800,45 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
> >  		return mount_service_send_reply(mo, error);
> >  	}
> >  
> > +	/* strtok_r mutates tokstr aka oc->value */
> > +	while ((tok = strtok_r(tokstr, ",", &savetok)) != NULL) {
> > +		char *equals = strchr(tok, '=');
> > +		char oldchar = 0;
> > +
> > +		if (equals) {
> > +			oldchar = *equals;
> > +			*equals = 0;
> > +		}
> > +
> > +#ifdef HAVE_NEW_MOUNT_API
> > +		if (mo->fsopenfd >= 0) {
> > +			int ret;
> > +
> > +			if (equals)
> > +				ret = fsconfig(mo->fsopenfd,
> > +					       FSCONFIG_SET_STRING, tok,
> > +					       equals + 1, 0);
> > +			else
> > +				ret = fsconfig(mo->fsopenfd,
> > +					       FSCONFIG_SET_FLAG, tok,
> > +					       NULL, 0);
> > +			if (ret) {
> > +				int error = errno;
> > +
> > +				fprintf(stderr, "%s: set mount option: %s\n",
> > +					mo->msgtag, strerror(error));
> > +				emit_fsconfig_messages(mo);
> > +				return mount_service_send_reply(mo, error);
> > +			}
> > +		}
> > +#endif
> > +
> > +		if (equals)
> > +			*equals = oldchar;
> > +
> > +		tokstr = NULL;
> > +	}
> > +
> >  	return mount_service_send_reply(mo, 0);
> >  }
> >  
> > @@ -875,6 +976,196 @@ static int mount_service_regular_mount(struct mount_service *mo,
> >  	return mount_service_send_reply(mo, 0);
> >  }
> >  
> > +#ifdef HAVE_NEW_MOUNT_API
> > +struct ms_to_mount_map {
> > +	unsigned long ms_flag;
> > +	unsigned int mount_attr_flag;
> > +};
> > +
> > +static const struct ms_to_mount_map attrs[] = {
> > +	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
> > +	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
> > +	{ MS_NODEV,		MOUNT_ATTR_NODEV },
> > +	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
> > +	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
> > +	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
> > +	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
> > +	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
> > +#ifdef MOUNT_ATTR_NOSYMFOLLOW
> > +	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
> > +#endif
> > +	{ 0, 0 },
> > +};
> > +
> > +static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
> > +				 unsigned int *attr_flags,
> > +				 unsigned long *leftover_ms_flags)
> > +{
> > +	const struct ms_to_mount_map *i;
> > +	unsigned int ms_flags = ntohl(oc->ms_flags);
> > +	unsigned int mount_attr_flags = 0;
> > +
> > +	for (i = attrs; i->ms_flag != 0; i++) {
> > +		if (ms_flags & i->ms_flag)
> > +			mount_attr_flags |= i->mount_attr_flag;
> > +		ms_flags &= ~i->ms_flag;
> > +	}
> > +
> > +	*leftover_ms_flags = ms_flags;
> > +	*attr_flags = mount_attr_flags;
> > +}
> > +
> > +struct ms_to_str_map {
> > +	unsigned long ms_flag;
> > +	const char *string;
> > +};
> > +
> > +static const struct ms_to_str_map strflags[] = {
> > +	{ MS_SYNCHRONOUS,	"sync" },
> > +	{ MS_DIRSYNC,		"dirsync" },
> > +	{ MS_LAZYTIME,		"lazytime" },
> > +	{ 0, 0 },
> > +};
> > +
> > +static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
> > +{
> > +	const struct ms_to_str_map *i;
> > +	int ret;
> > +
> > +	for (i = strflags; i->ms_flag != 0; i++) {
> > +		if (!(ms_flags & i->ms_flag))
> > +			continue;
> > +
> > +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
> > +			       NULL, 0);
> > +		if (ret) {
> > +			int error = errno;
> > +
> > +			fprintf(stderr, "%s: set %s option: %s\n",
> > +				mo->msgtag, i->string, strerror(error));
> > +			emit_fsconfig_messages(mo);
> > +
> > +			errno = error;
> > +			return -1;
> > +		}
> > +		ms_flags &= ~i->ms_flag;
> > +	}
> > +
> > +	/*
> > +	 * We can't translate all the supplied MS_ flags into MOUNT_ATTR_ flags
> > +	 * or string flags!  Return a magic code so the caller will fall back
> > +	 * to regular mount(2).
> > +	 */
> > +	return ms_flags ? -2 : 0;
> > +}
> 
> Let's please not forget later on to use the new define.

Er... which new define?  HAVE_NEW_MOUNT_API?  I think we're still inside
the #ifdef for that at this point.

<confused>

--D
