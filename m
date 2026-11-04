Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831034;
	b=OaZ2wyAumICNgK+uHUGB8FF+0ubK92uLT7sYwCgZUDd5RUJZoxNDWHC27BtZHykyjwZT
	 77KZj60U0MYt7F7+k0Xj756sB9qJPejqh6QjP4UDIDXLk2kTwGfmPB7wsxXHaO+1ToEbg
	 +fqPi0fixpNkZZGYXLNJ0yr+FTPUH5Zdwe8/zP8w5UDoxKVsNLJ/F4KvReK7T93LQD0nK
	 gLgKeFjOETz6RyP5jzTPKSNs1Of1Hs2u+BBvt+aftxxGnM3rP38Ja+3KAu0toaq/O0YhG
	 +7VUirSVUBFol9+8TEm8Rfkwco2hbofHz6I0Ado/VuAvGWG/9Mo0Ndsk+qHPsKHohBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KeZ2aB0X0IqNy32Bwapb83gUzvOHb7jOV5nmidAoLRQ=;
	b=W3DTM5EFFTfaW73H2OdlbfnMsG5eL/5eECKBWz7R8LW2UtAHGlB+ffL1sCQLKAXQHwWg
	 +X2vHJv88jjtG3OxLZpmHRoh3RoTARRGl9VqwPoEa0UCdjgDSQgIpe0cH9G9/qLHf1iQq
	 MLpSXDWPWY2Et6WGIawWCW7alu+FP4rH6PjoU+uJalcRPiSTshBfcaWvBJ4hakAI5Ds2l
	 x3HBtrPZjn5xUO9pgJj9Z9zliknp/r1dv2h7/SHegv+ZhaKzuanK4aavpULPEOZ8yKDV5
	 IWZzkZjZL0lny2XEKLA3EDyvJvi6tnd/vIMEb0jWiyCEIYSZIbmBWl4qJ1tb1h5S4/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=NcEExbnD;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF804606B388
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 22:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF804606B388
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=NcEExbnD
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f3c89594cso109173285a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 14:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793831033; x=1794435833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KeZ2aB0X0IqNy32Bwapb83gUzvOHb7jOV5nmidAoLRQ=;
        b=NcEExbnDLtiALC276t5kcclQzZoOYloVis0hCWAdB5suqT0QkRwNJ+AFK0XB4NzGVk
         MBvKf3YK63ail+629aXUNIvCM1WnXnfCIha+DrPSuNj8k3YzkImzwB+xGI2s2y2HBJ5T
         vvkTuikiQqNxAICkZ4ywv2TcbVVqmFMFp/2B11hfLkRa7xqDvLx4q/6WouEjHlPu8igf
         zrdHc2HpeafPYSIxUQLBS1un6n7qW3BkOqpkKrUbvRAIFCSnaZItXy7Cg5Cn0kHFlgPO
         kv82C6T1O0AQD/2BA2RX99j/GbgpjX9B9AtvNADneDIEvKVhq+f3BAJVyYf4DaCus4Kp
         YwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831033; x=1794435833;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KeZ2aB0X0IqNy32Bwapb83gUzvOHb7jOV5nmidAoLRQ=;
        b=L726tdnj6Aqkxo5EbBSzYALdqg/eSOqxsS77i4RLh/ym3uysc4wXh1niZmrz4pdPNS
         NIfM1J+Icn9/HtDynljZzc6rX7+lR/TTfu6E6DOrnktjuNsUAsblqS66Pl5f0J6Sz9pt
         6qKnB01xWPd40VY1KPa1fJtFpucRuaDVB0n1nEruNa9sNqIpONW3I+V+cuhKLyZKw3cH
         G3MqQnQLrYI/pSe7+DeVvx33ufg59wXSFuGqapVJmCokYhX2xGNy/mM9mnkUFbeIqmoX
         oEwMbihtXFvFw07eUUlqz1PnkA6s+4lqWxArs+S+7I+ZiCv+0+/PwvNgUrBNmry17Itc
         UsTA==
X-Gm-Message-State: APuU4Z8/dfOmMtWJKuee4d6ciB3nXSgCdClJNCeFySsRbnFl4ecdptlg
	mD62BGMKGi9HmFCm9u+YwLKnoiguA0XtnYIdpziLAU3/LZsyIW+8Z5LyE6P6EJXv/XY=
