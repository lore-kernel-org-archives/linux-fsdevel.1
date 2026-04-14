Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2171339A4
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 01:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776128403; cv=none; b=jqrE80TZN317wHLNtZKTwPMwP7v6OZP38iM4qAj0cCDvqmmq2Y+qCt4KMP5S3xyXT0G9c6aM4vyPpZzlW6onyAmbk6c87v4FOd4z94zyQ2KhtIgM5y5puOpCP9cLpGf4Oq+WscPtvDUuZx1YiCvTROVI0Om72RiJ133Z4bU5DhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776128403; c=relaxed/simple;
	bh=uxJR1zzj4EfhLx6auYWQ52bgfckSSU8jOZPv1pL3uys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD17q7TVdpGgw7ERQrjBHRlTRiOeKVcvLOfvDQPGQVjjOlzEI21LIc7A1G/ufzmn2/5CVSGs0UrwBek/6BxKdBuKMORBvJTmW9DI/oUqQwAhLh9hx9spwwvbA8loYk7AXHcBABHGz9TQzO4/1OMbaoN7GY8tk7mOc/E3yOdCfBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYFcBKBV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYFcBKBV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824C5C2BCAF;
	Tue, 14 Apr 2026 01:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776128402;
	bh=uxJR1zzj4EfhLx6auYWQ52bgfckSSU8jOZPv1pL3uys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYFcBKBVJJMiv+Y8wcSMUhjmuRaHkHrglVprI3nMMJVoSsxZzoL93lYaRP5CNSTWk
	 qqfeWh/DMVH9Iq0qgl4vGrPDIRbV1AL7qcl2/VDntndiftE9U0BCdyB5tpCjom97Ft
	 lhLCb/QYdBfdpFTOdkwPMqO56/SmtOGNR3hFnkcV6P+DJXO5isElOHA0H2iKSGag+x
	 F5Rm4HyjHV3jUnr8c1swX21F3Jt9CsnvKbWIYx1rHgKuHVKL1tWP9h2WY3zc9aPLqn
	 lKE19Jeq0qIcMDKVgUl2PAKJ3hQvKKqkCn+WR9OqWi/MWlKMc1GKq0HGRTjyr93tmp
	 25zzRam8rvOyA==
Date: Mon, 13 Apr 2026 18:00:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, joannelkoong@gmail.com
Subject: Re: [PATCH 02/13] mount_service: add systemd/inetd socket service
 mounting helper
Message-ID: <20260414010001.GA149953@frogsfrogsfrogs>
References: <177577270167.2064074.16504004857564657756.stgit@frogsfrogsfrogs>
 <177577270253.2064074.4846020380322993537.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177577270253.2064074.4846020380322993537.stgit@frogsfrogsfrogs>

On Thu, Apr 09, 2026 at 03:21:04PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Create a mount helper program that can start a fuse server that runs as
> a socket-based systemd service, and a new libfuse module to wrap all the
> details of communicating between the mount helper and the containerized
> fuse server.
> 
> This enables untrusted ext4 mounts via systemd service containers, which
> avoids the problem of malicious filesystems compromising the integrity
> of the running kernel through memory corruption.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  include/fuse_service.h                           |  243 ++++
>  include/fuse_service_priv.h                      |  133 ++
>  lib/mount_common_i.h                             |    3 
>  util/mount_service.h                             |   39 +
>  .github/workflows/install-ubuntu-dependencies.sh |   12 
>  doc/fuservicemount3.8                            |   24 
>  doc/meson.build                                  |    3 
>  include/meson.build                              |    4 
>  lib/fuse_service.c                               | 1099 +++++++++++++++++++
>  lib/fuse_service_stub.c                          |  106 ++
>  lib/fuse_versionscript                           |   17 
>  lib/helper.c                                     |   51 +
>  lib/meson.build                                  |   17 
>  lib/mount.c                                      |   12 
>  meson.build                                      |   34 +
>  meson_options.txt                                |    9 
>  util/fuservicemount.c                            |   18 
>  util/meson.build                                 |    9 
>  util/mount_service.c                             | 1304 ++++++++++++++++++++++
>  19 files changed, 3132 insertions(+), 5 deletions(-)
>  create mode 100644 include/fuse_service.h
>  create mode 100644 include/fuse_service_priv.h
>  create mode 100644 util/mount_service.h
>  create mode 100644 doc/fuservicemount3.8
>  create mode 100644 lib/fuse_service.c
>  create mode 100644 lib/fuse_service_stub.c
>  create mode 100644 util/fuservicemount.c
>  create mode 100644 util/mount_service.c
> 
> 

<snip>

> diff --git a/lib/fuse_service.c b/lib/fuse_service.c
> new file mode 100644
> index 00000000000000..b775727e7c91e2
> --- /dev/null
> +++ b/lib/fuse_service.c

<snip>

