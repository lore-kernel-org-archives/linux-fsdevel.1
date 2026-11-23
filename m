Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463072;
	b=2gYnpQyy+J5c0JmM0cZ52J636G+xGfn7nL6XoZvBQKxEfgtU207kvZOZfL641s80w2RW
	 IpDgJQdORsMd/2kN6UNWJc+qL8NTdtRoZvpATJyf8tqpgXHW7dM9XBu0Co08QPI6Ag5GN
	 x9ofwcWCfH1qF4WgDrF7ug3ykPIUNqvCfDSSEJHhBiVO2aeLptPf55aZpt6EWsvkNFvIQ
	 wdzCC9NpFwDrWFJhek35VVKhwUt0Hosq5wmEj9Xka5COk5n9zWFk7Of4dlWoq9eikkU0z
	 6Y5LklI0iJBZlRyL0BLhT9FV1vMzu6P/GcF8rT8yRzjnNDekqH0aVpzMrJDn5ER7fAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463072;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=4Dvz5NNNlICLTM3r9+Ya7zREyIrxNnm+Dij1r9SaGyU=;
	b=q/nA+5TXEsLsA00H5DMcxAZ1s/9vuzY0bSOY/uMzWT4bufumtCX72almAy/ZaffI1+TP
	 jz4oyqeO1dabGR3jGIvMITjJxzhHUvTcuk/fGExGCq4E+azhieqJWbYdDaZN3RNeRQxUr
	 X7pW3ppQ+E8xJu+u2MD9uBj0f4kfHRziUhWrXNZPZtsex81R8rCDoFco8nVkjdHwsXTY3
	 kLPzRU9cWZ2wi6GZ1pAHWC9Ld/t3I89BS8suOfYb7/gHVPRxGTyinMLDpL+XKQ+akt/Sl
	 zXeE5Pe3FIAZWjECuqb/ZKbdxtNPhAOQM3NO1yQ6B11pQUl1aYjrUkUKyobaC44Pn8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=greenberg.science;
	spf=pass smtp.mailfrom=greenberg.science;
	dkim=pass header.d=greenberg.science header.i=@greenberg.science header.a=rsa-sha256 header.s=fm1 header.b=XkgzEtbU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AUsBnpZR;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A1606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 19:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05A1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=greenberg.science
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=greenberg.science
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=greenberg.science header.i=@greenberg.science header.a=rsa-sha256 header.s=fm1 header.b=XkgzEtbU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=AUsBnpZR
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 106107A061B
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 14:44:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 23 Nov 2026 14:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	greenberg.science; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1795463070; x=1795549470; bh=4Dvz5NNNlI
	CLTM3r9+Ya7zREyIrxNnm+Dij1r9SaGyU=; b=XkgzEtbUZp852sCZTjZJw236iL
	CCtpZSQnDPUj0rC7+jivf6UK9jV8WGLOmEJh51YaQPoqbPXzSiQsWK+L32X7tcIc
	O8bcruCUBu7HB3eWxmkIt2vkENb7QKnw09CSVnJ807jyZSZ9C+FsMgK1O+/XX7Wn
	LlRzg7banshOfsdUaD1S4fgUrX/Vr/Oz6OB3jH5qhHBVZ+Y5UpRHTqtP0V8rCCRP
	Uhgm+CQyoLtzLB79eWhXOowgGyGKDlsD5+uKoM52P+1aa8lnNKDmnp3qtr/GdLM9
	+qixYu//ndr3iC24+nQPwUmGsGtGCixXDd8OzmW5YFXmrDB9p3NRzwQo86ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795463070; x=
	1795549470; bh=4Dvz5NNNlICLTM3r9+Ya7zREyIrxNnm+Dij1r9SaGyU=; b=A
	UsBnpZRFUHMB1O40+HqXhe2nfdnbIzgGqsoivhXEacfAXkG8zR2huGPKUEqrwN46
	SHokdWt9MxHL7OSLGCYIPvfJaONeSJGKbMxwBB/xilNklGMfmWt0uy4BbWOkzJYV
	6sjCJRyveeoO7kaEz2iHQMXzkZvuTuSDCY7SiUXSuz5gMuNLwwTuLOIAPidbu72m
	/exE6k/hGgOkhZY1K0uRt07/bA7Gc4TCKhncnTKJDWo4Qnw3WYWIjoTJElzjLzNP
	AvFB0xSC6dq8mjeBwA9RHCxAtKD5RXOWNjkDqZz6rQ45CSf6PH5HKXkB71zBjGeA
	eJ06hEGokN/QwdSjisCCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=greenberg.science a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795463070; d=greenberg.science;
	mf=PG1pY2hhZWxAZ3JlZW5iZXJnLnNjaWVuY2U+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:N41/HsOGDHGKkbesbgDOj10fs44hQtgSzQtpYRP4B/PixW5
	mHztaBHFK6x6fZG2zKVvER0gUw/XLymivQaYy97t0o//2bvpTPUT6rCKSRKo9HPf
	UBxnZhms+EfAQFkc4Ekr5qnmEKn5585PwRm/KJl4XRb381JM516nY0k7wn1L9pvY
	eUBeKcyRFh0Flvo0/8JKb82Qx+cDC6U+FxRa99obHvnVTBQURbEyfoJ+gHF9hHkL
	I2oOGJJY1Awuw8qtEoZroO7Q6A8gJVrMUbjh33WyL2vTwVk+FcAx4J6WEsyZgtnC
	ZFAqNd3K9k8XqJ8xk5A+hy9ItY9GHWoDQVNrSGw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-type,date,feedback-id,from,message-id,
	mime-version,subject,to;
