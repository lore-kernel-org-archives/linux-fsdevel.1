Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AC2FE56A
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700512; cv=none; b=BQkyQ6oTuxgK6LRvUk9UyPIDw602J+BX9LPq0WH7lgHgIDBkGWnGsq7Xi4AaEv6arPT3ZfqCIfkXhFRCaFRkkOLyf9sZiUxNelrHPA0iACi9Jw//TvNp2LftxqFGhz8/78y7JmjXpCefxt8ks2BnoH8tUS/mA0BTlLJMaiB1cDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700512; c=relaxed/simple;
	bh=cQm6/BwMSKw5gvhtk687qtk9//d/yyolZ08yqCtRnwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nc6F/9lFzwAVDCiDdA/InC98+ABG0rv2zxWK/XG99a73uiO30hRb7ff1wUre8UVJUmsYYD6YyNseaHAjxdNSRXAG3J6CVzQcSGYCbyi0OUsBdUjgWtuG0EGH2qmRP0a+QSunOlhxsN/pUAD42AXBlprXqxG5jAUanQz9Gxt8ND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKm4R86o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKm4R86o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E51D5C2BCB4;
	Mon, 20 Apr 2026 15:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776700512;
	bh=cQm6/BwMSKw5gvhtk687qtk9//d/yyolZ08yqCtRnwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UKm4R86oWcbCXK7hkpK0+g9H0MRg2ulzccLn/4yCcRp5UbNBW+sCaF+etru43BK7F
	 ul4Xp76vwufuuUK9R72HoVStSy0WY941oxyyIpvdj+sxQwzPgAsORiTcUCEMIXkTfx
	 m/VgmP+KkooOvs4sMzZoYBRbOPHUBGnJHyLKPqBROwsSPo/auLogKE8pJFUPmgYmEB
	 B16m5pl1ztH9Mljoa6+x9kUPWT64dTnuV22woP8BZT6lQ6qfG8pYzWLlMmfUoVa+j1
	 Xuoh7yZFWl/XTLrwbNTNvhvjwLKBy9WGtl5L40Exq4OyS2EJagydK4j/zr703uWZ/E
	 In3nIa0mgV1iw==
Date: Mon, 20 Apr 2026 08:55:11 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH v2 20/25] Make fusermount work bidirectional for sync init
Message-ID: <20260420155511.GL7727@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-20-b1ca8fcbf60f@bsbernd.com>
 <20260330190315.GA6202@frogsfrogsfrogs>
 <12fd5db1-c1c8-4fe8-b037-6ff0db122633@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12fd5db1-c1c8-4fe8-b037-6ff0db122633@ddn.com>