> +static int negotiate_hello(struct fuse_service *sf)
> +{
> +	struct fuse_service_hello hello = { };
> +	struct fuse_service_hello_reply reply = {
> +		.p.magic = htonl(FUSE_SERVICE_HELLO_REPLY),
> +		.version = htons(FUSE_SERVICE_PROTO),
> +	};
> +	struct iovec iov = {
> +		.iov_base = &hello,
> +		.iov_len = sizeof(hello),
> +	};
> +	struct msghdr msg = {
> +		.msg_iov = &iov,
> +		.msg_iovlen = 1,
> +	};
> +	uint64_t flags;

This is a u32 in the socket protocol.

> +	ssize_t size;
> +
> +	size = recvmsg(sf->sockfd, &msg, MSG_TRUNC);
> +	if (size < 0) {
> +		int error = errno;
> +
> +		fuse_log(FUSE_LOG_ERR, "fuse: receive service hello: %s\n",
> +			 strerror(error));
> +		return -error;
> +	}
> +	if (size != sizeof(hello)) {
> +		fuse_log(FUSE_LOG_ERR, "fuse: wrong service hello size %zd, expected %zd\n",
> +			 size, sizeof(hello));
> +		return -EBADMSG;
> +	}
> +
> +	if (ntohl(hello.p.magic) != FUSE_SERVICE_HELLO_CMD) {
> +		fuse_log(FUSE_LOG_ERR, "fuse: service server did not send hello command\n");
> +		return -EBADMSG;
> +	}
> +
> +	if (ntohs(hello.min_version) < FUSE_SERVICE_MIN_PROTO) {
> +		fuse_log(FUSE_LOG_ERR, "fuse: unsupported min service protocol version %u\n",
> +			ntohs(hello.min_version));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (ntohs(hello.max_version) > FUSE_SERVICE_MAX_PROTO) {
> +		fuse_log(FUSE_LOG_ERR, "fuse: unsupported max service protocol version %u\n",
> +			ntohs(hello.min_version));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	flags = ntohl(hello.flags);

Need to check for unrecognized bits being set here.

<snip>

> diff --git a/util/mount_service.c b/util/mount_service.c
> new file mode 100644
> index 00000000000000..abe88a0710255b
> --- /dev/null
> +++ b/util/mount_service.c

<snip>

> +static int mount_service_handle_fsopen_cmd(struct mount_service *mo,
> +					   const struct fuse_service_packet *p,
> +					   size_t psz)
> +{
> +	struct fuse_service_string_command *oc =
> +			container_of(p, struct fuse_service_string_command, p);
> +
> +	if (psz < sizeof_fuse_service_string_command(1)) {
> +		fprintf(stderr, "%s: fsopen command too small\n",
> +			mo->msgtag);
> +		return mount_service_send_reply(mo, EINVAL);
> +	}
> +
> +	if (!check_null_endbyte(p, psz)) {
> +		fprintf(stderr, "%s: fsopen command must be null terminated\n",
> +			mo->msgtag);
> +		return mount_service_send_reply(mo, EINVAL);
> +	}
> +
> +	if (mo->fstype) {
> +		fprintf(stderr, "%s: fstype respecified!\n",
> +			mo->msgtag);
> +		return mount_service_send_reply(mo, EINVAL);
> +	}
> +
> +	mo->fstype = strdup(oc->value);

It occurs to me -- the user that ran fuservicemount already *told* us
what the fuse subtype is going to be; they supplied it via the -t
option.  There's no need to pass the subtype to the fuse server only to
make it pass the subtype back to us.  The only thing that the fuse
server needs to tell us is if this is actually a fuseblk server, since
(among other things) it has to be able to *deal* with weird fuseblk
quirks, such as relying on the kernel to prevent other processes from
writing to the block device.

Therefore, the mount_service can just make a copy of the subtype string
from the cli arguments.  The fuse server can tell us if it wants fuseblk
mode (as a flag, instead of copying strings around!).  For the fsmount()
code path, it can set subtype= to the subtype string copied earlier.
For the classic mount() code, it can format "fuse{,blk}.$subtype" into a
string and pass that in.

<snip>

> +static int mount_service_handle_mount_cmd(struct mount_service *mo,
> +					  struct fuse_service_packet *p,
> +					  size_t psz)
> +{
> +	struct stat stbuf;
> +	struct fuse_service_mount_command *oc =
> +			container_of(p, struct fuse_service_mount_command, p);
> +	int ret;
> +
> +	if (psz != sizeof(struct fuse_service_mount_command)) {
> +		fprintf(stderr, "%s: mount command wrong size\n",
> +			mo->msgtag);
> +		return mount_service_send_reply(mo, EINVAL);
> +	}
> +
> +	if (!mo->fstype) {
> +		fprintf(stderr, "%s: missing mount type parameter\n",
> +			mo->msgtag);
> +		return mount_service_send_reply(mo, EINVAL);
> +	}
> +
> +	if (!mo->source) {
> +		fprintf(stderr, "%s: missing mount source parameter\n",
> +			mo->msgtag);
> +		return mount_service_send_reply(mo, EINVAL);
> +	}
> +
> +	if (!mo->mountpoint) {
> +		fprintf(stderr, "%s: missing mount point parameter\n",
> +			mo->msgtag);
> +		return mount_service_send_reply(mo, EINVAL);
> +	}
> +
> +	/*
> +	 * Make sure we can access the mountpoint and that it's either a
> +	 * directory or a regular file.  Linux can handle mounting atop special
> +	 * files, but we don't care to do such crazy things.
> +	 */
> +	ret = fstat(mo->mountfd, &stbuf);
> +	if (ret < 0) {
> +		int error = errno;
> +
> +		fprintf(stderr, "%s: %s: %s\n",
> +			mo->msgtag, mo->mountpoint, strerror(error));
> +		return mount_service_send_reply(mo, error);
> +	}
> +
> +	/* Make sure the mountpoint type matches what the caller wanted */
> +	switch (ntohs(oc->expected_fmt)) {

Now that the mountpoint command opens the mount point, the expected
format bits of the mountpoint should be passed along with the mountpoint
command and checked earlier.  The permission checks need to stay where
they are, though.

--D
