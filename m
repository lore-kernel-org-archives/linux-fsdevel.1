Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE70B3E5560;
	Thu, 14 May 2026 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769354; cv=none; b=Cz7IVQCjcI3xunLfWHWn5eWka9GvRjdIFwbw/dmtC8QdlmaWvVIBKw02UTQePdilEwIPP/gYqo7KrKXhz10ZDVuu5V6Aau2yxc+86gmiD08ZPC7zj2KMhxv1hdVEurkr4tCzCMWl2lc3xhIMKu39Han0qWAuydRR/vji5BdGZyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769354; c=relaxed/simple;
	bh=f+Jh1i68Nc4cr5Rl0wGjQE6BTToQTG/wdig2KKO73X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iR3uAKtQ3un7PblN0yazNB2BYmWdraawKFGQ26ZsvXzjFH+D99XKAnV7V4p29nPg2e9HX/gpEmju88YGcJ3DlRwQBAOVXRkcqeOhhRzcCekw+ygLRb+vYeUHt6OUcXNJ5b/AUQ3vW1S5Lev4zHUAZwaXHSPKiswnfIM1uyMR6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD46aWMm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD46aWMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6619EC2BCB3;
	Thu, 14 May 2026 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778769354;
	bh=f+Jh1i68Nc4cr5Rl0wGjQE6BTToQTG/wdig2KKO73X0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YD46aWMm+3fcfjV5G2fn0YlfUp7Zb1eFPjs2/Zu9zqF3DuV4Ia7KMLoB9DKEiLUVM
	 FemkoS6jQG3epY9YjRvn358Z+tO1sh4JAu9YQKHkj+aVJXyvIP9U9Z6sH6+I/rviKD
	 A9SFn2Q45eHO9/l3ikeyf4l1LQBLxObl5ckuJP02BiMQSMw5A6Up2l9NqkTzSxE/T9
	 oBIf/RGYxCiVUKAYd+fCKGvne2QrAvrn+8GqBIEuOwHcmCZD3j0oRS5ZYaepdtS0IK
	 /5V5HhTuzFanovKrBlSRJrtAt0u5+1GRwOgI0RUFfaDzO9eAMEaJjNI4GDy8lwGKCo
	 YsBp0NJ24PClg==
Date: Thu, 14 May 2026 07:35:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev,
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 03/33] fuse: make debugging configurable at runtime
Message-ID: <20260514143553.GA9531@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
 <177747205214.4101881.6181001367021214200.stgit@frogsfrogsfrogs>
 <20260513174102.GG9544@frogsfrogsfrogs>
 <e7ef9cbb-2692-409a-b24d-998b18e74324@bsbernd.com>
 <20260513183536.GL9544@frogsfrogsfrogs>
 <5bd3e5b2-af2a-4184-95c1-54ec645a679e@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd3e5b2-af2a-4184-95c1-54ec645a679e@bsbernd.com>

