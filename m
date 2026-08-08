Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EAA1E515
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191450; cv=none; b=gMnIn8+CQ8mzX83YM9HG2Z9iJQMarCxoO8uSMo7hEEn4vKwgeUj/IfIJAhpIPnyobb3kQbY1ZDAwvtTynd/ofd9vKU4ok0ovTwuX7LKci+gbOXQ/1fk/KLOvdJNX3Haz9jhPQq3kSbFpOYU+tqH1iEt/WHcn66xg5/m9NDRU0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191450; c=relaxed/simple;
	bh=yDwjzzEbuiM6wB+WtF0hVasVFv6zj1AqzogotjFtUu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqKYgVorgFZnySNQdbUnDS0DYKVsQDnSkKZPHID8tfa2I/4409be6t7mcp+PjS9vB30UIeLXBh6adHBWlQMd2mrNZWrOqvMi0jNo20Byfwth+FBz/h+51jvQ4+2sHOuQ3Bgliw67ti40tpdWStkGeTxawMYsBmG3t27hj5614ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=njcPzkbS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fLyELjvD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=szDHY6tG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2pLjEvFU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="njcPzkbS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fLyELjvD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="szDHY6tG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2pLjEvFU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D21780C9F;
	Sat,  8 Aug 2026 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786191436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qehbiy1CA3dVi+qrouYSN8RlLNI21IoWPgUv6jKFe1I=;
	b=njcPzkbS0nKgRDOBCsdQIenwyxVtbRlSK9B5DVZYgJWkzImM7S1LllkbDYM6gbbcKIdqgL
	Ehs3mfw+EOFTMqatGyTwpQqOrk+7qq5rRoIoFZ5AvjR/cYru0qaJ8NXCR4Fq1nmJJoqcqv
	4DNtOEOuNYfJn1muVxdYiktHr4jJRkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786191436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qehbiy1CA3dVi+qrouYSN8RlLNI21IoWPgUv6jKFe1I=;
	b=fLyELjvD93ELzIVUiQ8WkqFGzUn+2y/TzzCYR1Bzr21ktKzXAnWJo05gyh/94PHWOegqyl
	gI1U5S8u+LffBMDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786191432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qehbiy1CA3dVi+qrouYSN8RlLNI21IoWPgUv6jKFe1I=;
	b=szDHY6tGcKNdlx+XCa3JpjfYzpM8qXs5G3UIEjU1r3D5XDWDftLOO10ZPw5aJ44Mbzpctu
	Gv6AXnvX8HLukjxneIRmwxAAs2R3rATCO2JFM7P52cuGwLoaHJaknh7OAOoizveW0IjMak
	XyzncoIYxVq9hdyJdiq0slSWfQizBY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786191432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qehbiy1CA3dVi+qrouYSN8RlLNI21IoWPgUv6jKFe1I=;
	b=2pLjEvFUvZWrNHgNf0whLMKpoP5aV2f5ClQ/BhXmRfnniLBG/nWHVH+CJswb1J1/I1hgex
	eek3pPHSvuGrxvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82BE7779B2;
	Sat,  8 Aug 2026 12:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k29KHEced2rBTAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Sat, 08 Aug 2026 12:17:11 +0000
Date: Sat, 8 Aug 2026 13:17:09 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: vova tokarev <vladimirelitokarev@gmail.com>
Cc: akpm@linux-foundation.org, security@kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: BadBunny: UFFDIO_COPY shmem killpriv bypass leading to
 local privilege escalation
Message-ID: <ancYCBUT8aB0qHwz@pedro-suse.lan>
References: <CAGBKPgOm8q-8_rwyRPEmSj8JXdh_GaK1Q8vpJ=j-+yA0SgcNQw@mail.gmail.com>
 <CAGBKPgPPALX_5CQJAKUNjwi2fD28pBeS5pRuwQgePU93pOy8EA@mail.gmail.com>
 <anXnHMInq_JLYbWc@pedro-suse.lan>
 <CAGBKPgOfbMJruqcegJca6BBpEtpd91s5ASF_VU+gucWsjwp8WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGBKPgOfbMJruqcegJca6BBpEtpd91s5ASF_VU+gucWsjwp8WA@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

I'm adding a bunch of fs people that might have opinions about this. Please
see the rest of the thread below.

