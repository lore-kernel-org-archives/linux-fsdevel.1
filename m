Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE32DB788
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535964; cv=none; b=l9nrcssECv13k96rpCwN4GYKdYTXUqACh5gywvg34e4TJDJeb8awipuUZl653QxECVX2JY0jd0fevQyUge4vRBK8ABrKp/ilZXURgMkFQa/6koc/3Qp6h3zUYNLn98YDeTSKNNMbaaaJRyrpSZGbfZmKNziaD9iIEmabhC7PqDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535964; c=relaxed/simple;
	bh=yJvPos6W41NVA3w/bjhhfi/qVbo9Fcvcdig/i2q/yMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXr8yaI+Tv4ex51b+7NwYlLzP3SlXWa/DAJ8J6IRXG1kgWNEXILzVX58staL14azgDpnLHATOx9uogDUrZ1pDNsu58Fz0S6I+w1c7oNxrZWH1xG2aaDy0yVgSrXIXg6IwLHl6IvhbDuGRqb+3QAc3IItCKNb6YGAxoYgGH2A0b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb4YSJng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb4YSJng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94905C116C6;
	Thu, 26 Mar 2026 14:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774535963;
	bh=yJvPos6W41NVA3w/bjhhfi/qVbo9Fcvcdig/i2q/yMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fb4YSJngrY0EKM1NjiBJ8rJ9ZOMecHD4a3pzJjZOevx2cUAH3R/47v45lM1eyMu2w
	 +gWxDfrT4ZeiePnjZc0RAIg+ikWnCwKOzUTHhba+6gPSU0eCwT+JGqru4aMY+QmZcQ
	 RH5JncoTX+ywHDBOlW22VqYhwqBhpaJVGTuuqEELE0vpC7zNz1K5OtJr2dQfpsjmhh
	 Tfb8ptRZfTgXsO0kwib6w0/DqtZttN2qbrMBomm8/n1uYOlhEZZqqyU01v8B4Icj5V
	 maifLrukA9qmYDBXPpgLp3zUuD0b2dIcR/GNyFRXLTm/tcedX71FaGpBt0BTpi2/U9
	 EtkGjsSfqWcUg==
Date: Thu, 26 Mar 2026 15:39:18 +0100
From: Christian Brauner <brauner@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, Jan Kara <jack@suse.cz>, 
	"Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260326-gemindert-vertuschen-fd3a507eba94@brauner>
References: <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com>
 <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com>
 <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
 <20260324-hilfen-reibung-9783005d5d0f@brauner>
 <b8f5bff1-27bf-4934-9297-0aad551a550c@gmail.com>
 <d2d5c218-7063-4ea0-ab03-1433449f4d83@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2d5c218-7063-4ea0-ab03-1433449f4d83@linux.alibaba.com>

On Tue, Mar 24, 2026 at 08:21:00PM +0800, Gao Xiang wrote:
> 
> 
> On 2026/3/24 19:58, Demi Marie Obenour wrote:
> > On 3/24/26 04:48, Christian Brauner wrote:
> 
> ...
> 
> > > > > 
> > > > > > I would still consider such design highly suspicious but without more
> > > > > > detailed knowledge about the application I cannot say it's outright broken
> > > > > > :).
> > > > > 
> > > > > What do you mean "such design"?  "Writable untrusted
> > > > > remote EXT4 images mounting on the host"? Really, we have
> > > > > such applications for containers for many years but I don't
> > > > > want to name it here, but I'm totally exhaused by such
> > > > > usage (since I explained many many times, and they even
> > > > > never bother with LWN.net) and the internal team.
> > > > 
> > > > By "such design" I meant generally the concept that you fetch filesystem
> > > > images (regardless whether ext4 or some other type) from untrusted source.
> > > > Unless you do cryptographical verification of the data, you never know what
> > > > kind of garbage your application is processing which is always invitation
> > > > for nasty exploits and bugs...
> > > 
> > > If this is another 500 mail discussion about FS_USERNS_MOUNT on
> > > block-backed filesystems then my verdict still stands that the only
> > > condition under which I will let the VFS allow this if the underlying
> > > device is signed and dm-verity protected. The kernel will continue to
> > > refuse unprivileged policy in general and specifically based on quality
> > > or implementation of the underlying filesystem driver.
> > 
> > As far as I can tell, the main problems are:
> > 
> > 1. Most filesystems can only be run in kernel mode, so one needs a
> >     VM and an expensive RPC protocol if one wants to run them in a
> >     sandboxed environment.
> > 
> > 2. Context switch overhead is so high that running filesystems entirely
> >     in userspace, without some form of in-kernel I/O acceleration,
> >     is a performance problem.
> > 
> > 3. Filesystems are written in C and not designed to be secure against
> >     malicious on-disk images.
> > 
> > Gao Xiang is working on problem for EROFS.
> > FUSE iomap support solves 2.  lklfuse solves problem 1.
> 
> Sigh, I just would like to say, as Darrick and Jan's previous
> replies, immutable on-disk fses are a special kind of filesystems
> and the overall on-disk format is to provide vfs/MM basic
> informattion (like LOOKUP, GETATTR, and READDIR, READ), and the
> reason is that even some values of metadata could be considered
> as inconsistent, it's just like FUSE unprivileged daemon returns
> garbage (meta)data and/or TAR extracts garbage (meta)data --
> shouldn't matter at all.
> 
> Why I'm here is I'm totally exhaused by arbitary claim like
> "all kernel filesystem are insecure". Again, that is absolutely
> untrue: the feature set, the working model and the implementation
> complexity of immutable filesystems make it more secure by
> design.
> 
> Also the reason of "another 500 mail discussion about
> FS_USERNS_MOUNT" is just because "FS_USERNS_MOUNT is very very
> useful to containers", and the special kind of immutable on-disk
> filesystems can fit this goal technically which is much much
> unlike to generic writable ondisk fses or NFS and why I working
> on EROFS is also because I believe immutable ondisk filesystems
> are absolutely useful, more secure than other generic writable
> fses by design especially on containers and handling untrusted
> remote data.
> 
> I here claim again that all implementation vulnerability of
> EROFS will claim as 0-day bug, and I've already did in this way
> for many years.  Let's step back, even not me, if there are
> some other sane immutable filesystems aiming for containers,
> they will definitely claim the same, why not?

If you want unprivileged filesystem drivers mountable by arbitrary users
and containers then get behind the effort to move this completely out of
the kernel and into fuse making fuse fast enough so that we don't have
to think about it anymore.

The whole push over the last years has been that if users want to mount
arbitrary in-kernel filesystems in userspace then they better built a
delegation and security model _in userspace_ to make this happen. This
is why we built mountfsd in userspace which works just fine today.

I don't understand what exactly people think is going to happen once we
start promising that mounting untrusted images in the kernel for even
one filesystem is fine. This will march us down security madness we have
not experienced before with all of the k8s and container workloads out
there.

For me it is currently still completely irrelevant what filesystem
driver this is and whether it is immutable or not. Look at the size of
your attack surface in your codebase and your algorithms and the ever
expanding functionality it exposes. This pipe dream of "rootless"
containers being able to mount arbitrary images in-kernel without
userspace policy is not workable.

We debate this over and over because userspace is unwilling to accept
that there are fundamental policy problems that are not solved in the
kernel. And that includes when it is safe to mount arbitrary data. This
is especially true now as we're being flooded with (valid and invalid)
CVEs due to everyone believing their personal LLM companion.

You're going to be at LSF/MM/BPF and I'm sure there'll be more
discussion around this.
