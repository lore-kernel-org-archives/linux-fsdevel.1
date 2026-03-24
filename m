Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA813790B
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 21:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386318; cv=none; b=tOmVCBnokcdP7zpIeE4qFxCrz4b4Cgcwgt3IuRuln+83taTU8+rho2A1m9fJMQvA84xyEY8shJQU7nwEl28Y4yL80hV2sn5lsoXZWDgoG3f9xBIqH543gxpEOoNpWQJZTQWEPr92QenAbDtRfynMUdXz+srZXHqTk9MLw35BakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386318; c=relaxed/simple;
	bh=r5itWX89FKZGpibCqtIBvrjsqhEjRCRYLdIUSD5skmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfTonKl3AlzPg920XTMTXAZOIuoRqLDZGVmSaNjwNyMz53oFdrzjFh6W6VRN1ozWTKXhyduGKiWx7Tuw8xKy73BFbIJX7BGzpH9S8rMf6qXAlQk0uRSvN81nILNyYJCjUC9YQYdgIlxMQ5ZiYRR+D8zH/J+efaElvVW1lhvM1Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=UplHflUH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qgrUZZ93; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="UplHflUH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qgrUZZ93"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0A861400012;
	Tue, 24 Mar 2026 17:05:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 24 Mar 2026 17:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774386315;
	 x=1774472715; bh=SAx5Q95hhPxaxqQ7cqwSuEKmLCaRwdIFHXeYSoNpzt4=; b=
	UplHflUH4SDkFOB7GprMld3WF/QhlYIjxoo3agedGULNWsDgI4VoDwR8OT0NDb7W
	HYsZ/eOwvofRr5zKAHQ4hwKbkExXN2S00ttyptHalC3ntFWm0kXtvT12aks5RfE7
	V2NFQwQ29iu8GeOYa+M5bC+lxU/3GA0L6OLrhz6e1lQtnCJupleTedY5lx/tc0HI
	llpKuCXsVYm8Gj+p65YV2I663YhLVBk+up6pCOcKH9DCc8YD3xz/pS/b84iZ7TKF
	X1VQqxPVbP0wvn6tyFVR1jL30BMTlUwlgirMtNdNx7GxtSxPaDb0DeyYzm8on/1M
	OJH8JmR2lnVkvM1kdZXNaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774386315; x=
	1774472715; bh=SAx5Q95hhPxaxqQ7cqwSuEKmLCaRwdIFHXeYSoNpzt4=; b=q
	grUZZ93wJ2q/C5m8n+IfPHBT33D4NEUyxjafEGzsPiV5Q3AcjNFj7ab5HYFsYRxb
	/Ytt8xszUrH4QPuWKbsRawqza5qRueHzjW2waF9h+h+yOARj83+34mKBtTTGELZM
	3p65NmTNOnVzC+/U8K3YLmnbx6kE1hN7tsmOCzOcQFMBRhyn0jy1Cik2e4rMn3gF
	6a9shrLfKANNJkCva3EqPxaZHeihPJiwvtrIqjtxeNFjVo68V0weop5dcnkBgZQO
	2tg+RYZDFNxHn5xDFIq/kMsJlVowigEFoAF8aOHeQbd5Eb1/VfJDwHHZquKHUMsq
	FlygfkavpGelWEr8g8+QQ==
X-ME-Sender: <xms:i_zCabzHvzdG6e3c8YFr2i7d3NeXpnlEYwRvhq1HJXPXpLf53S06WA>
    <xme:i_zCaaLZl05mgIvrjjrSoF1eR25NNRvAUoFOGXmdYc9cDv-BzPPf18kYBE1pxin5V
    cTQz-nFL8hC_8ij8vEBptfOuYRKFkxQJlpHS5RNuUY39Zq6xQdj>
X-ME-Received: <xmr:i_zCadrImaQt_-sKvKd45U-2Kmxb9b199U5kI_LjQNAFfYW-EMkQZfD75_sMh4U_eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorg
    hnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghr
    thesuggunhdrtghomh
