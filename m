Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E076026
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775607118; cv=none; b=qv0lud0GGS6HWAZYH43noxDV9HgmP8WiifsMK9VlOyfK7WdIPsnWN0fbSdl/wp3LS7OyXdOY4RodmIdht8oWdxbxDa3qEzezCuC/VZ0+ktM7Stusp5ots/qgya1zKzSZyR1p1AiSsqPptHh1NnYOXYnZem6Cnb+Yd6Tv/3OY+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775607118; c=relaxed/simple;
	bh=23hYV1iTaCPOEDfYLukNTlH+uBo1hqiJGvSoVvnprtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqmTDFE4/qH4GAnt+zWjRxkXAePDnwCC8nqZw1cHlXCd4DhrZ0z7OktmB2gS6fPJjCnLA8m/vrKvn8yXCT/RQjVMFz765YdI5CZoxxJNNHQOuk03TY12Mukd4j1RxYSuFXOc+luOQOqHu26XvnnLe1SsNkdf7vwjBWB22s29pT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZhV9laQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZhV9laQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31A3C19421;
	Wed,  8 Apr 2026 00:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775607117;
	bh=23hYV1iTaCPOEDfYLukNTlH+uBo1hqiJGvSoVvnprtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZhV9laQM7taOT2WFbRDURnJeVHY73MxXPRdV9vsz8M+fgQrHmKa8xYTqgJykig8B
	 KBcKgifd/jBHIFiGUYi1yrYLwGeyef8eUqsejd6Ynugvtw++3pH/mIrbP2Ta8R/o85
	 mO/aL/FoSDkuP8u68Iy+d2m7qkb/uwRoh1Rk3QpOlOXqpowpldc68/LlIQz4RDbHWc
	 xUZWxBpCWgZhAX8qjoSJGwQrF5iYHvj7Kgbm8RtM4sS88rrNhVArX7FBGsr3X57ocG
	 lbuH9PoXkx6BF8AZHTdqhkGg1sBp/8c0GaewIlKvVrVLxj1zf5Lg2Trp+JMVaTJ9b/
	 EdM8L32OOFd+w==
Date: Tue, 7 Apr 2026 17:11:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
	neal@gompa.dev, joannelkoong@gmail.com
Subject: Re: [PATCH 17/17] nullfs: support fuse systemd service mode
Message-ID: <20260408001157.GT6202@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
 <177457463428.1008428.6991907403668845476.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177457463428.1008428.6991907403668845476.stgit@frogsfrogsfrogs>

On Thu, Mar 26, 2026 at 06:29:12PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This is the only example fuse server that exports a regular file instead
> of a directory tree.  Port it to be usable as a systemd fuse service so
> that we can test that capability.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  example/meson.build        |    6 +++
>  example/null.c             |   33 +++++++++++++-
>  example/nullfile.socket.in |   15 ++++++
>  example/nullfile@.service  |  102 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 154 insertions(+), 2 deletions(-)
>  create mode 100644 example/nullfile.socket.in
>  create mode 100644 example/nullfile@.service
> 
> 
> diff --git a/example/meson.build b/example/meson.build
> index 0a7cc3dbf31da4..c08a81747e68ae 100644
> --- a/example/meson.build
> +++ b/example/meson.build
> @@ -10,6 +10,12 @@ if not platform.endswith('bsd') and platform != 'dragonfly'
>      # support mounting files, This is enforced in vfs_domount_first()
>      # with the v_type != VDIR check.
>      examples += [ 'null' ]
> +
> +    if platform.endswith('linux')
> +        configure_file(input: 'nullfile.socket.in',
> +                       output: 'nullfile.socket',
> +                       configuration: private_cfg)
> +    endif
>  endif
>  
>  single_file_examples = [ 'hello_ll' ]
> diff --git a/example/null.c b/example/null.c
> index ec41def40ed5c5..3e7e43f722a432 100644
> --- a/example/null.c
> +++ b/example/null.c
> @@ -17,15 +17,24 @@
>   *
>   *     gcc -Wall null.c `pkg-config fuse3 --cflags --libs` -o null
>   *
> + * Change the ExecStart line in nullfile@.service:
> + *
> + *     ExecStart=/path/to/nullfile
> + *
> + * to point to the actual path of the nullfile binary.
> + *
> + * Finally, install the nullfile@.service and nullfile.socket files to the
> + * systemd service directory, usually /run/systemd/system.

Ok last rAmblIng email for now -- I've fixed the socket and service
name to be consistent with the server name, like it is for the other two
examples.  Apparently Codex is better at noticing those details than I
am.

I also dropped the hello_ll.c changes because the service stuff more or
less only works on Linux.  Nobody's porting systemd to BSD and there are
no inetd clones that support AF_UNIX, so that's a huge barrier to any of
it working anywhere else.

(I wouldn't be opposed to someone contributing support, but I'm not a
BSD/Windows/Devuan user)

--D

