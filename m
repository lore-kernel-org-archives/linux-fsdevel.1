Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649345;
	b=L6Vu1GrC+RTXWxlHewwVhjEHY2HFWbJczvnUdrBqd9iRS56Rtzfl9Pk/V2I1beipL/JR
	 pokvF9StEya44WLXW/BUNTdArATF9Dl3hQFQuFHzYIarPWUOwGb/+ykm4WG0RG9a6Zocg
	 Z7ZZSSMmnwWjgpiT45eYbuReiLJCShrlzgxs8Y+YaogDE6gWMg6bcxTnWfTVswVEyvh1N
	 W14GB7EcqkvA6pyog3wldNF53aHVh0wpSVdVuSTUlF6FHFC3NusR3nWNZA33RXtuM5sV5
	 K5Z1eKz8QbSlK+3Zj1EAd15yBtvrzqacdU32PB9wtIB89l8HAgu2MJpWp3U3rC92vPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649345;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kVgaSwpKolDEK6zLTmi5qCAne6TXQbCXglwlPE91d1g=;
	b=JG4TESAAYobp4uBQXBLrEo0vRq4aF3EtFcrSYjEVeLn0PJ5/O2I83K9ymRheiTk53ktH
	 +fYgwGFaUDhUCcVvcyRzz3LhkHFaBIBZz5GPLD7nFnjld0zifIHaZwpcWwS7eBkqoD77w
	 IPVzus+PUX1L7rSrtkDi/SAEj0asE64hsH3XH2wiaLUYUiLY7CYOaA63tVggqoqKpqaw+
	 ijAeX+yKS66Aa8t6+WhKKn+Azi1RzVEyG62b2Wtas61orRMKrWzAG2lCQbKJ25ISCjtTx
	 zwi6QyjxRIBCNDOT7LSHtzVtBKUP6cvo1paMRyTbeRlxHylfb7326kWtKeUUnlIrxxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bsbernd.com;
	spf=pass smtp.mailfrom=bsbernd.com;
	dkim=pass header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm2 header.b=O8nLyoEO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xUBiJh1S;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA8606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 23:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06FA8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bsbernd.com header.i=@bsbernd.com header.a=rsa-sha256 header.s=fm2 header.b=O8nLyoEO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xUBiJh1S
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D3911D005BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 18:29:04 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 25 Nov 2026 18:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795649343;
	 x=1795735743; bh=kVgaSwpKolDEK6zLTmi5qCAne6TXQbCXglwlPE91d1g=; b=
	O8nLyoEOAh9yO8LWUxHLdEFK5J0hh8/TsdVbEsaedqWtDsEnn2KVcPH3rwVw98O0
	vVL8hm1oryd/L5AeVpTVtgZTkQrbmiwvc3AtYFTx+RQF3AXNnuRLCseHoB7otjYI
	8ORcC3zaisa8TN6E6NoNb3QAKJcQzZoM84ds2XSoaegL85bZ8+5Fx4LdbO1UqXEm
	3DVk35wUFg/il+HTQSj4QRTdr8C0RlEtpSdWFGCXlarE1mXuCzSRfa6YV+pP3wte
	KGvXSHE8evNymAXAEjbFfLSpJl0DPm8JhG3OQrU2vImL0AJVDMiFUSTMdlisG+tm
	xX30xo5EbL07rkIW+dlz9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795649343; x=
	1795735743; bh=kVgaSwpKolDEK6zLTmi5qCAne6TXQbCXglwlPE91d1g=; b=x
	UBiJh1SW40tOZUcxqigmnWnmRmY83hmtGldEf5QNMYITSGrDq22kIcKFtxh4m2sT
	RisBTKyNCBSFR5o6IZkI5PJkI/R3dAblJEq/HiOROtsPv1oqnOnrAQnmgff9l+ME
	NT/4T5uqxE7b7oSaleXnHgbGn5Q+o+4mhAZ80Kfliu8ugHIlMr2dnk2dtjhw2K8G
	TbaK4M5Mie7JUT3Rp3AWIdpeF9fl7DRHPWjV5060MVZ/uwPqUTV83bUWsEyXAWaY
	cxCDG/VTscd2+KqZALkaTKJtSciGLv1LbbGCEEEZ6TLV+1cFsQ+mC3Hc2OjGw5hM
	tw3TwW+fVwaJwFxdJjnNg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=bsbernd.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795649343; d=bsbernd.com;
	mf=PGJlcm5kQGJzYmVybmQuY29tPg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:PPW0OuoVB4Dq5d3dYy7zPNh7Ob6oa+zpSGjI1j3sWcsEJne
	fNmvmtV1Blv8mSD6eLzH1I2HMRmKtPSVlPLfStWewP5ZqRA73iMIXKAwQlSuOmoF
	JmD3AmM+06rwmbINVSL+4WrmJQWa+1upP/nU0DzMuTSqXynnb1GT5/Y7V+/RVi8n
	O7VGTh5X/2WW5UwkrTNSkh12MDoCSezklNeH+FDDOLh5v01aN3ONMZrfSGVawYWc
	coaa9mdRof1805XL4u/q8gov0PhVqT2D1Pj2Z/aDHeb7Nm+w3fyE4ojo2OREKEsN
	vlenGXJ2gKWanCc0q2lHSmIyHNROk+srafQ1nJw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:S1WVfcLWoOVuDV/LL25Bzz94amvQr0kkAyiE3/o2DQk=:DgpuvTmaPreSNF8A1oUbHgLstAM4euenPU6Zu9ZxXCE=;
