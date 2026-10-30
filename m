Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793391146;
	b=vlYvEx4mWzQ+cCb1fgAkl96xjwtQbuZnatAfgMzr887Cl0vCpHSQKM+v01M3z4ce0mja
	 UxK3bSahprkni40kksXc054pRs+CBaBCbK/RTR6f1KOZxSnAWKnIlnmdHn+SPKH2nBboT
	 qQ5b3NkbDKtRgza2gkzTC8Ltqv/moAillxWrWv1aUEVRHiSlv4ZImJjsxg/dddpLF2Bys
	 T1LUwZXEMReHKNsXZPkN+pLKqOYZj6JU3WlOiYYe3l7MGnjKKV6/WsPSRE3j+j9/CHTpP
	 YqZGo8UEIQiHTGTie87hQelOE5I3CovRASosAyq7/1mDXOpauBjfg7DzzJ44hA1jagQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793391146;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=HhS9XCWw3vEpxinWiwFJvyjZm4wSdEFJIbRwscEPc4M=;
	b=lstB9i8TwLt/LHWegntLLbVmTXf3SNpgxX6w7vT0inrwqiq4OkJ1oDKEGhHizGZVcq3X
	 7OVn1Z6sNH3fp+ic22IpG0hAm/ERTQvB5vTVLQ+Co3MhGLHIHSY1ezeMTTAvOJqQbDh3z
	 SyGQE+tjLfihvmHDDeMRaY1fYxlJxTSm+jO7yOFbJoKwwopOybs2i7sjLMSZi0uuFBWtH
	 9h7844UJDblluH5dc5r8zJDioi3R9FHZj7d3/01XrZW++jwC0KDnDJlj8/Y2jCCHxxIkL
	 Gpz6pVr9SE55ghP1VXRJtiT/kTWwZhcC41V11SDCEWg4ntz2+LHZgh1pk20sopBGOOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=H9pLVCC5;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C4C606A31A;
	Fri, 30 Oct 2026 20:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59C4C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=H9pLVCC5
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id ADD5A1607C4;
	Fri, 30 Oct 2026 20:12:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 014442002A;
	Fri, 30 Oct 2026 20:12:21 +0000 (UTC)
Date: Fri, 30 Oct 2026 16:12:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: How to detect inode leaks?
Message-ID: <20261030161220.6f773b1c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 014442002A
X-Stat-Signature: mkhc7yenwbz57dkww4akr15qatx3kz4h
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18T7XKUgLdaMehf0FR+cWT44wCCiHnGDog=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=HhS9XCWw3vEpxinWiwFJvyjZm4wSdEFJIbRwscEPc4M=; b=H9pLVCC5irHO7xU8cJE+DRpC6Nu1nONFhSe4aDxCBzqec6veVem0kFFqc0wS3vzQfEm2jIx6WP12GnGp+zcWKIDejCLTiY/up6f+avVSp0BFnTz/2/kjLDIumT8/XcYLloJBFggCujjuUtoOuE++rXaR39+rYqBVl/tcJPwIf5w=
X-HE-Tag: 1793391141-154602
X-HE-Meta: U2FsdGVkX183CvujvqOrh/YRVZsGdG/D8YylkD6V2n5kFa1E+aOG6LLyQ9Hl8a/ChWIaJFJYRXRMw1wo8EIQsdTq4kv9KS8i95N6upBOARYQJXRSeHNHId8HXz3A4y5yk+z6zick8MnoEJjJbpL/QKQvhL7/X2HBdxJyMhN17hofYdbUedaBb5eqzGTYsFzLm1mWUW10EH6eIOjw1zBaulkvBnTCQ2ZI25I1ZQqDEHJZME93wlUrB7mvl0grelDO+KdHGnHuhrP3IJteN4AnDqEJui9Nuzz107n+lt7eIAVePuueAAkJesQ09aBM/Zre

Hi,

While working on a eventfs file system to allow the event format and id
files to be exposed as read-only for unprivileged users, I thought I had an
error path in the fill_super() logic that didn't free the created inode.

Basically this:

	inode = new_inode(sb);
	if (!inode)
		return -ENOMEM;

	inode->i_ino = 1;
	inode->i_mode = S_IFDIR | 0555;
	simple_inode_init_ts(inode);
	inode->i_op = &simple_dir_inode_operations;
	inode->i_fop = &simple_dir_operations;
	set_nlink(inode, 2);

	set_default_d_op(sb, &tracefs_dentry_operations);

	root = d_make_root(inode);
	if (!root)
		return -ENOMEM;