On Wed, May 13, 2026 at 09:44:30PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/13/26 20:35, Darrick J. Wong wrote:
> > On Wed, May 13, 2026 at 07:46:05PM +0200, Bernd Schubert wrote:
> >>
> >>
> >> On 5/13/26 19:41, Darrick J. Wong wrote:
> >>> On Wed, Apr 29, 2026 at 07:24:28AM -0700, Darrick J. Wong wrote:
> >>>> From: Darrick J. Wong <djwong@kernel.org>
> >>>>
> >>>> Use static keys so that we can configure debugging assertions and dmesg
> >>>> warnings at runtime.  By default this is turned off so the cost is
> >>>> merely scanning a nop sled.  However, fuse server developers can turn
> >>>> it on for their debugging systems.
> >>>>
> >>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >>>> ---
> >>>>  fs/fuse/fuse_iomap_i.h |   17 ++++++++++++++---
> >>>>  fs/fuse/Kconfig        |   15 +++++++++++++++
> >>>>  fs/fuse/fuse_iomap.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
> >>>>  3 files changed, 72 insertions(+), 3 deletions(-)
> >>>>
> >>>>
> >>>> diff --git a/fs/fuse/fuse_iomap_i.h b/fs/fuse/fuse_iomap_i.h
> >>>> index b9ab8ce140e8e1..c37a7c5cfc862f 100644
> >>>> --- a/fs/fuse/fuse_iomap_i.h
> >>>> +++ b/fs/fuse/fuse_iomap_i.h
> >>>> @@ -8,17 +8,28 @@
> >>>>  
> >>>>  #if IS_ENABLED(CONFIG_FUSE_IOMAP)
> >>>>  #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> >>>> -# define ASSERT(condition) do {						\
> >>>> +
> >>>> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
> >>>> +DECLARE_STATIC_KEY_TRUE(fuse_iomap_debug);
> >>>> +#else
> >>>> +DECLARE_STATIC_KEY_FALSE(fuse_iomap_debug);
> >>>> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
> >>>> +
> >>>> +# define ASSERT(condition) \
> >>>> +while (static_branch_unlikely(&fuse_iomap_debug)) {			\
> >>>>  	int __cond = !!(condition);					\
> >>>>  	if (unlikely(!__cond))						\
> >>>>  		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
> >>>>  	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
> >>>> -} while (0)
> >>>> +	break;								\
> >>>> +}
> >>>>  # define BAD_DATA(condition) ({						\
> >>>>  	int __cond = !!(condition);					\
> >>>>  	if (unlikely(__cond))						\
> >>>>  		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
> >>>> -	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
> >>>> +	if (static_branch_unlikely(&fuse_iomap_debug))			\
> >>>> +		WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
> >>>> +	unlikely(__cond);								\
> >>>>  })
> >>>>  #else
> >>>>  # define ASSERT(condition)
> >>>> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> >>>> index 934d48076a010c..1b8990f1c2a8f9 100644
> >>>> --- a/fs/fuse/Kconfig
> >>>> +++ b/fs/fuse/Kconfig
> >>>> @@ -101,6 +101,21 @@ config FUSE_IOMAP_DEBUG
> >>>>  	  Enable debugging assertions for the fuse iomap code paths and logging
> >>>>  	  of bad iomap file mapping data being sent to the kernel.
> >>>>  
> >>>> +	  Say N here if you don't want any debugging code code compiled in at
> >>>> +	  all.
> >>>> +
> >>>> +config FUSE_IOMAP_DEBUG_BY_DEFAULT
> >>>> +	bool "Debug FUSE file IO over iomap at boot time"
> >>>> +	default n
> >>>> +	depends on FUSE_IOMAP_DEBUG
> >>>> +	help
> >>>> +	  At boot time, enable debugging assertions for the fuse iomap code
> >>>> +	  paths and warnings about bad iomap file mapping data.  This enables
> >>>> +	  fuse server authors to control debugging at runtime even on a
> >>>> +	  distribution kernel while avoiding most of the overhead on production
> >>>> +	  systems.  The setting can be changed at runtime via the debug_iomap
> >>>> +	  module parameter.
> >>>> +
> >>>>  config FUSE_IO_URING
> >>>>  	bool "FUSE communication over io-uring"
> >>>>  	default y
> >>>> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> >>>> index c22c7961cc0bdc..f7a7eba8317c18 100644
> >>>> --- a/fs/fuse/fuse_iomap.c
> >>>> +++ b/fs/fuse/fuse_iomap.c
> >>>> @@ -18,6 +18,49 @@ static bool __read_mostly enable_iomap =
> >>>>  module_param(enable_iomap, bool, 0644);
> >>>>  MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
> >>>>  
> >>>> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
> >>>> +#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
> >>>> +DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
> >>>> +#else
> >>>> +DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
> >>>> +#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
> >>>> +
> >>>> +static int iomap_debug_set(const char *val, const struct kernel_param *kp)
> >>>> +{
> >>>> +	bool now;
> >>>> +	int ret;
> >>>> +
> >>>> +	if (!val)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	ret = kstrtobool(val, &now);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	if (now)
> >>>> +		static_branch_enable(&fuse_iomap_debug);
> >>>> +	else
> >>>> +		static_branch_disable(&fuse_iomap_debug);
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>> +static int iomap_debug_get(char *buffer, const struct kernel_param *kp)
> >>>> +{
> >>>> +	return sprintf(buffer, "%c\n",
> >>>> +		       static_branch_unlikely(&fuse_iomap_debug) ? 'Y' : 'N');
> >>>> +}
> >>>> +
> >>>> +static const struct kernel_param_ops iomap_debug_ops = {
> >>>> +	.set = iomap_debug_set,
> >>>> +	.get = iomap_debug_get,
> >>>
> >>> Codex points out that if we set KERNEL_PARAM_OPS_FL_NOARG in
> >>> kernel_param_ops::flags and teach iomap_debug_set to handle !val as now
> >>> == true, then we can support enabling debugging with
> >>> "modprobe fuse debug_iomap".  That seems reasonable to me, so I'll make
> >>> this minor change.
> >>>
> >>> --D
> >>>
> >>>> +};
> >>>> +
> >>>> +module_param_cb(debug_iomap, &iomap_debug_ops, NULL, 0644);
> >>>> +__MODULE_PARM_TYPE(debug_iomap, "bool");
> >>>> +MODULE_PARM_DESC(debug_iomap, "Enable debugging of fuse iomap");
> >>>> +#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
> >>>> +
> >>>>  bool fuse_iomap_enabled(void)
> >>>>  {
> >>>>  	/* Don't let anyone touch iomap until the end of the patchset. */
> >>>>
> >>>>
> >>
> >>
> >> Hi Darrick,
> >>
> >> would it help to just use debugfs? I will try to find time to send that
> >> out tomorrow.
> >>
> >> https://github.com/bsbernd/linux/commit/5f25afb42ae7bb7ead646cfa3a3683817975ccb9
> >>
> >> (on this branch https://github.com/bsbernd/linux/commits/fuse-debugfs/)
> > 
> > I'm skeptical, because debugfs is disabled in lockdown mode.  Presumably
> > some $enterprise customers might want to turn on the extra logging and
> > assertions even in production?  Some product groups I work with require
> > secureboot even in their dev environments.
> Pity, all we need is a debug-fs that can print some fuse specific
> topics, nothing insecure there.

Welll... debugfs is the place where anything goes, and other drivers use
it to expose deep knobs within the system or even the hardware.  You can
get yourself into a lot of trouble by writing into it, which is why
access is very tightly restricted.

The really pathetic thing with lockdown/secureboot is that distros ship
an even more aggressive version than what Linus has accepted upstream.
They're all deathly afraid that Microsoft will use any excuse to cancel
their code signing accounts and leave them unable to deploy anywhere.
Most hardware come with only Microsoft's keys baked in, which gives them
that ability.  It's absurd that any one entity should have that kind of
power over the software ecosystem. :(

--D
