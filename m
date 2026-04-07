Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E711A682F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 23:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775605368; cv=none; b=aaYaEdlrdy1Z/dwJPU1XeI0eWXUQrZy17MG3Cybz8yobl41lAS04SrVaShBKI73lwKFfRDmMZ8/y7ejQBHJcPq0Y+tBpJRCsx/ZQKigeRRFKTuqb51maOMAtF4oDK+ZHJI8TRlJa2bXwdyMmlo17vCixPPec8WJ0jRegIfe1e60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775605368; c=relaxed/simple;
	bh=NDypsz6V7Ov19ZQ3sBKPTVtfBJBJpmaIxLu2BJS/phs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2/HixdpEtN2dqxVrywn6WGEAtVktZIWlH4iojQ2rVo/PeVhXs8HkI8KafWkUwsToF72MUWLn6E59i6iBLlowqnuojZ27Dk6TVUpkQZXuJEpzhsA9vQnDbbbMPWtzrfVKptrLgva4WKVEmNZUhr17ZHmN0+hXLS9tXw/ndQeQjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIW3PN8j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIW3PN8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5C0C116C6;
	Tue,  7 Apr 2026 23:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775605367;
	bh=NDypsz6V7Ov19ZQ3sBKPTVtfBJBJpmaIxLu2BJS/phs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIW3PN8jV1WRMxVEhIAbgLUAoTn+nyNlb7K5MNCew9wB93Jt2soHGhh7afRzlJBXD
	 gh1TtTv+XI/ffPy0ycHVdCHCz/LKBUhgrXUcjy/CMFIISmyVf7PkBCaRXVGaMgTlGx
	 3rfCIM3dTusP9WUiT7lOoMySCZL5bLv0DK4JR6zGqkFCXQtCGoClKECrk7NHJVKg6P
	 cogMvmvgjlRqgy2VxZ11WNlkoQg3VlOxoQhvYfC7jHFFRvj9ZC6vIg6WDTB/E92+DZ
	 w2Xqo9x0JNcJqlpsuSrDLRT32xHGUFjuowvxkFkzqhyy7ECfpFyHc9Mut8wb2wUDpW
	 fNmyZ5+XQYFSw==
Date: Tue, 7 Apr 2026 16:42:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
	neal@gompa.dev, joannelkoong@gmail.com
Subject: Re: [PATCH 05/17] mount_service: update mtab after a successful mount
Message-ID: <20260407234247.GP6202@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463206.1008428.3710251281230290878.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177457463206.1008428.3710251281230290878.stgit@frogsfrogsfrogs>

