Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1539731B837;
	Wed, 13 May 2026 17:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694063; cv=none; b=iBBOZ7xmX+n3gilaCna0tUAJWhEWDDdEfZMLYdm6Qc6JP5i3+AvjcrCWZAjRKQ7pvVst/GxTxhmZ+31/CX6MTXtQdXB5xFjP3B/u7Zrj7C8HwL9TKVtjIhK7VqEAJxNZhKlhOgCfOGqg9JIMI0PmVN12lAkySUGEolLOP05V5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694063; c=relaxed/simple;
	bh=jvZ0jyzKsfzShC5Zej8Pg53G1/nGL5aqkT9ZEyvt8o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRtZoXCWoc+Ir78SqO7VPt/QTBXzi27pZw3zo78U8dHfk+8c9Z5/9kes616q6lrYlSbyfG6sqp3kWAvIv2ftqnEmfjYjFJ2Syxw7OfUf4gleQYPPfkwS7gmfTGGZSoShXFD/qoNqTW4YVgm7B/6zBDY/CGCPtkDbEcTYU2AeZLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBiOcu2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBiOcu2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D14C19425;
	Wed, 13 May 2026 17:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778694062;
	bh=jvZ0jyzKsfzShC5Zej8Pg53G1/nGL5aqkT9ZEyvt8o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBiOcu2u7y5puv17skRS1pYXttE2Zht5GdXanwvXClgrhvZMP1lZDcfzbGPMCjEiE
	 G85w0zpp6B01RQ8MKovHQi+mf1NZ3p7nOpSo7tGMb0J+D4oGj+KIHeyE/PIpYMJ6Tt
	 V6gGbhA9NTtn9BfGSk443vg59yQqJHiNAYHz2d2Fsa8TXeYgHdUoTKcDC43FiiT5XO
	 VaKqU6XVeGSyY555ztdMlv374R+dMsW6jOyjbi0r0iM0SqfyK+0wxkXpnI0TQPD2SX
	 /2kNONIeyR7Gc6tB1NvVwhdkYnfw/qbXyYe1AlORjAJVx1XTk3Wl4WmJ1tcVPGUs6Y
	 Sp4U9EVpAJkvw==
Date: Wed, 13 May 2026 10:41:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 03/33] fuse: make debugging configurable at runtime
Message-ID: <20260513174102.GG9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205214.4101881.6181001367021214200.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177747205214.4101881.6181001367021214200.stgit@frogsfrogsfrogs>

On Wed, Apr 29, 2026 at 07:24:28AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Use static keys so that we can configure debugging assertions and dmesg
> warnings at runtime.  By default this is turned off so the cost is
> merely scanning a nop sled.  However, fuse server developers can turn
> it on for their debugging systems.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_iomap_i.h |   17 ++++++++++++++---
>  fs/fuse/Kconfig        |   15 +++++++++++++++
>  fs/fuse/fuse_iomap.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 72 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/fs/fuse/fuse_iomap_i.h b/fs/fuse/fuse_iomap_i.h
> index b9ab8ce140e8e1..c37a7c5cfc862f 100644
> --- a/fs/fuse/fuse_iomap_i.h
> +++ b/fs/fuse/fuse_iomap_i.h
> @@ -8,17 +8,28 @@
>  
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
>  #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> -# define ASSERT(condition) do {						\
> +
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
> +DECLARE_STATIC_KEY_TRUE(fuse_iomap_debug);
> +#else
> +DECLARE_STATIC_KEY_FALSE(fuse_iomap_debug);
> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
> +
> +# define ASSERT(condition) \
> +while (static_branch_unlikely(&fuse_iomap_debug)) {			\
>  	int __cond = !!(condition);					\
>  	if (unlikely(!__cond))						\
>  		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
>  	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
> -} while (0)
> +	break;								\
> +}
>  # define BAD_DATA(condition) ({						\
>  	int __cond = !!(condition);					\
>  	if (unlikely(__cond))						\
>  		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
> -	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
> +	if (static_branch_unlikely(&fuse_iomap_debug))			\
> +		WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
> +	unlikely(__cond);								\
>  })
>  #else
>  # define ASSERT(condition)
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 934d48076a010c..1b8990f1c2a8f9 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -101,6 +101,21 @@ config FUSE_IOMAP_DEBUG
>  	  Enable debugging assertions for the fuse iomap code paths and logging
>  	  of bad iomap file mapping data being sent to the kernel.
>  
> +	  Say N here if you don't want any debugging code code compiled in at
> +	  all.
> +
> +config FUSE_IOMAP_DEBUG_BY_DEFAULT
> +	bool "Debug FUSE file IO over iomap at boot time"
> +	default n
> +	depends on FUSE_IOMAP_DEBUG
> +	help
> +	  At boot time, enable debugging assertions for the fuse iomap code
> +	  paths and warnings about bad iomap file mapping data.  This enables
> +	  fuse server authors to control debugging at runtime even on a
> +	  distribution kernel while avoiding most of the overhead on production
> +	  systems.  The setting can be changed at runtime via the debug_iomap
> +	  module parameter.
> +
>  config FUSE_IO_URING
>  	bool "FUSE communication over io-uring"
>  	default y
> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index c22c7961cc0bdc..f7a7eba8317c18 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -18,6 +18,49 @@ static bool __read_mostly enable_iomap =
>  module_param(enable_iomap, bool, 0644);
>  MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
>  
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
> +DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
> +#else
> +DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
> +
> +static int iomap_debug_set(const char *val, const struct kernel_param *kp)
> +{
> +	bool now;
> +	int ret;
> +
> +	if (!val)
> +		return -EINVAL;
> +
> +	ret = kstrtobool(val, &now);
> +	if (ret)
> +		return ret;
> +
> +	if (now)
> +		static_branch_enable(&fuse_iomap_debug);
> +	else
> +		static_branch_disable(&fuse_iomap_debug);
> +
> +	return 0;
> +}
> +
> +static int iomap_debug_get(char *buffer, const struct kernel_param *kp)
> +{
> +	return sprintf(buffer, "%c\n",
> +		       static_branch_unlikely(&fuse_iomap_debug) ? 'Y' : 'N');
> +}
> +
> +static const struct kernel_param_ops iomap_debug_ops = {
> +	.set = iomap_debug_set,
> +	.get = iomap_debug_get,

Codex points out that if we set KERNEL_PARAM_OPS_FL_NOARG in
kernel_param_ops::flags and teach iomap_debug_set to handle !val as now
== true, then we can support enabling debugging with
"modprobe fuse debug_iomap".  That seems reasonable to me, so I'll make
this minor change.

--D

> +};
> +
> +module_param_cb(debug_iomap, &iomap_debug_ops, NULL, 0644);
> +__MODULE_PARM_TYPE(debug_iomap, "bool");
> +MODULE_PARM_DESC(debug_iomap, "Enable debugging of fuse iomap");
> +#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
> +
>  bool fuse_iomap_enabled(void)
>  {
>  	/* Don't let anyone touch iomap until the end of the patchset. */
> 
> 
