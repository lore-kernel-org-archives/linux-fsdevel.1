Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AB2231832
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770860; cv=none; b=XqdXsDwBXncaml+uaZHtPMo80TLd7korB93kI5qfVtN9uTfbu+KrWK1WLgWD+NCbn1rwcajLQnCEtlPF7qL6xjX9hvp+rlokK9vADTnKuzFdG0Ur3BO5nPKlk+zfyO2AgrRWvn4IrlB0CDtAhzCvh6/7Vu1TORjrogYZJeHOVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770860; c=relaxed/simple;
	bh=AXZs8K35rJACRuxjKrTNrsxYaA3nqKe4gurdsjbdkEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRCQX7LjqZcLn3hNtJ8hYncKmnfJGWqwlF3zhEPnjYEa6YTzY3RnIEmWmLYPi+UTI8vyr05RKRA7glzYM7WRGKJAWBRw1xni5GYSflt5hTEhnlN8cn/XgEtUrSMRd0CCP+wWSabKoE8KV1/X0vREMa6yRYUdzg6tie9nT3AuE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL0fTSZU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL0fTSZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED492C2BCB0;
	Tue, 21 Apr 2026 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776770860;
	bh=AXZs8K35rJACRuxjKrTNrsxYaA3nqKe4gurdsjbdkEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vL0fTSZU+ii/Ac3yRtIoC9f/NctbvERWbOOdH/bh5fgfoqxuj5DoEmXshL7wllXed
	 VXwiFXDpzW+iioSrsLg4I/d2HvvGc8FNafcoRNwYCDEVf2VfvWb+1cCGevziOVdAmN
	 RNgpKYRaXjwouSwW3aqwvgsD+0q+f1Iea0xhVbQcwSvQmMOrbIB9qc02xZ5QreillD
	 go+HmkURz+hNm1IoNfR2CyY1Eq11jeeZq2vguR3b3lmDe4z1bUG3eTl+CGHmCWiTNh
	 tflSP3BKcYt10wCe+/jbY55c2qa2wmiwweIOi9vydDTjgPYWEuVlAh9I+k9v2C4dng
	 DnErn4hwwbcZQ==
Date: Tue, 21 Apr 2026 13:27:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>, 
	"Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <20260420-zuruf-haare-988a63f85290@brauner>
References: <20260417142503.1436446-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417142503.1436446-1-amir73il@gmail.com>

On Fri, Apr 17, 2026 at 04:25:03PM +0200, Amir Goldstein wrote:
> This document is motivated by the ongoing maintenance burden that
> abandoned and untestable filesystems impose on VFS developers, blocking
> infrastructure changes such as folio conversions and iomap migration.
> 
> This week alone, two new filesystems were proposed on linux-fsdevel
> (VMUFAT and FTRFS), highlighting the need for documented guidelines
> that new filesystem authors can refer to before submission.
> 
> Multiple recent discussions on linux-fsdevel have touched on the
> criteria for merging new filesystems and for deprecating old ones,
> covering topics such as modern VFS interface adoption, testability,
> userspace utilities, maintainer commitment, and user base viability.
> 
> Add Documentation/filesystems/adding-new-filesystems.rst describing
> the technical requirements and community expectations for merging a
> new filesystem into the kernel.  The guidelines cover:
> - Alternatives to consider before proposing a new in-kernel filesystem
> - Technical requirements: modern VFS interfaces (iomap, folios,
>   fs_context mount API), testability, and userspace utilities
> - Community expectations: identified maintainers, demonstrated
>   commitment, sustained backing, and a clear user base
> - Ongoing obligations after merging, including the risk of deprecation
>   for unmaintained filesystems
> 
> Link: https://lore.kernel.org/linux-fsdevel/20260411151155.321214-1-adrianmcmenamin@gmail.com/
> Link: https://lore.kernel.org/linux-fsdevel/20260413142357.515792-1-aurelien@hackers.camp/
> Link: https://lore.kernel.org/linux-fsdevel/yndtg2jbj55fzd2kkhsmel4pp5ll5xfvfiaqh24tdct3jiqosd@jzbfzf3rrxrd/
> Link: https://lore.kernel.org/linux-fsdevel/20260124091742.GA43313@macsyma.local/
> Link: https://lore.kernel.org/lkml/20260111140345.3866-1-linkinjeon@kernel.org/
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Theodore Tso <tytso@mit.edu>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Darrick J. Wong <djwong@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Assisted-by: Cursor:claude-4-opus
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

I'm all on board with this. I think this is worth doing and I think we
need a better process than the "just send it and see what sticks" model
and throw the whole community off the cliff at the same time.