On Thu, Mar 26, 2026 at 06:26:04PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Update "mtab" so that non-kernel mount options (e.g. "x-fubar=XXX") are
> recorded somewhere so that userspace utilities can pick that up.  Note
> that this likely is not the venerable /etc/mtab, which has been a
> symlink to procfs for years.  On a modern system, these non-kernel
> options end up /run/mount/utab.
> 
> But that's not a detail that libfuse has to worry about directly; it's
> really just calling mount -f(ake) to make the changes it wants.  Old
> hats may remember the use of mount -f to update /etc/mtab after mounting
> the root filesystem.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse_service_priv.h |    1 +
>  lib/mount_common_i.h        |    1 +
>  lib/fuse_service.c          |   15 ++++++++++++++
>  lib/mount.c                 |    7 ++++++
>  util/mount_service.c        |   47 +++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 71 insertions(+)
> 
> 
> diff --git a/include/fuse_service_priv.h b/include/fuse_service_priv.h
> index d1fdd6221b5268..17002249d6a02e 100644
> --- a/include/fuse_service_priv.h
> +++ b/include/fuse_service_priv.h
> @@ -36,6 +36,7 @@ struct fuse_service_memfd_argv {
>  #define FUSE_SERVICE_MNTPT_CMD		0x4d4e5450	/* MNTP */
>  #define FUSE_SERVICE_MOUNT_CMD		0x444f4954	/* DOIT */
>  #define FUSE_SERVICE_BYE_CMD		0x42594545	/* BYEE */
> +#define FUSE_SERVICE_MTABOPTS_CMD	0x4d544142	/* MTAB */
>  
>  /* mount.service sends replies to the fuse server */
>  #define FUSE_SERVICE_OPEN_REPLY		0x46494c45	/* FILE */
> diff --git a/lib/mount_common_i.h b/lib/mount_common_i.h
> index 631dff3e6f8aaf..541cdebae4f47a 100644
> --- a/lib/mount_common_i.h
> +++ b/lib/mount_common_i.h
> @@ -15,6 +15,7 @@ struct mount_opts;
>  char *fuse_mnt_build_source(const struct mount_opts *mo);
>  char *fuse_mnt_build_type(const struct mount_opts *mo);
>  char *fuse_mnt_kernel_opts(const struct mount_opts *mo);
> +char *fuse_mnt_mtab_opts(const struct mount_opts *mo);
>  unsigned int fuse_mnt_flags(const struct mount_opts *mo);
>  
>  
> diff --git a/lib/fuse_service.c b/lib/fuse_service.c
> index 795453693da09b..8076a8b2737574 100644
> --- a/lib/fuse_service.c
> +++ b/lib/fuse_service.c
> @@ -804,6 +804,7 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
>  	char *fstype = fuse_mnt_build_type(se->mo);
>  	char *source = fuse_mnt_build_source(se->mo);
>  	char *mntopts = fuse_mnt_kernel_opts(se->mo);
> +	char *mtabopts = fuse_mnt_mtab_opts(se->mo);
>  	char path[32];
>  	int ret;
>  	int error;
> @@ -871,6 +872,19 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
>  		}
>  	}
>  
> +	if (mtabopts) {
> +		ret = send_string(sf, FUSE_SERVICE_MTABOPTS_CMD, mtabopts,
> +				  &error);
> +		if (ret)
> +			goto out_strings;
> +		if (error) {
> +			fuse_log(FUSE_LOG_ERR, "fuse: service fs mtab options: %s\n",
> +				 strerror(error));
> +			ret = -error;
> +			goto out_strings;
> +		}
> +	}
> +
>  	ret = send_mount(sf, fuse_mnt_flags(se->mo), expected_fmt, &error);
>  	if (ret)
>  		goto out_strings;
> @@ -889,6 +903,7 @@ int fuse_service_session_mount(struct fuse_service *sf, struct fuse_session *se,
>  	opts->foreground = 1;
>  
>  out_strings:
> +	free(mtabopts);
>  	free(mntopts);
>  	free(source);
>  	free(fstype);
> diff --git a/lib/mount.c b/lib/mount.c
> index 2018172ae570f0..ce8f58450827ce 100644
> --- a/lib/mount.c
> +++ b/lib/mount.c
> @@ -758,6 +758,13 @@ char *fuse_mnt_kernel_opts(const struct mount_opts *mo)
>  	return NULL;
>  }
>  
> +char *fuse_mnt_mtab_opts(const struct mount_opts *mo)
> +{
> +	if (mo->mtab_opts)
> +		return strdup(mo->mtab_opts);
> +	return NULL;
> +}
> +
>  unsigned int fuse_mnt_flags(const struct mount_opts *mo)
>  {
>  	return mo->flags;
> diff --git a/util/mount_service.c b/util/mount_service.c
> index 4a2c1111b66b91..2e541f67277ee5 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -54,6 +54,9 @@ struct mount_service {
>  	/* mount options */
>  	char *mntopts;
>  
> +	/* mtab options */
> +	char *mtabopts;
> +
>  	/* socket fd */
>  	int sockfd;
>  
> @@ -842,6 +845,30 @@ static int mount_service_handle_mntopts_cmd(struct mount_service *mo,
>  	return mount_service_send_reply(mo, 0);
>  }
>  
> +static int mount_service_handle_mtabopts_cmd(struct mount_service *mo,
> +					     const struct fuse_service_packet *p)
> +{
> +	struct fuse_service_string_command *oc =
> +			container_of(p, struct fuse_service_string_command, p);
> +
> +	if (mo->mtabopts) {
> +		fprintf(stderr, "%s: mtab options respecified!\n",
> +			mo->msgtag);
> +		return mount_service_send_reply(mo, EINVAL);
> +	}
> +
> +	mo->mtabopts = strdup(oc->value);
> +	if (!mo->mtabopts) {
> +		int error = errno;
> +
> +		fprintf(stderr, "%s: alloc mtab options string: %s\n",
> +			mo->msgtag, strerror(error));
> +		return mount_service_send_reply(mo, error);
> +	}
> +
> +	return mount_service_send_reply(mo, 0);
> +}
> +
>  static int mount_service_handle_mountpoint_cmd(struct mount_service *mo,
>  					       const struct fuse_service_packet *p)
>  {
> @@ -973,6 +1000,14 @@ static int mount_service_regular_mount(struct mount_service *mo,
>  		return mount_service_send_reply(mo, error);
>  	}
>  
> +	/*
> +	 * The mount succeeded, so we send a positive reply even if the mtab
> +	 * update fails.
> +	 */
> +	if (mo->mtabopts)
> +		fuse_mnt_add_mount(mo->msgtag, mo->source, mo->mountpoint,
> +				   mo->fstype, mo->mtabopts);

Codex complains that we need to preserve the non-mtab mount options in
mtab for legacy systems where /etc/mtab isn't a symlink to
/proc/self/mounts.  I don't think it really matters here because that's
been the case for many years, and you can't mount -o remount a fuse
server anyway.

The primary benefit of the mtab updating code (which seems only to
manage /run/mount/utab these days, btw) is to provide a place to park
x-foo options for userspace programs to pick them up.

--D
