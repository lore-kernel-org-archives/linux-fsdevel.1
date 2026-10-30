Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375112;
	b=eZaORSZbTJGLZqMlriSQZdKwnjjytrVlmM6dkX1LHoSH62MuUfN+vHdXccJAIPZ3ynDU
	 yc1o39A1oOVklUVU76A8np9JVb4mphVqyiNDFhnfIGDSTg86/UhUh6aCV6hNNLg4u+tJJ
	 RhFLmA/6KKew3lk/qaOY1YylnNB14Q22EqBA4bI5dAYeZ1/sGrnC3vq0kM6ofNq/8WhpK
	 4J94z9sxkVZb0BVr4wsSJeI+N8Qn/ogcvMUmpwz4Yzp/9Q3d3z6CyMaGAZ4JUOQjy8JhL
	 h4uzMVbUZnjptxxGzX/1aIIY8cuTsXEDJomANrNSiX/AipsnOyCGH9W9IVUZ9yRVjrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=hLhpSxs/CI8L6fPpKCYlBQ7uDJcGOM1i7tYlKx8Tjmc=;
	b=ilt3IrddkCxP4dOfkAeM7ZY5boUjDHvCUlYdi6U3o6K8RZLswLOrSTPxXXUBLdPk4pzj
	 6fCTHmqX7SPvXDOYk0uioNzOj6oQvMq23yRR7Hlrfb7alNFF3LqzdjmM4IZ1Z5U9hWNBD
	 4cokWzwa7KhlaTyVFYD2IRzXytK5rCL3YjPqgRlKaVbexqdbz2OnlAWcaWgCRJsvH3Tgv
	 2l6H1WndJX7STM0qZ0KQop2swi2Uqo3Avd9+vFGYKc22IkNF5NIAAtfA+DJdi/ttoMy35
	 fGNMYgRCH3luftINvR9GVLkinBUObuhb6s9cARpLVe7YznNhwR5cAfoufLc2WAysimQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kJCb30Cu;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCAA606A31F
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 15:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CCAA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kJCb30Cu
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a549cd7fd2so7885445e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793375111; x=1793979911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hLhpSxs/CI8L6fPpKCYlBQ7uDJcGOM1i7tYlKx8Tjmc=;
        b=kJCb30CumIs39BYjENNb8QuYW3xpPW52sdHuKI4pKjROlEqtqanFqcEhQ69xV5/ncC
         pdosYpoWsFqljmKt9u2KPYM2dFGOyniti84h1W4rFMtIzftI4d9jAHNyoJ0qi6qUaqGM
         0jT9fF/a3kgcbjP6Ho4iLIiYuLwJ8QHRTiaK7Fc4bnMv4JerqKKpWgJFDRjIJBhHMaGm
         SZOYcnD9gQXkvY6Srb/3+mQMCUq44G7Y7q9iYY1nG5Qj2/hWj4nyis38a6tokg1orGGL
         0Wd6blNXOPHTGclX+zNbtcoOH5Zwu/sz7HkIJqtrCnFMg3KC/Am8vvY7r6LTnzIhmGfH
         W0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793375111; x=1793979911;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hLhpSxs/CI8L6fPpKCYlBQ7uDJcGOM1i7tYlKx8Tjmc=;
        b=S4ZoIaF6UjsS+vjA/MXcAaYg4cKs2lnC9PIrMlHlBUELZ6LbbcVFomZhVwHjg8M5Z5
         FGOhWwKvCyvBx09YBOnL+N0xAs2QDD7DY0vRu7McHW8LR9nDJ2X+y21YqOENRy4aA5z1
         KkqyI9Kig76C+GX16btOLn6kcLyAcTkz2q7a2s0ZYjpjy0F/ZiNG056YEGPm9MBmc7qQ
         wZhZ1tKGoJgg5VIXOmxEczsLSE1iZJUrDN4PqwIDsh/ME7Wp1FQbn/gYltC2jFfZ8Uc3
         djpVrHuxbUMBjJgqWGb4TZ8aoOjyPLM/0oFPvmUMDYvwXwLUGWs5USjzVVNlPMPSvzY3
         kw9w==
