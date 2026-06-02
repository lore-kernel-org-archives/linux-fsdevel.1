Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185753603DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780383544; cv=none; b=Vb9CVhPc2uiRdiF3uT30P7KPNThGxgZb0wDDqi86tOF/jBXvg8lIBunRIzLLNgMbwWMEgzRKKfO8W29aScQQrErVoAYxKJnHkTNBBhcGotDmBNn8GHHWCvLt41g7kXBMZV7dbD/NHNHW8uzQhP/Qw6DFGnRh5tz900jb+efttWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780383544; c=relaxed/simple;
	bh=0jh649FRBc4Bjvnq+qBgd8RoM+wjZ7Bwa0qbjiJSG2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3M4FAII118kQw/JI6NVs9ulZxYvIh7qvZT/wCFUDTj8VawHvJkdXZCybOFJNu/6pJ/HcPBd+FD/O05Ie+bPwrgsx7XRflSczm/AFkv/PcK7/YUZtEdit9sZHRd1vjNM7mXUb5cKsOjDbpYx0GRVB5FTQ4sCbGZ73L6Nd239apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=groves.net; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1824C921D9;
	Tue,  2 Jun 2026 06:59:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf01.hostedemail.com (Postfix) with ESMTPA id 9C5AD60010;
	Tue,  2 Jun 2026 06:58:59 +0000 (UTC)
Date: Mon, 1 Jun 2026 23:58:56 -0700
From: John Groves <john@groves.net>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
Message-ID: <ah5-40YypaswEG-1@groves.net>
References: <20260529134302.1989958-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529134302.1989958-1-mszeredi@redhat.com>
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 9C5AD60010
X-Stat-Signature: gtjgco8m5hcz8yoo7fnwu63yc9bmwsay
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX18Ez6eA1eH4QLQlsiFcbgHDAY2CFDReqEg=
X-HE-Tag: 1780383539-804029
X-HE-Meta: U2FsdGVkX1/Z9EqRrMtrly2Xa2YMgZqAODDZ6HOC1vohh/wF3T69IJ2Hyi/8flfQF37O1alX/iAUa5yEvvhGPcgpVue9V1aCDHW/gV0ByaHTDvCGLLWvRO521MqNlqeD3rA6bnffmwNBUeZ3QefLKFGu9Lbu3w9+EexGiCQUpQYS0o0aGD9qUg2cQTebW8n45+gQm0cRvHdn0HbwXXs3iBlsCsCSi5bzl6NH5VdXhnbb4wkIRTdx4ShfR2PR3ZKmptOsCqxTqcyJsggNog/6ERaD+7a4paOeD6id5hcI9OHJClCFNnbNVJqUWwITK6dJrHCL0fp90hkMw6Ug9BlMK33LaUAUiFC+

On 26/05/29 03:43PM, Miklos Szeredi wrote:
> The difference is that now the server needs to look at the fmap and check
> if any new device needs registering, the device index is now allocated by
> the kernel and returned by the ioctl().
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
> This is the first part of what we were talking about: using the backing
> file API for dax devices.
> 
> It's on top of the famfs-v10 patchset.
> 
> Totally untested, haven't even tried booting it.  Obviously needs
> nontrivial conversion in the server code as well.
> 
> Thanks,
> Miklos

Miklos, thanks for looking at this.

First, a scope check. This patch touches only the daxdev registration -
GET_FMAP, struct fuse_famfs_fmap_header, and the simple/interleave
extent structs in include/uapi/linux/fuse.h are untouched. I'm reading
that as tacit agreement to GET_FMAP and its ABI. Can you confirm? If so
the large piece is settled and this is really just about how a daxdev
gets registered.

Device indices - the part that has to be right
----------------------------------------------

Everything below turns on what a famfs device index *is*, so let me make
it explicit, because the patch's model of it (kernel-allocated) isn't
workable for famfs.

Famfs daxdevs are shared memory. The same physical memory is mapped by
famfs on multiple nodes, and on each node it most likely has a different
name and dev_t. What is invariant across nodes is the daxdev's UUID. So
a daxdev's definitive identity is its UUID, not a path or a dev_t.

The index is assigned by famfs userspace, as the order of appearance of
daxdevs in the famfs metadata log:
  - the primary daxdev (which holds the superblock) is always index 0;
  - additional daxdevs are introduced by ADD_DAXDEV log entries and take
    1..n in order of appearance.
  - ADD_DAXDEV log entries establish the UUID-to-index mapping
  - any file may have extents referencing any or all daxdevs defined
    previously in the log - by index

