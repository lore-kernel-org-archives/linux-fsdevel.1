Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AC53A7F59;
	Wed, 13 May 2026 18:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697338; cv=none; b=G7n/j4ppSk4AnHeMaDeH1nKvSuZD8F+IWJDyf6Uo93jIRz9nIKuUc6Qq1QfJHmH9x2UaRalyck8Nl7PCquXBnPK8N8omyIVbVEdg9SqwDecnXkejpCzSlNr7fhWYqMUmzp1/+hm+wtS5s34pczLdCy/9WaOTMY+eBl58FDzY1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697338; c=relaxed/simple;
	bh=qYLu0Buk6tnMRChOdeK2zf0IRezGPCHTaNltKYW0FwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByPswfrQb1QrGYBXJqH8HKRYcH5wT1m0mqGePLGQvd08xFvVdS4LyS21xo2WuhDHhcDPrxbT8veF8bDCRbKbrBfR3NBhfhDzKjlOyfGD2AETvFqENF8kr+2SutAhytHDPmeOjW2NJ8knto2zPK79c04rELG4NraMw4RZAmp+efw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+89ZVDt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+89ZVDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B09C19425;
	Wed, 13 May 2026 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778697338;
	bh=qYLu0Buk6tnMRChOdeK2zf0IRezGPCHTaNltKYW0FwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H+89ZVDtAtyvIeTL/W7Qj/QsVGuPWndwRZPY8hVUhB+CO46sU7Gr2q29CXUYtBVe0
	 BuQqy/gSplGTI37RU9K4s+PpIgojCp3qcwpTVFWLnh21cDIwSnq9rAPw0V8LRLH9e8
	 OJFRTn64tbrTu1a/TzvykxuTTuX8MlPZqjPw289hzu4iXorC2FyuX2I6TSK8T3NKGq
	 tsjaYTKfS7+2BYlT9wQH+88jmeG2OBL3UBt2IasEfiTYdCXSmoAqs3nOTcAPrEeZiF
	 dx3zFJZ22msplmh2Gx8yKwbTQ27JDNwZ+VgcNDdtnp47zecQNJNC1vb/PaYXVyscAu
	 2nuPAvH9GpW6A==
Date: Wed, 13 May 2026 11:35:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 03/33] fuse: make debugging configurable at runtime
Message-ID: <20260513183536.GL9544@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205214.4101881.6181001367021214200.stgit@frogsfrogsfrogs>
 <20260513174102.GG9544@frogsfrogsfrogs>
 <e7ef9cbb-2692-409a-b24d-998b18e74324@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ef9cbb-2692-409a-b24d-998b18e74324@bsbernd.com>

