Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E98B32FA18;
	Mon, 27 Apr 2026 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302810; cv=none; b=dKhUssmxrNxENU+ZP49WkAqq98Mrc6cfvLtfEnxCCmOJ8ethbBkJaCS7FhJcZCQaOZ/UGveoKKFhQ8ZP6Zy2fhgaiVmuRGWyUJj28IqwpomeFRwm3VQ1UvjCKDWx8qlci3jBoXPhT24E/8RbWU62heiViUh6mT/gVykiwKUeETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302810; c=relaxed/simple;
	bh=upjI1hr3/O7zacguPqo6Sm+JDnmiwezRdXd0a2nwqyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx4OoEQH5tbEUgBnZWllSqJyW5iZ9lpZhxSKmF0+q3mbhuiIVveHyfmqsXriB7q9ey8rDzpvQD8rbVSDUAv8/DJnJhIz9aP8GJN8DSne/3ucx37HtiA37PPkGgo/HN8y1if7xeUAF2GUNbZdyKkboMthU6qaODm+Gd+cvp6EdPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uNHJNBx+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uNHJNBx+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F067CC19425;
	Mon, 27 Apr 2026 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777302810;
	bh=upjI1hr3/O7zacguPqo6Sm+JDnmiwezRdXd0a2nwqyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uNHJNBx+9drvHPNRPbtYjYXzEllz7MJlKdn7E7BfDno4+fRjcYsFQFUJqU/iCVfRy
	 ZaiSnX+9ir1qpPQ9iKlmPVb75eeU6DWZV3SnC8KOCsycgC3VYrvEWrTLgoyfVktkBf
	 v7lbGdk6XzABovNQvxQlT/OHAsYAqnKsmNU93Ot6pCAQqYHhXn/55I5BZgMYsFn03l
	 GLFmiY8xX5GYYZ0GJNb1xhEYNwh2CT1UPA2nKMotUIEXwwDiqxTZ8uU3Lc+3ztaT7U
	 4RkcmD+nSTEXOPWuCMsv8iBvdwEgwL4vH4/JEpXv1l3I6aJcMPkG1I4dWlfJsEaibq
	 9wi7/nksHoizg==
Date: Mon, 27 Apr 2026 08:13:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
	miklos@szeredi.hu, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 12/13] example/service: create a sample systemd service
 for a high-level fuse server
Message-ID: <20260427151329.GN7739@frogsfrogsfrogs>
References: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
 <177689988756.3820166.5462739027142309789.stgit@frogsfrogsfrogs>
 <5b50e0a7-fe4b-4af4-a765-a91d21ab3852@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b50e0a7-fe4b-4af4-a765-a91d21ab3852@bsbernd.com>

