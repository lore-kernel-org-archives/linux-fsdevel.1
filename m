Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09863223DE9
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371791; cv=none; b=VbmLKEOdipuseUBaAvHOgtr49tzA+g/wd1cv3AkH4XvXrDOs19YWq+bH2ANT3htDBJNBVSRmqQj8CEJGl64SqnqRLAl/dVAM/bZV/rQPTX3+N+7/uU0tMcP0MNUtgF1W2rv69ANkkDzxHxEyPMhKwL1lSes2qkHGjIVWIWig6jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371791; c=relaxed/simple;
	bh=q6iB3VtxgCY3Xw/JKZ60wPNKrAlIDbrcICEJNsGe7KU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Hd4qN82H9J5umDTVyrr3XReoSB36uZrTrpdTrPgtOiV2qZzjzF3wd8XXpaPpfXBx5oQdawmW4lN5xEQLa3ujzT/qWA41WTeuR7cQmbaU+uvEwOQoP4EqRoeDjgggbzWzBZzNSophWoHj0TcuIP6jX/F1FXbJBQAeeJh4Os1amck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=QjDW5que; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="QjDW5que"
X-KPN-MessageId: d8524ed1-551c-11f1-bea8-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d8524ed1-551c-11f1-bea8-005056992ed3;
	Thu, 21 May 2026 15:56:20 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id d851394d-551c-11f1-83d9-00505699891e;
	Thu, 21 May 2026 15:56:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=xNoA4WAiTNyeHBSKuxYq9/XeyyCjjOWHJG/BdIu+aT8=;
	b=QjDW5queyv+BqSrYEcyG+IXugb+G8etXtX9wwC3QQ9c0A5Nw9lTSesrZCPujBstz0RfcxTHlCw5Jp
	 HmSgUmLAqumHcJTLR2bWUV1AwJFPnQmZXYMfS49dn92NTskteP+Tqug/S5y51rv3SAneWjHkA0Jwo2
	 Zp4jBWvrJug2+UE7piJ3F9tvqD08DL1OEgl7qisDGzN0K2lwOzEc/Dy8peXz31nFb5+LFIKXgOPbVz
	 xTQ4dXUX9ASI9tmiVekVM9YjkRI1Peb5IHVyUKAhv1b2tY77/Wswi5VZ/m51830R3AR542g5YLXQlG
	 UNty/bTRrTgfPvMcyZ5NXgmOdUU2NLg==
X-KPN-MID: 33|V0oQNxUDdeojKOe3tOZymwIXojTDQTe9BtWOWUC2VEIjyCvRG+wcCch29kFnD4w
 qdiWGrk3doo8Z0Rd+Vb1Zdi7bdky18Do0sf2XBybh4b4=
X-CMASSUN: 33|1BIxaS40/M0pJRP4nEbeLPqvpAt48dlTThw5ppesPtvn324tcccg+QU6LFS5kR8
 o/dUcXBQDySxkWjlmA9f9UA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id d8446141-551c-11f1-94b1-00505699eff2;
	Thu, 21 May 2026 15:56:20 +0200 (CEST)
Date: Thu, 21 May 2026 15:56:20 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Message-ID: <1947081210.2128972.1779371780097@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260521-wettstreit-meinen-46271dede480@brauner>
References: <20260521-wettstreit-meinen-46271dede480@brauner>
Subject: Re: [PATCH] selftests: openat2: port emptypath_test to kselftest
 harness
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal

Hi Christian,

Sorry I didn't yet get to this. Had a busy "my actual job" week and was also
trying to get the O_CREAT|O_DIRECTORY patch working, but it still has some issue.

This looks fine, feel free to add:

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

