Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB44C3D1CAA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863116; cv=none; b=Zn3L1kBRLaf6ndXFSqLOiTQS/nfOP5PcT7xJwy1Z9th7CTh/ndPl4TZRpUNPNFG37SWFvsqLqI+e8tr0Kd7T8/jzAYziGbpzPLShTpd6YhSIAJhKGM7wyPMQlh4IktKXmXDrE5Hn9sP4N+Bj+LWO1NXocMXqcRDd6xylrXTtsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863116; c=relaxed/simple;
	bh=7iYFAgLgvoK/hDgKBka77baolupPdOiBKIKlAwpYdHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjXvcBXOWRvPBAvr+9aSow3zRomzFJJiQldbUciU3bSdEoZWnDK8xhJrQ6vDu+7La7YZ3QnA6hZpcx5rsNN0lwFoyEranSYisgHrMDx1pQE6eyK8L69b+30QHiEPKMX3n6D4DuVRHPreZBbdkiz66v/7xkuvJMHT0ntqrgM0eBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R62+7dKZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=liCN2eNP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h0hKPmNq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wj5S91NQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R62+7dKZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="liCN2eNP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h0hKPmNq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wj5S91NQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC9715BCFC;
	Wed, 22 Apr 2026 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776863107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKKbCQ97Jn85mSKgZUdwhVGwcosbuChEbovMiT4lnLo=;
	b=R62+7dKZON4k7d9qtz0nmcaeOix0nDVBiKN4E1rDn5eHLKQzfWtd9vQFtUQGe8MISVSRyV
	zJ+EknDPcExjhYG3pI+gUjuqYIRSdQrQpnDFr0syCM5Yio6o+hAX5brI6GTz8ZJL08Lu0J
	LZZE3T+0W2kuCPI6G8/Lk6NsaalaqOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776863107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKKbCQ97Jn85mSKgZUdwhVGwcosbuChEbovMiT4lnLo=;
	b=liCN2eNPZ5m379F5ebFwJmhztsc8aRPEE/A06xpwltiq3vtjvPZ2OPQ/0dCtXbxIesn2zn
	drra7BnoJplozzDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h0hKPmNq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Wj5S91NQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776863102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKKbCQ97Jn85mSKgZUdwhVGwcosbuChEbovMiT4lnLo=;
	b=h0hKPmNqe2sS1ud+JToISSbGkD+r/mBy2T2dHb2gt5ZqQ1+vT94OSiKsr9iEgZUCOOZfMl
	5mFG46l2DlyHQvj6vHZE/BgMFam2pj4UyM5mOz6cPQoURcX9TQCRwJwLmFJRFAeMVcBbaL
	CIzdz94d5bEN4kXUhQcP7Lm6sY2vgfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776863102;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zKKbCQ97Jn85mSKgZUdwhVGwcosbuChEbovMiT4lnLo=;
	b=Wj5S91NQA2Flo1duSy5wEEayJMvHhuTblB6YYJRuo4/zo68s5k+On5HrrzEzkk06CfW/wm
	ah6KNUZJLxksd3Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFABF593AF;
	Wed, 22 Apr 2026 13:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LWvFLn7H6GlKEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 13:05:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 85A57A0B44; Wed, 22 Apr 2026 15:04:54 +0200 (CEST)
Date: Wed, 22 Apr 2026 15:04:54 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3] docs: add guidelines for submitting new filesystems
Message-ID: <il4uiigt6luo6nmuwhnqauzalyoxd2oadifbn3lafzrb7s5hmd@n74s5olh6xgi>
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MAILSPIKE_FAIL(0.00)[2a07:de40:b281:104:10:150:64:97:query timed out];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.com:email,linux.org.uk:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,lst.de:email]
X-Rspamd-Queue-Id: CC9715BCFC
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Wed 22-04-26 14:52:12, Amir Goldstein wrote:
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

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