> Hi folks,
> 
> I am posting this patch as a placeholder for a TOPIC discussion at LSFMM.
> This is a reoccurring topic on fsdevel and in LSFMM, but I think it is
> worth having, because I do not think we have made a significant progress
> in solving the vfs maintenance burden problem.
> 
> As much as I hate manifests and even more so discussions about
> manifests, I think that having a document like this will at least save
> us some time in writing the bounce emails.
> 
> Please try not to make this a discussion about a legal document!
> 
> Note that LLM has helped me collect the relevant discussions and
> articulate our collective feedbacks into a summary.
> 
> Note that same LLM makes it much easier for random people to
> submit new filesystems, so we may need to work harder in the near
> future on push backs...
> 
> Thanks,
> Amir.
> 
> 
>  .../filesystems/adding-new-filesystems.rst    | 167 ++++++++++++++++++
>  Documentation/filesystems/index.rst           |   1 +
>  2 files changed, 168 insertions(+)
>  create mode 100644 Documentation/filesystems/adding-new-filesystems.rst
> 
> diff --git a/Documentation/filesystems/adding-new-filesystems.rst b/Documentation/filesystems/adding-new-filesystems.rst
> new file mode 100644
> index 0000000000000..2e59b7127c05f
> --- /dev/null
> +++ b/Documentation/filesystems/adding-new-filesystems.rst
> @@ -0,0 +1,167 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _adding_new_filesystems:
> +
> +Adding New Filesystems
> +======================
> +
> +This document describes what is involved in adding a new filesystem to the
> +Linux kernel, over and above the normal submission advice in
> +:ref:`Documentation/process/submitting-patches.rst <submittingpatches>` and
> +:ref:`Documentation/process/submit-checklist.rst <submitchecklist>`.
> +
> +Every filesystem merged into the kernel becomes the collective responsibility
> +of the VFS maintainers and the wider filesystem development community.
> +Experience has shown that filesystems which become unmaintained impose a
> +significant and ongoing burden: they are hard or impossible to test, they
> +block infrastructure changes because someone must update or preserve old APIs
> +for code that nobody is actively looking after, and they accumulate unfixed
> +bugs.  The requirements and expectations described here are informed by this
> +experience and are intended to ensure that new filesystems enter the kernel
> +on a sustainable footing.
> +
> +
> +Do You Need a New In-Kernel Filesystem?
> +---------------------------------------
> +
> +Before proposing a new in-kernel filesystem, consider whether one of the
> +alternatives might be more appropriate.
> +
> + - If an existing in-kernel filesystem covers the same use case, improving it
> +   is generally preferred over adding a new implementation.  The kernel
> +   community favors incremental improvement over parallel implementations.
> +
> + - If the filesystem serves a niche audience or has a small user base, a FUSE
> +   (Filesystem in Userspace) implementation may be a better fit.  FUSE
> +   filesystems avoid the long-term kernel maintenance commitment and can be
> +   developed and released on their own schedule.
> +
> + - If kernel-level performance, reliability, or integration is genuinely
> +   required, make the case explicitly.  Explain who the users are, what the
> +   use case is, and why a FUSE implementation would not be sufficient.
> +
> +
> +Technical Requirements
> +----------------------
> +
> +New filesystems are expected to use current kernel interfaces and practices.

We can be stronger here and use "must" use current kernel interfaces and
practices. There's no need to accept a new filesystem if it would in any
way needlessly prolong the existency of legacy internal apis.

> +Submitting a filesystem built on outdated APIs creates an immediate
> +maintenance debt and is likely to face pushback during review.

"Submitting a filesystem built on outdated APIs creates an unacceptable
maintenance debt."

> +
> +Use modern VFS interfaces
> +  New filesystems should use iomap rather than buffer heads for block mapping
> +  and I/O, folios rather than raw page operations for page cache management,
> +  and the filesystem context API (``fs_context``) for the mount path.  See
> +  ``Documentation/filesystems/iomap/index.rst`` for iomap documentation and
> +  ``Documentation/filesystems/mount_api.rst`` for the mount API.

I think we can compile a list of must-haves.

