Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B318872A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788922; cv=none; b=R0zkuLKqVEAOWF37GYw6P+iLJSrXIpbdHx8Hu7pQEq0hCDr0gsXLXOXVwCY2NlOnPmC2/AMYbgFlPy6gdD+YlwbPIUWdMT/bg0XKYvr/wkmGZ9SwJfb1eQ7SZ9M/Eb1nFZMl2rPfrlamybJXMVNko8XfgE0Cxyq54MoybyWIyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788922; c=relaxed/simple;
	bh=YtnB8mHCRKPFlUOS63chLxROv0T6t72KBwwP5NgG878=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEEvS7IVEwFKkaW8Lr5NiHqJxwSgtNX9gEfwyU8G0UMiY4liQmLePXHY4BpTrNeL/TdKDYp8uVcoI172XpkoLWuUMrPnkr44yUv0KYn0Y+/BgHq0yE48xD86HDCYDKZggr7cJpzKefJHOlKRnZkORRZXgW9DJ92R1tifvaOcrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=KDuT1aCA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dq7HuYvT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="KDuT1aCA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dq7HuYvT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 863E61D00211;
	Tue, 17 Mar 2026 19:08:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 19:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773788919;
	 x=1773875319; bh=gBT/l3JVrcxOwshd4Ofs3cf6XtZetBd/EV78l2vIBmM=; b=
	KDuT1aCALKxQZ3D7MBBxa4G6Ftc/QEQdcgE5uvUsR9A9fj8beI/Fc5IhRB4sfn9s
	K7+XkNOCs/2mEgUm3EUUYkDcfmoCUrBTnztO8p6fVT8ViQ9zIcXZWksPxf7iC+qU
	Xm8YzEZBBM9fNSLEOiCVaOVRnddcEKjYvAeo4b5VdCWGkT1Lb1nffKA0RCJ59wUc
	k8/rN2xMcHUea5ptUYgDjgouHYks51Ia+5C64/MY8xKGZzvBUrGgHHlCVVV7tJZH
	VlfvvnXzBxkBLUpU9I9n318M+exEQ8dhf8IwGAWTKtblLOnoXcWzu2ksSDxFGUht
	xk+oGUGgmeazeQkCxFPOvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773788919; x=
	1773875319; bh=gBT/l3JVrcxOwshd4Ofs3cf6XtZetBd/EV78l2vIBmM=; b=d
	q7HuYvTeeNKawfubHhqAFN5zjJida4fgImmIZsOoNNKy0UXlZ8/4fS/EqYUmdxPF
	en7WwvXG55CzeLt++lJvzupQ3kGvQeYSeiKA8eqv4X92lXdGN71mGedMAwzjAGpR
	wgxYknUpkBUDNJLuyylo3pWxinhGKdzT4yc0/vPuC1g30RKZJa4XAp2VwB7dStuJ
	aqShvi7sX832IgZaKfs421kjsCvqHo+8/yZsDyHAgmQOwS74128xewWuoPC11MRm
	YUk6rQwS81pN6dukXVpiydwzzzZ1TWuJn1KQhJ3Vhre3yxOyx/lY3sJlt9cWY1D7
	ep9+BSNV94yBhFPc4kU5g==
X-ME-Sender: <xms:9t65aTsq9W8vPhgxC4EXPAbTWa-QHaBB8OHB3GI_UNLzz-tHkuQZXw>
    <xme:9t65aYI-Kf_flbtCHEaRLf-KiV8pg-RdI_YH-q711Ruzow1cpToYRoUw5dYytFCbH
    Y_POsrO8kkHHasX7T6yPy70qSe9orJ4FSjnwkBnyu7ohtf5Vw>
X-ME-Received: <xmr:9t65aQnEU1esnLD-qc0RxDBXTjnGacz2rTXUkUwKx-YTbYrqwpcrs0AiKEij6XJ4PnQpJULLWIJGkpRRwCJHqgjQtn0RVZvV9NEJVRKtTa_dEGtCfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddvheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehjohgrnhhn
    vghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhlohhssehs
    iigvrhgvughirdhhuhdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvh
X-ME-Proxy: <xmx:9t65aZL9A9sW22qSOSTr4JOOfmvJt0aphAxjT6INOWuOd88NE-1PHQ>
    <xmx:9t65aV7ykZvj2A-NfVtAYKln_83awRLn-5v15OPa-K8OUqzQRb8h1Q>
    <xmx:9t65ad3EvN76gMharuPPzIQG3jJ8PsCd4NuDPoTkYy11aHCwaspzow>
    <xmx:9t65abfWAp9frnbcdsoVl9IagYBkZ4ZdmEaQbE66bY_6iOp8nn7a3Q>
    <xmx:9965aWGmxLlTq1Tll64tySbZbbOjOV3NIcKDiaI_lGunEKy_j3msfUso>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 19:08:37 -0400 (EDT)
Message-ID: <70550759-eae2-482d-a598-164d10930220@bsbernd.com>
Date: Wed, 18 Mar 2026 00:08:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL v2] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>, bschubert@ddn.com
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
 neal@gompa.dev
References: <20260316235017.GK1742010@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260316235017.GK1742010@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/26 00:50, Darrick J. Wong wrote:
> Hi Bernd,
> 
> I hope you're feeling better!

Thank you much better!

> 
> Please have a look at this branch with changes for libfuse.  This second
> PR contains a bunch of new things:
> 
>  * Cleaned up error code handling and logging
>  * Examples of systemd-enabled high and low-level fuse servers
>  * Most of the checkpatch complaints addressed
>  * fuservicemount3 can now be a setuid program to allow unprivileged
>    userspace to fire up a contained filesystem driver.  This could be
>    opening Pandora's box...
> 
> As usual, I did a test-merge with the main upstream branch as of a few
> minutes ago, and didn't see any conflicts.  Please let me know if you
> encounter any problems.

I only found a minute to pull and push to my github repo to update the PR. 
BSD still fails