X-ME-Proxy: <xmx:i_zCaRKLh_qq-4XzpAsn7m_XExFocMzIA1_xF0eCljH-DH0iZ-ttEA>
    <xmx:i_zCaaQfVnh0RWJ745_Tui8q5IH87WMK0VpZQwW1OYX4iB40FCqkZQ>
    <xmx:i_zCaYsqRQRE5mWCNcOuPAcUlvjOSjPdX5LHG53VqnC_gsPttd13wQ>
    <xmx:i_zCaTZHCQ4TGD4ACJPH92vaMkDNyyYikVZ7ivInF50_sO0X86Wvxg>
    <xmx:i_zCaY6MJ1xyzWwuGMn14DQitM1fNovqd4vmH5T2grRf7Sqz0ZDraBJg>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 17:05:14 -0400 (EDT)
Message-ID: <a2ec8f5d-ffa4-4971-b05d-a0c5280c56b9@bsbernd.com>
Date: Tue, 24 Mar 2026 22:05:13 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/19] Split the fusermount do_mount function
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-15-a52d3040af69@bsbernd.com>
 <20260324001414.GP6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260324001414.GP6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/26 01:14, Darrick J. Wong wrote:
> On Mon, Mar 23, 2026 at 06:45:10PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> We will need new API and old API and need to pass the options to
>> two different functions - factor out the option parsing.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  util/fusermount.c | 298 +++++++++++++++++++++++++++++++++++++-----------------
>>  1 file changed, 205 insertions(+), 93 deletions(-)
>>
>> diff --git a/util/fusermount.c b/util/fusermount.c
>> index f17b44f51142c682b339d0ce2287f7c00d644454..ecf509bb80d5cd129f6e582f1ec666502c55603a 100644
>> --- a/util/fusermount.c
>> +++ b/util/fusermount.c
>> @@ -917,30 +917,132 @@ static int mount_notrunc(const char *source, const char *target,
>>  	return mount(source, target, filesystemtype, mountflags, data);
>>  }
>>  
>> +struct mount_params {
>> +	/* Input parameters */
>> +	int fd;                  /* /dev/fuse file descriptor */
>> +	mode_t rootmode;         /* Root mode from stat */
>> +	const char *dev;         /* Device path (/dev/fuse) */
>>  
>> -static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
>> -		    int fd, const char *opts, const char *dev, char **sourcep,
>> -		    char **mnt_optsp)
>> +	/* Parsed mount options */
>> +	unsigned long flags;     /* Mount flags (MS_NOSUID, etc.) */
>> +	char *optbuf;           /* Kernel mount options buffer */
>> +	char *fsname;           /* Filesystem name from options */
>> +	char *subtype;          /* Subtype from options */
>> +	int blkdev;             /* Block device flag */
>> +
>> +	/* Generated mount parameters */
>> +	char *source;           /* Mount source string */
>> +	char *type;             /* Filesystem type string */
>> +	char *mnt_opts;         /* Mount table options */
>> +
>> +	/* Pointer for optbuf manipulation */
>> +	char *optbuf_end;       /* Points to end of optbuf for sprintf */
>> +};
>> +
>> +static void free_mount_params(struct mount_params *mp)
>> +{
>> +	free(mp->optbuf);
>> +	free(mp->fsname);
>> +	free(mp->subtype);
>> +	free(mp->source);
>> +	free(mp->type);
>> +	free(mp->mnt_opts);
>> +}
>> +
>> +/*
>> + * Check if option is deprecated large_read.
>> + *
>> + * Returns true if the option should be skipped (large_read on kernel > 2.4),
>> + * false otherwise (all other options or large_read on old kernels).
>> + */
>> +static bool check_large_read(const char *opt, unsigned int len)
>> +{
>> +	struct utsname utsname;
>> +	unsigned int kmaj, kmin;
>> +	int res;
>> +
>> +	if (!opt_eq(opt, len, "large_read"))
>> +		return false;
>> +
>> +	res = uname(&utsname);
>> +	if (res == 0 &&
>> +	    sscanf(utsname.release, "%u.%u", &kmaj, &kmin) == 2 &&
>> +	    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
>> +		fprintf(stderr,
>> +			"%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n",
>> +			progname, kmaj, kmin);
>> +		return true;
> 
> Ugh, you can drop the uname and all that.  Nobody's running 2.4 kernels
> anymore, right?

Added a new commit that removes this. If someone complains I can recvert
that

> 
>> +	}
>> +	return false;
>> +}
>> +
>> +/*
>> + * Check if user has permission to use allow_other or allow_root options.
>> + *
>> + * Returns -1 if permission denied, 0 if allowed or option is not
>> + * allow_other/allow_root.
>> + */
>> +static int check_allow_permission(const char *opt, unsigned int len)
>> +{
>> +	if (getuid() != 0 && !user_allow_other &&
>> +	    (opt_eq(opt, len, "allow_other") || opt_eq(opt, len, "allow_root"))) {
>> +		fprintf(stderr, "%s: option %.*s only allowed if 'user_allow_other' is set in %s\n",
>> +			progname, len, opt, FUSE_CONF);
>> +		return -1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Process generic mount option.
>> + *
>> + * Handles mount flags (ro, rw, suid, etc.), kernel options
>> + * (default_permissions, allow_other, max_read, blksize), or exits on
>> + * unknown options.
>> + */
>> +static int process_generic_option(const char *opt, unsigned int len,
>> +				   unsigned long *flags, char **dest)
>> +{
>> +	int on;
>> +	int flag;
>> +
>> +	if (find_mount_flag(opt, len, &on, &flag)) {
>> +		if (on)
>> +			*flags |= flag;
>> +		else
>> +			*flags &= ~flag;
>> +		return 0;
>> +	}
>> +
>> +	if (opt_eq(opt, len, "default_permissions") ||
>> +	    opt_eq(opt, len, "allow_other") ||
>> +	    begins_with(opt, "max_read=") ||
>> +	    begins_with(opt, "blksize=")) {
>> +		memcpy(*dest, opt, len);
>> +		*dest += len;
>> +		**dest = ',';
>> +		(*dest)++;
>> +		return 0;
>> +	}
>> +
>> +	fprintf(stderr, "%s: unknown option '%.*s'\n", progname, len, opt);
>> +	exit(1);
>> +}
>> +
>> +static int prepare_mount(const char *opts, struct mount_params *mp)
>>  {
>>  	int res;
>> -	int flags = MS_NOSUID | MS_NODEV;
>> -	char *optbuf;
>> -	char *mnt_opts = NULL;
>>  	const char *s;
>>  	char *d;
>> -	char *fsname = NULL;
>> -	char *subtype = NULL;
>> -	char *source = NULL;
>> -	char *type = NULL;
>> -	int blkdev = 0;
>>  
>> -	optbuf = (char *) malloc(strlen(opts) + 128);
>> -	if (!optbuf) {
>> +	mp->flags = MS_NOSUID | MS_NODEV;
>> +	mp->optbuf = (char *) malloc(strlen(opts) + 128);
>> +	if (!mp->optbuf) {
>>  		fprintf(stderr, "%s: failed to allocate memory\n", progname);
>>  		return -1;
>>  	}
>>  
>> -	for (s = opts, d = optbuf; *s;) {
>> +	for (s = opts, d = mp->optbuf; *s;) {
>>  		unsigned len;
>>  		const char *fsname_str = "fsname=";
>>  		const char *subtype_str = "subtype=";
>> @@ -953,10 +1055,10 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
>>  				break;
>>  		}
>>  		if (begins_with(s, fsname_str)) {
>> -			if (!get_string_opt(s, len, fsname_str, &fsname))
>> +			if (!get_string_opt(s, len, fsname_str, &mp->fsname))
>>  				goto err;
>>  		} else if (begins_with(s, subtype_str)) {
>> -			if (!get_string_opt(s, len, subtype_str, &subtype))
>> +			if (!get_string_opt(s, len, subtype_str, &mp->subtype))
>>  				goto err;
>>  		} else if (opt_eq(s, len, "blkdev")) {
>>  			if (getuid() != 0) {
>> @@ -965,7 +1067,7 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
>>  					progname);
>>  				goto err;
>>  			}
>> -			blkdev = 1;
>> +			mp->blkdev = 1;
>>  		} else if (opt_eq(s, len, "auto_unmount")) {
>>  			auto_unmount = 1;
>>  		} else if (!opt_eq(s, len, "nonempty") &&
>> @@ -973,122 +1075,132 @@ static int do_mount(const char *mnt, const char **typep, mode_t rootmode,
>>  			   !begins_with(s, "rootmode=") &&
>>  			   !begins_with(s, "user_id=") &&
>>  			   !begins_with(s, "group_id=")) {
>> -			int on;
>> -			int flag;
>> -			int skip_option = 0;
>> -			if (opt_eq(s, len, "large_read")) {
>> -				struct utsname utsname;
>> -				unsigned kmaj, kmin;
>> -				res = uname(&utsname);
>> -				if (res == 0 &&
>> -				    sscanf(utsname.release, "%u.%u",
>> -					   &kmaj, &kmin) == 2 &&
>> -				    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
>> -					fprintf(stderr, "%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n", progname, kmaj, kmin);
>> -					skip_option = 1;
>> -				}
>> -			}
>> -			if (getuid() != 0 && !user_allow_other &&
>> -			    (opt_eq(s, len, "allow_other") ||
>> -			     opt_eq(s, len, "allow_root"))) {
>> -				fprintf(stderr, "%s: option %.*s only allowed if 'user_allow_other' is set in %s\n", progname, len, s, FUSE_CONF);
>> +			bool skip;
>> +
>> +			if (check_allow_permission(s, len) == -1)
>>  				goto err;
>> -			}
>> -			if (!skip_option) {
>> -				if (find_mount_flag(s, len, &on, &flag)) {
>> -					if (on)
>> -						flags |= flag;
>> -					else
>> -						flags  &= ~flag;
>> -				} else if (opt_eq(s, len, "default_permissions") ||
>> -					   opt_eq(s, len, "allow_other") ||
>> -					   begins_with(s, "max_read=") ||
>> -					   begins_with(s, "blksize=")) {
>> -					memcpy(d, s, len);
>> -					d += len;
>> -					*d++ = ',';
>> -				} else {
>> -					fprintf(stderr, "%s: unknown option '%.*s'\n", progname, len, s);
>> -					exit(1);
>> -				}
>> -			}
>> +
>> +			skip = check_large_read(s, len);
>> +
>> +			/*
>> +			 * Skip deprecated large_read to avoid passing it to
>> +			 * kernel which would reject it as unknown option.
>> +			 */
>> +			if (!skip)
>> +				process_generic_option(s, len, &mp->flags, &d);
>>  		}
>>  		s += len;
>>  		if (*s)
>>  			s++;
>>  	}
>>  	*d = '\0';
>> -	res = get_mnt_opts(flags, optbuf, &mnt_opts);
>> +	res = get_mnt_opts(mp->flags, mp->optbuf, &mp->mnt_opts);
>>  	if (res == -1)
>>  		goto err;
>>  
>> +	mp->optbuf_end = d;
>> +
>>  	sprintf(d, "fd=%i,rootmode=%o,user_id=%u,group_id=%u",
>> -		fd, rootmode, getuid(), getgid());
>> +		mp->fd, mp->rootmode, getuid(), getgid());
>>  
>> -	source = malloc((fsname ? strlen(fsname) : 0) +
>> -			(subtype ? strlen(subtype) : 0) + strlen(dev) + 32);
>> +	mp->source = malloc((mp->fsname ? strlen(mp->fsname) : 0) +
>> +			(mp->subtype ? strlen(mp->subtype) : 0) + strlen(mp->dev) + 32);
>>  
>> -	type = malloc((subtype ? strlen(subtype) : 0) + 32);
>> -	if (!type || !source) {
>> +	mp->type = malloc((mp->subtype ? strlen(mp->subtype) : 0) + 32);
>> +	if (!mp->type || !mp->source) {
>>  		fprintf(stderr, "%s: failed to allocate memory\n", progname);
>>  		goto err;
>>  	}
>>  
>> -	if (subtype)
>> -		sprintf(type, "%s.%s", blkdev ? "fuseblk" : "fuse", subtype);
>> +	if (mp->subtype)
>> +		sprintf(mp->type, "%s.%s", mp->blkdev ? "fuseblk" : "fuse", mp->subtype);
>>  	else
>> -		strcpy(type, blkdev ? "fuseblk" : "fuse");
>> +		strcpy(mp->type, mp->blkdev ? "fuseblk" : "fuse");
> 
> Hrm, maybe the patch adding fuse_mnt_build_source / fuse_mnt_build_type
> should have done something about this code too.
> 
> The straight-up conversion looks ok though.

Yeah, I need to do that in a later commit that makes these two functions
more generic.


Thanks,
Bernd