Message-Instance: m=1; h=sha256:q/sdALHv1mMXtg4k0GfMoz33jFUaYvnaJ30Os/0zKAA=:SnaUuhXAKJ1WGK6qjKCtFtgBFkiarwcJx83d+O5zdJg=;
X-ME-Sender: <xms:nZcEa_xVj7WKRI6EiToWeEYZgoVIj-ma91YE2y8uWXD0B6xMQ7GX3g>
    <xme:nZcEawNelOWOebB-K2-1PLBLsk0YuZuH0t6Odu50FINjqwM5-6b7A876dInXUn0c5
    7kQeLlO9xfXOfOKgZ7rXXl3_TzfWyciroRhmrmQh7v52nEJF15gYYQ2>
X-ME-Received: <xmr:nZcEa04BoKc6WyBztDCrqm-pKQgVIyOQfFEYtEZAv5Q8vnRQ0C1nly5AUaf5qGLDclBS-Sk1G3wbuHB5Iou5oIA>
X-ME-Proxy-Cause: dmFkZTEtpVC57NewP72bSEdugBKl8HPruxQdGTMTe00UoZ7i6b88TXn1EzwKJ1hnLveh2N
    dD66OnqluybOumVGTSajvHJ2OWCW1GNNLboLNKGLQqfJnYgflIiFkjioFcKoSx3B1ehtV9
    425W4vT0PNZ3T6+USDnRJEChrU95KrJO2VpjkuhvedIsmFB/bgP39eRn8O4ZCZA64glwZO
    aKUTxbKAQYb4HsjtfYWLBupZhaC4UPHAA0506FsU0xgZ9xidSYQ+kzSbaQS1as0lJUO8gT
    aiIecpMIpWvQsCsqo7+LPFu8B9HDrFnrISYJ5GNyvlKdoVeWznS02AmcIOGCCnAadpqFoR
    RQMFVYzPUXRrG2I/gg/KZ9Y+kE3sWPQqoXncGpOWK+E/REXO9SLRMGi2zm9G2gecYSJyNK
    xgHLwROiVD2W/ETjcNcyuY2DqqJSLceHCA4oQudH/aqegOxynZGkgZrClqVn0Of/j74J+m
    pcLAAtn2/MR1+UfEdQotj8FzRU8NqI7fQ+W5I7NzCvxOIIIMKw3kJT95GrHr4NcS9ZMlXz
    lFW+kC6rhomGm05AUn1sD8H6mtVBbEbne8fG9Wxj5L/bY+bvPz05TJ9RoL9aPgByD72Xwt
    YlN8vQZQ7bHnpGOCsdEJDIHMP6IQijA+XI1dSTqP+EzbL7tiSBrXgcXpvO+w
X-ME-Proxy: <xmx:nZcEa5njpe_AzVLWT20Z4gN7CeX-16r837ZdhYMtYgMu6XLF8Z_s1A>
    <xmx:nZcEa9S47Nu59dGTRnAYH5mIFUoLfpOZQW94KNttF2aq0vSmeNgwKA>
    <xmx:nZcEawGaNnEyhHARlNv6qzvjkgHOErx1_rz7shxPPqUtiVnHMWiZ2w>
    <xmx:nZcEa6FH_n-JskpCLMTVMNetXz0w8VisU-PKIZ718ZETkAMD4Y0YEg>
    <xmx:npcEa_BWJCXtmXs9xh8Zct2PvGotKs_7LyBX4IbNyp_CyEulDlxjO6G_>