Although I later found that d_make_inode() does an iput() on the inode on
failure, I wanted to know if the inode leak would be detected by kmemleak.

Thus I change the above to:

	root = NULL; // d_make_root(inode);
	if (!root)
		return -ENOMEM;

To force the leak. I booted this and ran:

~# while :; do mount -t eventfs nodev /sys/kernel/events/; done
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
mount: /sys/kernel/events: fsconfig() failed: Cannot allocate memory.
       dmesg(1) may have more information after failed mount system call.
[..]

Let it go for some time and waited for kmemleak to find it.

It never did.

I also added a:

  ~# echo 1 > /proc/sys/vm/drop_caches

And that still didn't trigger anything.

I did some tracing and this time I only ran the mount once.

In one window I did:

 ~# echo 1 > /proc/sys/vm/drop_caches
 ~# trace-cmd record  -p function --func-stack -l alloc_inode -B graph -p function_graph -l alloc_inode -l kmem_cache_free -O funcgraph-args -O funcgraph-retval

And another window I ran:

 ~# mount -t eventfs nodev /sys/kernel/events/
 ~# echo 1 > /proc/sys/vm/drop_caches

Waited and stopped the recording. The report had:

graph:            mount-1213  [002] ...2.  2088.465177: funcgraph_entry:      ! 456.541 us |  alloc_inode(sb=0xffff88812bf8e000); (ret=0xffff88813d489860)
                  mount-1213  [002] ...1.  2088.465180: function:             alloc_inode
                  mount-1213  [002] ...1.  2088.465197: kernel_stack:         <stack trace >
=> arch_ftrace_ops_list_func (ffffffff81bdf377)
=> ftrace_call (ffffffff816e5d85)
=> alloc_inode (ffffffff82491559)
=> new_inode (ffffffff82491757)
=> eventfs_ro_fill_super (ffffffff82990f2b)
=> get_tree_single (ffffffff824184fc)
=> vfs_get_tree (ffffffff8240dc6b)
=> vfs_cmd_create (ffffffff8253ac42)
=> __do_sys_fsconfig (ffffffff8253b28e)
=> do_syscall_64 (ffffffff8499faeb)
=> entry_SYSCALL_64_after_hwframe (ffffffff8100012f)

The ret=0xffff88813d489860 is the return value of the alloc_inode() call in
eventfs_ro_fill_super(). I then searched all the kmem_cache_free() for that
value and couldn't find it.

I then changed the code to:

	root = NULL; // d_make_root(inode);
	if (!root) {
		iput(inode);
		return -ENOMEM;
	}

Booted and ran the above again. This time I had in the trace:

graph:            mount-1134  [005] ...2.   799.112115: funcgraph_entry:      ! 816.295 us |  alloc_inode(sb=0xffff888140556000); (ret=0xffff8881514f4920)
                  mount-1134  [005] ...1.   799.112117: function:             alloc_inode
                  mount-1134  [005] ...1.   799.112133: kernel_stack:         <stack trace >
=> arch_ftrace_ops_list_func (ffffffff81bdf377)
=> ftrace_call (ffffffff816e5d85)
=> alloc_inode (ffffffff82491559)
=> new_inode (ffffffff82491757)
=> eventfs_ro_fill_super (ffffffff82990f28)
=> get_tree_single (ffffffff824184fc)
=> vfs_get_tree (ffffffff8240dc6b)
=> vfs_cmd_create (ffffffff8253ac42)
=> __do_sys_fsconfig (ffffffff8253b28e)
=> do_syscall_64 (ffffffff8499faeb)
=> entry_SYSCALL_64_after_hwframe (ffffffff8100012f)

But I also found:

graph:      ksoftirqd/5-43    [005] ..s1.   799.131415: funcgraph_entry:      + 23.788 us  |  kmem_cache_free(s=0xffff888100dc0500, x=0xffff8881514f4920); (ret=0x0)


Which shows that the inode was freed when I do a iput(inode) (which would
never happen if the function exited early).

This got me thinking. If for some reason any use case of alloc_inode() did
not free it, kmemleak will not catch it. I'm guessing because the inode is
referenced by something somewhere (where it requires the drop_caches or
memory pressure to free it).

My question is, is there any mechanism that can catch leaked inodes?

-- Steve
