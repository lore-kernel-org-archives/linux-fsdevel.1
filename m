Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407AF56261A;
	Tue, 29 Sep 2026 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713150; cv=none; b=KbF1VJdUjdJDG36IXcL8h1jYxiGBHcFyE60SQNWPuxOQfQFMzII4RweRBVXNu5bQf8bp6N/UDTpA3GpopUcPe/8LooPzDeu/oPb/MTkmLTNZUC062SnAoMPHwALYjMfOpOCFO7P+4XIOlcCEnri3I6AY4RS5BJKwXUOQYX40iUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713150; c=relaxed/simple;
	bh=URp8pcmwNAm2MkEbMlEchc34FoEgHKirhrtjH5VY9i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsh3JCXeOZhx1CxzMEJSNghiyWVpDHd07arvV9qybWDhgeCvjPp53IL0Eed2DM3pkR4XOjFvVdViXf7ZL47SVhqpv+WfqpMDU3oFyfOP8DkY8orxkVWu2hXODvJK15RD5w8Emtv/ryvc6hG935C9Wi6LVi4fYgnU9hHDAdjAI7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TZKu7zaL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PSpmbtM1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jTWGaLUl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vvZQiVgZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TZKu7zaL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PSpmbtM1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jTWGaLUl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvZQiVgZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C394921D9C;
	Tue, 29 Sep 2026 20:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790713141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5aqf7D8WUb3vYPshP37qlYVkzECYgJtcwMuXevseHU=;
	b=TZKu7zaLczYRDhiRrvjEnp/4fVUcsXWzZ1ZT77mx0KBIfijFA+Qf3En2HGu6elbolz0qbx
	inBkJC/9GOBo/uxQuLTCSOM1wU3IcB1xZd4SWwIRVOqzdbqcpRdmag9oGgSL6aA1xJSqdN
	RqdG9/3VDxGNzmOvuEZVBfTehf6317A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790713141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5aqf7D8WUb3vYPshP37qlYVkzECYgJtcwMuXevseHU=;
	b=PSpmbtM1R8PhfbUx0QE0/sUIVRmMtkh3mcgNWJ95Cmhaq48McYlhNjX+OyBNVr01NqzsOw
	cNrYpwhPes0y7yCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790713137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5aqf7D8WUb3vYPshP37qlYVkzECYgJtcwMuXevseHU=;
	b=jTWGaLUl0DX6jpGgKiOKrWBWFAWqymZDJ7SzN2Cw5Myp3ZkI+KgvxuHX6XLksLt2s7ba9a
	ZCRAEc26Tl0nPg5sleLHABMP+4OqYpcxskxI+FT3/VF5g281kOMXzbzP3NosTWsCQyBzuX
	quVEU7umkuthvadbtIwOXm+MdbYqUwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790713137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5aqf7D8WUb3vYPshP37qlYVkzECYgJtcwMuXevseHU=;
	b=vvZQiVgZrz/zgkvnMD/H/CZp1VWr71I7UdsT+CJJUHAxjNcga8ulVOuFVsOM/YpJxuPW0b
	jCxLeMipHApSQfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B15B136D1;
	Tue, 29 Sep 2026 20:18:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2u9rHDEdvGquVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Sep 2026 20:18:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 230BBA133D; Tue, 29 Sep 2026 22:18:57 +0200 (CEST)
Date: Tue, 29 Sep 2026 22:18:57 +0200
From: Jan Kara <jack@suse.cz>
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Thomas Maarseveen <maarseveent@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] lib/tests: errseq: add a concurrent
 check_and_advance test
Message-ID: <4znyopxfl4bd2sas2lwchnl7bw3borwratcpiwbxlycx5fyszd@i5dmmpapmlu4>
References: <20260927051726.71337-1-jain.sm@gmail.com>
 <20260927051726.71337-3-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927051726.71337-3-jain.sm@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,suse.cz,brown.name,gmail.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Sun 27-09-26 10:47:26, Shashank Mohan Jain wrote:
