Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C82A3FA5CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358878; cv=none; b=qG8OUQI1M0pcFJW5KclJULO7/iWiZH219S+sMkt66xv8fknIEQO2MEi89ROuVDLtXen7ozRqXHUEQ/+kwDa3KJiRcEWPjF6PhnN1FJmzH7uPqfDB7CNMqKYEsdR/HNBRRGtuJNzN9qPwx8/0MwYh3Z9EtenwSs6hNtZO6usXTw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358878; c=relaxed/simple;
	bh=mlfPJShk09pyjnqMwVqI1uVQ+DrA07X5uIhollU1068=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5e8BgPt468NixlscQyakXVFv5jLanWBUgmojq2Lo8yDZkvcrQSlrda1LXIf9q3BoAn5PeNidm91QyAdICaP4wB9ALWSVCpnEPHpcNAKXtQcqyMq8XmEs18dnnTCgYI2YSCtP9EN88dSHyNjE2Ogl5kT9Jw21qkWLAxv66wbL+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NceDan15; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NceDan15"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48558d6ef83so38058505e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 06:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774358870; x=1774963670; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJ6hFcMk7IiyKpKE0pSjnbzulJlv1YO0rPk2oh4pfE0=;
        b=NceDan15UDS07Zc6XCsP6SxtzB2Rj70Mdd0298Ay9atcjTcjgYhUrY4PflM/oTdWL4
         VCFs5tZ6asNLO/BJt9HWYSIR4zZxFx1UMRkbqzIAlTMOcGtT0NKdhKDpSMHbQdLFd3iU
         J2xSbhy9hewzjCpOvkfpQcbaH9D3v37sklzyyo6ziCHZuDzR0jsasYLsZi5PBscsydlH
         bYjPRmw+l121tufs7bhgzNIcnta/tgainw8ZRZKgQt/+pXy63A1jVqfQH/I6H/YJSYj+
         iO1tKLq5R+lMBCyZguDZvUO+wuY6WWhir8HKNr1d8oJ1L6ZU3yv4j4yvh4oPI1yLkcoK
         r3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358870; x=1774963670;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJ6hFcMk7IiyKpKE0pSjnbzulJlv1YO0rPk2oh4pfE0=;
        b=VP1BTPWgsBSZ2iDv0fX4JwxiR795riAdGQP1QyAt/xld9OgGCbXCkVSGrvbm60ahvU
         tAWjLDadJduKqKsQyL90Dhz91CiB2Pxk2ym7TsHcP6zmot/ci9qWEOdEwAHJuRgnE+NS
         RuOwsj+ONZK1HJWhLD4K6+6Th94rV8ZPNYiDooQy+26lY+i5zzUC2iLa7f9v/EwzmJwr
         k2B2AcdufO5Zyb0EuBwbMnnc7qRlk8GnbPxp5Whk76AhM4zEfeX766OYUwUglSPnnsZJ
         ZQVjW5tW6GK4CP1F5yxgAufgsZKG0ZbOeLjXbdY2rDIfsyGaGXwtg41y0YodwE6Ig2R2
         W+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf70U3WxsFkYIro3jIBi6kwtnsRjwtH+qAKXaflW4k90+jQ+boLcjx6mE6oqbiTSKOmx5ByLb345Wfd5AJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxI5jWmSJ/n4fy3WwQkt9FJ4WRresiya3mVhz7ABHkJchorah2p
	xItvYDoAIjSf/M/cdPX7eWHtuLjQQOXdZ0qxHbu83NVpzcwkT6TfJpdHKAvtiyom6w==
X-Gm-Gg: ATEYQzwukvjHASod5PJ9yOj/fhajNNtCSZqysP2fI0LDAc4NDXHGta8zlBE4uUqvyDl
	XuFxNQ3ZBG0J+G0ZRooUpBF31X8KSvDMVTVEBFDQSfJd6wAvbJ34jH3X43vq354KqyxNxEsD5F7
	A1SkzZPT1Qny/PRPwIkHnRhDkxRgCxl/sYFUSFPm4E8TZtMJXGmDVAVaNcjxmLgQnfWVnXUuEpw
	yTw9vVO8xDWgYAW8HBszyHd5tQk7xrt9+pNR7t18/220ArgOelEW1dpuUVAAoLAJp3b9xe/qoGZ
	OZn5ulsXy0px3KHNS/2IbrwG3J2A6BtlFsoM9TVaDm1Mcx+9fkVl6F2SP3OWwXRqsu0XdszBphD
	h26G3ttHQk30FIyENgvcVR/Y0jZGFPg1yFkc1V2TYg9TH+5RvdXSk/oExrsDCof3LiaaQWFJB1J
	uqSpapM09q6eCk1jz8a7vbK7hLGPpXiDLXnIV5CkvFYrgQc3YVriWN65s5li/nVRlP