On Wed, May 13, 2026 at 07:46:05PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/13/26 19:41, Darrick J. Wong wrote:
> > On Wed, Apr 29, 2026 at 07:24:28AM -0700, Darrick J. Wong wrote:
> >> From: Darrick J. Wong <djwong@kernel.org>
> >>
> >> Use static keys so that we can configure debugging assertions and dmesg
> >> warnings at runtime.  By default this is turned off so the cost is
> >> merely scanning a nop sled.  However, fuse server developers can turn
> >> it on for their debugging systems.
> >>
> >> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >> ---
> >>  fs/fuse/fuse_iomap_i.h |   17 ++++++++++++++---
> >>  fs/fuse/Kconfig        |   15 +++++++++++++++
> >>  fs/fuse/fuse_iomap.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 72 insertions(+), 3 deletions(-)
> >>
> >>
> >> diff --git a/fs/fuse/fuse_iomap_i.h b/fs/fuse/fuse_iomap_i.h
> >> index b9ab8ce140e8e1..c37a7c5cfc862f 100644
> >> --- a/fs/fuse/fuse_iomap_i.h
> >> +++ b/fs/fuse/fuse_iomap_i.h
> >> @@ -8,17 +8,28 @@
> >>  
> >>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
> >>  #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> >> -# define ASSERT(condition) do {						\
> >> +
> >> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
> >> +DECLARE_STATIC_KEY_TRUE(fuse_iomap_debug);
> >> +#else
> >> +DECLARE_STATIC_KEY_FALSE(fuse_iomap_debug);
> >> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
> >> +
> >> +# define ASSERT(condition) \
> >> +while (static_branch_unlikely(&fuse_iomap_debug)) {			\
> >>  	int __cond = !!(condition);					\
> >>  	if (unlikely(!__cond))						\
> >>  		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
> >>  	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
> >> -} while (0)
> >> +	break;								\
> >> +}
> >>  # define BAD_DATA(condition) ({						\
> >>  	int __cond = !!(condition);					\
> >>  	if (unlikely(__cond))						\
> >>  		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
> >> -	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
> >> +	if (static_branch_unlikely(&fuse_iomap_debug))			\
> >> +		WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
> >> +	unlikely(__cond);								\
> >>  })
> >>  #else
> >>  # define ASSERT(condition)
> >> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> >> index 934d48076a010c..1b8990f1c2a8f9 100644
> >> --- a/fs/fuse/Kconfig
> >> +++ b/fs/fuse/Kconfig
> >> @@ -101,6 +101,21 @@ config FUSE_IOMAP_DEBUG
> >>  	  Enable debugging assertions for the fuse iomap code paths and logging
> >>  	  of bad iomap file mapping data being sent to the kernel.
> >>  
> >> +	  Say N here if you don't want any debugging code code compiled in at
> >> +	  all.
> >> +
> >> +config FUSE_IOMAP_DEBUG_BY_DEFAULT
> >> +	bool "Debug FUSE file IO over iomap at boot time"
> >> +	default n
> >> +	depends on FUSE_IOMAP_DEBUG
> >> +	help
> >> +	  At boot time, enable debugging assertions for the fuse iomap code
> >> +	  paths and warnings about bad iomap file mapping data.  This enables
> >> +	  fuse server authors to control debugging at runtime even on a
> >> +	  distribution kernel while avoiding most of the overhead on production
> >> +	  systems.  The setting can be changed at runtime via the debug_iomap
> >> +	  module parameter.
> >> +
> >>  config FUSE_IO_URING
> >>  	bool "FUSE communication over io-uring"
> >>  	default y
> >> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> >> index c22c7961cc0bdc..f7a7eba8317c18 100644
> >> --- a/fs/fuse/fuse_iomap.c
> >> +++ b/fs/fuse/fuse_iomap.c
> >> @@ -18,6 +18,49 @@ static bool __read_mostly enable_iomap =
> >>  module_param(enable_iomap, bool, 0644);
> >>  MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
> >>  
> >> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> >> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
> >> +DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
> >> +#else
> >> +DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
> >> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
> >> +
> >> +static int iomap_debug_set(const char *val, const struct kernel_param *kp)
> >> +{
> >> +	bool now;
> >> +	int ret;
> >> +
> >> +	if (!val)
> >> +		return -EINVAL;
> >> +
> >> +	ret = kstrtobool(val, &now);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (now)
> >> +		static_branch_enable(&fuse_iomap_debug);
> >> +	else
> >> +		static_branch_disable(&fuse_iomap_debug);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int iomap_debug_get(char *buffer, const struct kernel_param *kp)
> >> +{
> >> +	return sprintf(buffer, "%c\n",
> >> +		       static_branch_unlikely(&fuse_iomap_debug) ? 'Y' : 'N');
> >> +}
> >> +
> >> +static const struct kernel_param_ops iomap_debug_ops = {
> >> +	.set = iomap_debug_set,
> >> +	.get = iomap_debug_get,
> > 
> > Codex points out that if we set KERNEL_PARAM_OPS_FL_NOARG in
> > kernel_param_ops::flags and teach iomap_debug_set to handle !val as now
> > == true, then we can support enabling debugging with
> > "modprobe fuse debug_iomap".  That seems reasonable to me, so I'll make
> > this minor change.
> > 
> > --D
> > 
> >> +};
> >> +
> >> +module_param_cb(debug_iomap, &iomap_debug_ops, NULL, 0644);
> >> +__MODULE_PARM_TYPE(debug_iomap, "bool");
> >> +MODULE_PARM_DESC(debug_iomap, "Enable debugging of fuse iomap");
> >> +#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
> >> +
> >>  bool fuse_iomap_enabled(void)
> >>  {
> >>  	/* Don't let anyone touch iomap until the end of the patchset. */
> >>
> >>
> 
> 
> Hi Darrick,
> 
> would it help to just use debugfs? I will try to find time to send that
> out tomorrow.
> 
> https://github.com/bsbernd/linux/commit/5f25afb42ae7bb7ead646cfa3a3683817975ccb9
> 
> (on this branch https://github.com/bsbernd/linux/commits/fuse-debugfs/)

I'm skeptical, because debugfs is disabled in lockdown mode.  Presumably
some $enterprise customers might want to turn on the extra logging and
assertions even in production?  Some product groups I work with require
secureboot even in their dev environments.

--D

> 
> Thanks,
> Bernd
> 
> Thanks,
> Bernd
> 
> 