X-Forwarded-Encrypted: i=1; AKwUvByGiyVUMrmBOwm8c7Ny3lr8uDfrVrcpkDg73P09o9zgADp1hREatltQjVp7dRAHIFhrQVBqpqJqLW7o+p5R@vger.kernel.org
X-Gm-Message-State: AFq9FYKlCamOlM8k3Ft/caS0hvZ4HT/W7SUu+ILj210CXtqMXryIwi0t
	10CbfLfAqZVwjfEJxzvsqi1Wloi1uapONB61Z4iZOcwlKKy5ylQQrhQiQPjc+ZqROw==
X-Gm-Gg: AYBFou0moc807dd0ezK2bFmwtjTZGX+FkpS9s1UMP6hpNFGqXp6KRdUR5uumZ94H18C
	FBVsT3pij+7PhVZFvep42rBNIZ8XLJI+xHgbps5Cpn6RZsgSsvaTdul6sAv2f/qH7dkMQDtboqi
	CUdhRDZ9wct918DiPk8m7JVaIgElIpspwdEroJqCnPwE+weGpLwRVlZPnsnGLL4RxRNU7XPgLhr
	U2jhTA5T36OxLiC4vf1Wt3cxH0mWNtx35T6iP0j/E2evDkvz9pTyPfPzL+sLF/+HnWkoHeyPqiP
	fPF3gCdabk2JWPiEuwka3zrP9AZfRmfchdMwCnsoP0wcRNVFuXCjPH8b4lV5KgJeTKFu14jz86G
	fWE1Lhqm6wAhyAYcTsVWzR2s2BF6jge3ASs+J6KDm+pfxCjj2g8GuG/fpoR8OnErmKjY6E6Itpr
	sJ/vRTyKz29WCN+4mE9ES6utLfJdhtUE+XLNtTI5XpJHS46cCXV+1CucT9FXPKqeeZ2iPtYJeKJ
	a4d0WFp62p7pRkCAhWNyy9En88xieo3bfjjUg1FxjZ1cR52Oq6R3UjIrVnlNce9OeZ/milGZ2nL
	Kvq5SDUU4SSWCU63FtWsSQoEGit/YWMfaksi1YLn9hnzuWZTRHg7ZrLDx9HX
X-Received: by 2002:a05:600c:64c9:b0:4a2:180a:3417 with SMTP id 5b1f17b1804b1-4ac14dd1debmr62418945e9.1.1793375110258;
        Fri, 30 Oct 2026 08:45:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:43c5:cfa4:de19:f8f0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b77f06sm3901507f8f.21.2026.10.30.08.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:45:09 -0700 (PDT)
Date: Fri, 30 Oct 2026 16:45:04 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>
Subject: landlock bug: procfs denials because inodes have unstable identity
Message-ID: <auS7gAFy13EOp_Zt@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello!

The Landlock LSM lets processes define policies which are attached to
struct inode objects internally.  As a consequence, if filesystems
forget these inodes and start using new inode objects for the same
files or directories later on, these policies do not work as intended
any more.

As it turns out, procfs has that property as well and can lose inode
identities over time, even though it does not happen immediately.

In my understanding, this is not intended.  Landlock has explicit
selftests to exercise that Landlock policies work in Procfs.

For reference, similar issues have been investigated also for hostfs
[1] and 9p [2]:

[1] https://lore.kernel.org/all/20230309165455.175131-2-mic@digikod.net/
[2] https://lore.kernel.org/all/cover.1756935780.git.m@maowtm.org/


Steps to reproduce
==================

Process A:

* Enter a Landlock domain where access to /proc/sys/kernel/random
  (and files below it) is allowed.
* Repeatedly open and close the boot_id file from that same directory

At the same time, the dentry caches get freed up.
We can emulate this by writing to /proc/sys/vm/drop_caches from
another (root) process:

# echo 2 > /proc/sys/vm/drop_caches

Observed result: Process A fails because of a Landlock refusal opening
  the boot_id file.  When Landlock walks the path for the check, the
  inodes have now a different identity than before and don't match, so
  Landlock denies the operation.

