Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256BF3914FD
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784213558; cv=none; b=og5cXMk8Kj5l7wZJvJ8dgfBi2lyLBPL46k9pPLNbQ0gyLe/WnZTdY8DAjZiIjGZykiEpyuP2KHWBYPHECRLBvP6trGP3G9ZytaN0P3Nco/WzRubOSNTm0rOolqGJIt430luSAe8HNtK5n+jGtIWFxlAAQez/KH5UU8OTvhdyo5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784213558; c=relaxed/simple;
	bh=jy92LLrWp94YNBQBXJsnRNvITP4xCfKvaD+gvAGi27s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QommkFagiTf/x6Si3ilVNGhNCYEwCxzat9dT/Q1HEWVBEKnghv7zuCMLmo+kHgyNVYCv6UZjN9n1UlD51Pc09numdP9jKocDXnhzLmHOou5NhpWD8wdfTe4HkpaKYByMRcWKFCJSyXfPHm8J862ixb9bZENLz+9CQ2JsoHW7fUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rSxCRe6p; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CS5XclvV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jXmZAIeB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b64Qscsa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rSxCRe6p";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CS5XclvV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jXmZAIeB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b64Qscsa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89F443E2F;
	Thu, 16 Jul 2026 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784213554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYbhXGSgex5itBuC29L2tXsl/V6kL3xsKyCYsFqjByM=;
	b=rSxCRe6piz6Dh1MUjehtr1chjF63peln2fjo34OXzxQoSFSsY1fsZLroAmQMxmoawVC4o5
	EIWdSmo20NQn6tyXtqwxN7offs3mQtYuOuTuqBFuD1xcwZPAMInaGnh0HcMx8fy6Oqfmuj
	uqgphPQgGc59Zdlnb/lxVGV/oUMEPlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784213554;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYbhXGSgex5itBuC29L2tXsl/V6kL3xsKyCYsFqjByM=;
	b=CS5XclvVYEYLt205kX6mrAwz+ry/KC/sU5sWrKV4mOv71pByJZuFmm8v0Q6s3JTEl+V24l
	RMkif9inXa1vlQDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jXmZAIeB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b64Qscsa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784213553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYbhXGSgex5itBuC29L2tXsl/V6kL3xsKyCYsFqjByM=;
	b=jXmZAIeBkWd4Cgi6nP2iMy5A2eV4Gl2XR+9kC0EmhHjs9BjxsBdoS0Rg58LEPKZjY8Rznl
	5vHmGHYwboELrXQmEGbCyKHZ2t7CmELdQ87QqWTexM0wh869vls5L2lNxVw9eKfVJO5v9L
	pUnmWeqIpoeA11g1feL2LWI4vEDdvb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784213553;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lYbhXGSgex5itBuC29L2tXsl/V6kL3xsKyCYsFqjByM=;
	b=b64Qscsayz0EeVlcm/Qq4bib268deZBb9PH3n7AKTWFNfn9KnE3qApcGAkaIe7bG3CaOfw
	KvaYdEmEHe8OCSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 516B0779AD;
	Thu, 16 Jul 2026 14:52:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E+lcEjHwWGo4WgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 16 Jul 2026 14:52:33 +0000
Date: Fri, 17 Jul 2026 00:52:31 +1000
From: David Disseldorp <ddiss@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] kunit: use scoped_with_init_fs() in tests that resolve
 paths
Message-ID: <20260717005231.4720378d.ddiss@suse.de>
In-Reply-To: <20260701-work-kunit-nullfs-v1-1-dfa60270434f@kernel.org>
References: <20260701-work-kunit-nullfs-v1-1-dfa60270434f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 89F443E2F
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi Christian,

Sorry for the late response, I missed this...

On Wed, 01 Jul 2026 16:54:23 +0200, Christian Brauner wrote:

> KUnit runs each test in a kthread (kunit_generic_run_threadfn_adapter()).
...
> The initramfs tests hit the same
> wall: they call unpack_to_rootfs() (init_mkdir()/init_mknod() under the
> hood) and then verify with relative-name init_stat()/init_unlink()/
> filp_open(), all of which resolve against the nullfs root and pwd.
> 
> Wrap the path-resolving regions of both suites in scoped_with_init_fs(),
> which borrows the userspace init fs_struct (set up by init_userspace_fs()
> before kunit_run_all_tests()) for the duration. This is the same opt-in
> the rest of the tree uses for kthread path resolution. Doing it per test
> rather than blanket-wrapping the KUnit runner keeps the nullfs isolation
> in place for the many tests that should never touch the filesystem.

Doing it per-test certainly makes sense, but for initramfs I think it'd
be a little cleaner to just use the existing per-test init() callback
instead. I.e.:

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index bc55306d226dc..9cf316c13ffa5 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -3,6 +3,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/init.h>
 #include <linux/init_syscalls.h>
 #include <linux/initrd.h>
@@ -562,7 +563,7 @@ static struct kunit_case __refdata initramfs_test_cases[] = {
        {},
 };
 
-static int __init initramfs_test_init(struct kunit_suite *suite)
+static int __init initramfs_suite_init(struct kunit_suite *suite)
 {
        /*
         * unpack_to_rootfs() uses module-static state (victim, byte_count,
@@ -574,9 +575,23 @@ static int __init initramfs_test_init(struct kunit_suite *suite)
        return 0;
 }
 
+/* Tests run in a nullfs kthread; always use the init fs for path resolution. */
+static int __init initramfs_test_init(struct kunit *test)
+{
+       test->priv = __override_init_fs();
+       return 0;
+}
+
+static void __init initramfs_test_exit(struct kunit *test)
+{
+       __revert_init_fs(test->priv);
+}
+
 static struct kunit_suite __refdata initramfs_test_suite = {
        .name = "initramfs",
-       .suite_init = initramfs_test_init,
+       .suite_init = initramfs_suite_init,
+       .init = initramfs_test_init,
+       .exit = initramfs_test_exit,
        .test_cases = initramfs_test_cases,
 };
 kunit_test_init_section_suites(&initramfs_test_suite);

What do you think?

Cheers, David
