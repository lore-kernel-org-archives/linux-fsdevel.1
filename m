Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D669F1A9F83
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773792912; cv=none; b=vEBH6TiOim3Vx369SIDlZUsACPVprHYmjJ3o8lEIIzKK+8cMVz+dziBRoiXU8ZNZfL2I7LT98cjzPNiLELLD7Z0LBDMRrkjiQoimJlHbMeV7tptuD4UtxLggZ1E/xa01gBAvgIuWge1R4vmm/Sxoo4EHYjNlEmmFa7ahUvqODDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773792912; c=relaxed/simple;
	bh=U/4zbzduSWp9tgSwuOZpc2Rs7vg9+R+6jxqMxwvC/9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSumzr2S+KPW54pAewSRFFol74vB68pNLIYCzdlKtmEg/FyiNdUitouTAoP8sKOZKIYUug88Kf0PrWcNJQUo5P/gAebADBMA1o03xEa0ZH5wP3EMw0Jej45pEjUNDUauCw/mp+ODvkq5552BrgswkfEIkdUaqarjm8O2CxpIeJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjaOSh3N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjaOSh3N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87424C4CEF7;
	Wed, 18 Mar 2026 00:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773792912;
	bh=U/4zbzduSWp9tgSwuOZpc2Rs7vg9+R+6jxqMxwvC/9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjaOSh3NwoOinRqJpvApPgENdP89yyIGgdYFJLtFE3rdF8xI+vjw9jLJu4R3Ocv+j
	 RzB/dbuJV3rLfN71a+t2YSBI+co/IQN5gsQPQNMaEIQvOHvhQdwnNZ+yyLajaxA6g2
	 dsbG3E25xVvFYhiRj6hCmhStuvd9OP8WQ2MNjdKWPijhP5JLSrwP0nhXcaJurOWRXF
	 3KWueTVoQGlHEa4UhBfq+9C20PIXe7eLT6xo2Gz04Uo/IFH9cEARN3EF43IOzEE9TS
	 dd/L8J+lXuy1JqvI35egE5Hygbzj3bwTM7c9+PNTD1iWS5MBug4skOmJ8s1Sos4IGF
	 HjS+zEab8s5SA==
Date: Tue, 17 Mar 2026 17:15:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: bschubert@ddn.com, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Subject: Re: [GIT PULL v2] libfuse: run fuse servers as a contained service
Message-ID: <20260318001512.GT6069@frogsfrogsfrogs>
References: <20260316235017.GK1742010@frogsfrogsfrogs>
 <70550759-eae2-482d-a598-164d10930220@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70550759-eae2-482d-a598-164d10930220@bsbernd.com>