On Sat, Aug 08, 2026 at 12:13:06PM +0300, vova tokarev wrote:
> Pedro,
> 
> Thanks for the review. Let me address both points.
> 
> On the page fault comparison:
> 
> UFFDIO_COPY is not comparable to a page fault. Page faults serve
> existing page cache content (read-like). UFFDIO_COPY adds new,

A page fault can also write to the page cache. On MAP_SHARED mappings.

> 
> user-controlled content to the shmem page cache (write-like).
> 
> The correct comparison is to write(), which calls file_modified()
> 
> -> __remove_privs() to strip SUID/SGID.
> 
> 
> This is exactly the reasoning used when fallocate() was fixed
> 
> across XFS (commit fbe7e5200365), ext4, and f2fs to call
> 
> file_modified(). The XFS commit message says:
> 
> "as various fallocate modes can change the file contents [...]
> 
> we should drop file privileges like suid just like we do for a
> 
> regular write()"

I can't speak for fallocate, or other system calls. As far as I'm aware,
this is a best-effort kind of thing. As I said, writing to a MAP_SHARED
mapping does not clear the setuid bit. It's a super trivial thing to do,
too. But it's not a problem because setuid executables are not world-writable.

I simply don't think this can feasibly be a security boundary, considering
how much it has been historically screwed up, and how the second-most basic
way to write to a file Just Bypasses It. I also don't know a single setuid
program that's packaged as 04777. Do you?

