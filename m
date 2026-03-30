Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8881B39A06E
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774899445; cv=none; b=a/656uyOGlqF8CYksnVMZWjCGZQ3NfEei1q/EAMVR0G8Nmn4I6weliRiukjw5YTisPXJB2TO9AOA6yvy839DCyRF+567CLbEkFmBJqBuUmRVQL3GwPk6d/pWe95G5mi+J+voGXOCOxioOD+gtpSGp/6zbO4p9pEaSuIVptRUzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774899445; c=relaxed/simple;
	bh=LT7LQcJ9H/bQtYv+V9glhEzM1l/X/jAKiYSjhcp9xzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9s7H9cZ+LFIz9E/c8G36NK4VQE0NqAY1Qcu/44JqV9KJJ91h8Fz5in/X4Qj+iTctP3m+R3PR/L3RhUm2h8jmqykNKbrBGKgmeh5GyVZH58PFT2ZsDRXpWLwRf4uu5WCe3IyWIxB+9Vti9QoyoutpLHY9D0FldUUbn+jkiZbyOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=FBG6HVPZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2eOFHRU5; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="FBG6HVPZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2eOFHRU5"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F99A1D00173;
	Mon, 30 Mar 2026 15:37:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 30 Mar 2026 15:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774899441;
	 x=1774985841; bh=/QEH/A6iinzyNjxNtuBb5LcnmwmPnmDsc3m0gLVJars=; b=
	FBG6HVPZG5cNU7PUV46ZFogHRck8nCsHEMVH1SsNrDT0uI6dmcXbwKX7zaBcbHI3
	RTt3y58fQnQZOA8DVxGTvuAs5gmhV5JR58UhWqJPM1+SW183kPrDS5mLQg3BUCkc
	+T7866bLYM4rjhPkwKXMWprJH6y0jr4ZPGY264IV9cP5ixuFsQyBm97PWfA6J4n+
	yULXVi4ly0OKGQsiobW2WoSs2haDXIISSwnQiTQFNwWAQJNaiRmjbXQBlido8ELR
	ZNVtSIzacaREUWXSGNLZ2jS29xkH6Ym0qf0G+A+zzM5kWjiCTAv9zQYJb0el/zPj
	kAA4YyRBaV1dxly+vujxag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774899441; x=
	1774985841; bh=/QEH/A6iinzyNjxNtuBb5LcnmwmPnmDsc3m0gLVJars=; b=2
	eOFHRU5B918NzF72kfcnErWgoMlGK6OL74/hKSYA0Mq+cxP15N8E18Zbh2x58tJ3
	V5ubeY0eJdVj71gjQb/nFIuILIZWEXgKqTGDCQ/Eh3yOygBhZbYWngpkFr8AJLb1
	ppcXP+hDLZ5MRiVcHAW0uJ2/ggRoGTOJapkwhnTh1lMpa1/KjdkYNJek1TpbYRXq
	m3wx/gNQtQRMfH7PcWjP43lAow1dY7N6y3JCzSU2oE9I7y36fZpRnPOA7S1R1xr2
	0qMUQMsEva7sRLYuCRgPwlTsxog4/4qXVOz+Oo3WvBzU07aUiuTkz2Cdiosd79pp
	PzJishtgfsAJHE+3DJXqQ==
X-ME-Sender: <xms:8dDKae4eIALMg_vDxILy_5lNpVHI5PhzKyDX3Hkf4AlULLvcvTrXJg>
    <xme:8dDKablAUKIGsxJi5avs_l2-86S2fs-7HHzctzZ8kY7yk1_Tg5lxzWDN-aWV4UFoS
    -2DPFy-giwIWvGGqZBJvDBgPwsibCmCQA7KcMyCUFUZuffJFjk>
X-ME-Received: <xmr:8dDKaXQfoZdl8vi6eCnq2mg-cf7htMV4TTI8Vph8Xrw-_o4-jcYYVaesRsCQ0TH6HK92yRF5f06Na-FvUjPxVswSGSCnTR8Mz5DVJnvlhKu_KcSfVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeeugfevvdeggeeutdelgffgiefgffejheffkedtieduffehledvfeevgeej
    hedtjeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsshgthhhusggvrhhtsegu
    ughnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhr
    tghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepjhhorghnnhgvlh
    hkohhonhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:8dDKaSEMusyPeyp4567u69KODD_MsakBVXqDg4umY_iLttDwr-xHwA>
    <xmx:8dDKaUGf_oTpwmVE1ytD6bprwR7QI0X9DdkxjeQQoUiRIwTDaz_fSw>
    <xmx:8dDKaYRTmiAE9XbG7DrIen-YJL2V3mwhQjh97k9gKDf7H5HSCR6E0A>
    <xmx:8dDKadKddgyWWCGj2gNTHDxhKEYU_D5LnwBZKLpcHPmdEsv_UX-aRw>
    <xmx:8dDKaeQ2EXMy0bDSop1Hq_uC6p27LTAHvcW4fCss493dnbH4Odtz94Ok>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 15:37:20 -0400 (EDT)
