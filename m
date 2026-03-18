Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B03F3128D9
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 21:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870701; cv=none; b=cglr2gEkaEDsxS9oebqMPmkmnfbQ4wok2iNcgj8B23khG8W3VBWduQPU/odUlbs6/tnzHCNPxfzryrnp7Tc3SdaoNOiqVcy73kcb+nul6n3jm5Hd3saoAr2ytLW/rurBKHScUcfI8ydk2AZUksA0rB1t/Ie4Iw3NUPzEiyrvJlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870701; c=relaxed/simple;
	bh=fJ5duSbE1hiwy52535NiiHhKBE1dMW3nnpdQmbr5LYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYSx20qQAcm+8vO8fby7bGP26C6FQuj507/Pprkcdj8tctwycrXhPiq+107T+XBzX/Ba29vJvRo93qwqMYjmavKNMKcFH3bXqaL/06witMfwHqAVDHIb72ekZrogr1QxoUrOpMLnPnxEcAm8gbdZJaoVsxh3K322quinH/FU0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rezZc77q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rezZc77q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E90C19421;
	Wed, 18 Mar 2026 21:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773870700;
	bh=fJ5duSbE1hiwy52535NiiHhKBE1dMW3nnpdQmbr5LYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rezZc77qt7s/W/ffqT5OsOLJsbokUc6WNK3NRkHgbGDJP8A+xVVBl8I57matUNeDv
	 a5RKib1t16v1fglDV4XmMJJ/yAEigOSfUqkKZ0TUQXn8ChSwEUQSTmJuWIuHU9fOmN
	 zzPtySfENC2HreWVFa2gQNMqvRiE5gRUhSl0uENaFu8JJzfBmWVNeIBpwvHGcWT30C
	 Nrx5CtfPmy4sZgLtEtSecNE858TQdWrAz2rQleY89t7za7jj+pQMM5JH3Va+8HVzh4
	 qtdQG8qR4pWIn6pKaxPxQrXP1hMu+m9hDZYlwAN9JgowA1Q44QCgeVqyPSu1nmYp73
	 IGY+hG3mh0bCA==
Date: Wed, 18 Mar 2026 14:51:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Luis Henriques <luis@igalia.com>,
	Horst Birthelmer <horst@birthelmer.de>,
	Gao Xiang <xiang@kernel.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <20260318215140.GL1742010@frogsfrogsfrogs>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <20260204190649.GB7693@frogsfrogsfrogs>
 <ce74079f-1e0a-4fee-9259-48f08c6989aa@linux.alibaba.com>
 <20260206053835.GD7693@frogsfrogsfrogs>
 <cf44fe77-4616-45c8-975a-08dafaecad47@linux.alibaba.com>
 <20260221004752.GE11076@frogsfrogsfrogs>
 <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de8630d-b6f5-406e-809a-bc2a2d945afb@linux.alibaba.com>

On Tue, Mar 17, 2026 at 12:17:48PM +0800, Gao Xiang wrote:
> Hi Darrick,
> 
> On 2026/2/21 08:47, Darrick J. Wong wrote:
> > On Fri, Feb 06, 2026 at 02:15:12PM +0800, Gao Xiang wrote:
> 
> ...
> 
> > 
> > > > 
> > > > Fuse, otoh, is for all the other weird users -- you found an old
> > > > cupboard full of wide scsi disks; or management decided that letting
> > > > container customers bring their own prepopulated data partitions(!) is a
> > > > good idea; or the default when someone plugs in a device that the system
> > > > knows nothing about.
> 
> I brainstormed some more thoughts:
> 
> End users would like to mount a filesystem, but it's unknown that
> the filesystem is consistent or not, especially for filesystems
> are intended to be mounted as "rw", it's very hard to know if the
> filesystem metadata is fully consistent without a full fsck scan
> in advance.
> 
> Considering the following metadata inconsistent case (note that
> block 0x123 is referenced by the inconsistent metadata, rather
> than normal filesystem reflink with correct metadata):
> 
>  inode A (with high permission)
>  extent [0~4k)               maps to block 0x123
> 
>  random inode B (with low permission)
>  extent [0~4k)               maps to block 0x123 too
> 
> So there will exist at least three attack ways:
> 
>  1) Normal users will record the sensitive information to inode
>     A (since it's not the normal COW, the block 0x123 will be
>     updated in place), but normal users don't know there exists
>     the malicious inode B, so the sensitive information can be
>     fetched via inode B illegally;
> 
>  2) Attackers can write inode B with low permission in the proper
>     timing to change the inode A to compromise the computer
>     system;
> 
>  3) Of course, such two inodes can cause double freeing issues.
> 
> I think the normal copy-on-write (including OverlayFS) mechanism
> doesn't have the issue (because all changes will just have another
> copy). Of course, hardlinking won't have the same issue either,
> because there is only one inode for all hardlinks.

Yes, though you can screw with the link counts to cause other mayhem ;)

> I don't think FUSE-implemented userspace drivers will resolve
> such issues (I think users can only get the following usage reclaim:

Filesystem implementations /can/ detect these sorts of problems, but
most of them have no means to do that quickly.  As you and Demi Marie
have noted, the only reasonable way to guard against these things is
pre-mount fsck.

And even then, attackers still have a window to screw with the fs
metadata after fsck exits but before mount(2) takes the block device.
I guess you'd have to inject the fsck run after the O_EXCL opening.

Technically speaking fuse4fs could just invoke e2fsck -fn before it
starts up the rest of the libfuse initialization but who knows if that's
an acceptable risk.  Also unclear if you actually want -fy for that.

> "that is not the case that we will handle with userspace FUSE
> drivers, because the metadata is serious broken"), the only way to
> resolve such attack vectors is to run
> 
> the full-scan fsck consistency check and then mount "rw"
> 
> or
> 
> using the immutable filesystem like EROFS (so that there will not
> be such inconsisteny issues by design) and isolate the entire write
> traffic with a full copy-on-write mechanism with OverlayFS for
> example (IOWs, to make all write copy-on-write into another trusted
> local filesystem).

(Yeah, that's probably the only way to go for prepopulated images like
root filesystems and container packages)

> I hope it's a valid case, and that can indeed happen if the arbitary
> generic filesystem can be mounted in "rw".  And my immutable image
> filesystem idea can help mitigate this too (just because the immutable
> image won't be changed in any way, and all writes are always copy-up)

That, we agree on :)

--D

> Thanks,
> Gao Xiang
> 