On Sun, Apr 26, 2026 at 11:21:21PM +0200, Bernd Schubert wrote:
> 
> 
> On 4/23/26 01:22, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a simple high-level fuse server that can be run as a systemd
> > service.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  example/single_file.h        |   38 ++++++
> >  example/meson.build          |    6 +
> >  example/service_hl.c         |  224 +++++++++++++++++++++++++++++++++++
> >  example/service_hl.socket.in |   15 ++
> >  example/service_hl@.service  |  102 ++++++++++++++++
> >  example/service_ll.c         |    1 
> >  example/single_file.c        |  271 +++++++++++++++++++++++++++++++++++++++---
> >  7 files changed, 640 insertions(+), 17 deletions(-)
> >  create mode 100644 example/service_hl.c
> >  create mode 100644 example/service_hl.socket.in
> >  create mode 100644 example/service_hl@.service
> > 
> > 
> > diff --git a/example/single_file.h b/example/single_file.h
> > index d8a91adbf875ef..86edb51afb3384 100644
> > --- a/example/single_file.h
> > +++ b/example/single_file.h
> > @@ -124,6 +124,7 @@ ssize_t single_file_pread(char *buf, size_t count, off_t pos);
> >  
> >  /* low-level fuse operation handlers */
> >  
> > +#ifdef USE_SINGLE_FILE_LL_API
> >  bool is_single_file_child(fuse_ino_t parent, const char *name);
> >  bool is_single_file_ino(fuse_ino_t ino);
> >  
> > @@ -149,5 +150,42 @@ void single_file_ll_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
> >  
> >  int reply_buf_limited(fuse_req_t req, const char *buf, size_t bufsize,
> >  		      off_t off, size_t maxsize);
> > +#endif
> > +
> > +/* high-level fuse operation handlers */
> > +
> > +#ifdef USE_SINGLE_FILE_HL_API
> > +bool is_single_open_file_path(const struct fuse_file_info *fi, const char *name);
> > +
> > +int single_file_hl_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
> > +			   off_t offset, struct fuse_file_info *fi,
> > +			   enum fuse_readdir_flags flags);
> > +
> > +int single_file_hl_statfs(const char *path, struct statvfs *buf);
> > +
> > +int single_file_hl_statx(const char *path, int statx_flags, int statx_mask,
> > +			 struct statx *stx, struct fuse_file_info *fi);
> > +
> > +int single_file_hl_getattr(const char *path, struct stat *stbuf,
> > +			   struct fuse_file_info *fi);
> > +int single_file_hl_chmod(const char *path, mode_t mode,
> > +			 struct fuse_file_info *fi);
> > +int single_file_hl_utimens(const char *path, const struct timespec ctv[2],
> > +			   struct fuse_file_info *fi);
> > +int single_file_hl_chown(const char *path, uid_t owner, gid_t group,
> > +			 struct fuse_file_info *fi);
> > +int single_file_hl_truncate(const char *path, off_t len,
> > +			    struct fuse_file_info *fi);
> > +
> > +int single_file_hl_opendir(const char *path, struct fuse_file_info *fi);
> > +int single_file_hl_open(const char *path, struct fuse_file_info *fi);
> > +
> > +int single_file_hl_fsync(const char *path, int datasync,
> > +			 struct fuse_file_info *fi);
> > +#endif
> > +
> > +#if !defined(USE_SINGLE_FILE_LL_API) && !defined(USE_SINGLE_FILE_HL_API)
> > +# warning USE_SINGLE_FILE_[HL]L_API not defined!
> > +#endif
> >  
> >  #endif /* FUSE_SINGLE_FILE_H_ */
> > diff --git a/example/meson.build b/example/meson.build
> > index e948f6ba74fdfa..19a383f7cd2c74 100644
> > --- a/example/meson.build
> > +++ b/example/meson.build
> > @@ -19,6 +19,12 @@ if platform.endswith('linux')
> >      configure_file(input: 'service_ll.socket.in',
> >                     output: 'service_ll.socket',
> >                     configuration: private_cfg)
> > +
> > +    single_file_examples += [ 'service_hl' ]
> > +    configure_file(input: 'service_hl.socket.in',
> > +                   output: 'service_hl.socket',
> > +                   configuration: private_cfg)
> > +
> >  endif
> >  
> >  threaded_examples = [ 'notify_inval_inode',
> > diff --git a/example/service_hl.c b/example/service_hl.c
> > new file mode 100644
> > index 00000000000000..9c4f3ae7a6cf3c
> > --- /dev/null
> > +++ b/example/service_hl.c
> > @@ -0,0 +1,224 @@
> > +/*
> > + * FUSE: Filesystem in Userspace
> > + * Copyright (C) 2026 Oracle.
> > + *
> > + * This program can be distributed under the terms of the GNU GPLv2.
> > + * See the file GPL2.txt.
> > + */
> > +
> > +/** @file
> > + *
> > + * minimal example filesystem using high-level API and systemd service api
> 
> Could you add a bit more context?
> 
> - Shows how to build a high level FUSE filesystems that can be managed
> by systemd
> - Enables on-demand filesystem mounting via socket activation
> - Allows running FUSE servers with minimal privileges (unlike
> traditional FUSE which needs mount permissions)

I will do that for both service_[hl]l.c files.  Currently I have for the
lowlevel example:

 * Minimal example filesystem using low-level API and systemd service API.
 *
 * - Shows how to build a low level FUSE filesystem server that can be managed
 *   by systemd
 * - Enables on-demand filesystem mounting via socket activation
 * - Demonstrates requesting resources from the mount-caller's environment
 * - Allows running FUSE servers with minimal privileges; isolated mount,
 *   network, and pid namespaces; and a separate uid/gid (unlike traditional
 *   FUSE which needs mount permissions and runs in the caller's environment)
 *
 * Compile with:
 *
 *     gcc -Wall single_file.c service_ll.c `pkg-config fuse3 --cflags --libs` -o service_ll
 *
 * Note: If the pkg-config command fails due to the absence of the fuse3.pc
 *     file, you should configure the path to the fuse3.pc file in the
 *     PKG_CONFIG_PATH variable.
 *
 * Change the ExecStart line in service_ll@.service:
 *
 *     ExecStart=/path/to/service_ll
 *
 * to point to the actual path of the service_ll binary.
 *
 * Finally, install the service_ll@.service and service_ll.socket files to the
 * systemd service directory, usually /run/systemd/system.  Run these commands
 * to activate:
 *
 *     systemctl daemon-reload
 *     systemctl start service_ll.socket
 *
 * Then mount with:
 *
 *     mount -t fuse.service_ll /dev/sda /mnt

and similar for service_hl.c.

--D

> 
> Thanks,
> Bernd
> 
