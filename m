Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776153E0C7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897495; cv=none; b=uGv5ur6BG0pu2woqlSBsPT/1rYXLIKSaAzKB3RFRg6Pgw1P3cIZ7BqH3rvLvSLVOuh3GZyqnuMIdXtLAoCKH1a4rpZ7ykXa4T+LKIAMeMav4TklR96VM+vx5mgFFTh4Vvp/MRd2B7bFHwOFBfgOsq1V+U2jJLEC0MYIo10X5iB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897495; c=relaxed/simple;
	bh=e+u28mnf2gXZtA5y3Myn3VFMI9+kNbdHPYcIhFXtprc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhLUDARxDcp87b224dJEhS1MpPonRTcL+G3lPRGGqjye6HG/9qosW/jzBadDpsef87jZEwk7tDR9l8YfJN2b+6X3ppcnMcNK6KraI7s+qQDlOLLurJ420bT9np3rlROyeBK1TWlCmVsYpWQQFrQVXLUZVklQzezcRaQ/IZcdumQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDzfkg8+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDzfkg8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6E1C4CEF7;
	Mon, 30 Mar 2026 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774897495;
	bh=e+u28mnf2gXZtA5y3Myn3VFMI9+kNbdHPYcIhFXtprc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDzfkg8+YNPKbj9R/WpcRtMijdKBtUANxQMVShstZkSQm2Hv2kkE4kYESw0CuQW5C
	 G52tmI/AMl6YAkqF7q2c3HvcYID8aa5fDL9L930nWf9fxrK5+SZpi0EWEb4fofpblz
	 LtwgSH7TEZMC3b8P8c44GiMSB0mQ6PFpxRzZnRrKBAI05thd4gIhcHrVeUGB8odIZn
	 boKTBFA1hi30CcKsJbhrfBgG8xOR1QwHyFaH/LnUZ+Z7lmT8y3PYkxfU2g/x+nUX4h
	 FAwky7zhcLX3S+7dVsRiBdVQMfS8R6oYMe2OrU5IA5M5NRxD6ieEuYsgr5urzvxiKp
	 +By8tuxN/X1nA==
Date: Mon, 30 Mar 2026 12:04:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH v2 25/25] Add a background debug option to passthrough hp
Message-ID: <20260330190454.GC6202@frogsfrogsfrogs>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-25-b1ca8fcbf60f@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-fuse-init-before-mount-v2-25-b1ca8fcbf60f@bsbernd.com>

On Thu, Mar 26, 2026 at 10:34:58PM +0100, Bernd Schubert wrote:
> Background debugging is useful when logs should go
> to syslog for a daemon running in background.
> 
> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  example/passthrough_hp.cc | 41 +++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/example/passthrough_hp.cc b/example/passthrough_hp.cc
> index cca865973ab5e8e9c1faa0fa28eb292a172a4812..fa924b89ab3cc42a88767423674a6a190c0aa520 100644
> --- a/example/passthrough_hp.cc
> +++ b/example/passthrough_hp.cc
> @@ -160,7 +160,8 @@ struct Fs {
>  	Inode root;
>  	double timeout;
>  	bool debug;
> -	bool debug_fuse;
> +	bool debug_fuse; // foreground fuse debug
> +	bool bg_debug_fuse; // background fuse debug
>  	bool foreground;
>  	std::string source;
>  	size_t blocksize;
> @@ -1480,21 +1481,22 @@ static cxxopts::ParseResult parse_options(int argc, char **argv)
>  {
>  	cxxopts::Options opt_parser(argv[0]);
>  	std::vector<std::string> mount_options;
> -	opt_parser.add_options()("debug", "Enable filesystem debug messages")(
> -		"debug-fuse", "Enable libfuse debug messages")(
> -		"foreground", "Run in foreground")("help", "Print help")(
> -		"nocache", "Disable attribute all caching")(
> -		"nosplice", "Do not use splice(2) to transfer data")(
> -		"nopassthrough", "Do not use pass-through mode for read/write")(
> -		"single", "Run single-threaded")(
> -		"o",
> -		"Mount options (see mount.fuse(5) - only use if you know what "
> -		"you are doing)",
> -		cxxopts::value(mount_options))(
> -		"num-threads", "Number of libfuse worker threads",
> -		cxxopts::value<int>()->default_value(SFS_DEFAULT_THREADS))(
> -		"clone-fd", "use separate fuse device fd for each thread")(
> -		"direct-io", "enable fuse kernel internal direct-io");
> +	opt_parser.add_options()
> +		("debug", "Enable filesystem debug messages")
> +		("debug-fuse", "Enable libfuse debug messages")
> +		("bg-debug-fuse", "Enable libfuse debug messages in background")
> +		("foreground", "Run in foreground")("help", "Print help")
> +		("nocache", "Disable attribute all caching")
> +		("nosplice", "Do not use splice(2) to transfer data")
> +		("nopassthrough", "Do not use pass-through mode for read/write")
> +		("single", "Run single-threaded")
> +		("o", "Mount options (see mount.fuse(5) - only use if you know what "
> +		      "you are doing)",
> +		cxxopts::value(mount_options))
> +		("num-threads", "Number of libfuse worker threads",
> +		cxxopts::value<int>()->default_value(SFS_DEFAULT_THREADS))
> +		("clone-fd", "use separate fuse device fd for each thread")
> +		("direct-io", "enable fuse kernel internal direct-io");
>  
>  	// FIXME: Find a better way to limit the try clause to just
>  	// opt_parser.parse() (cf. https://github.com/jarro2783/cxxopts/issues/146)
> @@ -1520,6 +1522,7 @@ static cxxopts::ParseResult parse_options(int argc, char **argv)
>  
>  	fs.debug = options.count("debug") != 0;
>  	fs.debug_fuse = options.count("debug-fuse") != 0;
> +	fs.bg_debug_fuse = options.count("bg-debug-fuse") != 0;
>  
>  	fs.foreground = options.count("foreground") != 0;
>  	if (fs.debug || fs.debug_fuse)
> @@ -1643,6 +1646,12 @@ int main(int argc, char *argv[])
>  
>  	fuse_loop_cfg_set_clone_fd(loop_config, fs.clone_fd);
>  
> +	if (!fs.foreground)
> +		fuse_log_enable_syslog("passthrough-hp", LOG_PID | LOG_CONS,
> +				       LOG_DAEMON);
> +	if (fs.bg_debug_fuse)
> +		fuse_session_set_debug(se);
> +
>  	/* Start daemonization before mount so parent can report mount failure */
>  	if (fs.foreground)
>  		daemon_flags |= FUSE_DAEMONIZE_NO_BACKGROUND;
> 
> -- 
> 2.43.0
> 
> 
