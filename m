Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D4334C98C
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304899; cv=none; b=pReqfNn8b0B8gaH6VWlee1TQ8k9QS8/SiiG53tfi6cISqMUHs3ZPSoZgiLOQWVEGEwfMSgstUp1s6lk4W336U3Js8kRKXAy7pDmSKZevAfb7VSlV02k7eLE/qq0d52Y7rdU9HktAlaIojqmeNc8uY17ptZHcHB8EJxAQTSGhf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304899; c=relaxed/simple;
	bh=w+t3VNO/24fK3XTxrgvgh5GiLVOFliqwfLA50t5GI3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf+eS+z5BVcEgi+8cQn3/89pu0khripwB2HXtmCQro1KtmeyLKnk8FLY/B3Vxuc2F+0pJmxCQ56AS8Z8i78gvpFVa5XaCxiuY/iUtXI87bd9/g0SSvBUXfjvsZesQlrfNOCTZsJCny0BYbR+hWrna1HKi8zQKuR6G6OEASBPPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr5WtJwV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr5WtJwV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00940C19425;
	Mon, 27 Apr 2026 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777304899;
	bh=w+t3VNO/24fK3XTxrgvgh5GiLVOFliqwfLA50t5GI3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pr5WtJwVsjmhcj6oiS5pkMUHc1Ia8rsjj8yTf6ctKv8yBKek4t57O9XvByDWM6t72
	 KHdoJoYH2FpuGPUzUQatGcxyDXtIVMqLMLHOUAblO9tc08eI9UoAf+opUgAY/ll9Kb
	 iWyJBvDuLIaVFsaJIQLvDBwTCiTHzTIVM8YKhR5ww3iEaankjkbEJHOUzX3kLNGgvT
	 06v6332egjy6tAqBpfqIbNGEFla82U6lxJWzPy50CU5ECfZeU233M/suRwarM5c6ei
	 S6ldaW3tjnLXr5VBfCsHhfDZGaIEotBl0dBNdMCqbiRGXAP1ffwfWFXx+6RJaBIMaW
	 JS/dW06LChhSg==
Date: Mon, 27 Apr 2026 08:48:18 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] docs: add guidelines for submitting new filesystems
Message-ID: <20260427154818.GL7765@frogsfrogsfrogs>
References: <20260422125212.1743006-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422125212.1743006-1-amir73il@gmail.com>

On Wed, Apr 22, 2026 at 02:52:12PM +0200, Amir Goldstein wrote:
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
> 
> Christian,
> 
> I think that the trickle of comments has slowed down to a halt
> and this version should be good to go.
> 
> Thanks,
> Amir.
> 
> Changes since v2:
> - Refine fuzzing clause (jack,djwong)
> - Refine ioctls clause (jaegeuk)
> - Remove new mount API (safinaskar)
> - Use stronger MUST language for technical requirements (brauner)
> 
> Changes since v1: (willy)
> - Prefer plural maintainers
> - Structure of patch series
> - Community engagement
> - Mention ioctls
> - Mention fuzzing
> - Mention netfs
> 
>  .../filesystems/adding-new-filesystems.rst    | 195 ++++++++++++++++++
>  Documentation/filesystems/index.rst           |   1 +
>  2 files changed, 196 insertions(+)
>  create mode 100644 Documentation/filesystems/adding-new-filesystems.rst
> 
> diff --git a/Documentation/filesystems/adding-new-filesystems.rst b/Documentation/filesystems/adding-new-filesystems.rst
> new file mode 100644
> index 0000000000000..a3d0bf16f73a0
> --- /dev/null
> +++ b/Documentation/filesystems/adding-new-filesystems.rst
> @@ -0,0 +1,195 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _adding_new_filesystems:
> +
> +Adding New Filesystems
> +======================
> +
> +This document describes what is involved in adding a new filesystem to the
> +Linux kernel.
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
> +New filesystems must use current kernel interfaces and practices.
> +Submitting a filesystem built on outdated APIs creates an unacceptable
> +maintenance debt and is likely to face pushback during review.
> +
> +Use modern VFS interfaces
> +  Do not use interfaces listed in
> +  :ref:`Documentation/process/deprecated.rst <deprecated>`.
> +
> +  Use folios rather than raw page operations for page cache management and
> +  iomap rather than buffer heads for block mapping and I/O.  See
> +  ``Documentation/filesystems/iomap/index.rst`` for iomap documentation.
> +
> +  Block-based filesystems that need functionality not currently provided by
> +  iomap should be prepared to explain why adding that functionality to iomap
> +  is infeasible, rather than reimplementing their own block mapping layer.
> +
> +  Network filesystems should consider using the netfs library
> +  (``Documentation/filesystems/netfs_library.rst``), or be prepared to explain
> +  why it is not a good fit.
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