X-ME-Sender: <xms:P28Ha6Qld4O1DusXiFWFDaM88zNaLT_3ZqF3Kur0VpNd21ngVPGwOw>
    <xme:P28Ha5HOqdRfhMDa4ZjVEVB8mFpD5NFhgjemDYmq7B8GDOlHpus4X1c6VCVN0LJk8
    bF1dEPovix3g_LgbLHBznsM-qsr_bSdDE7uFZzA9wfFYNRnRP01OQ>
X-ME-Received: <xmr:P28Ha_EIBa4wByLakJb2dg1VAo2A42oJ3TTXsGFEx752N8YwSeF7mohfrsEtN4_YwpcECuyAJ_t_ZacN2b01mLgud7ck3aMjfIxIBWWpJB5vKDLidA>
X-ME-Proxy-Cause: dmFkZTES9sBAb/nIj5nkRvarksZV62nLahHLyLwHBfNgbb13bxy7hNhPTWPihtXIYPYMN0
    7cA9hGlnwqH0XOvLTs4l7+UTIpghlaYZF7N/QdLtgh0LIVQxrhrt6TELaas6ubNB9wr+Oh
    WsGX7hCHQljckla8wT0UJiPmYaTy7+4msyz+zKVQj70QCFLT/NgCa8yzKS+E+NKodAcoRp
    o4eewaqUmCRsqsLr8FhRK5FtoxAIeOGQMijwJEH8IrQT33ddcvePGqAvsNKqxr6WZykeVZ
    XUdHNvpZU2rVFUb33Jb0OMtS5jmZowwkTU43EIRlHr5MrPObINYlHgw5JYhbIbWaa3Pptm
    r8qFub+Tl1amxoIMW/u1CsMNJkfDSonidbeSHibVaFwsYSdpB0RYa6imyq2uCcPpOu2PvF
    Iz3XAItxzT5czW/3Gz//apfKNW2hBCeFKtJE9hbMvJyXVisc/ykwy79ObRRF4vhQqxBx1Q
    GTKo2YrX069iIgxCxb7X5evbdbuVwbp3PMCApf1YZZTUHBu/fu0Tbdy/NVauDypCNThecG
    56JYxB+3b9FHkLIwUxb/0ZsBgw0yPj9hWJQNtosibRJK9LzyMt/CyQ3DDI+jzN/9uFoTlH
    zEL2aPSyDP+t65S7xiq73Kr+3z++rXeW27orUbmiYEUpXF4NafR0w0bQ8f3Q
X-ME-Proxy: <xmx:P28Ha3RziWkb28ZOxG2NSX8MdJY_Cv84YqKYjyQC3I5j5neDFphQ0g>
    <xmx:P28HawLXOIJplGqu4m1YASRr1ZO2AxHwD26ZrkzypGdl5YvgH6UPKg>
    <xmx:P28HayZcBXTsbq6tznYYRlW6binPCmrBWsI2EN8ywjmjLc1EIS5AtA>
    <xmx:P28Hay88Xgms41SFmIFXmwk0J2dF0o1SrsNi5UEjdy4sbo3W0HrN8A>
    <xmx:P28Hayt7zqBT80a9f7xjFUDv2dy28E3RVN_J2kmOhRP_CYn_KllP6hZJ>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 18:29:02 -0500 (EST)
Message-ID: <08961e0f-fe38-4557-961d-03b13db78431@bsbernd.com>
Date: Thu, 26 Nov 2026 00:29:01 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/fuse: test listing directories with long
 names
To: Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: fuse-devel@lists.linux.dev
References: <20261125-work-fuse-readdir-v1-0-44312add01a8@kernel.org>
 <20261125-work-fuse-readdir-v1-2-44312add01a8@kernel.org>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20261125-work-fuse-readdir-v1-2-44312add01a8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/26 11:26, Christian Brauner wrote:
> Add a test that lists a directory whose first entry has a name too long
> for a one page READDIR or READDIRPLUS reply:
> 
> - READDIR with the shortest such name and with FUSE_NAME_MAX
> 
> - READDIRPLUS with the shortest such name and with FUSE_NAME_MAX
> 
> It starts out with a 4k getdents64() buffer, doubles it on EINVAL and
> checks that both the long name and the entry after it show up.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  .../testing/selftests/filesystems/fuse/.gitignore  |   1 +
>  tools/testing/selftests/filesystems/fuse/Makefile  |   2 +
>  .../filesystems/fuse/fuse_readdir_long_name_test.c | 197 +++++++++++++++++++++
>  3 files changed, 200 insertions(+)
> 
> diff --git a/tools/testing/selftests/filesystems/fuse/.gitignore b/tools/testing/selftests/filesystems/fuse/.gitignore
> index 7c787313e69b6..cd5492659ffcf 100644
> --- a/tools/testing/selftests/filesystems/fuse/.gitignore
> +++ b/tools/testing/selftests/filesystems/fuse/.gitignore
> @@ -6,3 +6,4 @@ write_extend_eof_test
>  fuse_acl_cache_test
>  fuse_symlink_cache_test
>  fuse_readdir_cache_test
> +fuse_readdir_long_name_test
> diff --git a/tools/testing/selftests/filesystems/fuse/Makefile b/tools/testing/selftests/filesystems/fuse/Makefile
> index e3ae3acff1139..2e77b19d6d06a 100644
> --- a/tools/testing/selftests/filesystems/fuse/Makefile
> +++ b/tools/testing/selftests/filesystems/fuse/Makefile
> @@ -7,6 +7,7 @@ TEST_GEN_PROGS += write_extend_eof_test
>  TEST_GEN_PROGS += fuse_acl_cache_test
>  TEST_GEN_PROGS += fuse_symlink_cache_test
>  TEST_GEN_PROGS += fuse_readdir_cache_test
> +TEST_GEN_PROGS += fuse_readdir_long_name_test
>  TEST_GEN_FILES := fuse_mnt
>  
>  include ../../lib.mk
> @@ -32,5 +33,6 @@ $(OUTPUT)/fuse_mnt: LDLIBS += $(VAR_LDLIBS)
>  $(OUTPUT)/fuse_acl_cache_test: fuse_common.c fuse_acl_cache_test.c
>  $(OUTPUT)/fuse_symlink_cache_test: fuse_common.c fuse_symlink_cache_test.c
>  $(OUTPUT)/fuse_readdir_cache_test: fuse_common.c fuse_readdir_cache_test.c
> +$(OUTPUT)/fuse_readdir_long_name_test: fuse_common.c fuse_readdir_long_name_test.c
>  
>  EXTRA_CLEAN := fuse_common.o
> diff --git a/tools/testing/selftests/filesystems/fuse/fuse_readdir_long_name_test.c b/tools/testing/selftests/filesystems/fuse/fuse_readdir_long_name_test.c
> new file mode 100644
> index 0000000000000..6fd280cb3188e
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/fuse/fuse_readdir_long_name_test.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * List a FUSE directory whose first entry has a name that doesn't fit
> + * into a single page of READDIR or READDIRPLUS reply, using a small
> + * getdents64() buffer, and check that no entry goes missing.
> + */
> +
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <sys/syscall.h>
> +
> +#include "kselftest_harness.h"
> +
> +#include "fuse_common.h"
> +
> +#define LONG_INO	2
> +#define AFTER_INO	3
> +#define AFTER_NAME	"after"
> +#define FUSE_NAME_MAX	(PATH_MAX - 1)
> +#define GETDENTS_MAX	65536
> +
> +struct linux_dirent64 {
> +	uint64_t	d_ino;
> +	int64_t		d_off;
> +	unsigned short	d_reclen;
> +	unsigned char	d_type;
> +	char		d_name[];
> +};
> +
> +static char long_name[FUSE_NAME_MAX + 1];
> +
> +static void fs_getattr(fuse_req_t req, fuse_ino_t ino,
> +		       struct fuse_file_info *fi)
> +{
> +	struct stat st = {};
> +
> +	if (ino != FUSE_ROOT_ID) {
> +		fuse_reply_err(req, ENOENT);
> +		return;
> +	}
> +	st.st_ino = ino;
> +	st.st_mode = S_IFDIR | 0755;
> +	st.st_nlink = 2;
> +	fuse_reply_attr(req, &st, 0);
> +}
> +
> +/* Whole entries from @off, as many as fit into @size. */
> +static void fill_dir(fuse_req_t req, size_t size, off_t off, bool plus)
> +{
> +	char *buf = malloc(size);
> +	size_t used = 0;
> +
> +	if (!buf) {
> +		fuse_reply_err(req, ENOMEM);
> +		return;
> +	}
> +
> +	for (; off < 2; off++) {
> +		const char *name = off ? AFTER_NAME : long_name;
> +		struct fuse_entry_param e = {};
> +		size_t len;
> +
> +		e.ino = off ? AFTER_INO : LONG_INO;
> +		e.attr.st_ino = e.ino;
> +		e.attr.st_mode = S_IFREG | 0444;
> +		e.attr.st_nlink = 1;
> +		if (plus)
> +			len = fuse_add_direntry_plus(req, buf + used, size - used,
> +						     name, &e, off + 1);
> +		else
> +			len = fuse_add_direntry(req, buf + used, size - used,
> +						name, &e.attr, off + 1);
> +		if (len > size - used)
> +			break;
> +		used += len;
> +	}
> +
> +	fuse_reply_buf(req, buf, used);
> +	free(buf);
> +}
> +
> +static void fs_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
> +		       off_t off, struct fuse_file_info *fi)
> +{
> +	fill_dir(req, size, off, false);
> +}
> +
> +static void fs_readdirplus(fuse_req_t req, fuse_ino_t ino, size_t size,
> +			   off_t off, struct fuse_file_info *fi)
> +{
> +	fill_dir(req, size, off, true);
> +}
> +
> +static const struct fuse_lowlevel_ops fs_ops = {
> +	.getattr	= fs_getattr,
> +	.readdir	= fs_readdir,
> +};
> +
> +static const struct fuse_lowlevel_ops fs_ops_plus = {
> +	.getattr	= fs_getattr,
> +	.readdir	= fs_readdir,
> +	.readdirplus	= fs_readdirplus,
> +};
> +
> +FIXTURE(readdir_long_name)
> +{
> +	struct fuse_common_ctx ctx;
> +};
> +
> +FIXTURE_VARIANT(readdir_long_name)
> +{
> +	bool plus;
> +	size_t name_len;
> +};
> +
> +/* The shortest names whose entries don't fit into a 4k page, and the longest. */
> +FIXTURE_VARIANT_ADD(readdir_long_name, readdir_4073)
> +{
> +	.plus = false,
> +	.name_len = 4073,
> +};
> +FIXTURE_VARIANT_ADD(readdir_long_name, readdir_name_max)
> +{
> +	.plus = false,
> +	.name_len = FUSE_NAME_MAX,
> +};
> +FIXTURE_VARIANT_ADD(readdir_long_name, readdirplus_3945)
> +{
> +	.plus = true,
> +	.name_len = 3945,
> +};
> +FIXTURE_VARIANT_ADD(readdir_long_name, readdirplus_name_max)
> +{
> +	.plus = true,
> +	.name_len = FUSE_NAME_MAX,
> +};
> +
> +FIXTURE_SETUP(readdir_long_name)
> +{
> +	char err[MAX_ERR_MSG];
> +
> +	memset(long_name, 'L', variant->name_len);
> +	long_name[variant->name_len] = '\0';
> +
> +	if (fs_setup(variant->plus ? &fs_ops_plus : &fs_ops, &self->ctx, err))
> +		SKIP(return, "%s", err);
> +}
> +
> +FIXTURE_TEARDOWN(readdir_long_name)
> +{
> +	fs_teardown(&self->ctx);
> +}
> +
> +TEST_F(readdir_long_name, small_buffer)
> +{
> +	bool seen_long = false, seen_after = false;
> +	size_t size = 4096;
> +	char *buf = NULL;
> +	int fd;
> +
> +	fd = open(self->ctx.mountpoint, O_RDONLY | O_DIRECTORY);
> +	ASSERT_GE(fd, 0);
> +
> +	for (;;) {
> +		long n;
> +
> +		buf = realloc(buf, size);
> +		ASSERT_NE(buf, NULL);
> +		n = syscall(SYS_getdents64, fd, buf, size);
> +		/* The next entry doesn't fit, try again with more room. */
> +		if (n < 0 && errno == EINVAL && size < GETDENTS_MAX) {
> +			size *= 2;
> +			continue;
> +		}
> +		ASSERT_GE(n, 0);
> +		if (!n)
> +			break;
> +
> +		for (long off = 0; off < n;) {
> +			struct linux_dirent64 *d = (void *)(buf + off);
> +
> +			if (!strcmp(d->d_name, long_name))
> +				seen_long = true;
> +			else if (!strcmp(d->d_name, AFTER_NAME))
> +				seen_after = true;
> +			off += d->d_reclen;
> +		}
> +	}
> +
> +	free(buf);
> +	close(fd);
> +	EXPECT_TRUE(seen_long);
> +	EXPECT_TRUE(seen_after);
> +}
> +
> +TEST_HARNESS_MAIN
> 

I had especially created memfs_ll.cc in libfuse in order to test long
long names, but glibc buffers are larger than 4K - my simple tests
missed the issue.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
