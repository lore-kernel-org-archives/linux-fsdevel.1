Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0741DED5;
	Thu, 27 Aug 2026 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787829385; cv=none; b=Z/tzQXvfLiAmFhoj3wS0jIAQ0fNv6wJ2OZXr46VbxzDdnUS/M8syB7WBcOpWyGDsR6HXwdMvoBC5PZ/OfbGKPCEqVnEVLRw1cuClAcEXirVFN78N2yYSR1KggLkbPreyH3zREFKbEehv8XSs/KuTaNsz75cXG3JHW395GXgwXlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787829385; c=relaxed/simple;
	bh=rJgaNg4NXkvxyL00fRFsfz4wVf5liHo6wpMPYbNvnCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNvjC9M2VXACQzm0bVV2PuN52Ts69S4JfO802tkPilbTJnFLNtCMcN8gfsbBITgO9NiMDloGVD+5sAPIt2j29CoYH28XqQ13ITVBAVV62sTcYz9F1bT65mMc3tZOrQjnYleIFlbp6hreEog1KsJUiGEa2JI/JKlMlPuUgvBeTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ete13qD/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sy4Pw6KA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qKKBZ/11; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/PzQCwM0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ete13qD/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sy4Pw6KA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qKKBZ/11";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/PzQCwM0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EEF21211E6;
	Thu, 27 Aug 2026 11:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787829374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WqQUP7lvA0V2Zho7rSjsm+X9ByhdA5NvsknnG2kcg=;
	b=Ete13qD/ZOmgyA4OIpfqjFAJ5/zepvqabbuRcESIavpiklqqAtg6eOdpvQlXUU/OADMEcp
	qXVWHpbomWOBMEqZbZUbe1ZjHLrbgH5trFTMNMzE8jSkErdTIk68p1skeOvUVWBVjYdPXz
	OXXY5ZACirhEReZPspy76pQovPZZnvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787829374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WqQUP7lvA0V2Zho7rSjsm+X9ByhdA5NvsknnG2kcg=;
	b=Sy4Pw6KAVABoKmV/U/rQ7lPmP0r1IlOP9fJ0EdEyokOcYsxNeE0tk0smWy0ARW0ZCei7bE
	wytanyCgNXzjWsCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787829369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WqQUP7lvA0V2Zho7rSjsm+X9ByhdA5NvsknnG2kcg=;
	b=qKKBZ/11v0xQBRpfeXbkxtjiSiT9kjhENPp9RwHb6JKRWiYamvLZ18huca4eHrPYNbquzP
	np0szK5v+dmCvbjhZKQXPb44c5OTS4qnZ1CsOD32YJ2PQzxzxR0BspAYlzFio1f/0xv2s3
	3KCcDqRUzHP0qaj7aFJ3HUTYbpQYn/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787829369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3WqQUP7lvA0V2Zho7rSjsm+X9ByhdA5NvsknnG2kcg=;
	b=/PzQCwM0lXkaCw4bWKYswoWH5RpREzgU9+uZG5cByksL9UGKQp+Jq79cZlm3eEs8GHPjuJ
	OuOEfvyfYRpVcxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E659A13354;
	Thu, 27 Aug 2026 11:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SWk7OHkckGr0ZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Aug 2026 11:16:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D252A1324; Thu, 27 Aug 2026 13:16:09 +0200 (CEST)
