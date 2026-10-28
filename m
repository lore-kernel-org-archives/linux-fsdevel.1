Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180003;
	b=dN3jzlmaBF3u6iMTEJ4ipo1+hQoiqA4qFrNJKnihFZi9WoTbCBmt1CdzLVpRAyH1ijgq
	 /ZZANDO4gNJDHr2ZcNVx6DBOfZ3p8O+Y0LrLT1lpVhs4uVkAuoocJPiYw2BVIedcbS7lq
	 Pl3xQIWdaMLmf1KnRccuD7HcpZvUuccTj+God840lnYFAwTs2LP6LHq3DtJW9I0Ir4ga/
	 SLKqsTlnBIozeAFTALxuRQcL7yUVlDhohINVhnmfOc+X0OyRjY7en4firUv4sodW2Q3a/
	 YDKqRi0P4v1+SkV27toISwTfsk36eGHPl/8KJDUhV8QhXqlVbQkEFAKxqjTFBCtysaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180003;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=o48BxfVRKyt8VwocGYiaSs0bwuLsENkNmhgJ5mRhlcg=;
	b=Prcr4JAf/TImxrnzVoTap/rc9J/iMUiAn84HGVIL4G8feLjVpST95VitwU55ulDILR59
	 aRK1lI9wmxxmLwajXdj0U1vmujVWd3hcxtXgla5pMNPuQnBcKVBglzS+p8nOvpu1D3vnZ
	 7jjmb/wo4Von350mlnTbpA/DA9oZxNMzKLUQKb6/PGOMwpnfb6HgETqoBNXcqIri90d9U
	 xFGpsz43TOOXc89060By3s9s/Qd9seaFduZawhfSdtTmhQ6uJ5NjVvm4/caalZX4VWoSn
	 hSUnWF8Ln4UJ24qUdzTq23+JJ9lPk+X7f9XSCEG6037gCWx9NXqu3XVGsHbnvU13ffw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b="QkmyU/vW";
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D936606A31C;
	Wed, 28 Oct 2026 09:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D936606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=QkmyU/vW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=o48BxfVRKyt8VwocGYiaSs0bwuLsENkNmhgJ5mRhlcg=; b=QkmyU/vWjCV60OWMBHN+43GJJq
	T4cc9x79JCeL0TxvbjYQLZDzlgWaXu0VkmyYLUC0rHzkt8uUodCM7RIp/5o3yJ67y85h+vzpg7QwW
	CxJtc6ubM4zs/ipN1Y+DX2uN7Zg6l1dIttfQM13IGlVU6Sl6EskwqqqoPBPDqC/5wQrzy5PTWlF0q
	LogsmiaYO+FATLPXZ2bbYc/asQHc5cRQP79PQB0es9kDhkrAWZC/f3nsd4B49bO4yVIdTgQSRWAR0
	A5YHqyOosp2BQQmpahoxT2JgkOFV8aVZ9qmPKKGQ+wJauWTgN9K/MFe79vAM27v+dCGzA1Y8QEl4Q
	AePlXYSg==;
Received: from [188.250.79.109] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xM020-00CisY-IC; Wed, 28 Oct 2026 10:33:16 +0100
From: Luis Henriques <luis@igalia.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Shuah Khan <shuah@kernel.org>,
  fuse-devel@lists.linux.dev,  linux-fsdevel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH] selftests/fuse: add the missing symlink caching test
In-Reply-To: <20261026194008.274349-1-sashal@kernel.org>
References: <20261026194008.274349-1-sashal@kernel.org>
Date: Wed, 28 Oct 2026 09:34:44 +0000
Message-ID: <87zevyi2x7.fsf@igalia.com>
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
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26 2026, Sasha Levin wrote:

> Commit 3e14f079d7a0 ("selftests/fuse: add fuse symlink caching test")
> registered fuse_symlink_cache_test in the fuse selftest Makefile and
> .gitignore, but the test source was not part of the applied commit, so
> building the fuse selftests fails:
>
>   make[1]: *** No rule to make target 'fuse_symlink_cache_test.c', needed=
 by '.../fuse_symlink_cache_test'.