> +
> +Avoid deprecated interfaces
> +  Do not use interfaces listed in
> +  :ref:`Documentation/process/deprecated.rst <deprecated>`.  If the
> +  filesystem depends on an interface that is being phased out, plan for
> +  conversion before submission.
> +
> +Provide userspace utilities
> +  A ``mkfs`` tool is expected so that the filesystem can be created and used
> +  by testers and users.  A ``fsck`` tool is strongly recommended; while not
> +  strictly required for every filesystem type, the ability to verify
> +  consistency and repair corruption is an important part of a mature
> +  filesystem.
> +
> +Be testable
> +  The filesystem must be testable in a meaningful way.  The
> +  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
> +  framework (also known as xfstests) is the standard testing infrastructure
> +  for Linux filesystems and its use is highly recommended.  At a minimum,
> +  there must be a credible and documented way to test the filesystem and
> +  detect regressions.  When submitting, include a summary of test results
> +  indicating which tests pass, fail, or are not applicable.
> +
> +Provide documentation
> +  A documentation file under ``Documentation/filesystems/`` describing the
> +  filesystem, its on-disk format, mount options, and any notable design
> +  decisions is recommended.
> +
> +
> +Community and Maintainership Expectations
> +-----------------------------------------
> +
> +Merging a filesystem is a long-term commitment.  The kernel community
> +needs confidence that the filesystem will be actively maintained after it
> +is merged.
> +
> +Identified maintainer
> +  The submission must include a ``MAINTAINERS`` entry with at least one
> +  maintainer (``M:``), a mailing list (``L:``), and a git tree (``T:``).
> +  The maintainer is expected to be the primary point of contact for the
> +  filesystem going forward.

Tbh, I'd rather have at least two but given past experiences but
probably not something we need to consistently enforce here.

> +
> +Demonstrated commitment
> +  A track record of maintaining kernel code -- for example, in other
> +  subsystems -- significantly strengthens the case for a new filesystem.
> +  Maintainers who are already known and trusted within the community face
> +  less friction during review.
> +
> +Sustained backing
> +  Major filesystems in Linux have organizational or corporate support behind
> +  their development.  Filesystems that depend entirely on volunteer effort
> +  face higher scrutiny about their long-term viability.
> +
> +Responsiveness
> +  The maintainer is expected to respond to bug reports, address review
> +  feedback, and adapt the filesystem to VFS infrastructure changes such as
> +  folio conversions, iomap migration, and mount API updates.  Unresponsive
> +  maintainership is one of the primary reasons filesystems end up on the
> +  path to deprecation.
> +
> +User base
> +  Clearly describe who the users of this filesystem are and the scale of the
> +  user base.  Filesystems with a very small or unclear user base face a
> +  harder path to acceptance and a higher risk of future deprecation.
> +
> +A practical way to demonstrate many of the qualities above is to maintain the
> +filesystem out-of-tree for a period before requesting a merge.  This shows
> +sustained commitment, builds a visible user base, and gives reviewers
> +confidence that the code and its maintainer will persist after merging.
> +That said, it is recognized that for some filesystems the user base grows
> +significantly only after upstreaming, so a compelling case for expected
> +adoption can substitute for a large existing user base.
> +
> +
> +Submission Process
> +------------------
> +
> +Send patches to the linux-fsdevel mailing list
> +(``linux-fsdevel@vger.kernel.org``).  CC the relevant VFS maintainers as
> +listed in the ``MAINTAINERS`` file under ``FILESYSTEMS (VFS and infrastructure)``.
> +
> +Expect thorough review.  Filesystem code interacts deeply with the VFS, memory
> +management, and block layers, so reviewers will examine the code carefully.
> +Address all review feedback and be prepared for multiple revision cycles.
> +
> +It may be appropriate to mark the filesystem as experimental in its Kconfig
> +help text for the first few releases to set expectations while the code
> +stabilizes in-tree.
> +
> +
> +Ongoing Obligations
> +-------------------
> +
> +Merging is not the finish line.  Maintaining a filesystem in the kernel is an
> +ongoing commitment.
> +
> + - Adapt to VFS infrastructure changes.  The VFS layer evolves continuously;
> +   maintainers are expected to keep up with conversions such as folio
> +   migration, iomap adoption, and mount API updates.
> +
> + - Maintain test coverage.  As test suites evolve, the filesystem's test
> +   results should be kept current.
> +
> + - Handle security issues promptly.  Filesystems parse complex on-disk
> +   structures from potentially untrusted media and must treat security
> +   reports with urgency.
> +
> + - Filesystems that become unmaintained -- where the maintainer stops
> +   responding, infrastructure changes go unadapted, and testing becomes
> +   impossible -- are candidates for deprecation and eventual removal from
> +   the kernel.
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index f4873197587df..10e40cc9cbc9d 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -42,6 +42,7 @@ algorithms work.
>     caching/index
>  
>     porting
> +   adding-new-filesystems
>  
>  Filesystem support layers
>  =========================
> -- 
> 2.53.0
> 