Date: Thu, 27 Aug 2026 13:16:09 +0200
From: Jan Kara <jack@suse.cz>
To: Bill Wendling <morbo@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: Add KUnit tests for fdtable
Message-ID: <egqqrzdu6e44fmlyh6p3h2zitq6jbuboupyveys6nbtszkliat@fx226q5x6txh>
References: <20260810204118.1981755-1-morbo@google.com>
 <20260827041732.188707-1-morbo@google.com>
 <20260827041732.188707-2-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827041732.188707-2-morbo@google.com>
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,linux.org.uk:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Thu 27-08-26 04:17:30, Bill Wendling wrote:
> This adds a KUnit test suite for fdtable to verify correct allocation,
> max_fds initialization, and dynamic object size of the fd array under
> __counted_by_ptr when CONFIG_CC_HAS_COUNTED_BY_PTR is enabled.
> 
> Assisted-by: Gemini:3.1-pro-preview
> Signed-off-by: Bill Wendling <morbo@google.com>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2 - Added 'test_dup_fd' testcase for separate allocation path.
> v3 - Add version to the PATCH subject line
> ---
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: codemender-patching+linux@google.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  fs/Kconfig               |  8 +++++
>  fs/file.c                |  4 +++
>  fs/tests/.kunitconfig    |  2 ++
>  fs/tests/fdtable_kunit.c | 72 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+)
>  create mode 100644 fs/tests/.kunitconfig
>  create mode 100644 fs/tests/fdtable_kunit.c
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index e05917adcd60..05b63f7506a7 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -421,4 +421,12 @@ source "fs/unicode/Kconfig"
>  config IO_WQ
>  	bool
>  
> +config FDTABLE_KUNIT_TEST
> +	bool "KUnit test for fdtable" if !KUNIT_ALL_TESTS
> +	depends on KUNIT=y
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the fdtable KUnit tests, which tests various aspects
> +	  of the fdtable structure and allocation.
> +
>  endmenu
> diff --git a/fs/file.c b/fs/file.c
> index 628ca07dc4b1..9c7001b901cf 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1529,3 +1529,7 @@ int iterate_fd(struct files_struct *files, unsigned n,
>  	return res;
>  }
>  EXPORT_SYMBOL(iterate_fd);
> +
> +#ifdef CONFIG_FDTABLE_KUNIT_TEST
> +#include "tests/fdtable_kunit.c"
> +#endif
> diff --git a/fs/tests/.kunitconfig b/fs/tests/.kunitconfig
> new file mode 100644
> index 000000000000..de67125a9421
> --- /dev/null
> +++ b/fs/tests/.kunitconfig
> @@ -0,0 +1,2 @@
> +CONFIG_KUNIT=y
> +CONFIG_FDTABLE_KUNIT_TEST=y
> diff --git a/fs/tests/fdtable_kunit.c b/fs/tests/fdtable_kunit.c
> new file mode 100644
> index 000000000000..6abd2a8d8f5d
> --- /dev/null
> +++ b/fs/tests/fdtable_kunit.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <kunit/test.h>
> +#include <linux/fdtable.h>
> +#include <linux/file.h>
> +
> +static void test_alloc_fdtable(struct kunit *test)
> +{
> +	struct fdtable *fdt;
> +	unsigned int slots = 64;
> +
> +	fdt = alloc_fdtable(slots);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
> +
> +	/* Check that max_fds is set correctly and is >= slots */
> +	KUNIT_EXPECT_GE(test, fdt->max_fds, slots);
> +
> +	/* Check that fd is allocated */
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt->fd);
> +
> +	/*
> +	 * Check dynamic object size of fdt->fd if compiler supports
> +	 * __counted_by_ptr.
> +	 */
> +#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> +	KUNIT_EXPECT_EQ(test, __builtin_dynamic_object_size(fdt->fd, 0),
> +			fdt->max_fds * sizeof(struct file *));
> +#endif
> +
> +	__free_fdtable(fdt);
> +}
> +
> +static void test_dup_fd(struct kunit *test)
> +{
> +	struct files_struct *newf;
> +	struct fdtable *fdt;
> +
> +	newf = dup_fd(&init_files, NULL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, newf);
> +
> +	fdt = rcu_dereference_raw(newf->fdt);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt);
> +
> +	/* Check that max_fds is set correctly and is >= NR_OPEN_DEFAULT */
> +	KUNIT_EXPECT_GE(test, fdt->max_fds, NR_OPEN_DEFAULT);
> +
> +	/* Check that fd is allocated */
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fdt->fd);
> +
> +	/*
> +	 * Check dynamic object size of fdt->fd if compiler supports
> +	 * __counted_by_ptr.
> +	 */
> +#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> +	KUNIT_EXPECT_EQ(test, __builtin_dynamic_object_size(fdt->fd, 0),
> +			fdt->max_fds * sizeof(struct file *));
> +#endif
> +
> +	put_files_struct(newf);
> +}
> +
> +static struct kunit_case fdtable_test_cases[] = {
> +	KUNIT_CASE(test_alloc_fdtable),
> +	KUNIT_CASE(test_dup_fd),
> +	{}
> +};
> +
> +static struct kunit_suite fdtable_test_suite = {
> +	.name = "fdtable",
> +	.test_cases = fdtable_test_cases,
> +};
> +
> +kunit_test_suite(fdtable_test_suite);
> -- 
> 2.55.0.897.gb25b4bd76c-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