X-Gm-Gg: AYBFou0fXKORsVFRuGEAlR8au6DzwplEy+a1G+KqkvkPNPBhkNRebbUuocshf3Y7LOb
	Ben5CkYnpKdyYLncHyibBM7bsjiEt9Xerxxynds5Xgx+MNrvMi4pYJM0n1mGvmAC5GwUSr6h4Bx
	+0Aa2owuIQv0cZgAX4qD2HEauzNO6Bf0sw4c+eH8EEtCDCx/O3/WMl0bBLMA2lFkoIooWCSHCrI
	Q4u3/2d0OTRw7xnlG2SeFqPFgpBWqr24lT98J9g3DHESlQwpVOkFCKNsyQVMRa6iN7C5l41ZEUU
	GHWihYYO5uV1oIr4meIjDRb9m78QQsgjx6Y8gSnwMMPzaT/aiwwnRFP0M2gtdxvAf6jHhYf+Zz+
	IKNbB51ZA1TBznhCsHX4Df1raWtVLvQPNJY7UqrS8BV7Ts79ymDcNs1jRtMntzD2Trl8Efj7Aeh
	vIaf5NoAJibI/qkp+skEkR5juk1frwYSXOgs07v56WaNRug5YvQhsqqGetyesAVbrD85rrVzYay
	JtYo8FmRwkeDAQkcm6dKEjkDfu2wrbJdoetTJnnZwB0rRpbDzI1BqOyPvVq3pOwdEX8+dQ3r1HW
	uXXXmkMTVNBjSGm1hhOTzOOSFVweF3FcJf7mpMtdC3LX7Q==
X-Received: by 2002:a05:620a:608d:b0:93c:7e9c:3bba with SMTP id af79cd13be357-944216bd4bdmr3093198785a.41.1793831032557;
        Wed, 04 Nov 2026 14:23:52 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4691a76sm312610285a.4.2026.11.04.14.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:23:51 -0800 (PST)
Date: Wed, 04 Nov 2026 22:23:51 +0000
Message-ID: <464ef986eab97abf226791c7e19ad111.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Eric Dumazet <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
 Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>,
 Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>,
 Jan Kara <jack@suse.cz>, Jan Kara <jack@suse.com>,
 linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
 linux-sound@vger.kernel.org, linux-mm@kvack.org,
 Chuck Lever <chuck.lever@oracle.com>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH RFC 0/7] proc: move procfs to what kernfs does
In-Reply-To: <20261102-defizit-jobaussicht-kurios-7016c6e67442@brauner>
References: <20261102-defizit-jobaussicht-kurios-7016c6e67442@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hey Christian,

This is a summary of my Claude review of everything.  It didn't find
anything wrong with the conversions in parts 3 to 6, the findings are in
part 1 and on the procfs side.  1-3 are reproduced in a VM, 4-6 are from
reading the code.

1) bugfixes 19/38 ("proc: resume readdir after the last name it
   returned")

proc_readdir_de() now returns 1 instead of 0 when there's nothing left
to emit:

	if (!de) {
		read_unlock(&proc_subdir_lock);
		return 1;
	}

proc_root_readdir() needs that to go on to the pids, but proc_readdir()
and proc_tgid_net_readdir() are also the ->iterate_shared() of every
other directory, and iterate_dir() hands the value to its caller.
getdents doesn't look at it, old_readdir() and the compat one do:

	error = iterate_dir(fd_file(f), &buf.ctx);
	if (buf.result)
		error = buf.result;

	return error;

So at the end of the directory readdir(2) returns 1 without having
written a dirent, and keeps doing that.  This is syscall 89 through
int $0x80 in a loop on x86_64 with IA32_EMULATION, giving up after
100000 calls:

	             base, 18/38         19/38, whole series
	/proc        106 entries, 0      106 entries, 0
	/proc/fs       4 entries, 0        4 entries, 1 from then on
	/proc/net     31 entries, 0       31 entries, 1 from then on
	/proc/sys     10 entries, 0       10 entries, 0

/proc/bus, driver, irq, tty and self/net do the same as /proc/fs.
glibc doesn't use that syscall, but this patch is tagged for stable.

proc_readdir() has to keep returning the 1 for proc_root_readdir(), so
I think proc_dir_operations and proc_net_operations want a wrapper that
turns it into 0.  The comment above proc_readdir_de() that says the VFS
doesn't care about the return value should go as well.

2) cleanup 5/5 ("proc: drop the _buf suffix from the new methods")

4/5 renames the old ->proc_read() so that "A module that sets one of
them doesn't build anymore".  5/5 hands the name to the new method, and
the old and the new prototype only differ in __user:

	ssize_t (*proc_read)(struct file *, char __user *, size_t, loff_t *);
	ssize_t (*proc_read)(struct file *, char *, size_t, loff_t *);

Only sparse sees that.  The compiler does reject an old ->proc_write()
or ->proc_ioctl() (gcc 13, clang 18), but this

	.proc_open	= foo_open,	/* single_open() */
	.proc_read	= seq_read,
	.proc_lseek	= seq_lseek,
	.proc_release	= single_release,

builds without a warning with W=1.  pde_set_flags() only refuses the
release helpers for seq_file entries, which this isn't one of, so it
registers too.  With a module that has exactly that loaded on top of the
series there's no warning, open() works and every read() fails with
-EFAULT.

The tree had 84 of those at your base.  None are left, but whatever is
in flight in other trees, gets backported or lives out of tree ends up
there without anybody noticing.  Either the read method keeps a name of
its own or pde_set_flags() refuses seq_read, and either way this
probably wants an entry in porting.rst.