> Add a test case that races errseq_check_and_advance() on one CPU
> against errseq_set() of a different error on another CPU, then records
> the first error again and lets a second cursor consume it. The second
> -EIO is recorded after the first cursor's check returned, so that
> cursor's next check must report an error, whichever way the race with
> -ENOSPC went.
> 
> Without the previous commit 1-6% of 2 million rounds lose the error
> on UML with 4 CPUs (seccomp=on ncpus=4); with it none do. The case is
> skipped on a single CPU and stops after 5 seconds.
> 
> Assisted-by: LLM
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Needs the errseq KUnit suite from commit b52f5c1605f2 ("lib/tests: add
> KUnit tests for errseq"), which is in mm-nonmm-unstable. The case is
> skipped unless the kernel has at least two CPUs (on UML:
> --kernel_args seccomp=on --kernel_args ncpus=4).
> 
>  lib/tests/errseq_kunit.c | 110 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 105 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/tests/errseq_kunit.c b/lib/tests/errseq_kunit.c
> index 8f39ebc4a248..5ebc411ea749 100644
> --- a/lib/tests/errseq_kunit.c
> +++ b/lib/tests/errseq_kunit.c
> @@ -2,21 +2,26 @@
>  /*
>   * KUnit tests for the errseq_t error-tracking infrastructure.
>   *
> - * These exercise the documented single-threaded semantics of the errseq
> - * API (see Documentation/core-api/errseq.rst and lib/errseq.c): error
> + * Most cases exercise the documented single-threaded semantics of the
> + * errseq API (see Documentation/core-api/errseq.rst and lib/errseq.c): error
>   * recording and overwriting, the "seen" handoff between errseq_sample()
>   * and errseq_check_and_advance(), and the re-reporting of an error that
>   * is recorded again after it has been seen.
>   *
> - * The lockless properties of errseq_t under concurrent updates are
> - * outside the scope of these deterministic tests, as is the WARN path
> - * for invalid error values.
> + * The WARN path for invalid error values is not tested.  The last case
> + * races errseq_set() against errseq_check_and_advance() on another CPU.
>   */
>  #include <kunit/test.h>
>  
> +#include <linux/atomic.h>
> +#include <linux/cpumask.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/errseq.h>
> +#include <linux/jiffies.h>
> +#include <linux/kthread.h>
> +#include <linux/random.h>
> +#include <linux/sched.h>
>  
>  /*
>   * A zeroed errseq_t is the "no error has ever occurred" epoch: it
> @@ -209,6 +214,100 @@ static void errseq_test_two_subscribers_independent(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, errseq_check_and_advance(&eseq, &cursor_b), 0);
>  }
>  
> +/*
> + * errseq_check_and_advance() racing with errseq_set() on another CPU.
> + *
> + * Each round, cursor @f checks an unseen -EIO while another CPU records
> + * -ENOSPC.  Afterwards -EIO is recorded again and cursor @g checks.  The
> + * second -EIO is recorded after @f's check returned, so @f's next check
> + * must report an error, whichever way the race with -ENOSPC went.
> + */
> +struct errseq_race {
> +	errseq_t eseq;
> +	atomic_t go;		/* round the writer should run */
> +	atomic_t done;		/* last round the writer completed */
> +	unsigned int wdelay;
> +};
> +
> +static void errseq_race_spin(unsigned int n)
> +{
> +	while (n--)
> +		cpu_relax();
> +}
> +
> +static int errseq_race_writer(void *data)
> +{
> +	struct errseq_race *r = data;
> +	int seen = 0;
> +
> +	while (!kthread_should_stop()) {
> +		int round = atomic_read_acquire(&r->go);
> +
> +		if (round == seen) {
> +			cond_resched();
> +			continue;
> +		}
> +		seen = round;
> +		errseq_race_spin(READ_ONCE(r->wdelay));
> +		errseq_set(&r->eseq, -ENOSPC);
> +		atomic_set_release(&r->done, round);
> +	}
> +	return 0;
> +}
> +
> +#define ERRSEQ_RACE_ROUNDS	2000000
> +#define ERRSEQ_RACE_SECONDS	5
> +
> +static void errseq_test_check_and_advance_race(struct kunit *test)
> +{
> +	struct errseq_race *r;
> +	struct task_struct *writer;
> +	unsigned long deadline;
> +	int round, unreported = 0, missed = 0;
> +
> +	if (num_online_cpus() < 2)
> +		kunit_skip(test, "needs at least two CPUs");
> +
> +	r = kunit_kzalloc(test, sizeof(*r), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, r);
> +
> +	writer = kthread_run(errseq_race_writer, r, "errseq_race");
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(writer));
> +
> +	deadline = jiffies + ERRSEQ_RACE_SECONDS * HZ;
> +	for (round = 1; round <= ERRSEQ_RACE_ROUNDS; round++) {
> +		errseq_t f = 0, g = 0;
> +
> +		WRITE_ONCE(r->eseq, 0);
> +		errseq_set(&r->eseq, -EIO);
> +		WRITE_ONCE(r->wdelay, get_random_u32_below(64));
> +		atomic_set_release(&r->go, round);
> +
> +		errseq_race_spin(get_random_u32_below(64));
> +		if (!errseq_check_and_advance(&r->eseq, &f))
> +			unreported++;
> +
> +		while (atomic_read_acquire(&r->done) != round)
> +			cond_resched();
> +
> +		/* Recorded after f's check returned: f must hear about it. */
> +		errseq_set(&r->eseq, -EIO);
> +		errseq_check_and_advance(&r->eseq, &g);
> +		if (!errseq_check_and_advance(&r->eseq, &f))
> +			missed++;
> +
> +		if (time_after(jiffies, deadline))
> +			break;
> +		if (!(round & 1023))
> +			cond_resched();
> +	}
> +	kthread_stop(writer);
> +
> +	kunit_info(test, "%d rounds, %d missed errors\n", round - 1, missed);
> +	KUNIT_EXPECT_EQ(test, unreported, 0);
> +	KUNIT_EXPECT_EQ(test, missed, 0);
> +}
> +
>  static struct kunit_case errseq_test_cases[] = {
>  	KUNIT_CASE(errseq_test_zero_epoch_reports_no_error),
>  	KUNIT_CASE(errseq_test_set_records_error),
> @@ -223,6 +322,7 @@ static struct kunit_case errseq_test_cases[] = {
>  	KUNIT_CASE(errseq_test_repeat_error_visible_to_all_cursors),
>  	KUNIT_CASE(errseq_test_advance_stable_when_unchanged),
>  	KUNIT_CASE(errseq_test_two_subscribers_independent),
> +	KUNIT_CASE_SLOW(errseq_test_check_and_advance_race),
>  	{}
>  };
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