Feedback-ID: ib2794684:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 14:44:29 -0500 (EST)
From: Michael Greenberg <michael@greenberg.science>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 mgreenbe@stevens.edu
Subject: [PATCH] namei: don't count symlinks twice when a lookup restarts
Date: Mon, 23 Nov 2026 14:44:28 -0500
Message-ID: <87zeuz5o4j.fsf@hippogriff>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Since commit 2788cc47f459 ("Don't reset ->total_link_count on nested
calls of vfs_path_lookup()"), only set_nameidata() sets
->total_link_count, once per lookup. When a walk in RCU mode fails
with -ECHILD, filename_lookup(), __filename_parentat(), do_file_open()
and do_file_open_root() retry it in ref-walk mode with the same
nameidata, and the retry re-counts every link the abandoned walk had
already followed. The LOOKUP_REVAL retry after -ESTALE does the same.

So a path that crosses n symlinks fails with -ELOOP if the RCU walk
got through more than MAXSYMLINKS - n of them before giving up, which
is possible for any n > MAXSYMLINKS / 2. A mount or umount anywhere
on the system can make an RCU walk give up, since it changes
mount_lock's sequence count, so whether such a lookup fails depends on
unrelated activity. Opening the first link of a chain for 3 s, in a
4-CPU KVM guest, while another process mounted and unmounted a tmpfs
in its own mount namespace:

         v7.4-rc4               with this patch
  links  opens      -ELOOP      opens      -ELOOP
  20     1,350,902  0           1,109,467  0
  21     1,352,363  259,737     1,036,744  0
  40       947,012  449,441       571,202  0
  41       973,308  973,308       852,776  852,776

Without the mount loop, a 40-link chain never failed: 0 of 1.1 million
openat2() calls on a v7.3 host. The reproducer is below.

The fix is simple: restart the count in path_init(), which begins
every attempt, at the value set_nameidata() saved, if such a value
exists. This avoids the DoS risk 2788cc47f459 fixed while fixing the
incorrect -ELOOP returns.

Fixes: 2788cc47f459 ("Don't reset ->total_link_count on nested calls of vfs_path_lookup()")
Cc: stable@vger.kernel.org
Link: https://github.com/rrnewton/hermit/issues/5045
Signed-off-by: Michael Greenberg <michael@greenberg.science>
---
// SPDX-License-Identifier: GPL-2.0
//
// Spurious ELOOP from a symlink chain under MAXSYMLINKS, while mounts happen
// elsewhere on the system.
//
//   cc -O2 -Wall -o eloop-retry eloop-retry.c
//   ./eloop-retry 40 3     # chain of 40 links, open for 3 seconds
//
// It makes l1 -> l2 -> ... -> lN -> f in a fresh temporary directory. A child
// enters its own user and mount namespace and mounts and unmounts a tmpfs
// there in a loop. The parent opens l1 over and over, and counts the opens
// that fail with ELOOP. With N <= 20 none should, and with N > 40 all must.
// With 21 <= N <= 40, an unpatched kernel fails some: a walk that leaves RCU
// mode with -ECHILD is retried without resetting nd->total_link_count, so the
// links the first walk followed are counted twice.

#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <sched.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

static void die(const char *what)
{
	perror(what);
	exit(1);
}

int main(int argc, char **argv)
{
	int links = argc > 1 ? atoi(argv[1]) : 40;
	int seconds = argc > 2 ? atoi(argv[2]) : 3;
	char dir[] = "/tmp/eloop-retry.XXXXXX", name[32], target[32];
	long opens = 0, eloop = 0, other = 0;
	struct timespec now, end;
	pid_t churn;

	if (links < 1 || links > 100 || seconds < 1) {
		fprintf(stderr, "usage: %s [links 1-100] [seconds]\n", argv[0]);
		return 2;
	}
	if (!mkdtemp(dir) || chdir(dir) < 0)
		die(dir);
	if (close(open("f", O_CREAT | O_WRONLY, 0644)) < 0)
		die("f");
	for (int i = 1; i <= links; i++) {
		snprintf(name, sizeof(name), "l%d", i);
		if (i < links)
			snprintf(target, sizeof(target), "l%d", i + 1);
		else
			snprintf(target, sizeof(target), "f");
		if (symlink(target, name) < 0)
			die(name);
	}
	if (mkdir("mnt", 0755) < 0)
		die("mnt");

	churn = fork();
	if (churn < 0)
		die("fork");
	if (churn == 0) {
		if (unshare(CLONE_NEWUSER | CLONE_NEWNS) < 0)
			die("unshare");
		for (;;) {
			if (mount("t", "mnt", "tmpfs", 0, NULL) < 0)
				die("mount");
			if (umount("mnt") < 0)
				die("umount");
		}
	}

	clock_gettime(CLOCK_MONOTONIC, &end);
	end.tv_sec += seconds;
	do {
		int fd = open("l1", O_RDONLY);

		opens++;
		if (fd >= 0)
			close(fd);
		else if (errno == ELOOP)
			eloop++;
		else
			other++;
		clock_gettime(CLOCK_MONOTONIC, &now);
	} while (now.tv_sec < end.tv_sec ||
		 (now.tv_sec == end.tv_sec && now.tv_nsec < end.tv_nsec));

	kill(churn, SIGKILL);
	waitpid(churn, NULL, 0);
	printf("%d links: %ld opens, %ld ELOOP, %ld other errors\n",
	       links, opens, eloop, other);
	return eloop != 0;
}

 fs/namei.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 925aeb63bfa1..5f39d42ea6be 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2699,6 +2699,13 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->flags = flags;
 	nd->state |= ND_JUMPED;
 
+	/*
+	 * A retry in ref-walk mode after -ECHILD, or with LOOKUP_REVAL after
+	 * -ESTALE, starts the walk over. Start the link count from where we
+	 * left off, so we don't double count.
+	 */
+	nd->total_link_count = nd->saved ? nd->saved->total_link_count : 0;
+
 	nd->m_seq = __read_seqcount_begin(&mount_lock.seqcount);
 	nd->r_seq = __read_seqcount_begin(&rename_lock.seqcount);
 	smp_rmb();
-- 
2.53.0