On Mon, Apr 20, 2026 at 01:18:41AM +0200, Bernd Schubert wrote:
> 
> 
> On 3/30/26 21:03, Darrick J. Wong wrote:
> > On Thu, Mar 26, 2026 at 10:34:53PM +0100, Bernd Schubert wrote:
> >> From: Bernd Schubert <bschubert@ddn.com>
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> ---
> >>  util/fusermount.c | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++---
> >>  util/meson.build  |   2 +-
> >>  2 files changed, 291 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/util/fusermount.c b/util/fusermount.c
> >> index d42e16955f6d26f81e6d2a5acb040b1448e20b51..31bf959024ae0cd2a4e50974589bfab30a100b0a 100644
> >> --- a/util/fusermount.c
> >> +++ b/util/fusermount.c
> >> @@ -11,6 +11,9 @@
> >>  #include "fuse_config.h"
> >>  #include "mount_util.h"
> >>  #include "util.h"
> >> +#if __linux__
> >> +#include "mount_i_linux.h"
> >> +#endif
> >>  
> >>  #include <stdio.h>
> >>  #include <stdlib.h>
> >> @@ -923,6 +926,7 @@ static void free_mount_params(struct mount_params *mp)
> >>  	free(mp->source);
> >>  	free(mp->type);
> >>  	free(mp->mnt_opts);
> >> +	memset(mp, 0, sizeof(*mp));
> >>  }
> >>  
> >>  /*
> >> @@ -1309,6 +1313,171 @@ static int open_fuse_device(const char *dev)
> >>  	return fd;
> >>  }
> >>  
> >> +/*
> >> + * Context for split mount operation (sync-init mode)
> >> + */
> >> +struct mount_context {
> >> +	int fd;
> >> +	const char *dev;
> >> +	struct stat stbuf;
> >> +	char *source;
> >> +	char *mnt_opts;
> >> +	char *x_opts;
> >> +	const char *type;
> >> +};
> >> +
> >> +/*
> >> + * Phase 1: Open device and prepare for mount (sync-init mode)
> >> + * Returns fd on success, -1 on failure
> >> + */
> >> +static int mount_fuse_prepare(const char *mnt, const char *opts,
> >> +			      struct mount_context *ctx)
> >> +{
> >> +	int res;
> >> +	int mountpoint_fd = -1;
> >> +	char *do_mount_opts = NULL;
> >> +	const char *real_mnt = mnt;
> >> +
> >> +	memset(ctx, 0, sizeof(*ctx));
> >> +	ctx->dev = getenv(FUSE_KERN_DEVICE_ENV) ?: FUSE_DEV;
> > 
> > Should this use the helper to figure out the fuse device path?
> 
> I somehow already had that in my branch, must have changed after sent
> the series, don't remember anymore.

No worries.  It's a treewide change, so there's always the possibility
of subsequent "do it here too" patches.  All in a day's work, etc.

--D

> > 
> >> +
> >> +	ctx->fd = open_fuse_device(ctx->dev);
> >> +	if (ctx->fd == -1)
> >> +		return -1;
> >> +
> >> +	drop_privs();
> >> +	read_conf();
> >> +
> >> +	if (getuid() != 0 && mount_max != -1) {
> >> +		int mount_count = count_fuse_fs();
> >> +
> >> +		if (mount_count >= mount_max) {
> >> +			fprintf(stderr,
> >> +				"%s: too many FUSE filesystems mounted; mount_max=N can be set in %s\n",
> >> +				progname, FUSE_CONF);
> >> +			goto fail_close_fd;
> >> +		}
> >> +	}
> >> +
> >> +	res = extract_x_options(opts, &do_mount_opts, &ctx->x_opts);
> >> +	if (res)
> >> +		goto fail_close_fd;
> >> +
> >> +	res = check_perm(&real_mnt, &ctx->stbuf, &mountpoint_fd);
> >> +	restore_privs();
> >> +
> >> +	if (mountpoint_fd != -1)
> >> +		close(mountpoint_fd);
> >> +
> >> +	if (res == -1)
> >> +		goto fail_close_fd;
> >> +
> >> +	free(do_mount_opts);
> >> +	return ctx->fd;
> >> +
> >> +fail_close_fd:
> >> +	close(ctx->fd);
> >> +	free(do_mount_opts);
> >> +	free(ctx->x_opts);
> >> +	ctx->fd = -1;
> >> +	return -1;
> >> +}
> >> +
> >> +#ifdef HAVE_NEW_MOUNT_API
> >> +/*
> >> + * Phase 2: Perform the actual mount using new mount API (sync-init mode)
> >> + * Returns 0 on success, -1 on failure
> >> + */
> >> +static int mount_fuse_finish_fsmount(const char *mnt, const char *opts,
> >> +				     struct mount_context *ctx,
> >> +				     const char **type)
> >> +{
> >> +	int res;
> >> +	char *do_mount_opts = NULL;
> >> +	char *x_prefixed_opts = NULL;
> >> +	struct mount_params mp = {
> >> +		.fd = ctx->fd,
> >> +		.rootmode = ctx->stbuf.st_mode & S_IFMT,
> >> +		.dev = ctx->dev,
> >> +	};
> >> +	char *final_mnt_opts = NULL;
> >> +
> >> +	/* Extract x-options */
> >> +	res = extract_x_options(opts, &do_mount_opts, &x_prefixed_opts);
> > 
> > Didn't we already extract_x_options() in phase 1?  Can we save
> > do_mount_opts in ctx instead of calling this twice?
> 
> Fixed.
> 
> > 
> >> +	if (res)
> >> +		goto fail;
> >> +
> >> +	res = prepare_mount(do_mount_opts, &mp);
> >> +	if (res == -1)
> >> +		goto fail;
> >> +
> >> +	/* Merge x-options if running as root */
> >> +	final_mnt_opts = mp.mnt_opts;
> >> +	if (geteuid() == 0 && ctx->x_opts && strlen(ctx->x_opts) > 0) {
> >> +		size_t mnt_opts_len = strlen(mp.mnt_opts);
> >> +		size_t x_mnt_opts_len = mnt_opts_len + strlen(ctx->x_opts) + 2;
> >> +		char *x_mnt_opts = calloc(1, x_mnt_opts_len);
> >> +
> >> +		if (!x_mnt_opts)
> >> +			goto fail_free_params;
> >> +
> >> +		if (mnt_opts_len) {
> >> +			strcpy(x_mnt_opts, mp.mnt_opts);
> >> +			strncat(x_mnt_opts, ",", 2);
> >> +		}
> >> +		strncat(x_mnt_opts, ctx->x_opts,
> >> +			x_mnt_opts_len - mnt_opts_len - 2);
> > 
> > asprintf?
> 
> Fixed as well.
> 
> 
> Thanks,
> Bernd
> 