2026-03-17T23:01:17.9810147Z FAILED: [code=1] example/hello_ll.p/single_file.c.o 
2026-03-17T23:01:17.9813484Z cc -Iexample/hello_ll.p -Iexample -I../example -Iinclude -I../include -Ilib -I../lib -I. -I.. -fdiagnostics-color=always -Wall -Winvalid-pch -Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -pthread -MD -MQ example/hello_ll.p/single_file.c.o -MF example/hello_ll.p/single_file.c.o.d -o example/hello_ll.p/single_file.c.o -c ../example/single_file.c
2026-03-17T23:01:17.9817014Z ../example/single_file.c:46:10: error: use of undeclared identifier 'PTHREAD_MUTEX_INITIALIZER'
2026-03-17T23:01:17.9817870Z    46 |         .lock = PTHREAD_MUTEX_INITIALIZER,
2026-03-17T23:01:17.9818369Z       |                 ^
2026-03-17T23:01:17.9819309Z ../example/single_file.c:198:51: warning: unused parameter 'ino' [-Wunused-parameter]
2026-03-17T23:01:17.9820276Z   198 | void single_file_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
2026-03-17T23:01:17.9821012Z       |                                                   ^
2026-03-17T23:01:17.9821785Z ../example/single_file.c:198:60: warning: unused parameter 'flags' [-Wunused-parameter]
2026-03-17T23:01:17.9823239Z   198 | void single_file_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
2026-03-17T23:01:17.9824029Z       |                                                            ^
2026-03-17T23:01:17.9824978Z ../example/single_file.c:198:71: warning: unused parameter 'mask' [-Wunused-parameter]
2026-03-17T23:01:17.9829337Z   198 | void single_file_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
2026-03-17T23:01:17.9830366Z       |                                                                       ^
2026-03-17T23:01:17.9832001Z ../example/single_file.c:199:33: warning: unused parameter 'fi' [-Wunused-parameter]
2026-03-17T23:01:17.9833062Z   199 |                        struct fuse_file_info *fi)
2026-03-17T23:01:17.9833562Z       |                                               ^
2026-03-17T23:01:17.9834825Z ../example/single_file.c:211:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2026-03-17T23:01:17.9836166Z   211 |         pthread_mutex_lock(&single_file.lock);
2026-03-17T23:01:17.9836592Z       |         ^
2026-03-17T23:01:17.9837750Z ../example/single_file.c:226:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2026-03-17T23:01:17.9869585Z   226 |         pthread_mutex_unlock(&single_file.lock);
2026-03-17T23:01:17.9870081Z       |         ^
2026-03-17T23:01:17.9871240Z ../example/single_file.c:239:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2026-03-17T23:01:17.9872595Z   239 |         pthread_mutex_lock(&single_file.lock);
2026-03-17T23:01:17.9873056Z       |         ^
2026-03-17T23:01:17.9874265Z ../example/single_file.c:241:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2026-03-17T23:01:17.9876020Z   241 |         pthread_mutex_unlock(&single_file.lock);
2026-03-17T23:01:17.9876497Z       |         ^
2026-03-17T23:01:17.9877854Z ../example/single_file.c:252:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2026-03-17T23:01:17.9879416Z   252 |         pthread_mutex_lock(&single_file.lock);
2026-03-17T23:01:17.9879896Z       |         ^
2026-03-17T23:01:17.9881050Z ../example/single_file.c:259:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2026-03-17T23:01:17.9882409Z   259 |         pthread_mutex_unlock(&single_file.lock);
2026-03-17T23:01:17.9882862Z       |         ^
2026-03-17T23:01:17.9884018Z ../example/single_file.c:273:2: warning: call to undeclared function 'pthread_mutex_lock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2026-03-17T23:01:17.9885354Z   273 |         pthread_mutex_lock(&single_file.lock);
2026-03-17T23:01:18.0387503Z       |         ^
2026-03-17T23:01:18.0402115Z ../example/single_file.c:275:2: warning: call to undeclared function 'pthread_mutex_unlock'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
2026-03-17T23:01:18.0403861Z   275 |         pthread_mutex_unlock(&single_file.lock);
2026-03-17T23:01:18.0404573Z       |         ^
2026-03-17T23:01:18.0404979Z 12 warnings and 1 error generated.


And actually, the Ubuntu build also fails

[12/109] Compiling C object lib/libfuse3.so.3.19.0.p/fuse_service.c.o
FAILED: [code=1] lib/libfuse3.so.3.19.0.p/fuse_service.c.o 
clang -Ilib/libfuse3.so.3.19.0.p -Ilib -I../../../home/runner/work/libfuse/libfuse/lib -Iinclude -I../../../home/runner/work/libfuse/libfuse/include -I. -I../../../home/runner/work/libfuse/libfuse -fdiagnostics-color=always -fsanitize=address,undefined -fno-omit-frame-pointer -Wall -Winvalid-pch -Wextra -Werror -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H -Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes -Wmissing-declarations -Wwrite-strings -fno-strict-aliasing -fPIC -pthread -DFUSE_USE_VERSION=317 '-DFUSERMOUNT_DIR="/tmp/libfuse-install-wwy0ckA/bin"' -MD -MQ lib/libfuse3.so.3.19.0.p/fuse_service.c.o -MF lib/libfuse3.so.3.19.0.p/fuse_service.c.o.d -o lib/libfuse3.so.3.19.0.p/fuse_service.c.o -c ../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c
../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:400:19: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
  400 |                 sf->allow_other = 1;
      |                                 ^ ~
../../../home/runner/work/libfuse/libfuse/lib/fuse_service.c:473:21: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
  473 |         sf->owns_fusedevfd = 1;
      |                            ^ ~
2 errors generated.
[13/109] Compiling C object lib/libfuse3.so.3.19.0.p/modules_subdir.c.o

Checkpatch looks much better, I can push a patch tomorrow to disable the
strcpy warning. 

Other than that I didn't look at the actual changes yet, will really try
to review this week.

Thanks,
Bernd