Expected result: Dropping the caches should not affect Landlock's
  behaviour.

At the bottom of this email, I am including the source code for a
program that does Process A -- you can run this to reproduce, and then
write into the drop_caches file from another process as root.


Solution...?
============

I don't have a fix for it yet.

I am open to suggestions.  Is this feasible to change in procfs?

—Günther



Reproducer program, for easier reproduction (don't forget to drop
caches in parallel):

---landlock_uuid.c
#define _GNU_SOURCE
#include <err.h>
#include <fcntl.h>
#include <linux/landlock.h>
#include <stddef.h>
#include <sys/prctl.h>
#include <sys/syscall.h>
#include <unistd.h>

static int landlock_create_ruleset(struct landlock_ruleset_attr *attr,
				   size_t size, __u32 flags)
{
	return syscall(__NR_landlock_create_ruleset, attr, size, flags);
}

static int landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
			     void *rule_attr, __u32 flags)
{
	return syscall(__NR_landlock_add_rule, ruleset_fd, rule_type,
		       rule_attr, flags);
}

static int landlock_restrict_self(int ruleset_fd, __u32 flags)
{
	return syscall(__NR_landlock_restrict_self, ruleset_fd, flags);
}

int main(void)
{
	struct landlock_ruleset_attr ruleset_attr = {
		.handled_access_fs =
			LANDLOCK_ACCESS_FS_EXECUTE |
			LANDLOCK_ACCESS_FS_WRITE_FILE |
			LANDLOCK_ACCESS_FS_READ_FILE |
			LANDLOCK_ACCESS_FS_READ_DIR |
			LANDLOCK_ACCESS_FS_REMOVE_DIR |
			LANDLOCK_ACCESS_FS_REMOVE_FILE |
			LANDLOCK_ACCESS_FS_MAKE_CHAR |
			LANDLOCK_ACCESS_FS_MAKE_DIR |
			LANDLOCK_ACCESS_FS_MAKE_REG |
			LANDLOCK_ACCESS_FS_MAKE_SOCK |
			LANDLOCK_ACCESS_FS_MAKE_FIFO |
			LANDLOCK_ACCESS_FS_MAKE_BLOCK |
			LANDLOCK_ACCESS_FS_MAKE_SYM |
			LANDLOCK_ACCESS_FS_REFER |
			LANDLOCK_ACCESS_FS_TRUNCATE |
			LANDLOCK_ACCESS_FS_IOCTL_DEV |
			LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
	};
	/*
	 * Backwards compatibility checks omitted for brevity.
	 * Assuming Linux 7.3 here. :)
	 */

	int ruleset_fd = landlock_create_ruleset(&ruleset_attr,
						 sizeof(ruleset_attr), 0);
	if (ruleset_fd < 0)
		err(1, "landlock_create_ruleset");

	int parent_fd = open("/proc/sys/kernel/random", O_PATH | O_CLOEXEC);
	if (parent_fd < 0)
		err(1, "open(/proc/sys/kernel/random)");

	struct landlock_path_beneath_attr path_beneath = {
		.allowed_access = LANDLOCK_ACCESS_FS_READ_FILE,
		.parent_fd = parent_fd,
	};
	if (landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
			      &path_beneath, 0) < 0)
		err(1, "landlock_add_rule");

	close(parent_fd);

	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) < 0)
		err(1, "prctl(PR_SET_NO_NEW_PRIVS)");

	if (landlock_restrict_self(ruleset_fd, 0) < 0)
		err(1, "landlock_restrict_self");

	close(ruleset_fd);

	/* Print out the boot_id file once a second. */
	for (;;) {
		int fd = open("/proc/sys/kernel/random/boot_id", O_RDONLY);
		if (fd < 0)
			err(1, "open(/proc/sys/kernel/random/boot_id)");

		char buf[64];
		ssize_t n;
		while ((n = read(fd, buf, sizeof(buf))) > 0) {
			if (write(STDOUT_FILENO, buf, n) < 0)
				err(1, "write");
		}
		if (n < 0)
			err(1, "read");

		close(fd);
		sleep(1);
	}

	return 0;
}
---
