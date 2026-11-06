Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793947395;
	b=toEzovRQt9DtLSOUXsafI0YRMSXx8X1DevciUr5SNFLJc6cK7GTQXnTCeZ1w9Lu1JAXs
	 cVrVdvzD7hnx95b/7vmkDROR47sY2ceVT+mcr+Rh1HitPrOj/Jbog4cNa65h5IxnM31H7
	 BV4ArfhfjcATinL53wumekYHev/Ivt/UQq31aMD2uytTsTbAkO5bZ7QG55XR7L3uyt1DQ
	 U/4dd+3/+oiCjI27a4orOK3k2XiypXD2xCLQQmWPmt0zkpwsKPhVwHZpOWqlcYb3zhy9u
	 gSw8usMcuohAKx+X/8KnUApCvF3wf7sNkJUwvzfvtVS0LkaJfJVD0k9UFBmNXF/VQ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947395;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Subject:Date:X-OQ-MSGID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b5604KNK+JABaWihUJoA8XuHeQr1iQAxEImMjxxyEeE=;
	b=0wVz8WNuZ8sH+RbUTn814uOAFf0gbiSYUDZijPGqL4EDOqU5i7TqDJnmP8VaJResaOJl
	 7otFjt8ifL2FuOg8OsXltqzcbUjNx8o5jqi+d9bk0CUmY+OhPvYX4xwiZ9ESMktnJEAQl
	 rhJIdfKuQPQs/FZNB4JynqpnpSapdt/gjwz/ntjG2ZP6nq8wn5ZpbzLgL36CGWFyQoPSS
	 EgYFrsp6GuUuG7upnE15v1YCQ6OfecSTZDBd8nTd/OxtdeZM2YIjiFgO6SfeDs5NKw5pV
	 PIUolebCnHDc/9R1LJ6GjpURTmQGkdO0ffrMU/CuarrSSwF+Y0DALjlKlv76zIe+mIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="igxl/oTO";
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6F606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 06:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE6F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=igxl/oTO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793947389; bh=b5604KNK+JABaWihUJoA8XuHeQr1iQAxEImMjxxyEeE=;
	h=From:To:Subject:Date;
	b=igxl/oTOsjFFJce4G2oMDobMDmJgmlpNtV5pv3rZ1OQkpVEPEmODFBy0GLet5XGct
	 hfzSjGK46ai7PllA1UdqsrLLkvqboeqMKlrlV58LMSYpwKeEnDuNIJsryJpZbjYpFO
	 Y8xbQdt4mp9xl5fCnvFy2HNGLBUDfJyYTyOZUNvk=
Received: from shuai-VMware-Virtual-Platform.. ([218.28.192.28])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id AC51E468; Fri, 06 Nov 2026 14:43:05 +0800
X-QQ-mid: xmsmtpt1793947385tfrns5vlm
Message-ID: <tencent_EE9EBC53933F6E9658D6848B7B89F4370B06@qq.com>
X-QQ-XMAILINFO: M+LbSN6IdDJLOOGSfbhU4o71fub16g1D846oCw9LUFBCHLlzIoQxGLLNwd1lz2
	 GQInjmH9Y7g/8UHXFNDK6oJvuC7r1vpQgaRh7zBOtmWtAZbrLrc39W877wgbSIbR7ZeGI6pOMA0C
	 R3YLKzY7J7DjVuQKkuRKHOjULFfA8p154nJSedUiOQcjmle48pnzPc/g3tEomy8i2XXtCWp3kSiI
	 zbXd34d0zXiXjHdi0bLpMZ7VvMS0dKtwd6pxppbFHTk54nqvT81s0WBYykC74JXfuOHM0vJIyWk5
	 tUPKD3A/B18jbxgflrwbltBxVMKnNFVISPp53ZPe7l9/aYTToJvAN0ljQW9UVfZKid5LajOnONv9
	 M8Jnd709Ln948u/DGtXvBz3MmxSdsb5GQvVXpJsvPQwBHCxCVmG4jB7GMhtKy/qSZGiiw0jLU9X/
	 tTFeCF4vo4xzhzFFq0mYtUmqvXkchRZ7OYiLzb5lxuAw3EJASC0FgkoEmNn2Iyz5oJV4h/iMK7WW
	 z+tmnvWgVmEiFWfZ7bMLjRy3yuZX5OAj+yPI8voZjyH1siUHnlus+L3gdsYLkbvzzrAK5c5+s4zo
	 orUFDguova3uxF1d31DIwVusJFzkX+VuHnwK3xyFkuJ8u/PssajuKJadmOlMtFuG0HqSIE60cTtY
	 E5SOSPGWAxqefM5+VuX7SZyWHI58CApCso70UXhfr7oueh/3UvdRvKZ1RQpk6w2oUkN9aFSXmGlk
	 VllK6gtTiXjRnuSxsM6tpYsZMyYe8NdusXjWFrIJXi9S2XZL6Q6FyWDBQMTAFl6lI38fOwL03UDz
	 1/jZsFVC9/KW8SmWm/3m+v6KOCmftMT+W0US0ZUpl+KnF2mgQdvNByoZ7wmsL81pE7Fd7u+ujxt5
	 kKioVSL3ZYAllnNv6HtezMVpYfgNaHmvv3tUnxZERCBH2z6dBRR7SB9GE7MsIrOpJducXkTZ1qNx
	 lD+CiejxhGsZZUQoUlaZp6m6zaDsXC3zFRhHIDlLJU16b7IYi8+2vMJDu8+caG/rDqp3kAI/06VZ
	 xKq3zPy6luCQ8IelVy6+zJDjHX7neJ1kiC6NiS0w==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Shuai Liu <847807867@qq.com>