Two properties make the index a userspace-owned, cluster-invariant value
the kernel cannot allocate:

  1. Bootstrap. The famfs metadata log establishes the indices - each
     ADD_DAXDEV entry defines the next - and an index can then appear in
     any later file fmap. But the log is itself a file on index 0 (with
     the superblock), so index 0 must resolve before the kernel can even
     read the log. The numbering is fixed in the log before the kernel
     sees any of it, so the kernel can't be the allocator.
     (idr_alloc_cyclic never hands out 0 anyway, so a kernel-assigned
     primary couldn't even be index 0.)

  2. Cluster-invariance. fmaps live in the shared-memory log, read
     identically by every node. A given dev_index must denote the same
     daxdev (the same UUID) on every node, even though it most likely has
     a different name and dev_t on each node. A kernel-allocated id is
     node-local and mount-local - the wrong kind of value to live in a
     shared fmap.

So the index must be supplied by userspace (which owns the log and
resolves each index's UUID to a local device), and the kernel looks
devices up by that index. Resolving UUID -> local device is inherently
userspace's job; the kernel trusts that resolution and never needs the
UUID.

This is also why the hand-rolled daxdev table is the right structure, not
incidental cruft: a small self-contained array in famfs.c, keyed directly
by the dense zero-based index, closing the discovery race (valid flag +
wmb) and giving O(1) lookup. That's exactly what this index namespace
calls for.

Identity by reference, not by path - this part is right
-------------------------------------------------------

The genuinely better idea here is getting the kernel out of resolving a
device pathname: the daemon hands over an already-resolved reference
(you do it with an fd, from which the kernel takes inode->i_rdev)
instead of a string the kernel has to kern_path(). I want to adopt that
- credit where it's due.

The minimal way to realize it is to have GET_DAXDEV return a dev_t: the
kernel uses dax_dev_find() and kern_path()/may_open_dev() drop out
entirely. No ABI change - struct fuse_daxdev_out already carries the
index and has reserved space (sized with room for a uuid), so it's just
filling a reserved field, and the index is already first-class in the
reply.

The fd delivers that same dev_t (the kernel already reads it from
f_path), so BACKING_OPEN can realize the same idea - but the dev_t is
the part that's actually the improvement, and the daxdev reply ABI
already models (index, dev_t) while fuse_backing_map models neither. So
realizing it is cleaner without the fd than with it; the costs of going
through BACKING_OPEN are below.

On BACKING_OPEN
---------------

If you feel strongly about FUSE_DEV_IOC_BACKING_OPEN, I'll make it work
- but I want to be honest that for famfs it's a shared-almost-nothing
approach:

  - famfs needs its own handler regardless (the famfs branch of
    fuse_backing_open), and that handler can keep populating the famfs
    devlist exactly as today - so the only things actually shared are the
    ioctl entry and the {fd, flags} struct.

  - it forces 'select FUSE_PASSTHROUGH', pulling in file retention, I/O
    forwarding, refcounting and close - none of which famfs uses. Famfs
    maps device memory directly via iomap/dax_direct_access; there is no
    backing file and no famfs close path (fuse_backing_close already
    returns -EINVAL when famfs_iomap is set).

  - the ABI doesn't fit. struct fuse_backing_map is {int32_t fd; uint32_t
    flags; uint64_t padding} - it's fd-shaped, with no dev_t field and no
    index field. To use it for famfs I'd have to carry the device by fd
    (which forces the daemon to open() the device just to register it -
    the daemon otherwise never opens it) and smuggle the native index
    through padding. And the fd does no real work: in famfs_daxdev_open()
    it's borrowed only to read f_path -> devno, then dropped; exclusivity
    comes from fs_dax_get()'s holder, not the fd.

On access control, in case it's a concern behind the fd: the famfs path
is already gated on the server holding CAP_SYS_RAWIO at init -
FUSE_DAX_FMAP is only offered under capable(CAP_SYS_RAWIO) in
fuse_send_init(), and famfs_iomap (hence GET_FMAP/GET_DAXDEV) is enabled
only if that flag comes back. So the registering daemon is already
raw-IO-trusted; there's no access-control gap an fd's open would close
(may_open_dev() isn't a capability check anyway, just a mount-nodev test).

Net
---

I'm glad to (a) confirm we're aligned on GET_FMAP and its ABI, and (b)
switch GET_DAXDEV to return a dev_t instead of a path. I can't move index
allocation into the kernel - the index is a userspace-owned,
cluster-invariant value for the reasons above - and I'd keep the famfs
daxdev table where it is. Lazy discovery has to keep working either way:
only the primary daxdev is known at mount; the rest are discovered as the
famfs metadata log is replayed and first referenced by an fmap.

If you still want BACKING_OPEN after the above, say so and I'll make it
work, ABI overloads and all - but I think GET_DAXDEV + dev_t is the
smaller and better-fitting change.

<snip>

Thanks,
John