X-Received: by 2002:a05:600c:a43:b0:486:fbd1:9dc0 with SMTP id 5b1f17b1804b1-486fee0d52fmr213826905e9.22.1774358869131;
        Tue, 24 Mar 2026 06:27:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:820c:ac9a:1d85:a65e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116ee562sm59082225e9.15.2026.03.24.06.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:27:48 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:27:43 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 07/11] selftests/landlock: Drain stale audit
 records on init
Message-ID: <acKRT6_wJkISyrLb@google.com>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-8-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-8-mic@digikod.net>

On Thu, Mar 12, 2026 at 11:04:40AM +0100, Mickaël Salaün wrote:
> Non-audit Landlock tests generate audit records as side effects when
> audit_enabled is non-zero (e.g. from boot configuration).  These records
> accumulate in the kernel audit backlog while no audit daemon socket is
> open.  When the next test opens a new netlink socket and registers as
> the audit daemon, the stale backlog is delivered, causing baseline
> record count checks to fail spuriously.
> 
> Fix this by draining all pending records in audit_init() right after
> setting the receive timeout.  The 1-usec SO_RCVTIMEO causes audit_recv()
> to return -EAGAIN once the backlog is empty, naturally terminating the
> drain loop.
> 
> Domain deallocation records are emitted asynchronously from a work
> queue, so they may still arrive after the drain.  Remove records.domain
> == 0 checks from tests where a stale deallocation record from a previous
> test could cause spurious failures.
> 
> Also fix a socket file descriptor leak on error paths in audit_init():
> if audit_set_status() or setsockopt() fails (e.g.  when another audit
> daemon is already registered), close the socket before returning.
> 
> Fix off-by-one checks in matches_log_domain_allocated() and
> matches_log_domain_deallocated() where snprintf() truncation was
> detected with ">" instead of ">=" (snprintf() returns the length
> excluding the NUL terminator, so equality means truncation).
> 
> Cc: Günther Noack <gnoack@google.com>
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>  tools/testing/selftests/landlock/audit.h      | 29 +++++++++++++++----
>  tools/testing/selftests/landlock/audit_test.c |  2 --
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 44eb433e9666..550acaafcc1e 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -309,7 +309,7 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
>  
>  	log_match_len =
>  		snprintf(log_match, sizeof(log_match), log_template, pid);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
> @@ -326,7 +326,7 @@ static int __maybe_unused matches_log_domain_deallocated(
>  
>  	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
>  				 num_denials);
> -	if (log_match_len > sizeof(log_match))
> +	if (log_match_len >= sizeof(log_match))
>  		return -E2BIG;
>  
>  	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
> @@ -379,19 +379,36 @@ static int audit_init(void)
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
>  	if (err)
> -		return err;
> +		goto err_close;
>  
>  	/* Sets a timeout for negative tests. */
>  	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
>  			 sizeof(audit_tv_default));
> -	if (err)
> -		return -errno;
> +	if (err) {
> +		err = -errno;
> +		goto err_close;
> +	}
> +
> +	/*
> +	 * Drains stale audit records that accumulated in the kernel backlog
> +	 * while no audit daemon socket was open.  This happens when
> +	 * non-audit Landlock tests create domains or trigger denials while
> +	 * audit_enabled is non-zero (e.g. from boot configuration), or when
> +	 * domain deallocation records arrive asynchronously after a
> +	 * previous test's socket was closed.
> +	 */
> +	while (audit_recv(fd, NULL) == 0)
> +		;
>  
>  	return fd;
> +
> +err_close:
> +	close(fd);
> +	return err;
>  }
>  
>  static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
> diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
> index 46d02d49835a..f92ba6774faa 100644
> --- a/tools/testing/selftests/landlock/audit_test.c
> +++ b/tools/testing/selftests/landlock/audit_test.c
> @@ -412,7 +412,6 @@ TEST_F(audit_flags, signal)
>  		} else {
>  			EXPECT_EQ(1, records.access);
>  		}
> -		EXPECT_EQ(0, records.domain);
>  
>  		/* Updates filter rules to match the drop record. */
>  		set_cap(_metadata, CAP_AUDIT_CONTROL);
> @@ -601,7 +600,6 @@ TEST_F(audit_exec, signal_and_open)
>  	/* Tests that there was no denial until now. */
>  	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
>  	EXPECT_EQ(0, records.access);
> -	EXPECT_EQ(0, records.domain);
>  
>  	/*
>  	 * Wait for the child to do a first denied action by layer1 and
> -- 
> 2.53.0
> 

Ooh, nice catch!  I have definitely stumbled across this bug in the
past (especially when the kernel is compiled with more debugging
options), and I know from Justin that he ran into it as well.
Draining the audit logs before sending a new stimulus for audit
logging looks like a good approach.

Reviewed-by: Günther Noack <gnoack@google.com>

—Günther