To: linux-fsdevel@vger.kernel.org
Subject: end_dirop() can unlock the i_rwsem of a re-parented dentry on PREEMPT_RT (DEBUG_LOCKS_WARN_ON in filename_symlinkat)
Date: Fri,  6 Nov 2026 14:43:03 +0800
X-OQ-MSGID: <20261106064303.523924-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Al, Neil,

I've been digging into this syzbot report and would like to share an
analysis and ask for your insight on where the invariant breaks.

  syzbot dashboard: https://syzkaller.appspot.com/bug?extid=2ed46b6b748df855347f
  Title: WARNING in filename_symlinkat (PREEMPT_RT, still open)
  First reported: February 2026; syzbot's own retests are flaky
  (10 of the last 15 retests report "no crash"), and earlier fix
  attempts posted to the discussion thread did not resolve it.

1. What the warning means
-------------------------

The crash is a DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
fired from inode_unlock() called by end_dirop(), via:

  filename_symlinkat
    -> end_creating_path()          (fs/namei.c)
       -> end_creating()            (include/linux/namei.h)
          -> end_dirop()            (fs/namei.c)
             -> inode_unlock(de->d_parent->d_inode)

end_dirop() re-derives the directory to unlock from the *current*
value of de->d_parent:

        struct inode *dir = de->d_parent->d_inode;
        ...
        inode_unlock(dir);

while start_dirop() locked the parent's i_rwsem *before* performing
lookup_one_qstr_excl().  The warning therefore means that between
start_dirop() and end_dirop(), the returned dentry was re-parented:
we took the lock on inode A but are now releasing inode B.  On
!PREEMPT_RT the same mismatch presumably happens silently.

2. What I checked and could not break
-------------------------------------

For de->d_parent to change, something must move `de` itself (d_move()
family) while we hold it.  I audited the plausible candidates:

  a) lookup_one_qstr_excl()/d_lookup(): lookups hash under the parent
     and never re-parent an existing dentry.  No window.

  b) d_splice_alias_ops()/d_splice_alias() during a lookup of a
     directory, which is the classic way a dentry gets moved to
     another parent:
       - IS_ROOT alias branch: __d_move(new, dentry) under
         write_seqlock(&rename_lock) moves the *existing* alias into
         the freshly allocated lookup dentry's slot; the destination
         is a new dentry, not the dirop's held one.
       - !IS_ROOT branch: __d_unalias(dentry, new) takes
         s_vfs_rename_mutex and then inode_trylock_shared() on the
         alias's old parent, and bails out with -ESTALE if the
         trylock fails; the moving victim is the alias, not `de`.

  By static reading I could not construct an interleaving in which
  the dentry returned by start_dirop() gets its d_parent changed
  while the dirop's exclusive parent lock is held.  Either I am
  missing a caller, or the mechanism is subtler than the alias
  paths -- hence this email.

3. Instrumentation result: ~48k iterations, zero hits
------------------------------------------------------

To get runtime evidence I added two DEBUG probes to the tip of the
paths in question (both compiled only under CONFIG_PREEMPT_RT):

  - end_dirop(): read rt_mutex_owner() of de->d_parent->d_inode and
    warn with full context (dentry/parent pointers, %pd names, inode
    numbers, d_flags, filesystem/superblock, comm, pid, owner comm)
    whenever owner != current -- i.e. log *before* the kernel's own
    debug check fires;

  - end_creating_path(): compare path->dentry (the parent whose lock
    start_creating_path() took) against dentry->d_parent at the end,
    to catch divergence even if the ownership warning never fires.

I then looped syzbot's C reproducer (gfs2 with lock_nolock, mount /
chdir / creat / open(".") / symlinkat+renameat2 racing threads) under
QEMU/KVM with the syzbot-provided PREEMPT_RT config, across ~48,000
reproducer iterations.  Result: zero probe hits, zero false
positives -- the probes print nothing in a completely healthy run,
and the kernel-side check never fired either.

So the window is real (syzbot hit it) but extremely narrow, and my
repro cannot reach it locally.

4. Questions
------------

  Q1: Is end_dirop()'s contract deliberately "unlock whatever
      de->d_parent points to now", relying on an assumption that no
      path can re-parent the dentry while the dirop parent lock is
      held?  Or would it be more robust for start_dirop() to
      remember the exact directory it locked (e.g. return the locked
      inode alongside the dentry) and have end_dirop() unlock that
      captured inode?

  Q2: Which callers of d_move()/__d_move() do you see as plausible
      candidates for re-parenting a held create/remove dentry?
      Candidates I could not fully rule out by reading are callers
      outside the lookup path itself (rename on another mount of the
      same file, network/cluster filesystems revalidating and
      re-parenting dentries, overlayfs redirect/merge behavior, ...).

  Q3: If no re-parenting path exists, could the divergence instead
      originate at start time -- i.e. start_creating_path() locking
      one parent while the dentry handed to end_creating() was
      created under a different one?  My end_creating_path() probe
      compares exactly that and never fired, which argues against
      it, but a second pair of eyes on that layer would help.

Happy to share the instrumented kernel, probe diffs, and full boot
logs.  The reproducer is the one attached to the syzbot report, so
anyone with a PREEMPT_RT build can try it directly.

Thanks,
Shuai Liu (刘帅)

