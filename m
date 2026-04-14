Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6C38424D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 23:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776211116; cv=none; b=d9jQMx7UicxOjv/IU4/vQAKrs65ADoIyEqBJUrVBbDxo6xLsTK/OFBlMHxxHfQyKgeUE0ROwQmvaDzxHJFozLK5azfyYxVfAgQS4aN3MIPPW3MsgwaAWsluKxHQhv0ubmHOIP6gHTs/3Ku6OODFifwG03ymTVOUTYmqftnXruKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776211116; c=relaxed/simple;
	bh=v/OgGfgRPpbITqjocX/o2f0PDQwtRFi2ShcXRbp8Dg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBJzgR99DLtedh2XJPnNXYPBWGhJh2wju4bHkdxzCcVaYey30DeMh6mzP7DCjKZQruK+heQQG2K+HceED4ThyKBLHgygIntKD2LqJVUIBFZxKy3HC1co6/D2JnpY9rRfHfc58c8XdEwGyEzYV6kbEyO8TWZWSVuDPsWYH1ZodgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbppLJ3l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbppLJ3l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C390FC19425;
	Tue, 14 Apr 2026 23:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776211115;
	bh=v/OgGfgRPpbITqjocX/o2f0PDQwtRFi2ShcXRbp8Dg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FbppLJ3l62LP3IpkWBUqvOpRXPpZBghEq4O5FDDemdW1k9OOGVzyPJjeZ54YGopuy
	 vJ9AfgnnZUhdOYLfRcAXz2xraW+NXV0JW4I/3oNpQXm31RGuZ/IJimYdNr2RlBWRrd
	 VQwvKyeUdengae700ZXb89eS1ihW5ZLz8Xuv4EiDQF+CXgzrqtmir9UjufIZqiMy8C
	 O0BS5eoTRR822zu3A2bAUUVJdX53MD87fGYy4PIzE1wqm/IFA9eoJQO5hXjkKHw+ij
	 5btv6cQe3lHmEjeZZCPX3SRnmtW2RifxdZH5d82gyDLQpJDBYaBysDnosiQAMyossy
	 z0GicwX7njilw==
Date: Tue, 14 Apr 2026 16:58:35 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 03/13] mount_service: create high level fuse helpers
Message-ID: <20260414235835.GG604658@frogsfrogsfrogs>
References: <177577270167.2064074.16504004857564657756.stgit@frogsfrogsfrogs>
 <177577270271.2064074.7122706765827201316.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177577270271.2064074.7122706765827201316.stgit@frogsfrogsfrogs>