Message-ID: <d7e830f2-fb3f-4782-a6bc-9b850ebdcc36@bsbernd.com>
Date: Mon, 30 Mar 2026 21:37:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] mount_service: create high level fuse helpers
To: "Darrick J. Wong" <djwong@kernel.org>, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev,
 joannelkoong@gmail.com
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463171.1008428.692188550544402497.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <177457463171.1008428.692188550544402497.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Darrick,

On 3/27/26 02:25, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a fuse_main wrapper for fuse services.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  include/fuse.h         |   33 ++++++++++++++++++++++++++++
>  lib/fuse_versionscript |    1 +
>  lib/helper.c           |   57 +++++++++++++++++++++++++++++++++++++++++-------
>  3 files changed, 83 insertions(+), 8 deletions(-)
> 
> 
> diff --git a/include/fuse.h b/include/fuse.h
> index 595cac07f2be36..c7dae040857aca 100644
> --- a/include/fuse.h
> +++ b/include/fuse.h
> @@ -1008,6 +1008,39 @@ static inline int fuse_main_fn(int argc, char *argv[],
>  #define fuse_main(argc, argv, op, user_data) \
>  	fuse_main_fn(argc, argv, op, user_data)
>  
> +#if FUSE_MAKE_VERSION(3, 19) <= FUSE_USE_VERSION
> +struct fuse_service;
> +int fuse_service_main_real_versioned(struct fuse_service *service,
> +				     int argc, char *argv[],
> +				     const struct fuse_operations *op,
> +				     size_t op_size,
> +				     struct libfuse_version *version,
> +				     void *user_data);
> +
> +/**
> + * Same as fuse_service_main_fn, but takes its information from the mount
> + * service context.
> + */
> +static inline int fuse_service_main_fn(struct fuse_service *service,
> +				       int argc, char *argv[],
> +				       const struct fuse_operations *op,
> +				       void *user_data)
> +{
> +	struct libfuse_version version = {
> +		.major  = FUSE_MAJOR_VERSION,
> +		.minor  = FUSE_MINOR_VERSION,
> +		.hotfix = FUSE_HOTFIX_VERSION,
> +		.padding = 0
> +	};
> +
> +	return fuse_service_main_real_versioned(service, argc, argv, op,
> +						sizeof(*(op)), &version,
> +						user_data);
> +}
> +#define fuse_service_main(s, argc, argv, op, user_data) \
> +	fuse_service_main_fn(s, argc, argv, op, user_data)
> +#endif /* FUSE_USE_VERSION >= FUSE_MAKE_VERSION(3, 19) */

sorry, this is not exactly what I meant. Could you take a look here? I
just pushed the unfinished patch I made in December. It got complicated
in the high level API and I didn't have time to finish it yet.

https://github.com/libfuse/libfuse/pull/1382/changes/24836ded18e9736eb4691600600ff1d7cf581e29

Basically I would like to add the API version to the functions, in order
to set defaults flags. The topic came up about FUSE_CAP_AUTO_INVAL_DATA,
because it can cause data corruption, but there is also a risk to cause
regressions. So would be good to set that based on the API version
(assuming people read the rather new doc/ChangeLog-API.rst).

Anyway your function should basically be

int fuse_service_main_real_versioned(struct fuse_service *service,
				     int argc, char *argv[],
				     const struct fuse_operations *op,
				     size_t op_size,
                                     unsigned int user_apiabi_version,
				     struct libfuse_version *version,
				     void *user_data);


I.e. adding in 'user_apiabi_version'. Although while looking into this
again, maybe we should mis-use 'padding' and rename it 'api version. It
would definitely simplify things.


While you look into all these things, what is your opinion? ;)


Thanks,
Bernd