On Wed, Mar 18, 2026 at 12:08:37AM +0100, Bernd Schubert wrote:
> 
> 
> On 3/17/26 00:50, Darrick J. Wong wrote:
> > Hi Bernd,
> > 
> > I hope you're feeling better!
> 
> Thank you much better!
> 
> > 
> > Please have a look at this branch with changes for libfuse.  This second
> > PR contains a bunch of new things:
> > 
> >  * Cleaned up error code handling and logging
> >  * Examples of systemd-enabled high and low-level fuse servers
> >  * Most of the checkpatch complaints addressed
> >  * fuservicemount3 can now be a setuid program to allow unprivileged
> >    userspace to fire up a contained filesystem driver.  This could be
> >    opening Pandora's box...
> > 
> > As usual, I did a test-merge with the main upstream branch as of a few
> > minutes ago, and didn't see any conflicts.  Please let me know if you
> > encounter any problems.
> 
> I only found a minute to pull and push to my github repo to update the PR. 
> BSD still fails
> 
> 2026-03-17T23:01:17.9810147Z FAILED: [code=1] example/hello_ll.p/single_file.c.o 
> 2026-03-17T23:01:17.9813484Z cc -Iexample/hello_ll.p -Iexample -I../example -Iinclude -I../include -Ilib -I../lib -I. -I.. -fdiagnostics-color=always -Wall -Winvalid-pch -Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -pthread -MD -MQ example/hello_ll.p/single_file.c.o -MF example/hello_ll.p/single_file.c.o.d -o example/hello_ll.p/single_file.c.o -c ../example/single_file.c
> 2026-03-17T23:01:17.9817014Z ../example/single_file.c:46:10: error: use of undeclared identifier 'PTHREAD_MUTEX_INITIALIZER'
> 2026-03-17T23:01:17.9817870Z    46 |         .lock = PTHREAD_MUTEX_INITIALIZER,
> 2026-03-17T23:01:17.9818369Z       |                 ^
> 2026-03-17T23:01:17.9819309Z ../example/single_file.c:198:51: warning: unused parameter 'ino' [-Wunused-parameter]
> 2026-03-17T23:01:17.9820276Z   198 | void single_file_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
> 2026-03-17T23:01:17.9821012Z       |                                                   ^
> 2026-03-17T23:01:17.9821785Z ../example/single_file.c:198:60: warning: unused parameter 'flags' [-Wunused-parameter]
> 2026-03-17T23:01:17.9823239Z   198 | void single_file_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
> 2026-03-17T23:01:17.9824029Z       |                                                            ^
> 2026-03-17T23:01:17.9824978Z ../example/single_file.c:198:71: warning: unused parameter 'mask' [-Wunused-parameter]
> 2026-03-17T23:01:17.9829337Z   198 | void single_file_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
> 2026-03-17T23:01:17.9830366Z       |                                                                       ^
> 2026-03-17T23:01:17.9832001Z ../example/single_file.c:199:33: warning: unused parameter 'fi' [-Wunused-parameter]
> 2026-03-17T23:01:17.9833062Z   199 |                        struct fuse_file_info *fi)
> 2026-03-17T23:01:17.9833562Z       |                                               ^
> 2026-03-17T23:01:17.9834825Z ../example/single_file.c:211:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2026-03-17T23:01:17.9836166Z   211 |         pthread_mutex_lock(&single_file.lock);
> 2026-03-17T23:01:17.9836592Z       |         ^
> 2026-03-17T23:01:17.9837750Z ../example/single_file.c:226:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2026-03-17T23:01:17.9869585Z   226 |         pthread_mutex_unlock(&single_file.lock);
> 2026-03-17T23:01:17.9870081Z       |         ^
> 2026-03-17T23:01:17.9871240Z ../example/single_file.c:239:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2026-03-17T23:01:17.9872595Z   239 |         pthread_mutex_lock(&single_file.lock);
> 2026-03-17T23:01:17.9873056Z       |         ^
> 2026-03-17T23:01:17.9874265Z ../example/single_file.c:241:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2026-03-17T23:01:17.9876020Z   241 |         pthread_mutex_unlock(&single_file.lock);
> 2026-03-17T23:01:17.9876497Z       |         ^
> 2026-03-17T23:01:17.9877854Z ../example/single_file.c:252:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2026-03-17T23:01:17.9879416Z   252 |         pthread_mutex_lock(&single_file.lock);
> 2026-03-17T23:01:17.9879896Z       |         ^
> 2026-03-17T23:01:17.9881050Z ../example/single_file.c:259:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2026-03-17T23:01:17.9882409Z   259 |         pthread_mutex_unlock(&single_file.lock);
> 2026-03-17T23:01:17.9882862Z       |         ^
> 2026-03-17T23:01:17.9884018Z ../example/single_file.c:273:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2026-03-17T23:01:17.9885354Z   273 |         pthread_mutex_lock(&single_file.lock);
> 2026-03-17T23:01:18.0387503Z       |         ^
> 2026-03-17T23:01:18.0402115Z ../example/single_file.c:275:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
> 2026-03-17T23:01:18.0403861Z   275 |         pthread_mutex_unlock(&single_file.lock);
> 2026-03-17T23:01:18.0404573Z       |         ^
> 2026-03-17T23:01:18.0404979Z 12 warnings and 1 error generated.

Aha, I bet that came as a result of me boneheadedly copying this from
lib/util.c:

#ifdef HAVE_PTHREAD_SETNAME_NP
#define _GNU_SOURCE
#include <pthread.h>
#endif

Will fix that right up.

> And actually, the Ubuntu build also fails
> 
> [12/109] Compiling C object lib/libfuse3.so.3.19.0.p/fuse_service.c.o
> FAILED: [code=1] lib/libfuse3.so.3.19.0.p/fuse_service.c.o 
> clang -Ilib/libfuse3.so.3.19.0.p -Ilib -I../../../home/runner/work/libfuse/libfuse/lib -Iinclude -I../../../home/runner/work/libfuse/libfuse/include -I. -I../../../home/runner/work/libfuse/libfuse -fdiagnostics-color=always -fsanitize=address,undefined -fno-omit-frame-pointer -Wall -Winvalid-pch -Wextra -Werror -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -fPIC -pthread -DFUSE_USE_VERSION=317 '-DFUSERMOUNT_DIR="/tmp/libfuse-install-wwy0ckA/bin"' -MD -MQ lib/libfuse3.so.3.19.0.p/fuse_service.c.o -MF lib/libfuse3.so.3.19.0.p/fuse_service.c.o.d -o lib/libfuse3.so.3.19.0.p/fuse_service.c.o -c ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c
> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:400:19: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>   400 |                 sf->allow_other = 1;
>       |                                 ^ ~
> ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:473:21: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
>   473 |         sf->owns_fusedevfd = 1;

Er... ok.  Debian 13 gcc (14.2) doesn't complain about this, but fmeh,
I'll just turn that into a fullblown int. :)

Thanks for dipping your toes in!

--D

>       |                            ^ ~
> 2 errors generated.
> [13/109] Compiling C object lib/libfuse3.so.3.19.0.p/modules_subdir.c.o
> 
> Checkpatch looks much better, I can push a patch tomorrow to disable the
> strcpy warning. 
> 
> Other than that I didn't look at the actual changes yet, will really try
> to review this week.
> 
> Thanks,
> Bernd