>
> Add fuse_symlink_cache_test.c as posted in Luis Henriques's v5
> submission. The test serves a file and a symlink to it from a libfuse
> low-level filesystem, resolves the symlink 100 times, and counts the
> readlink requests that reach the server: one when FUSE_CAP_CACHE_SYMLINKS
> is set during FUSE_INIT, and all 100 when it is not.
>
> Fixes: 3e14f079d7a0 ("selftests/fuse: add fuse symlink caching test")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202610170822.oEJ1Autq-lkp@intel.com/
> Link: https://lore.kernel.org/r/20261001164916.15311-8-luis@igalia.com
> Originally-by: Luis Henriques <luis@igalia.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> As with e64a46aefc01 ("selftests/fuse: add the missing FUSE_HAS_SYNCFS
> privilege test"), the new file in the posted patch is not in the applied
> commit; the other files did land.

Oh, wow!  I wonder how that happen.  Anyway, thanks for noticing that and
for fixing it, Sasha.  If it makes any sense (I wrote the test! :-) ) feel
free to add my

Reviewed-by: Luis Henriques <luis@igalia.com>

Cheers,
--=20
Lu=C3=ADs


>  .../fuse/fuse_symlink_cache_test.c            | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_symlink=
_cache_test.c
>
> diff --git a/tools/testing/selftests/filesystems/fuse/fuse_symlink_cache_=
test.c b/tools/testing/selftests/filesystems/fuse/fuse_symlink_cache_test.c
> new file mode 100644
> index 0000000000000..7b53734995736
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fuse/fuse_symlink_cache_test.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Simple filesystem to test FUSE symlink cache
> + *
> + * This is a simple FUSE filesystem that contains two objects: a file na=
med
> + * 'file' and a symlink to that file named 'link'.  If symlink caching is
> + * disabled (i.e. FUSE_CAP_CACHE_SYMLINKS is reset during FUSE_INIT), wh=
enever
> + * the ->readlink() is executed to resolve 'link' a counter will be incr=
emented.
> + *
> + * If symlink caching is enabled (i.e. FUSE_CAP_CACHE_SYMLINKS is set du=
ring
> + * FUSE_INIT), resolving a symlink will only call into user-space the fi=
rst
> + * time.
> + */
> +
> +#define FUSE_USE_VERSION 31
> +
> +#include <stdio.h>
> +#include <fuse_lowlevel.h>
> +
> +#include "kselftest_harness.h"
> +
> +#include "fuse_common.h"
> +
> +#define FILENAME "file"
> +#define FILE_INO 42
> +
> +#define LINKNAME "link"
> +#define LINK_INO 43
> +
> +#define TIMEOUT	86400.0f
> +
> +struct test_state {
> +	pthread_mutex_t lock;
> +	int readlink_counter;
> +	bool cache;
> +} test_state =3D {
> +	.lock =3D PTHREAD_MUTEX_INITIALIZER,
> +};
> +
> +static void fs_init(void *userdata, struct fuse_conn_info *conn)
> +{
> +	pthread_mutex_lock(&test_state.lock);
> +	if (test_state.cache)
> +		fuse_set_feature_flag(conn, FUSE_CAP_CACHE_SYMLINKS);
> +	else
> +		fuse_unset_feature_flag(conn, FUSE_CAP_CACHE_SYMLINKS);
> +	pthread_mutex_unlock(&test_state.lock);
> +}
> +
> +static void fs_lookup(fuse_req_t req, fuse_ino_t parent, const char *nam=
e)
> +{
> +	struct fuse_entry_param e =3D {};
> +
> +	if (parent !=3D FUSE_ROOT_ID ||
> +	    (strcmp(name, FILENAME) !=3D 0 && strcmp(name, LINKNAME) !=3D 0)) {
> +		fuse_reply_err(req, ENOENT);
> +		return;
> +	}
> +
> +	if (!strcmp(name, FILENAME)) {
> +		e.ino =3D FILE_INO;
> +		e.attr.st_mode =3D S_IFREG | 0444;
> +		e.attr.st_nlink =3D 2;
> +	} else if (!strcmp(name, LINKNAME)) {
> +		e.ino =3D LINK_INO;
> +		e.attr.st_mode =3D S_IFLNK | 0444;
> +		e.attr.st_nlink =3D 1;
> +		e.attr.st_size =3D strlen(FILENAME);
> +	}
> +	e.attr_timeout =3D TIMEOUT;
> +	e.entry_timeout =3D TIMEOUT;
> +
> +	fuse_reply_entry(req, &e);
> +}
> +
> +static void fs_readlink(fuse_req_t req, fuse_ino_t ino)
> +{
> +	char buf[PATH_MAX];
> +	size_t sz =3D strlen(FILENAME);
> +
> +	if (ino !=3D LINK_INO) {
> +		fuse_reply_err(req, ENOENT);
> +		return;
> +	}
> +
> +	memcpy(buf, FILENAME, sz);
> +	buf[sz] =3D '\0';
> +	pthread_mutex_lock(&test_state.lock);
> +	test_state.readlink_counter++;
> +	pthread_mutex_unlock(&test_state.lock);
> +
> +	fuse_reply_readlink(req, buf);
> +}
> +
> +static const struct fuse_lowlevel_ops fs_ops =3D {
> +	.init           =3D fs_init,
> +	.lookup		=3D fs_lookup,
> +	.readlink	=3D fs_readlink,
> +};
> +
> +FIXTURE(symlink_cache)
> +{
> +	struct fuse_common_ctx ctx;
> +};
> +FIXTURE_VARIANT(symlink_cache)
> +{
> +	const bool cache;
> +};
> +FIXTURE_VARIANT_ADD(symlink_cache, symlinks_nocache)
> +{
> +	/* Variant with symlink cache disabled */
> +	.cache =3D false,
> +};
> +FIXTURE_VARIANT_ADD(symlink_cache, symlinks_cache)
> +{
> +	/* Variant with symlink cache enabled */
> +	.cache =3D true,
> +};
> +
> +FIXTURE_SETUP(symlink_cache)
> +{
> +	char err[MAX_ERR_MSG];
> +
> +	pthread_mutex_lock(&test_state.lock);
> +	test_state.readlink_counter =3D 0;
> +	test_state.cache =3D variant->cache;
> +	pthread_mutex_unlock(&test_state.lock);
> +
> +	if (fs_setup(&fs_ops, &self->ctx, err))
> +		SKIP(return, err);
> +}
> +
> +FIXTURE_TEARDOWN(symlink_cache)
> +{
> +	fs_teardown(&self->ctx);
> +}
> +
> +TEST_F(symlink_cache, test_symlink_cache)
> +{
> +	char pathname[PATH_MAX];
> +	char buf[PATH_MAX];
> +	ssize_t sz;
> +	int counter;
> +	int i;
> +
> +	sprintf(pathname, "%s/%s", self->ctx.mountpoint, LINKNAME);
> +	for (i =3D 0; i < 100; i++) {
> +		sz =3D readlink(pathname, buf, PATH_MAX);
> +		ASSERT_NE(sz, -1);
> +	}
> +	pthread_mutex_lock(&test_state.lock);
> +	counter =3D test_state.readlink_counter;
> +	pthread_mutex_unlock(&test_state.lock);
> +
> +	if (variant->cache) {
> +		ASSERT_EQ(counter, 1);
> +	} else {
> +		ASSERT_EQ(counter, 100);
> +	}
> +}
> +
> +TEST_HARNESS_MAIN
>
> base-commit: 9b1da7b4a4e197072e630c3b85d4100a399752ff
> --=20
> 2.53.0
>