> +
>  /* ----------------------------------------------------------- *
>   * More detailed API					       *
>   * ----------------------------------------------------------- */
> diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
> index 1fc73f417f90a0..43f8bf11b64548 100644
> --- a/lib/fuse_versionscript
> +++ b/lib/fuse_versionscript
> @@ -236,6 +236,7 @@ FUSE_3.19 {
>  		fuse_service_exit;
>  		fuse_service_expect_mount_mode;
>  		fuse_service_finish_file_requests;
> +		fuse_service_main_real_versioned;
>  		fuse_service_parse_cmdline_opts;
>  		fuse_service_receive_file;
>  		fuse_service_release;
> diff --git a/lib/helper.c b/lib/helper.c
> index 533526273207d5..3509f1aa0c8f79 100644
> --- a/lib/helper.c
> +++ b/lib/helper.c
> @@ -15,6 +15,7 @@
>  #include "fuse_misc.h"
>  #include "fuse_opt.h"
>  #include "fuse_lowlevel.h"
> +#include "fuse_service.h"
>  #include "mount_util.h"
>  
>  #include <stdio.h>
> @@ -357,7 +358,8 @@ int fuse_daemonize(int foreground)
>  	return 0;
>  }
>  
> -int fuse_main_real_versioned(int argc, char *argv[],
> +int fuse_service_main_real_versioned(struct fuse_service *service,
> +			     int argc, char *argv[],
>  			     const struct fuse_operations *op, size_t op_size,
>  			     struct libfuse_version *version, void *user_data)
>  {
> @@ -367,8 +369,15 @@ int fuse_main_real_versioned(int argc, char *argv[],
>  	int res;
>  	struct fuse_loop_config *loop_config = NULL;
>  
> -	if (fuse_parse_cmdline(&args, &opts) != 0)
> -		return 1;
> +	if (service) {
> +		if (fuse_service_parse_cmdline_opts(&args, &opts) != 0) {
> +			res = 1;
> +			goto out0;
> +		}
> +	} else {
> +		if (fuse_parse_cmdline(&args, &opts) != 0)
> +			return 1;
> +	}
>  
>  	if (opts.show_version) {
>  		printf("FUSE library version %s\n", PACKAGE_VERSION);
> @@ -405,9 +414,17 @@ int fuse_main_real_versioned(int argc, char *argv[],
>  		goto out1;
>  	}
>  
> -	if (fuse_mount(fuse,opts.mountpoint) != 0) {
> -		res = 4;
> -		goto out2;
> +	if (service) {
> +		if (fuse_service_session_mount(service, fuse_get_session(fuse),
> +					       0, &opts) != 0) {
> +			res = 4;
> +			goto out2;
> +		}
> +	} else {
> +		if (fuse_mount(fuse, opts.mountpoint) != 0) {
> +			res = 4;
> +			goto out2;
> +		}
>  	}
>  
>  	if (fuse_daemonize(opts.foreground) != 0) {
> @@ -421,9 +438,14 @@ int fuse_main_real_versioned(int argc, char *argv[],
>  		goto out3;
>  	}
>  
> -	if (opts.singlethread)
> +	if (opts.singlethread) {
> +		if (service) {
> +			fuse_service_send_goodbye(service, 0);
> +			fuse_service_release(service);
> +		}
> +
>  		res = fuse_loop(fuse);
> -	else {
> +	} else {
>  		loop_config = fuse_loop_cfg_create();
>  		if (loop_config == NULL) {
>  			res = 7;
> @@ -434,6 +456,12 @@ int fuse_main_real_versioned(int argc, char *argv[],
>  
>  		fuse_loop_cfg_set_idle_threads(loop_config, opts.max_idle_threads);
>  		fuse_loop_cfg_set_max_threads(loop_config, opts.max_threads);
> +
> +		if (service) {
> +			fuse_service_send_goodbye(service, 0);
> +			fuse_service_release(service);
> +		}
> +
>  		res = fuse_loop_mt(fuse, loop_config);
>  	}
>  	if (res)
> @@ -448,9 +476,22 @@ int fuse_main_real_versioned(int argc, char *argv[],
>  	fuse_loop_cfg_destroy(loop_config);
>  	free(opts.mountpoint);
>  	fuse_opt_free_args(&args);
> +out0:
> +	if (service) {
> +		fuse_service_send_goodbye(service, res);
> +		fuse_service_release(service);
> +	}
>  	return res;
>  }
>  
> +int fuse_main_real_versioned(int argc, char *argv[],
> +			     const struct fuse_operations *op, size_t op_size,
> +			     struct libfuse_version *version, void *user_data)
> +{
> +	return fuse_service_main_real_versioned(NULL, argc, argv, op, op_size,
> +						version, user_data);
> +}
> +
>  /* Not symboled, as not part of the official API */
>  int fuse_main_real_30(int argc, char *argv[], const struct fuse_operations *op,
>  		      size_t op_size, void *user_data);
> 
> 