> 
> UFFDIO_COPY on shmem changes file contents.
> 
> It should drop file privileges like suid, just like write().
> 
> 
> On the PoC setup and exploitability:
> 
> The PoC uses mode 04777 for simplicity of demonstration,
> 
> but the underlying bug is a killpriv invariant violation:
> 
> every VFS write path calls file_modified() to strip SUID on
> 
> content modification, but shmem_mfill_filemap_add() does not.
> 
> The killpriv mechanism is defense-in-depth - if file permissions
> 
> alone were sufficient to protect SUID, the kernel wouldn't bother
> 
> stripping SUID on write(). But it does, because writable SUID files
> 
>  do occur in practice (group-writable SUID binaries, POSIX ACLs,
> 
>  container shared mounts, chained with a separate write-access bug).
> 
> 
> For precedent: CVE-2023-0386 (overlayfs copy-up preserving SUID
> 
>  across namespaces) is the same class of bug - a kernel code path
> 
>  that modifies or copies file content without stripping SUID -
> 
> and was scored CVSS 7.8 and added to CISA's KEV catalog.
> 
> The fallocate killpriv fixes were backported to all stable trees.
> 
> 
> Additionally, this path is available even with
> 
> vm.unprivileged_userfaultfd=0, since UFFD_USER_MODE_ONLY
> 
> bypasses the privilege check (userfaultfd_syscall_allowed()
> 
> returns true unconditionally for USER_MODE_ONLY).
> 
> The kernel considers this path safe for unprivileged use,
> 
> yet it skips killpriv.
> 
> 
> *On the fix:*
> 
> Regardless of how we classify severity, the fix is trivial and makes
> 
> UFFDIO_COPY consistent with every other write path -
> 
> add file_modified() to shmem_mfill_filemap_add().
> 
> I'm happy to submit a patch if you'd like.
> 
> 
> Best regards,
> 
> Vladimir
> 
> On Fri, Aug 7, 2026 at 5:14 PM Pedro Falcato <pfalcato@suse.de> wrote:
> 
> > On Fri, Aug 07, 2026 at 01:40:41PM +0300, vova tokarev wrote:
> > > Hi,
> > >
> > > It's been almost two months since I sent this report, and I haven't
> > > heard back. I'd really appreciate any feedback when you get a chance.
> > >
> > > I've rechecked both mainline master and stable 6.12.95 -- the
> > > vulnerability remains unfixed in both trees:
> > >
> > > 1. mm/shmem.c: shmem_mfill_atomic_pte() (6.12) /
> > shmem_mfill_filemap_add()
> > >    (7.x) still adds pages to the page cache without calling
> > file_modified()
> > >    or __remove_privs(). Writing to a SUID binary on tmpfs via UFFDIO_COPY
> > >    preserves the setuid bit.
> > >
> > > 2. mm/userfaultfd.c: I noticed commit 85668fda932a added retry state
> > >    tracking on master, but MFILL_RETRY_STATE_VMA_FLAGS still does not
> > >    include VMA_WRITE_BIT -- the mprotect TOCTOU remains exploitable.
> > >
> > > This is a deterministic local privilege escalation (no race timing
> > > needed for the killpriv bypass), affects every kernel since 4.11
> > > (8+ years), and works on any system with userfaultfd + tmpfs (the
> > > default on virtually all distributions).
> > >
> > > I have a full working PoC that gets uid=0 from uid=1000 reliably.
> > > Happy to provide any additional information if needed.
> > >
> > > Thanks,
> > > Vladimir
> > >
> > >
> > > ---------- Forwarded message ---------
> > > From: vova tokarev <vladimirelitokarev@gmail.com>
> > > Date: Tue, Jun 16, 2026 at 12:37 PM
> > > Subject: BadBunny: UFFDIO_COPY shmem killpriv bypass leading to local
> > > privilege escalation
> > > To: <security@kernel.org>
> > >
> > >
> > > Hi,
> > >
> > > I found a local privilege escalation (BadBunny) in the userfaultfd +
> > > shmem subsystems that affects all Linux kernels from 4.11 to 7.1
> > > (every major distribution: Ubuntu, Debian, Fedora, RHEL, SUSE, Arch,
> > > Android, ChromeOS, and any system with CONFIG_USERFAULTFD=y and a
> > > tmpfs/shmem mount).
> > >
> > > Two bugs are chained:
> > >
> > > 1. TOCTOU in UFFDIO_COPY retry path (mm/userfaultfd.c):
> > >    mfill_retry_state_changed() does not re-validate VM_WRITE after
> > >    dropping and re-acquiring the mmap lock in mfill_copy_folio_retry().
> > >    A concurrent mprotect(PROT_READ) installs a writable PTE into a
> > >    now-read-only VMA.
> >
> > This sounds like a bug, but not really exploitable.
> >
> > >
> > > 2. Missing killpriv in shmem UFFDIO_COPY (mm/shmem.c):
> > >    shmem_mfill_filemap_add() adds pages to the shmem page cache
> > >    without calling file_modified()/killpriv. This preserves SUID/SGID
> > >    bits when file content is replaced via UFFDIO_COPY, unlike normal
> > >    write() which strips them.
> > >
> > > NOTE: The killpriv bypass (Bug 2) does not require
> > > unprivileged userfaultfd and works even with
> > vm.unprivileged_userfaultfd=0,
> > > since UFFDIO_COPY on shmem is available to any process that can open
> > > a tmpfs file O_RDWR and call userfaultfd with UFFD_USER_MODE_ONLY.
> >
> > Who made the suid file world-writable? Note that this is not a bug, page
> > fault paths don't clear the suid bit either.
> >
> > >
> > > An unprivileged user can replace the content of a SUID-root binary on
> > > tmpfs via UFFDIO_COPY while preserving its setuid permission, then
> > > execute it to obtain root.
> > >
> > > The attack is deterministic (no timing dependency for the killpriv
> > > bypass), requires no heap spraying, and bypasses all modern kernel
> > > mitigations (KASLR, SMEP, SMAP, CFI, PAC, heap hardening).
> > >
> > > Affected versions: Linux 4.11+ (since shmem UFFDIO_COPY support,
> > >     commit 4c27fe4c4c84 "userfaultfd: shmem: add shmem_mcopy_atomic_pte")
> >
> > This sounds like a bug, but not really exploitable.
> > > Confirmed on: 7.1.0 (aarch64)
> > > Affected distros: All major distributions (Ubuntu, Debian, Fedora,
> > >     RHEL, SUSE, Arch, Android, ChromeOS) that have CONFIG_USERFAULTFD=y
> > >     and tmpfs mounted (virtually all Linux systems)
> > >
> > > Attached files:
> > >   - bad_bunny.c                           Full LPE exploit (uid=1000 to
> > > uid=0) Build: gcc -static -O2 -pthread
> > >   - suidhelper.c                            Standalone SUID payload
> > binary
> > > Build: gcc -static -O2
> > >   - uffdio_copy_lpe_report.md     Detailed writeup with root cause,
> > > reproduction steps, and suggested fix
> > >   - badbunny_demo.mp4             PoC demo clip
> > >
> > > The PoC (bad_bunny.c) sets up a SUID target on tmpfs, drops to
> >
> > Since the exploit isn't public, I assume you set up the tmpfs file as root
> > and world writable. This is not an LPE.
> >
> >
> > --
> > Pedro
> >

-- 
Pedro