> + *
>   * ## Source code ##
>   * \include passthrough_fh.c
>   */
>  
> -
> -#define FUSE_USE_VERSION 31
> +#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 19)
>  
>  #include <fuse.h>
>  #include <fuse_lowlevel.h>
> +#include <fuse_service.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -117,6 +126,26 @@ int main(int argc, char *argv[])
>  	struct fuse_args args = FUSE_ARGS_INIT(argc, argv);
>  	struct fuse_cmdline_opts opts;
>  	struct stat stbuf;
> +	struct fuse_service *service = NULL;
> +	int ret;
> +
> +	if (fuse_service_accept(&service) != 0)
> +		return 1;
> +
> +	if (fuse_service_accepted(service)) {
> +		if (fuse_service_append_args(service, &args) != 0)
> +			return 1;
> +		if (fuse_service_finish_file_requests(service) != 0)
> +			return 1;
> +
> +		fuse_service_expect_mount_mode(service, S_IFREG);
> +
> +		ret = fuse_service_main(service, args.argc, args.argv,
> +					&null_oper, NULL);
> +
> +		fuse_opt_free_args(&args);
> +		return fuse_service_exit(ret);
> +	}
>  
>  	if (fuse_parse_cmdline(&args, &opts) != 0)
>  		return 1;
> diff --git a/example/nullfile.socket.in b/example/nullfile.socket.in
> new file mode 100644
> index 00000000000000..23e57a25f2eb93
> --- /dev/null
> +++ b/example/nullfile.socket.in
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2026 Oracle.  All Rights Reserved.
> +# Author: Darrick J. Wong <djwong@kernel.org>
> +[Unit]
> +Description=Socket for nullfile Service
> +
> +[Socket]
> +ListenSequentialPacket=@FUSE_SERVICE_SOCKET_DIR_RAW@/nullfile
> +Accept=yes
> +SocketMode=0220
> +RemoveOnStop=yes
> +
> +[Install]
> +WantedBy=sockets.target
> diff --git a/example/nullfile@.service b/example/nullfile@.service
> new file mode 100644
> index 00000000000000..665f8d4226ff49
> --- /dev/null
> +++ b/example/nullfile@.service
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2026 Oracle.  All Rights Reserved.
> +# Author: Darrick J. Wong <djwong@kernel.org>
> +[Unit]
> +Description=nullfile Sample Fuse Service
> +
> +# Don't leave failed units behind, systemd does not clean them up!
> +CollectMode=inactive-or-failed
> +
> +[Service]
> +Type=exec
> +ExecStart=/path/to/null
> +
> +# Try to capture core dumps
> +LimitCORE=infinity
> +
> +SyslogIdentifier=%N
> +
> +# No realtime CPU scheduling
> +RestrictRealtime=true
> +
> +# Don't let us see anything in the regular system, and don't run as root
> +DynamicUser=true
> +ProtectSystem=strict
> +ProtectHome=true
> +PrivateTmp=true
> +PrivateDevices=true
> +PrivateUsers=true
> +
> +# No network access
> +PrivateNetwork=true
> +ProtectHostname=true
> +RestrictAddressFamilies=none
> +IPAddressDeny=any
> +
> +# Don't let the program mess with the kernel configuration at all
> +ProtectKernelLogs=true
> +ProtectKernelModules=true
> +ProtectKernelTunables=true
> +ProtectControlGroups=true
> +ProtectProc=invisible
> +RestrictNamespaces=true
> +RestrictFileSystems=
> +
> +# Hide everything in /proc, even /proc/mounts
> +ProcSubset=pid
> +
> +# Only allow the default personality Linux
> +LockPersonality=true
> +
> +# No writable memory pages
> +MemoryDenyWriteExecute=true
> +
> +# Don't let our mounts leak out to the host
> +PrivateMounts=true
> +
> +# Restrict system calls to the native arch and only enough to get things going
> +SystemCallArchitectures=native
> +SystemCallFilter=@system-service
> +SystemCallFilter=~@privileged
> +SystemCallFilter=~@resources
> +
> +SystemCallFilter=~@clock
> +SystemCallFilter=~@cpu-emulation
> +SystemCallFilter=~@debug
> +SystemCallFilter=~@module
> +SystemCallFilter=~@reboot
> +SystemCallFilter=~@swap
> +
> +SystemCallFilter=~@mount
> +
> +# libfuse io_uring wants to pin cores and memory
> +SystemCallFilter=mbind
> +SystemCallFilter=sched_setaffinity
> +
> +# Leave a breadcrumb if we get whacked by the system call filter
> +SystemCallErrorNumber=EL3RST
> +
> +# Log to the kernel dmesg, just like an in-kernel filesystem driver
> +StandardOutput=append:/dev/ttyprintk
> +StandardError=append:/dev/ttyprintk
> +
> +# Run with no capabilities at all
> +CapabilityBoundingSet=
> +AmbientCapabilities=
> +NoNewPrivileges=true
> +
> +# We don't create files
> +UMask=7777
> +
> +# No access to hardware /dev files at all
> +ProtectClock=true
> +DevicePolicy=closed
> +
> +# Don't mess with set[ug]id anything.
> +RestrictSUIDSGID=true
> +
> +# Don't let OOM kills of processes in this containment group kill the whole
> +# service, because we don't want filesystem drivers to go down.
> +OOMPolicy=continue
> +OOMScoreAdjust=-1000
> 
> 