> Op 21-05-2026 12:55 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> Convert the emptypath selftests to the
> FIXTURE_SETUP()/FIXTURE_TEARDOWN() and the two checks become TEST_F()s.
> No change in coverage.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  .../filesystems/openat2/emptypath_test.c      | 92 ++++++++++++-------
>  1 file changed, 57 insertions(+), 35 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/openat2/emptypath_test.c b/tools/testing/selftests/filesystems/openat2/emptypath_test.c
> index d75b5e998ff9..be37ccba57ec 100644
> --- a/tools/testing/selftests/filesystems/openat2/emptypath_test.c
> +++ b/tools/testing/selftests/filesystems/openat2/emptypath_test.c
> @@ -1,55 +1,77 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
> +#define _GNU_SOURCE
>  #define __SANE_USERSPACE_TYPES__
>  #include <fcntl.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <string.h>
> +#include <sys/stat.h>
>  
> -#include "kselftest.h"
> +#include "kselftest_harness.h"
>  
>  #ifndef O_EMPTYPATH
>  #define O_EMPTYPATH	(1 << 26)
>  #endif
>  
> -int main(void)
> +#define EMPTYPATH_TEST_FILE "/tmp/emptypath_test"
> +
> +FIXTURE(emptypath) {
> +	int opath_fd;
> +};
> +
> +FIXTURE_SETUP(emptypath)
>  {
> -	int opath_fd, reopen_fd;
> -	const char *path = "/tmp/emptypath_test";
> -
> -	ksft_print_header();
> -	ksft_set_plan(2);
> -
> -	opath_fd = open(path, O_CREAT | O_WRONLY, S_IRWXU);
> -	if (opath_fd < 0)
> -		ksft_exit_fail_msg("create %s: %m\n", path);
> -	close(opath_fd);
> -
> -	opath_fd = open(path, O_PATH);
> -	if (opath_fd < 0)
> -		ksft_exit_fail_msg("open %s O_PATH: %m\n", path);
> -
> -	reopen_fd = openat(opath_fd, "", O_RDONLY);
> -	if (reopen_fd < 0 && errno == ENOENT)
> -		ksft_test_result_pass("empty path without O_EMPTYPATH returns ENOENT\n");
> -	else if (reopen_fd >= 0) {
> -		ksft_test_result_fail("empty path without O_EMPTYPATH unexpectedly succeeded\n");
> -		close(reopen_fd);
> -	} else {
> -		ksft_test_result_fail("empty path without O_EMPTYPATH: expected ENOENT, got %m\n");
> +	int fd;
> +
> +	self->opath_fd = -1;
> +
> +	fd = open(EMPTYPATH_TEST_FILE, O_CREAT | O_WRONLY, S_IRWXU);
> +	ASSERT_GE(fd, 0) {
> +		TH_LOG("create %s: %s", EMPTYPATH_TEST_FILE, strerror(errno));
>  	}
> +	close(fd);
>  
> -	reopen_fd = openat(opath_fd, "", O_RDONLY | O_EMPTYPATH);
> +	self->opath_fd = open(EMPTYPATH_TEST_FILE, O_PATH);
> +	ASSERT_GE(self->opath_fd, 0) {
> +		TH_LOG("open %s O_PATH: %s", EMPTYPATH_TEST_FILE, strerror(errno));
> +	}
> +}
>  
> -	if (reopen_fd < 0 && errno == EINVAL)
> -		ksft_exit_skip("O_EMPTYPATH not supported\n");
> +FIXTURE_TEARDOWN(emptypath)
> +{
> +	if (self->opath_fd >= 0)
> +		close(self->opath_fd);
> +	unlink(EMPTYPATH_TEST_FILE);
> +}
>  
> -	if (reopen_fd >= 0) {
> -		ksft_test_result_pass("O_EMPTYPATH reopens O_PATH fd\n");
> -		close(reopen_fd);
> -	} else {
> -		ksft_test_result_fail("O_EMPTYPATH failed: %m\n");
> +/* An empty path is rejected with ENOENT unless O_EMPTYPATH is set. */
> +TEST_F(emptypath, without_flag_returns_enoent)
> +{
> +	int fd = openat(self->opath_fd, "", O_RDONLY);
> +
> +	if (fd >= 0)
> +		close(fd);
> +	ASSERT_LT(fd, 0) {
> +		TH_LOG("empty path without O_EMPTYPATH unexpectedly succeeded");
> +	}
> +	EXPECT_EQ(errno, ENOENT) {
> +		TH_LOG("expected ENOENT, got %s", strerror(errno));
>  	}
> +}
> +
> +/* O_EMPTYPATH reopens the O_PATH fd through an empty path. */
> +TEST_F(emptypath, reopens_opath_fd)
> +{
> +	int fd = openat(self->opath_fd, "", O_RDONLY | O_EMPTYPATH);
> +
> +	if (fd < 0 && errno == EINVAL)
> +		SKIP(return, "O_EMPTYPATH not supported");
>  
> -	unlink(path);
> -	ksft_finished();
> +	ASSERT_GE(fd, 0) {
> +		TH_LOG("O_EMPTYPATH failed: %s", strerror(errno));
> +	}
> +	close(fd);
>  }
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.47.3