It's been known as 'fstests' (without the leading 'x') ever since other
filesystems started using it for their QA.

With that fixed,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


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
> +Identified maintainers
> +  The submission must include a ``MAINTAINERS`` entry with at least one
> +  maintainer (``M:``), a mailing list (``L:``), and a git tree (``T:``).
> +  Having two or more maintainers is strongly preferred so that coverage
> +  does not depend on a single person.  The maintainers are expected to be
> +  the primary points of contact for the filesystem going forward.
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
> +Building your track record
> +  A practical way to demonstrate many of the qualities above is to maintain
> +  the filesystem out-of-tree for a period before requesting a merge.  This
> +  shows sustained commitment, builds a visible user base, and gives reviewers
> +  confidence that the code and its maintainer will persist after merging.
> +  That said, it is recognized that for some filesystems the user base grows
> +  significantly only after upstreaming, so a compelling case for expected
> +  adoption can substitute for a large existing user base.
> +
> +
> +Submission Process
> +------------------
> +
> +This section covers what is specific to filesystem submissions, over and
> +above the normal submission advice in
> +:ref:`Documentation/process/submitting-patches.rst <submittingpatches>` and
> +:ref:`Documentation/process/submit-checklist.rst <submitchecklist>`.
> +
> + - Send patches to the linux-fsdevel mailing list
> +   (``linux-fsdevel@vger.kernel.org``).  CC the relevant VFS maintainers as
> +   listed in the ``MAINTAINERS`` file under
> +   ``FILESYSTEMS (VFS and infrastructure)``.
> +
> + - Structure the submission logically.  It is neither acceptable to send one
> +   large patch containing the entire filesystem, nor is a replay of the full
> +   development history helpful to reviewers.  Instead, split the series by
> +   topic -- for example: superblock and mount handling, inode operations,
> +   directory operations, address space operations, and so on -- so that each
> +   patch is reviewable in isolation.
> +
> + - Separate any filesystem-specific ioctls into their own patches with
> +   dedicated justification.  Interfaces beyond those already common across
> +   other filesystems will receive additional scrutiny because they are hard
> +   to maintain and may conflict with future generic interfaces.
> +
> + - Expect thorough review.  Filesystem code interacts deeply with the VFS,
> +   memory management, and block layers, so reviewers will examine the code
> +   carefully.  Address all review feedback and be prepared for multiple
> +   revision cycles.
> +
> + - It may be appropriate to mark the filesystem as experimental in its Kconfig
> +   help text for the first few releases to set expectations while the code
> +   stabilizes in-tree.
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
> + - Handle security issues and regression promptly.  Both those reported
> +   by ordinary users and those reported by test bots and fuzzing tools.
> +   The filesystem must handle corrupted input gracefully without corrupting
> +   memory, hanging, or crashing the kernel.
> +
> + - Engage with the wider filesystem community.  Participate on linux-fsdevel,
> +   share approaches to common problems, and look for opportunities to reuse
> +   shared infrastructure.  It is inappropriate to develop in isolation on a
> +   private list and surface patches only at merge time.
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