3) bugfixes 38/38 ("selftests/proc: check that a faulting readlink()
   doesn't hold up removal")

This adds proc-remove-slow-reader to the Makefile and to .gitignore
along with proc-remove-slow-readlink, but proc-remove-slow-reader.c
only shows up in core 08/16.  From here up to core 07/16 make says

	make: *** No rule to make target '[...]/proc-remove-slow-reader'.  Stop.

in tools/testing/selftests/proc, so also with part 1 applied on its
own.  The two lines want to move to core 08/16.

4) core 04/16 ("proc: let procfs own the seq_file of seq_file entries")

pde_seq_start() returns right after it unpinned, pde_seq_next() goes on:

	v = pde->seq_ops->next(m, v, pos);
	if (v == ERR_PTR(-EIO))
		pde_seq_stop_pinned(m, v);
	/* seq_file would blame these seq_operations, blame the entry's */
	if (*pos == old) {
		pr_info_ratelimited("buggy .next function %ps did not update position index\n",
				    pde->seq_ops->next);
		++*pos;
	}
	return v;

core 16/16 documents that next() may return ERR_PTR(-EIO).  A next()
that does and leaves *pos alone is called buggy for it, and
pde->seq_ops is read after the unpin, when the module it points into
can be gone.  Nothing in the tree returns -EIO from next() today.  A
return v after pde_seq_stop_pinned() takes care of both.

5) bugfixes 35/38 ("proc: sysctl: don't hold the tables while readdir
   copies to userspace")

	while (err > 0) {
		if (!d.skip) {
			err = proc_sys_fill_dirent(file, &d);
			if (err)
				break;
	...
	sysctl_dir_done(&d);
	return 0;

sysctl_dir_next() only pins the memory, so the entry can be unregistered
before proc_sys_make_inode() looks at it and returns -ENOENT.  The loop
breaks without moving ctx->pos and returns 0.  If that was the first
entry of the getdents64() call userspace sees the end of the directory
and loses everything behind it.

The old code bailed out the same way, so it's not a regression, but
it's the "terminated early" case you set out to fix and these are the
lines that get rewritten.  Handling -ENOENT like d.skip would carry on
after that name.  -ENOMEM probably wants to be returned instead of
turning into EOF.

6) stable tags, bugfixes 34/38 and 37/38

34/38 has no Fixes: or stable tag and says "No functional changes", but
35/38 is tagged for stable and depends on it.  Without 34/38
proc_sys_make_inode() reads table->mode and calls ->set_ownership()
after it dropped sysctl_lock, and the caller 35/38 adds doesn't keep the
table registered.  35/38 applies cleanly without 34/38, so nothing will
complain if only the tagged one gets picked up.

37/38 has Fixes: 7e0e953bb0cf, which is 4.0.  "the inode holds a
reference to the entry" only covers RCU walk since 47458802f660
("procfs: move dropping pde and pid from ->evict_inode() to
->free_inode()"), which went into 6.8.  Before that the inode drops the
entry in ->evict_inode() without a grace period, and the pin is what
keeps ->data around for a walker that got it from ->get_link().  Which
stable trees have that commit isn't something I checked.

Smaller stuff:

- The cursors in bugfixes 19/38 and 31/38 hang off an open file and
  anybody can have as many as they have fds, so GFP_KERNEL_ACCOUNT.

- copy_to_user_fromio() has no callers left after drivers 22/23.

- fs 07/27 says ntfs_set_label() refused a label that's too long with
  -ENAMETOOLONG or -EFBIG.  It doesn't always, cpu_str.len is a u8 and
  ntfs_nls_to_utf16() is allowed (PATH_MAX - 2) / 2 here, so 300
  characters come out as 44 and pass the check.  That's an old ntfs3
  bug, it's only the sentence in the changelog.

Two more old ones that you might want in part 1, the series doesn't
change either of them:

- allocinfo can deadlock against a module load.
  codetag_alloc_module_section() calls reserve_module_tags() with
  mod_lock held for write, and its three error paths call
  shutdown_mem_profiling(true) -> remove_proc_entry("allocinfo"), which
  waits for the readers.  A reader that's pinned and in
  allocinfo_start() -> codetag_lock_module_list() sits in
  down_read(mod_lock).  There's no copy to userspace involved, so
  moving the copies out doesn't help this one.

- snd_info_text_entry_write() allocates the larger buffer and frees the
  old one without copying what's in it, so a text entry written in
  pieces loses the start once it crosses a page.  It's been like that
  since ffb73b08e794.

For what it's worth the end state checks out.  Every proc_ops
initializer in the tree matches the final struct, the only entries that
still read straight into userspace are kcore, kmsg, kpagecount,
kpageflags, kpagecgroup and profile, all built in and never removed, and
nothing in the tree trips the new checks in pde_set_flags().

This part is me. I have a selftest that my claude wrote to validate #1.
If you want I can send it along, but we should probably have a test for
that.

Thanks,
Josef