On Thu, Apr 09, 2026 at 03:21:20PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a fuse_main wrapper for fuse services.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  include/fuse.h         |   34 +++++++++++++
>  lib/fuse_versionscript |    1 
>  lib/helper.c           |  125 ++++++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 156 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/include/fuse.h b/include/fuse.h
> index 2bc3a9650c7c8b..129c744e39c46a 100644
> --- a/include/fuse.h
> +++ b/include/fuse.h
> @@ -1008,6 +1008,40 @@ static inline int fuse_main_fn(int argc, char *argv[],
>  #define fuse_main(argc, argv, op, user_data) \
>  	fuse_main_fn(argc, argv, op, user_data)
>  
> +#if FUSE_MAKE_VERSION(3, 19) <= FUSE_USE_VERSION
> +struct fuse_service;
> +int fuse_service_main_real_versioned(struct fuse_service *service,
> +				     struct fuse_args *args,
> +				     const struct fuse_operations *op,
> +				     size_t op_size,
> +				     struct libfuse_version *version,
> +				     void *user_data);
> +
> +/**
> + * Same as fuse_service_main_fn, but takes its information from the mount
> + * service context and an fuse_args that has already had fuse_service_append_args
> + * applied to it.
> + */
> +static inline int fuse_service_main_fn(struct fuse_service *service,
> +				       struct fuse_args *args,
> +				       const struct fuse_operations *op,
> +				       void *user_data)
> +{
> +	struct libfuse_version version = {
> +		.major  = FUSE_MAJOR_VERSION,
> +		.minor  = FUSE_MINOR_VERSION,
> +		.hotfix = FUSE_HOTFIX_VERSION,
> +		.padding = FUSE_USE_VERSION,
> +	};
> +
> +	return fuse_service_main_real_versioned(service, args, op,
> +						sizeof(*(op)), &version,
> +						user_data);
> +}
> +#define fuse_service_main(s, args, op, user_data) \
> +	fuse_service_main_fn(s, args, op, user_data)
> +#endif /* FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 19) */
> +
>  /* ----------------------------------------------------------- *
>   * More detailed API					       *
>   * ----------------------------------------------------------- */
> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> index aa1912c76fb715..fc37931b475bdf 100644
> --- a/lib/fuse_versionscript
> +++ b/lib/fuse_versionscript
> @@ -236,6 +236,7 @@ FUSE_3.19 {
>  		fuse_service_exit;
>  		fuse_service_expect_mount_mode;
>  		fuse_service_finish_file_requests;
> +		fuse_service_main_real_versioned;
>  		fuse_service_parse_cmdline_opts;
>  		fuse_service_receive_file;
>  		fuse_service_release;
> diff --git a/lib/helper.c b/lib/helper.c
> index 819b9a6e4d243c..a2b3cc617bca54 100644
> --- a/lib/helper.c
> +++ b/lib/helper.c
> @@ -15,6 +15,7 @@
>  #include "fuse_misc.h"
>  #include "fuse_opt.h"
>  #include "fuse_lowlevel.h"
> +#include "fuse_service.h"
>  #include "mount_util.h"
>  
>  #include <stdio.h>
> @@ -365,6 +366,126 @@ int fuse_daemonize(int foreground)
>  	return 0;
>  }
>  
> +struct fuse *_fuse_new_31(struct fuse_args *args,
> +		       const struct fuse_operations *op, size_t op_size,
> +		       struct libfuse_version *version,
> +		       void *user_data);
> +
> +int fuse_service_main_real_versioned(struct fuse_service *service,
> +				     struct fuse_args *args,
> +				     const struct fuse_operations *op,
> +				     size_t op_size,
> +				     struct libfuse_version *version,
> +				     void *user_data)
> +{
> +	struct fuse *fuse;
> +	struct fuse_cmdline_opts opts;
> +	int res;
> +	struct fuse_loop_config *loop_config = NULL;
> +
> +	if (fuse_service_parse_cmdline_opts(args, &opts) != 0) {
> +		res = 1;
> +		goto out0;
> +	}
> +
> +	if (opts.show_version) {
> +		printf("FUSE library version %s\n", PACKAGE_VERSION);
> +		fuse_lowlevel_version();
> +		res = 0;
> +		goto out1;
> +	}
> +
> +	if (opts.show_help) {
> +		if (args->argv[0][0] != '\0')
> +			printf("usage: %s [options] <mountpoint>\n\n",
> +			       args->argv[0]);
> +		printf("FUSE options:\n");
> +		fuse_cmdline_help();
> +		fuse_lib_help(args);
> +		res = 0;
> +		goto out1;
> +	}
> +
> +	if (!opts.show_help &&
> +	    !opts.mountpoint) {
> +		fuse_log(FUSE_LOG_ERR, "error: no mountpoint specified\n");
> +		res = 2;
> +		goto out1;
> +	}
> +
> +	fuse = _fuse_new_31(args, op, op_size, version, user_data);
> +	if (fuse == NULL) {
> +		res = 3;
> +		goto out1;
> +	}
> +
> +	if (fuse_service_session_mount(service, fuse_get_session(fuse),

Just use @se below.

> +				       0, &opts) != 0) {
> +		res = 4;
> +		goto out2;
> +	}
> +
> +	/* No need to fork when running as a systemd service */
> +	if (fuse_daemonize(1) != 0) {

I'll change fuse_service_session_mount to do the chdir("/") call and
then we can skip this call entirely.

> +		res = 5;
> +		goto out3;
> +	}
> +
> +	struct fuse_session *se = fuse_get_session(fuse);
> +
> +	if (fuse_set_signal_handlers(se) != 0) {
> +		res = 6;
> +		goto out3;
> +	}
> +
> +	if (opts.singlethread) {
> +		fuse_service_send_goodbye(service, 0);
> +		fuse_service_release(service);
> +
> +		res = fuse_loop(fuse);
> +	} else {
> +		loop_config = fuse_loop_cfg_create();
> +		if (loop_config == NULL) {

Put this fallible call before fuse_service_session_mount and then we
don't have to call fuse_service_session_unmount to back this out.

> +			res = 7;
> +			goto out4;
> +		}
> +
> +		fuse_loop_cfg_set_clone_fd(loop_config, opts.clone_fd);
> +
> +		fuse_loop_cfg_set_idle_threads(loop_config, opts.max_idle_threads);
> +		fuse_loop_cfg_set_max_threads(loop_config, opts.max_threads);
> +
> +		fuse_service_send_goodbye(service, 0);
> +		fuse_service_release(service);
> +
> +		res = fuse_loop_mt(fuse, loop_config);
> +	}
> +	if (res)
> +		res = 8;
> +
> +	/*
> +	 * We've released the mount service helper, so we can't ask it to
> +	 * unmount the filesystem.  In other words, once mount() succeeds,
> +	 * the user has to unmount the filesystem.
> +	 */
> +	fuse_remove_signal_handlers(se);
> +	goto out2;
> +
> +out4:
> +	fuse_remove_signal_handlers(se);

Not needing the fuse_service_session_unmount call makes this cleanup
code become much simpler.

--D

> +out3:
> +	fuse_service_session_unmount(service);
> +out2:
> +	fuse_destroy(fuse);
> +out1:
> +	fuse_loop_cfg_destroy(loop_config);
> +	free(opts.mountpoint);
> +out0:
> +	fuse_service_send_goodbye(service, res);
> +	fuse_service_release(service);
> +	return res;
> +}
> +
>  int fuse_main_real_versioned(int argc, char *argv[],
>  			     const struct fuse_operations *op, size_t op_size,
>  			     struct libfuse_version *version, void *user_data)
> @@ -403,10 +524,6 @@ int fuse_main_real_versioned(int argc, char *argv[],
>  		goto out1;
>  	}
>  
> -	struct fuse *_fuse_new_31(struct fuse_args *args,
> -			       const struct fuse_operations *op, size_t op_size,
> -			       struct libfuse_version *version,
> -			       void *user_data);
>  	fuse = _fuse_new_31(&args, op, op_size, version, user_data);
>  	if (fuse == NULL) {
>  		res = 3;
> 
> 
